CREATE OR REPLACE PROCEDURE sp_utilizador_create(
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




CREATE OR REPLACE PROCEDURE sp_utilizador_update(
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
    SET
        email = p_email,
        senha = p_senha,
        nome = p_nome,
        sobrenome = p_sobrenome,
        perfil_id = p_perfil_id
    WHERE id = p_id;
END;
$$;




CREATE OR REPLACE PROCEDURE sp_utilizador_delete(
    p_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM utilizador WHERE id = p_id;
END;
$$;




CREATE OR REPLACE VIEW vw_utilizador_read AS
SELECT * FROM utilizador;




CREATE OR REPLACE PROCEDURE sp_utilizador_readOne(
    p_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM utilizador WHERE id = p_id;
END;
$$;
