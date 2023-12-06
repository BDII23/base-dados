--delete
CREATE OR REPLACE PROCEDURE sp_delete_utilizador(p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM utilizador WHERE id = p_id;
END;
$$;

--insert
CREATE OR REPLACE PROCEDURE sp_create_utilizador(
    p_email VARCHAR(500),
    p_senha VARCHAR(400),
    p_nome VARCHAR(300),
    p_sobrenome VARCHAR(300),
    p_perfil_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO utilizador (email, senha, nome, sobrenome, perfil_id)
    VALUES (p_email, p_senha, p_nome, p_sobrenome, p_perfil_id);
END;
$$;

--update
CREATE OR REPLACE PROCEDURE sp_update_utilizador(
    p_id INT,
    p_email VARCHAR(500),
    p_senha VARCHAR(400),
    p_nome VARCHAR(300),
    p_sobrenome VARCHAR(300),
    p_perfil_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE utilizador
    SET email = p_email,
        senha = p_senha,
        nome = p_nome,
        sobrenome = p_sobrenome,
        perfil_id = p_perfil_id
    WHERE id = p_id;
END;
$$;

--read
CREATE OR REPLACE FUNCTION fn_read_utilizador()
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    email VARCHAR(500),
    senha VARCHAR(400),
    nome VARCHAR(300),
    sobrenome VARCHAR(300),
    perfil_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM utilizador;
END;
$$;

--read one
CREATE OR REPLACE FUNCTION fn_readone_utilizador(p_id INT)
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    email VARCHAR(500),
    senha VARCHAR(400),
    nome VARCHAR(300),
    sobrenome VARCHAR(300),
    perfil_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM utilizador WHERE id = p_id;
END;
$$;
