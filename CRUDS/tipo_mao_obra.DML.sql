CREATE OR REPLACE PROCEDURE delete_tipo_mao_obra(IN p_id INT)
AS
$$
BEGIN
    DELETE FROM tipo_mao_obra WHERE id = p_id;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE create_tipo_mao_obra(
    IN p_tipo VARCHAR(100),
    IN p_custo MONEY
)
AS
$$
BEGIN
    INSERT INTO tipo_mao_obra (tipo, custo) VALUES (p_tipo, p_custo);
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_tipo_mao_obra(
    IN p_id INT,
    IN p_tipo VARCHAR(100),
    IN p_custo MONEY
)
AS
$$
BEGIN
    UPDATE tipo_mao_obra
    SET tipo = p_tipo, custo = p_custo
    WHERE id = p_id;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readone_tipo_mao_obra(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(tipo_mao_obra)
    INTO json
    FROM tipo_mao_obra
	WHERE p_id = tipo_mao_obra.id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_tipo_mao_obra()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT array_to_json(array_agg(row_to_json(row)))
    INTO json
    FROM (SELECT * FROM tipo_mao_obra) row;

    RETURN json;
END;
$$ LANGUAGE plpgsql;