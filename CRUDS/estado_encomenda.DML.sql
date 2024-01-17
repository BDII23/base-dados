CREATE OR REPLACE PROCEDURE delete_estado_encomenda(IN p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM estado_encomenda WHERE id = p_id;
END;
$$;



CREATE OR REPLACE PROCEDURE create_estado_encomenda(
    IN p_data_criacao TIMESTAMP,
    IN p_estado VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO estado_encomenda (data_criacao, estado) VALUES (p_data_criacao, p_estado);
END;
$$;



CREATE OR REPLACE PROCEDURE update_estado_encomenda(
    IN p_id INT,
    IN p_data_criacao TIMESTAMP,
    IN p_estado VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE estado_encomenda SET data_criacao = p_data_criacao, estado = p_estado WHERE id = p_id;
END;
$$;



CREATE OR REPLACE FUNCTION read_estado_encomenda()
RETURNS SETOF estado_encomenda
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM estado_encomenda;
END;
$$;



CREATE OR REPLACE FUNCTION readone_estado_encomenda(p_id INT)
RETURNS SETOF estado_encomenda
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM estado_encomenda WHERE id = p_id;
END;
$$;



CREATE OR REPLACE FUNCTION readjson_estado_encomenda()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT array_to_json(array_agg(row_to_json(row)))
    INTO json
    FROM (SELECT * FROM estado_encomenda) row;

    RETURN json;
END;
$$ LANGUAGE plpgsql;