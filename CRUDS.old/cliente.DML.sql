CREATE OR REPLACE PROCEDURE sp_create_cliente(
    IN p_email VARCHAR(500),
    IN p_senha VARCHAR(400),
    IN p_nome VARCHAR(300),
    IN p_nif CHAR(9)
)
AS $$
BEGIN
    INSERT INTO cliente (email, senha, nome, nif)
    VALUES (p_email, p_senha, p_nome, p_nif);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE sp_update_cliente(
    IN p_id INT,
    IN p_email VARCHAR(500),
    IN p_senha VARCHAR(400),
    IN p_nome VARCHAR(300),
    IN p_nif CHAR(9)
)
AS $$
BEGIN
    UPDATE cliente
    SET email = p_email, senha = p_senha, nome = p_nome, nif = p_nif
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE sp_delete_cliente(
    IN p_id INT
)
AS $$
BEGIN
    DELETE FROM cliente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_read_cliente()
RETURNS SETOF cliente AS $$
BEGIN
    RETURN QUERY SELECT * FROM cliente;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_readone_cliente(
    IN p_id INT
)
RETURNS cliente AS $$
DECLARE
    cliente_encontrado cliente;
BEGIN
    SELECT * INTO cliente_encontrado FROM cliente WHERE id = p_id;
    RETURN cliente_encontrado;
END;
$$ LANGUAGE plpgsql;