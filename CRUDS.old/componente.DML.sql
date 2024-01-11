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

    IF p_descricao is null or p_descricao = '' THEN
        RAISE EXCEPTION 'A descricao do componente não pode ser nula ou vazia';
    END IF;

     IF p_quantidade < 0 THEN 
        RAISE EXCEPTION 'A quantidade de componentes não pode ser negativa';
    END IF;

     IF p_tipo_id is null or p_tipo_id < 0 THEN
        RAISE EXCEPTION 'O tipo ID do componente não pode ser nulo ou negativo.';
    END IF;

     IF p_armazem_id is null or p_armazem_id < 0  THEN
        RAISE EXCEPTION 'O armazem ID do compoennte não pode ser nulo ou negativo';
    END IF;


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
