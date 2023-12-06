CREATE OR REPLACE PROCEDURE sp_delete_fatura_cliente(IN p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM fatura_cliente WHERE id = p_id;
END;
$$;



CREATE OR REPLACE PROCEDURE sp_create_fatura_cliente(
    IN p_descricao TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO fatura_cliente (descricao) VALUES (p_descricao);
END;
$$;



CREATE OR REPLACE PROCEDURE sp_update_fatura_cliente(
    IN p_id INT,
    IN p_descricao TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE fatura_cliente SET descricao = p_descricao WHERE id = p_id;
END;
$$;



CREATE OR REPLACE FUNCTION fn_read_fatura_cliente()
RETURNS SETOF fatura_cliente
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM fatura_cliente;
END;
$$;



CREATE OR REPLACE FUNCTION fn_readone_fatura_cliente(IN p_id INT)
RETURNS SETOF fatura_cliente
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM fatura_cliente WHERE id = p_id;
END;
$$;