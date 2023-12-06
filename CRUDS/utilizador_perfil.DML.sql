-- Stored Procedure para Create (Insert)
CREATE OR REPLACE PROCEDURE sp_create_utilizador_perfil(
    p_perfil VARCHAR(100)
)
AS $$
BEGIN
    INSERT INTO utilizador_perfil (perfil) VALUES (p_perfil);
END;
$$ LANGUAGE plpgsql;

-- Stored Procedure para Update
CREATE OR REPLACE PROCEDURE sp_update_utilizador_perfil(
    p_id INT,
    p_perfil VARCHAR(100)
)
AS $$
BEGIN
    UPDATE utilizador_perfil
    SET perfil = p_perfil
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;

-- Stored Procedure para Delete
CREATE OR REPLACE PROCEDURE sp_delete_utilizador_perfil(
    p_id INT
)
AS $$
BEGIN
    DELETE FROM utilizador_perfil
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;

-- Função para Read (Select)
CREATE OR REPLACE FUNCTION fn_read_utilizador_perfil()
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    perfil VARCHAR(100)
)
AS $$
BEGIN
    RETURN QUERY SELECT id, data_criacao, perfil FROM utilizador_perfil;
END;
$$ LANGUAGE plpgsql;

-- Função para ReadOne (Select com filtro por ID)
CREATE OR REPLACE FUNCTION fn_readone_utilizador_perfil(
    p_id INT
)
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    perfil VARCHAR(100)
)
AS $$
BEGIN
    RETURN QUERY SELECT id, data_criacao, perfil FROM utilizador_perfil WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;
