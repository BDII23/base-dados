CREATE OR REPLACE PROCEDURE delete_componente(IN p_id INT)
AS $$
BEGIN
    DELETE FROM componente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE create_componente(
    IN p_descricao TEXT,
    IN p_quantidade INT,
    IN p_tipo_id INT,
    IN p_armazem_id INT
)
AS $$
BEGIN
    INSERT INTO componente (descricao, quantidade, tipo_id, armazem_id)
    VALUES (p_descricao, p_quantidade, p_tipo_id, p_armazem_id);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_componente(
    IN p_id INT,
    IN p_descricao TEXT,
    IN p_quantidade INT,
    IN p_tipo_id INT,
    IN p_armazem_id INT
)
AS $$
BEGIN
    UPDATE componente
    SET descricao = p_descricao,
        quantidade = p_quantidade,
        tipo_id = p_tipo_id,
        armazem_id = p_armazem_id
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION read_componente()
RETURNS SETOF componente
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM componente;
END;
$$;



CREATE OR REPLACE FUNCTION readone_componente(p_id INT)
RETURNS SETOF componente
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM componente WHERE id = p_id;
END;
$$;



CREATE OR REPLACE FUNCTION readjson_componente()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT array_to_json(array_agg(row_to_json(row)))
    INTO json
    FROM (SELECT * FROM componente) row;

    RETURN json;
END;
$$ LANGUAGE plpgsql;