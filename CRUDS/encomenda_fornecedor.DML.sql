CREATE OR REPLACE PROCEDURE delete_encomenda_fornecedor(
    in_id INT
)
AS $$
BEGIN
    DELETE FROM encomenda_fornecedor WHERE id = in_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE create_encomenda_fornecedor(
    in_estado_id INT,
    in_fornecedor_id INT
)
AS $$
BEGIN
    INSERT INTO encomenda_fornecedor (estado_id, fornecedor_id, fatura_id)
    VALUES (in_estado_id, in_fornecedor_id, in_fatura_id);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_encomenda_fornecedor(
    in_id INT,
    in_estado_id INT,
    in_fornecedor_id INT
)
AS $$
BEGIN
    UPDATE encomenda_fornecedor
    SET estado_id = in_estado_id,
        fornecedor_id = in_fornecedor_id,
        fatura_id = in_fatura_id
    WHERE id = in_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readone_encomenda_fornecedor(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(encomenda_fornecedor)
    INTO json
    FROM (
        SELECT
            encomenda_fornecedor.*,
            (
                SELECT json_agg(detalhe_encomenda_fornecedor)
                FROM (
                    SELECT detalhe_encomenda_fornecedor.*,
                        (
                            SELECT readone_componente(detalhe_encomenda_fornecedor.componente_id) AS componente
                        ) componente
                    FROM detalhe_encomenda_fornecedor
                ) detalhe_encomenda_fornecedor
                WHERE detalhe_encomenda_fornecedor.encomenda_id = encomenda_fornecedor.id
            ) detalhe_encomenda_fornecedor,
            (
                SELECT json_agg(estado_encomenda)
                FROM estado_encomenda
                WHERE estado_encomenda.id = encomenda_fornecedor.estado_id
            ) estado_encomenda,
            (
                SELECT json_agg(fornecedor)
                FROM fornecedor
                WHERE fornecedor.id = encomenda_fornecedor.fornecedor_id
            ) fornecedor
        FROM encomenda_fornecedor
    ) encomenda_fornecedor
	WHERE encomenda_fornecedor.id = p_id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_encomenda_fornecedor()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(encomenda_fornecedor)
    INTO json
    FROM (
        SELECT
            encomenda_fornecedor.*,
            (
                SELECT json_agg(detalhe_encomenda_fornecedor)
                FROM (
                    SELECT detalhe_encomenda_fornecedor.*,
                        (
                            SELECT readone_componente(detalhe_encomenda_fornecedor.componente_id) AS componente
                        ) componente
                    FROM detalhe_encomenda_fornecedor
                ) detalhe_encomenda_fornecedor
                WHERE detalhe_encomenda_fornecedor.encomenda_id = encomenda_fornecedor.id
            ) detalhe_encomenda_fornecedor,
            (
                SELECT json_agg(estado_encomenda)
                FROM estado_encomenda
                WHERE estado_encomenda.id = encomenda_fornecedor.estado_id
            ) estado_encomenda,
            (
                SELECT json_agg(fornecedor)
                FROM fornecedor
                WHERE fornecedor.id = encomenda_fornecedor.fornecedor_id
            ) fornecedor
        FROM encomenda_fornecedor
    ) encomenda_fornecedor;

    RETURN json;
END;
$$ LANGUAGE plpgsql;