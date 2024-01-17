CREATE OR REPLACE PROCEDURE sp_create_tipo_componente(
    p_tipo VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN

    IF p_tipo IS NULL OR p_tipo = '' THEN
        RAISE EXCEPTION 'O tipo não pode ser nulo ou vazio.';
    END IF;

    INSERT INTO tipo_componente (tipo) VALUES (p_tipo);
END;
$$;



CREATE OR REPLACE PROCEDURE sp_delete_tipo_componente(p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM tipo_componente WHERE id = p_id;
END;
$$;



CREATE OR REPLACE PROCEDURE sp_update_tipo_componente(
    p_id INT,
    p_tipo VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE tipo_componente SET tipo = p_tipo WHERE id = p_id;
END;
$$;



CREATE OR REPLACE FUNCTION fn_read_tipo_componente()
RETURNS SETOF tipo_componente
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM tipo_componente;
END;
$$;



CREATE OR REPLACE FUNCTION fn_readone_tipo_componente(p_id INT)
RETURNS SETOF tipo_componente
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM tipo_componente WHERE id = p_id;
END;
$$;