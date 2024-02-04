CREATE OR REPLACE PROCEDURE delete_encomenda_cliente(p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM encomenda_cliente WHERE id = p_id;
END;
$$;



CREATE OR REPLACE PROCEDURE create_encomenda_cliente(
    p_data_criacao TIMESTAMP,
    p_estado_id INT,
    p_cliente_id INT,
    p_fatura_id INT
)
AS $$
BEGIN
    INSERT INTO encomenda_cliente (data_criacao, estado_id, cliente_id, fatura_id)
    VALUES (p_data_criacao, p_estado_id, p_cliente_id, p_fatura_id);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_encomenda_cliente(
    p_id INT,
    p_data_criacao TIMESTAMP,
    p_estado_id INT,
    p_cliente_id INT,
    p_fatura_id INT)
AS $$
BEGIN
    UPDATE encomenda_cliente
    SET 
        data_criacao = p_data_criacao,
        estado_id = p_estado_id,
        estado_algumacoisa_id = p_estado_id,
        cliente_id = p_cliente_id,
        fatura_id = p_fatura_id
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readone_encomenda_cliente(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(encomenda_cliente)
    INTO json
    FROM (
        SELECT
            encomenda_cliente.*,
            (
                SELECT json_agg(detalhe_encomenda_cliente)
                FROM (
					SELECT detalhe_encomenda_cliente.*,
						(
							SELECT json_agg(equipamento)
							FROM (
								SELECT equipamento.*,
									(
										SELECT json_agg(tipo_equipamento)
										FROM tipo_equipamento
										WHERE tipo_equipamento.id = equipamento.tipo_id
									) tipo_equipamento
								FROM equipamento
							) equipamento
							WHERE equipamento.id = detalhe_encomenda_cliente.equipamento_id
						) equipamento
					FROM detalhe_encomenda_cliente
				) detalhe_encomenda_cliente
                WHERE detalhe_encomenda_cliente.encomenda_id = encomenda_cliente.id
            ) detalhe_encomenda_cliente
        FROM encomenda_cliente
	) encomenda_cliente
	WHERE encomenda_cliente.id = p_id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_encomenda_cliente()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(encomenda_cliente)
    INTO json
    FROM (
        SELECT
            encomenda_cliente.*,
            (
                SELECT json_agg(detalhe_encomenda_cliente)
                FROM (
					SELECT detalhe_encomenda_cliente.*,
						(
							SELECT json_agg(equipamento)
							FROM (
								SELECT equipamento.*,
									(
										SELECT json_agg(tipo_equipamento)
										FROM tipo_equipamento
										WHERE tipo_equipamento.id = equipamento.tipo_id
									) tipo_equipamento
								FROM equipamento
							) equipamento
							WHERE equipamento.id = detalhe_encomenda_cliente.equipamento_id
						) equipamento
					FROM detalhe_encomenda_cliente
				) detalhe_encomenda_cliente
                WHERE detalhe_encomenda_cliente.encomenda_id = encomenda_cliente.id
            ) detalhe_encomenda_cliente
        FROM encomenda_cliente
	) encomenda_cliente;

    RETURN json;
END;
$$ LANGUAGE plpgsql;