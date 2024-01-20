CREATE OR REPLACE PROCEDURE sp_create_utilizador_perfil(
    p_perfil VARCHAR(100)
)
AS $$
BEGIN
    INSERT INTO utilizador_perfil (perfil) VALUES (p_perfil);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_utilizador_perfil(
    p_id INT,
    p_perfil VARCHAR(100)
)
AS $$
BEGIN
    UPDATE utilizador_perfil
    SET perfil = p_perfil
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE delete_utilizador_perfil(p_id INT)
AS $$
BEGIN
    DELETE FROM utilizador_perfil
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION read_utilizador_perfil()
RETURNS SETOF utilizador_perfil
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM utilizador_perfil;
END;
$$;



CREATE OR REPLACE FUNCTION readone_utilizador_perfil(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(utilizador_perfil)
    INTO json
    FROM utilizador_perfil
	WHERE p_id = utilizador_perfil.id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_utilizador_perfil()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT array_to_json(array_agg(row_to_json(row)))
    INTO json
    FROM (SELECT * FROM utilizador_perfil) row;

    RETURN json;
END;
$$ LANGUAGE plpgsql;