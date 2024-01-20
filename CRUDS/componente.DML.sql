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
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(componente)
    INTO json
    FROM (
        SELECT
            componente.*,
            (
                SELECT json_agg(tipo_componente)
                FROM tipo_componente
                WHERE tipo_componente.id = componente.tipo_id
            ) tipo_componente,
            (
                SELECT json_agg(armazem)
                FROM armazem
                WHERE armazem.id = componente.armazem_id
            ) armazem
        FROM componente
	) componente
	WHERE p_id = componente.id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_componente()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(componente)
    INTO json
    FROM (
        SELECT
            componente.*,
            (
                SELECT json_agg(tipo_componente)
                FROM tipo_componente
                WHERE tipo_componente.id = componente.tipo_id
            ) tipo_componente,
            (
                SELECT json_agg(armazem)
                FROM armazem
                WHERE armazem.id = componente.armazem_id
            ) armazem
        FROM componente
	) componente;

    RETURN json;
END;
$$ LANGUAGE plpgsql;