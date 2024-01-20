CREATE OR REPLACE PROCEDURE create_fornecedor(
    p_nome VARCHAR(100),
    p_nif CHAR(9),
    p_email VARCHAR(200),
    p_telefone CHAR(9),
    p_endereco VARCHAR(500)
)
AS $$
BEGIN
    INSERT INTO fornecedor (nome, nif, email, telefone, endereco)
    VALUES (p_nome, p_nif, p_email, p_telefone, p_endereco);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE delete_fornecedor(p_id INT)
AS $$
BEGIN
    DELETE FROM fornecedor WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_fornecedor(
    p_id INT,
    p_nome VARCHAR(100),
    p_nif CHAR(9),
    p_email VARCHAR(200),
    p_telefone CHAR(9),
    p_endereco VARCHAR(500)
)
AS $$
BEGIN
    UPDATE fornecedor
    SET nome = p_nome,
        nif = p_nif,
        email = p_email,
        telefone = p_telefone,
        endereco = p_endereco
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION read_fornecedor()
RETURNS SETOF fornecedor
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM fornecedor;
END;
$$;



CREATE OR REPLACE FUNCTION readone_fornecedor(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(fornecedor)
    INTO json
    FROM fornecedor
	WHERE p_id = fornecedor.id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_fornecedor()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT array_to_json(array_agg(row_to_json(row)))
    INTO json
    FROM (SELECT * FROM fornecedor) row;

    RETURN json;
END;
$$ LANGUAGE plpgsql;