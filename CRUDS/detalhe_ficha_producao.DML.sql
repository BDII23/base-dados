CREATE OR REPLACE PROCEDURE delete_detalhe_ficha_producao(
    detalhe_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM detalhe_ficha_producao WHERE id = detalhe_id;
END;
$$;



CREATE OR REPLACE PROCEDURE create_detalhe_ficha_producao(
    p_descricao TEXT,
    p_componente_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO detalhe_ficha_producao (descricao, componente_id)
    VALUES (p_descricao, p_componente_id);
END;
$$;



CREATE OR REPLACE PROCEDURE update_detalhe_ficha_producao(
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



CREATE OR REPLACE FUNCTION read_datalhe_ficha_producao()
RETURNS SETOF datalhe_ficha_producao
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM datalhe_ficha_producao;
END;
$$;



CREATE OR REPLACE FUNCTION readone_datalhe_ficha_producao(p_id INT)
RETURNS SETOF datalhe_ficha_producao
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM datalhe_ficha_producao WHERE id = p_id;
END;
$$;