CREATE OR REPLACE PROCEDURE create_guia_remessa_fornecedor(
    IN p_data_envio TIMESTAMPTZ,
    IN p_data_entrega TIMESTAMPTZ,
    IN p_endereco_origem VARCHAR(300),
    IN p_endereco_chegada VARCHAR(300),
    IN p_estado_id INT,
    IN p_detalhe_encomenda_id INT,
    IN p_utilizador_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN   
    INSERT INTO guia_remessa_fornecedor (
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
$$;



CREATE OR REPLACE PROCEDURE update_guia_remessa_fornecedor(
    IN p_id INT,
    IN p_data_envio TIMESTAMPTZ,
    IN p_data_entrega TIMESTAMPTZ,
    IN p_endereco_origem VARCHAR(300),
    IN p_endereco_chegada VARCHAR(300),
    IN p_estado_id INT,
    IN p_detalhe_encomenda_id INT,
    IN p_utilizador_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE guia_remessa_fornecedor
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
$$;



CREATE OR REPLACE PROCEDURE delete_guia_remessa_fornecedor(IN p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM guia_remessa_fornecedor WHERE id = p_id;
END;
$$;



CREATE OR REPLACE FUNCTION readone_guia_remessa_fornecedor(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
	SELECT json_agg(guia_remessa_fornecedor)
    INTO json
    FROM (
        SELECT
            guia_remessa_fornecedor.*,
            (
                SELECT json_agg(detalhe_remessa_fornecedor)
                FROM (
					SELECT detalhe_remessa_fornecedor.*,
						(
							SELECT json_agg(detalhe_encomenda_fornecedor)
							FROM (
								SELECT detalhe_encomenda_fornecedor.*,
									readone_componente(detalhe_encomenda_fornecedor.componente_id) AS componente
								FROM detalhe_encomenda_fornecedor
							) detalhe_encomenda_fornecedor
							WHERE detalhe_encomenda_fornecedor.id = detalhe_remessa_fornecedor.detalhe_encomenda_id
						) detalhe_encomenda_fornecedor
					FROM detalhe_remessa_fornecedor
				) detalhe_remessa_fornecedor
                WHERE detalhe_remessa_fornecedor.remessa_id = guia_remessa_fornecedor.id
            ) detalhe_remessa_fornecedor,
			(
				SELECT json_agg(fatura_fornecedor)
                FROM fatura_fornecedor
                WHERE fatura_fornecedor.id = guia_remessa_fornecedor.fatura_id
			) fatura_fornecedor
        FROM guia_remessa_fornecedor
	) guia_remessa_fornecedor
	WHERE guia_remessa_fornecedor.id = p_id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_guia_remessa_fornecedor()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
	SELECT json_agg(guia_remessa_fornecedor)
    INTO json
    FROM (
        SELECT
            guia_remessa_fornecedor.*,
            (
                SELECT json_agg(detalhe_remessa_fornecedor)
                FROM (
					SELECT detalhe_remessa_fornecedor.*,
						(
							SELECT json_agg(detalhe_encomenda_fornecedor)
							FROM (
								SELECT detalhe_encomenda_fornecedor.*,
									readone_componente(detalhe_encomenda_fornecedor.componente_id) AS componente
								FROM detalhe_encomenda_fornecedor
							) detalhe_encomenda_fornecedor
							WHERE detalhe_encomenda_fornecedor.id = detalhe_remessa_fornecedor.detalhe_encomenda_id
						) detalhe_encomenda_fornecedor
					FROM detalhe_remessa_fornecedor
				) detalhe_remessa_fornecedor
                WHERE detalhe_remessa_fornecedor.remessa_id = guia_remessa_fornecedor.id
            ) detalhe_remessa_fornecedor,
			(
				SELECT json_agg(fatura_fornecedor)
                FROM fatura_fornecedor
                WHERE fatura_fornecedor.id = guia_remessa_fornecedor.fatura_id
			) fatura_fornecedor
        FROM guia_remessa_fornecedor
	) guia_remessa_fornecedor;

    RETURN json;
END;
$$ LANGUAGE plpgsql;