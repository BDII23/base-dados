CREATE OR REPLACE PROCEDURE create_armazem(
    p_endereco VARCHAR(100)
)
AS $$
BEGIN
    INSERT INTO armazem (endereco) VALUES (p_endereco);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_armazem(p_id INT, p_endereco VARCHAR(100))
AS $$
BEGIN
    UPDATE armazem SET endereco = p_endereco WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE delete_armazem(p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM armazem WHERE id = p_id;
END;
$$;



CREATE OR REPLACE FUNCTION readone_armazem(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(armazem)
    INTO json
    FROM armazem
	WHERE p_id = armazem.id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_armazem()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT array_to_json(array_agg(row_to_json(row)))
    INTO json
    FROM (SELECT * FROM armazem) row;

    RETURN json;
END;
$$ LANGUAGE plpgsql;