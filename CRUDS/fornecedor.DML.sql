CREATE OR REPLACE PROCEDURE sp_fornecedor_create(
    p_nome VARCHAR(100),
    p_nif CHAR(9),
    p_email VARCHAR(200),
    p_telefone CHAR(9),
    p_endereco VARCHAR(500)
)
AS
$$
BEGIN
    INSERT INTO fornecedor (nome, nif, email, telefone, endereco) 
    VALUES (p_nome, p_nif, p_email, p_telefone, p_endereco);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE sp_fornecedor_update(
    p_id SERIAL,
    p_nome VARCHAR(100),
    p_nif CHAR(9),
    p_email VARCHAR(200),
    p_telefone CHAR(9),
    p_endereco VARCHAR(500)
)
AS
$$
BEGIN
    UPDATE fornecedor 
    SET nome = p_nome, nif = p_nif, email = p_email, telefone = p_telefone, endereco = p_endereco
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE sp_fornecedor_delete(
    p_id SERIAL
)
AS
$$
BEGIN
    DELETE FROM fornecedor WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE VIEW vw_fornecedor_read AS
    SELECT * FROM fornecedor;


CREATE OR REPLACE PROCEDURE sp_fornecedor_readOne(
    p_id SERIAL
)
AS
$$
BEGIN
    SELECT * FROM fornecedor WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;
