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

    IF p_tipo IS NULL OR p_tipo = '' THEN
        RAISE EXCEPTION 'O tipo não pode ser nulo ou vazio.';
    END IF;

   
    IF p_custo < 0 THEN
        RAISE EXCEPTION 'O custo não pode ser negativo.';
    END IF;

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



CREATE OR REPLACE FUNCTION read_tipo_mao_obra()
RETURNS SETOF tipo_mao_obra
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM tipo_mao_obra;
END;
$$;



CREATE OR REPLACE FUNCTION readone_tipo_mao_obra(p_id INT)
RETURNS SETOF tipo_mao_obra
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM tipo_mao_obra WHERE id = p_id;
END;
$$;