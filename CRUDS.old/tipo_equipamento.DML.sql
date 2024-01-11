--create
CREATE OR REPLACE PROCEDURE sp_create_tipo_equipamento(p_tipo VARCHAR(150))
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO tipo_equipamento (tipo) VALUES (p_tipo);
END;
$$;


--update
CREATE OR REPLACE PROCEDURE sp_update_tipo_equipamento(p_id INT, p_tipo VARCHAR(150))
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE tipo_equipamento SET tipo = p_tipo WHERE id = p_id;
END;
$$;



--delete
CREATE OR REPLACE PROCEDURE sp_delete_tipo_equipamento(p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM tipo_equipamento WHERE id = p_id;
END;
$$;


--read
CREATE OR REPLACE FUNCTION fn_read_tipo_equipamento()
RETURNS TABLE (id INT, data_criacao TIMESTAMP, tipo VARCHAR(150))
AS $$
BEGIN
    RETURN QUERY SELECT id, data_criacao, tipo FROM tipo_equipamento;
END;
$$ LANGUAGE plpgsql;


--read one
CREATE OR REPLACE FUNCTION fn_read_one_tipo_equipamento(p_id INT)
RETURNS TABLE (id INT, data_criacao TIMESTAMP, tipo VARCHAR(150))
AS $$
BEGIN
    RETURN QUERY SELECT id, data_criacao, tipo FROM tipo_equipamento WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;
