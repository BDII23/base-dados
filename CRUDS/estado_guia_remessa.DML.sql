CREATE OR REPLACE PROCEDURE delete_estado_guia_remessa(IN p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM estado_guia_remessa WHERE id = p_id;
END;
$$;



CREATE OR REPLACE PROCEDURE create_estado_guia_remessa(IN p_estado VARCHAR(100))
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO estado_guia_remessa(estado) VALUES (p_estado);
END;
$$;



CREATE OR REPLACE PROCEDURE update_estado_guia_remessa(IN p_id INT, IN p_estado VARCHAR(100))
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE estado_guia_remessa SET estado = p_estado WHERE id = p_id;
END;
$$;



CREATE OR REPLACE FUNCTION read_estado_guia_remessa()
RETURNS SETOF estado_guia_remessa
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM estado_guia_remessa;
END;
$$;



CREATE OR REPLACE FUNCTION readone_estado_guia_remessa(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(estado_guia_remessa)
    INTO json
    FROM estado_guia_remessa
	WHERE p_id = estado_guia_remessa.id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_estado_guia_remessa()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT array_to_json(array_agg(row_to_json(row)))
    INTO json
    FROM (SELECT * FROM estado_guia_remessa) row;

    RETURN json;
END;
$$ LANGUAGE plpgsql;