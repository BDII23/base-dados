CREATE OR REPLACE PROCEDURE create_tipo_componente(
    p_tipo VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO tipo_componente (tipo) VALUES (p_tipo);
END;
$$;



CREATE OR REPLACE PROCEDURE delete_tipo_componente(p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM tipo_componente WHERE id = p_id;
END;
$$;



CREATE OR REPLACE PROCEDURE update_tipo_componente(
    p_id INT,
    p_tipo VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE tipo_componente SET tipo = p_tipo WHERE id = p_id;
END;
$$;



CREATE OR REPLACE FUNCTION read_tipo_componente()
RETURNS SETOF tipo_componente
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM tipo_componente;
END;
$$;



CREATE OR REPLACE FUNCTION readone_tipo_componente(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(tipo_componente)
    INTO json
    FROM tipo_componente
	WHERE p_id = tipo_componente.id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_tipo_componente()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT array_to_json(array_agg(row_to_json(row)))
    INTO json
    FROM (SELECT * FROM tipo_componente) row;

    RETURN json;
END;
$$ LANGUAGE plpgsql;