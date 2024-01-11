--delete
CREATE OR REPLACE PROCEDURE sp_delete_tipo_mao_obra(IN p_id INT)
AS
$$
BEGIN
    DELETE FROM tipo_mao_obra WHERE id = p_id;
END;
$$
LANGUAGE plpgsql;


--create
CREATE OR REPLACE PROCEDURE sp_create_tipo_mao_obra(
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

--update
CREATE OR REPLACE PROCEDURE sp_update_tipo_mao_obra(
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

--read
CREATE OR REPLACE FUNCTION fn_read_tipo_mao_obra()
RETURNS TABLE (
    out_id INT,
    out_data_criacao TIMESTAMP,
    out_tipo VARCHAR(100),
    out_custo MONEY
)
AS
$$
BEGIN
    RETURN QUERY SELECT * FROM tipo_mao_obra;
END;
$$
LANGUAGE plpgsql;

--read one 
CREATE OR REPLACE FUNCTION fn_readone_tipo_mao_obra(IN p_id INT)
RETURNS TABLE (
    out_id INT,
    out_data_criacao TIMESTAMP,
    out_tipo VARCHAR(100),
    out_custo MONEY
)
AS
$$
BEGIN
    RETURN QUERY SELECT * FROM tipo_mao_obra WHERE id = p_id;
END;
$$
LANGUAGE plpgsql;
