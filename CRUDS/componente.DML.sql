CREATE OR REPLACE PROCEDURE sp_delete_componente(IN p_id INT)
AS $$
BEGIN
    DELETE FROM componente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE sp_create_componente(
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



CREATE OR REPLACE PROCEDURE sp_update_componente(
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



CREATE OR REPLACE FUNCTION fn_read_componente(p_id INT)
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    descricao TEXT,
    quantidade INT,
    tipo_id INT,
    armazem_id INT
)
AS $$
BEGIN
    RETURN QUERY SELECT * FROM componente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_readone_componente()
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    descricao TEXT,
    quantidade INT,
    tipo_id INT,
    armazem_id INT
)
AS $$
BEGIN
    RETURN QUERY SELECT * FROM componente;
END;
$$ LANGUAGE plpgsql;
