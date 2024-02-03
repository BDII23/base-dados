CREATE OR REPLACE PROCEDURE delete_detalhe_ficha_producao(detalhe_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM detalhe_ficha_producao WHERE id = detalhe_id;
END;
$$;



CREATE OR REPLACE PROCEDURE create_detalhe_ficha_producao(p_componente_id INT, p_ficha_producao_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO detalhe_ficha_producao (componente_id, ficha_producao_id)
    VALUES (p_componente_id, p_ficha_producao_id);
END;
$$;



CREATE OR REPLACE PROCEDURE update_detalhe_ficha_producao(p_detalhe_id INT, p_componente_id INT, p_ficha_producao_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE detalhe_ficha_producao
    SET componente_id = p_componente_id, ficha_producao_id = p_ficha_producao_id
    WHERE id = p_detalhe_id;
END;
$$;



CREATE OR REPLACE FUNCTION readone_detalhe_ficha_producao(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(detalhe_ficha_producao)
    INTO json
    FROM detalhe_ficha_producao
	WHERE p_id = detalhe_ficha_producao.id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_detalhe_ficha_producao()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT array_to_json(array_agg(row_to_json(row)))
    INTO json
    FROM (SELECT * FROM detalhe_ficha_producao) row;

    RETURN json;
END;
$$ LANGUAGE plpgsql;