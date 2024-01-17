CREATE OR REPLACE PROCEDURE create_tipo_equipamento(p_tipo VARCHAR(150))
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO tipo_equipamento (tipo) VALUES (p_tipo);
END;
$$;



CREATE OR REPLACE PROCEDURE update_tipo_equipamento(p_id INT, p_tipo VARCHAR(150))
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE tipo_equipamento SET tipo = p_tipo WHERE id = p_id;
END;
$$;



CREATE OR REPLACE PROCEDURE delete_tipo_equipamento(p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM tipo_equipamento WHERE id = p_id;
END;
$$;



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