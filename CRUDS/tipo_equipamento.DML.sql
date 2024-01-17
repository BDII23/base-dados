CREATE OR REPLACE PROCEDURE create_tipo_equipamento(p_tipo VARCHAR(150))
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO tipo_equipamento (tipo) VALUES (p_tipo);
END;
$$;



CREATE OR REPLACE PROCEDURE update_tipo_equipamento(p_id INT, p_tipo VARCHAR(150))
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE tipo_equipamento SET tipo = p_tipo WHERE id = p_id;
END;
$$;



CREATE OR REPLACE PROCEDURE delete_tipo_equipamento(p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM tipo_equipamento WHERE id = p_id;
END;
$$;



CREATE OR REPLACE FUNCTION read_tipo_equipamento()
RETURNS SETOF tipo_equipamento
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM tipo_equipamento;
END;
$$;



CREATE OR REPLACE FUNCTION readone_tipo_equipamento(p_id INT)
RETURNS SETOF tipo_equipamento
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM tipo_equipamento WHERE id = p_id;
END;
$$;



CREATE OR REPLACE FUNCTION readjson_tipo_equipamento()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT array_to_json(array_agg(row_to_json(row)))
    INTO json
    FROM (SELECT * FROM tipo_equipamento) row;

    RETURN json;
END;
$$ LANGUAGE plpgsql;