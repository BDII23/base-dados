CREATE OR REPLACE PROCEDURE delete_fatura_cliente(IN p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM fatura_cliente WHERE id = p_id;
END;
$$;



CREATE OR REPLACE PROCEDURE create_fatura_cliente(
    IN p_descricao TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN    
    INSERT INTO fatura_cliente (descricao) VALUES (p_descricao);
END;
$$;



CREATE OR REPLACE PROCEDURE update_fatura_cliente(
    IN p_id INT,
    IN p_descricao TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE fatura_cliente SET descricao = p_descricao WHERE id = p_id;
END;
$$;



CREATE OR REPLACE FUNCTION readone_fatura_cliente(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(fatura_cliente)
    INTO json
    FROM fatura_cliente
	WHERE p_id = fatura_cliente.id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_fatura_cliente()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT array_to_json(array_agg(row_to_json(row)))
    INTO json
    FROM (SELECT * FROM fatura_cliente) row;

    RETURN json;
END;
$$ LANGUAGE plpgsql;