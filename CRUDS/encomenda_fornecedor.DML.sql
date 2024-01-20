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



CREATE OR REPLACE FUNCTION read_encomenda_fornecedor()
RETURNS SETOF encomenda_fornecedor
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM encomenda_fornecedor;
END;
$$;



CREATE OR REPLACE FUNCTION readone_encomenda_fornecedor(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(encomenda_fornecedor)
    INTO json
    FROM encomenda_fornecedor
	WHERE p_id = encomenda_fornecedor.id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_encomenda_fornecedor()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT array_to_json(array_agg(row_to_json(row)))
    INTO json
    FROM (SELECT * FROM encomenda_fornecedor) row;

    RETURN json;
END;
$$ LANGUAGE plpgsql;