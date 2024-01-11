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
    p_componente_id INT,
    p_ficha_producao_id INT,
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO detalhe_ficha_producao (descricao, componente_id, ficha_producao_id)
    VALUES (p_descricao, p_componente_id, p_ficha_producao_id);
END;
$$;



CREATE OR REPLACE PROCEDURE sp_update_detalhe_ficha_producao(
    p_detalhe_id INT,
    p_descricao TEXT,
    p_componente_id INT,
    p_ficha_producao_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE detalhe_ficha_producao
    SET descricao = p_descricao, componente_id = p_componente_id, ficha_producao_id = p_ficha_producao_id
    WHERE id = p_detalhe_id;
END;
$$;



CREATE OR REPLACE FUNCTION fn_read_detalhe_ficha_producao()
RETURNS TABLE (
    detalhe_id INT,
    data_criacao TIMESTAMP,
    descricao TEXT,
    componente_id INT,
    ficha_producao_id INT,
)
AS $$
BEGIN
    RETURN QUERY SELECT id, data_criacao, descricao, componente_id, ficha_producao_id FROM detalhe_ficha_producao;
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
    componente_id INT,
    ficha_producao_id INT
)
AS $$
BEGIN
    RETURN QUERY SELECT id, data_criacao, descricao, componente_id, ficha_producao_id FROM detalhe_ficha_producao WHERE id = p_detalhe_id;
END;
$$
LANGUAGE plpgsql;
