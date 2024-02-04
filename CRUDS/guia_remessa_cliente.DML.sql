CREATE OR REPLACE PROCEDURE create_guia_remessa_cliente(
    p_data_envio TIMESTAMP,
    p_data_entrega TIMESTAMP,
    p_endereco_origem VARCHAR(300),
    p_endereco_chegada VARCHAR(300),
    p_estado_id INT,
    p_detalhe_encomenda_id INT,
    p_utilizador_id INT
)
AS $$
BEGIN
    INSERT INTO guia_remessa_cliente (
        data_envio,
        data_entrega,
        endereco_origem,
        endereco_chegada,
        estado_id,
        detalhe_encomenda_id,
        utilizador_id
    ) VALUES (
        p_data_envio,
        p_data_entrega,
        p_endereco_origem,
        p_endereco_chegada,
        p_estado_id,
        p_detalhe_encomenda_id,
        p_utilizador_id
    );
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_guia_remessa_cliente(
    p_id INT,
    p_data_envio TIMESTAMP,
    p_data_entrega TIMESTAMP,
    p_endereco_origem VARCHAR(300),
    p_endereco_chegada VARCHAR(300),
    p_estado_id INT,
    p_detalhe_encomenda_id INT,
    p_utilizador_id INT
)
AS $$
BEGIN
    UPDATE guia_remessa_cliente
    SET
        data_envio = p_data_envio,
        data_entrega = p_data_entrega,
        endereco_origem = p_endereco_origem,
        endereco_chegada = p_endereco_chegada,
        estado_id = p_estado_id,
        detalhe_encomenda_id = p_detalhe_encomenda_id,
        utilizador_id = p_utilizador_id
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE delete_guia_remessa_cliente(p_id INT)
AS $$
BEGIN
    DELETE FROM guia_remessa_cliente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readone_guia_remessa_cliente(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(guia_remessa_cliente)
    INTO json
    FROM (
        SELECT
            guia_remessa_cliente.*,
            (
                SELECT json_agg(detalhe_remessa_cliente)
                FROM (
					SELECT detalhe_remessa_cliente.*,
						(
							SELECT json_agg(detalhe_encomenda_cliente)
							FROM (
								SELECT detalhe_encomenda_cliente.*,
									readone_equipamento(detalhe_encomenda_cliente.equipamento_id) AS equipamento
								FROM detalhe_encomenda_cliente
							) detalhe_encomenda_cliente
							WHERE detalhe_encomenda_cliente.id = detalhe_remessa_cliente.detalhe_encomenda_id
						) detalhe_encomenda_cliente
					FROM detalhe_remessa_cliente
				) detalhe_remessa_cliente
                WHERE detalhe_remessa_cliente.remessa_id = guia_remessa_cliente.id
            ) detalhe_remessa_cliente
        FROM guia_remessa_cliente
	) guia_remessa_cliente
	WHERE guia_remessa_cliente.id = p_id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_guia_remessa_cliente()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(guia_remessa_cliente)
    INTO json
    FROM (
        SELECT
            guia_remessa_cliente.*,
            (
                SELECT json_agg(detalhe_remessa_cliente)
                FROM (
					SELECT detalhe_remessa_cliente.*,
						(
							SELECT json_agg(detalhe_encomenda_cliente)
							FROM (
								SELECT detalhe_encomenda_cliente.*,
									readone_equipamento(detalhe_encomenda_cliente.equipamento_id) AS equipamento
								FROM detalhe_encomenda_cliente
							) detalhe_encomenda_cliente
							WHERE detalhe_encomenda_cliente.id = detalhe_remessa_cliente.detalhe_encomenda_id
						) detalhe_encomenda_cliente
					FROM detalhe_remessa_cliente
				) detalhe_remessa_cliente
                WHERE detalhe_remessa_cliente.remessa_id = guia_remessa_cliente.id
            ) detalhe_remessa_cliente
        FROM guia_remessa_cliente
	) guia_remessa_cliente;

    RETURN json;
END;
$$ LANGUAGE plpgsql;