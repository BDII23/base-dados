CREATE OR REPLACE PROCEDURE delete_equipamento(p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM equipamento WHERE id = in_id;
END;
$$;



CREATE OR REPLACE PROCEDURE create_equipamento(
    in_tipo_id INT
)
AS $$
BEGIN
    INSERT INTO equipamento (tipo_id) 
    VALUES (in_tipo_id);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_equipamento(
    in_id INT,
    in_tipo_id INT)
AS $$
BEGIN
    UPDATE equipamento SET tipo_id = in_tipo_id WHERE id = in_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION read_equipamento()
RETURNS SETOF equipamento
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM equipamento;
END;
$$;



CREATE OR REPLACE FUNCTION readone_equipamento(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(equipamento)
    INTO json
    FROM equipamento
	WHERE p_id = equipamento.id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_equipamento()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(equipamento)
    INTO json
    FROM (
        SELECT
            equipamento.*,
            (
                SELECT json_agg(tipo_equipamento)
                FROM tipo_equipamento
                WHERE tipo_equipamento.id = equipamento.tipo_id
            ) tipo_equipamento
        FROM equipamento
		) equipamento;

    RETURN json;
END;
$$ LANGUAGE plpgsql;