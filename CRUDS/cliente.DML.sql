CREATE OR REPLACE PROCEDURE sp_cliente_create(
    p_email VARCHAR(500),
    p_senha VARCHAR(400),
    p_nome VARCHAR(300),
    p_nif CHAR(9)
)
AS
$$
BEGIN
    INSERT INTO cliente (email, senha, nome, nif)
    VALUES (p_email, p_senha, p_nome, p_nif);
END;
$$ LANGUAGE plpgsql;

/* ========================================================== */

CREATE OR REPLACE PROCEDURE sp_cliente_update(
    p_id SERIAL,
    p_email VARCHAR(500),
    p_senha VARCHAR(400),
    p_nome VARCHAR(300),
    p_nif CHAR(9)
)
AS
$$
BEGIN
    UPDATE cliente
    SET email = p_email, senha = p_senha, nome = p_nome, nif = p_nif
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;

/* ========================================================== */

CREATE OR REPLACE PROCEDURE sp_cliente_delete(
    p_id SERIAL
)
AS
$$
BEGIN
    DELETE FROM cliente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE VIEW vw_cliente_read AS
SELECT * FROM cliente;

/* ========================================================== */

CREATE OR REPLACE PROCEDURE sp_cliente_readOne(
    p_id SERIAL
)
AS
$$
BEGIN
    SELECT * FROM cliente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;

/* ========================================================== */

CREATE OR REPLACE VIEW vw_cliente_read AS
SELECT * FROM cliente;