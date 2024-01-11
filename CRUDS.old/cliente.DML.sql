CREATE OR REPLACE PROCEDURE sp_create_cliente(
    IN p_email VARCHAR(500),
    IN p_senha VARCHAR(400),
    IN p_nome VARCHAR(300),
    IN p_nif CHAR(9)
)
AS $$
BEGIN

    IF p_email IS NULL OR p_email = '' THEN
        RAISE EXCEPTION 'O email do cliente não pode ser nulo ou vazio.';
    END IF;

    IF p_senha IS NULL OR p_senha = '' THEN
        RAISE EXCEPTION 'A senha do cliente não pode ser nula ou vazia.';
    END IF;

    IF p_nome IS NULL OR p_nome = '' THEN
        RAISE EXCEPTION 'O nome do cliente não pode ser nulo ou vazio.';
    END IF;

    IF LENGTH(p_nif) <> 9 THEN
        RAISE EXCEPTION 'O NIF do cliente deve ter 9 caracteres.';
    END IF;

    IF NOT p_nif ~ '^\d+$' THEN
        RAISE EXCEPTION 'O NIF do cliente deve conter apenas dígitos.';
    END IF;

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