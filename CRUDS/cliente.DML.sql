CREATE OR REPLACE PROCEDURE create_cliente(
    IN p_email VARCHAR(500),
    IN p_senha VARCHAR(400),
    IN p_nome VARCHAR(300),
    IN p_nif CHAR(9)
)
AS $$
BEGIN
    INSERT INTO cliente (email, senha, nome, nif)
    VALUES (p_email, p_senha, p_nome, p_nif);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_cliente(
    IN p_id INT,
    IN p_email VARCHAR(500),
    IN p_senha VARCHAR(400),
    IN p_nome VARCHAR(300),
    IN p_nif CHAR(9)
)
AS $$
BEGIN
    UPDATE cliente
    SET email = p_email, senha = p_senha, nome = p_nome, nif = p_nif
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE delete_cliente(IN p_id INT)
AS $$
BEGIN
    DELETE FROM cliente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION read_cliente()
RETURNS SETOF cliente
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM cliente;
END;
$$;



CREATE OR REPLACE FUNCTION readone_cliente(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(cliente)
    INTO json
    FROM cliente
	WHERE p_id = cliente.id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_cliente()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT array_to_json(array_agg(row_to_json(row)))
    INTO json
    FROM (SELECT * FROM cliente) row;

    RETURN json;
END;
$$ LANGUAGE plpgsql;