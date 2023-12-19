CREATE OR REPLACE PROCEDURE sp_delete_detalhe_ficha_producao(
    detalhe_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM detalhe_ficha_producao WHERE id = detalhe_id;
END;
$$;



CREATE OR REPLACE PROCEDURE sp_create_detalhe_ficha_producao(
    p_descricao TEXT,
    p_componente_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_descricao IS NULL OR p_descricao = '' THEN
        RAISE EXCEPTION 'A descrição não pode ser nula ou vazia.';
    END IF;

    
    IF p_componente_id IS NULL THEN
        RAISE EXCEPTION 'O componente_id não pode ser nulo.';
    END IF;
    INSERT INTO detalhe_ficha_producao (descricao, componente_id)
    VALUES (p_descricao, p_componente_id);
END;
$$;



CREATE OR REPLACE PROCEDURE sp_update_detalhe_ficha_producao(
    p_detalhe_id INT,
    p_descricao TEXT,
    p_componente_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE detalhe_ficha_producao
    SET descricao = p_descricao, componente_id = p_componente_id
    WHERE id = p_detalhe_id;
END;
$$;



CREATE OR REPLACE FUNCTION fn_read_detalhe_ficha_producao()
RETURNS TABLE (
    detalhe_id INT,
    data_criacao TIMESTAMP,
    descricao TEXT,
    componente_id INT
)
AS $$
BEGIN
    RETURN QUERY SELECT id, data_criacao, descricao, componente_id FROM detalhe_ficha_producao;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_readone_detalhe_ficha_producao(
    p_detalhe_id INT
)
RETURNS TABLE (
    detalhe_id INT,
    data_criacao TIMESTAMP,
    descricao TEXT,
    componente_id INT
)
AS $$
BEGIN
    RETURN QUERY SELECT id, data_criacao, descricao, componente_id FROM detalhe_ficha_producao WHERE id = p_detalhe_id;
END;
$$
LANGUAGE plpgsql;
