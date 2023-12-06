-- Create
CREATE OR REPLACE PROCEDURE create_fornecedor(
    p_nome VARCHAR(100),
    p_nif CHAR(9),
    p_email VARCHAR(200),
    p_telefone CHAR(9),
    p_endereco VARCHAR(500)
)
AS $$
BEGIN
    INSERT INTO fornecedor (nome, nif, email, telefone, endereco)
    VALUES (p_nome, p_nif, p_email, p_telefone, p_endereco);
END;
$$ LANGUAGE plpgsql;

--Delete
CREATE OR REPLACE PROCEDURE delete_fornecedor(p_id INT)
AS $$
BEGIN
    DELETE FROM fornecedor WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;


--Update
CREATE OR REPLACE PROCEDURE update_fornecedor(
    p_id INT,
    p_nome VARCHAR(100),
    p_nif CHAR(9),
    p_email VARCHAR(200),
    p_telefone CHAR(9),
    p_endereco VARCHAR(500)
)
AS $$
BEGIN
    UPDATE fornecedor
    SET nome = p_nome,
        nif = p_nif,
        email = p_email,
        telefone = p_telefone,
        endereco = p_endereco
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;

--Read all
CREATE OR REPLACE FUNCTION read_fornecedor()
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    nome VARCHAR(100),
    nif CHAR(9),
    email VARCHAR(200),
    telefone CHAR(9),
    endereco VARCHAR(500)
)
AS $$
BEGIN
    RETURN QUERY SELECT * FROM fornecedor;
END;
$$ LANGUAGE plpgsql;

--ReadOne
CREATE OR REPLACE FUNCTION readone_fornecedor(p_id INT)
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    nome VARCHAR(100),
    nif CHAR(9),
    email VARCHAR(200),
    telefone CHAR(9),
    endereco VARCHAR(500)
)
AS $$
BEGIN
    RETURN QUERY SELECT * FROM fornecedor WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;