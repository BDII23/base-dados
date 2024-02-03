CREATE OR REPLACE FUNCTION login_utilizador(_email VARCHAR, _senha VARCHAR)
RETURNS TABLE (
    existe BOOLEAN,
	id INT,
    nome VARCHAR,
    sobrenome VARCHAR,
    email VARCHAR,
    perfil VARCHAR
) AS $$
BEGIN
    SELECT
        TRUE,
		ut.id,
        ut.nome,
        ut.sobrenome,
        ut.email,
        up.perfil
    INTO 
        existe,
		id,
        nome,
        sobrenome,
        email,
        perfil
    FROM utilizador ut
    JOIN utilizador_perfil up ON up.id = ut.perfil_id
    WHERE ut.email = _email AND ut.senha = _senha;

    IF NOT FOUND THEN
        existe := FALSE;
    END IF;

    RETURN NEXT;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE delete_utilizador(p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM utilizador WHERE id = p_id;
END;
$$;



CREATE OR REPLACE PROCEDURE create_utilizador(
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



CREATE OR REPLACE PROCEDURE update_utilizador(
    p_id INT,
    p_email VARCHAR(500),
    p_nome VARCHAR(300),
    p_sobrenome VARCHAR(300),
    p_perfil_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE utilizador
    SET email = p_email,
        nome = p_nome,
        sobrenome = p_sobrenome,
        perfil_id = p_perfil_id
    WHERE id = p_id;
END;
$$;



CREATE OR REPLACE FUNCTION readone_utilizador(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(utilizador)
    INTO json
    FROM utilizador
	WHERE p_id = utilizador.id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_utilizador()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(utilizador)
    INTO json
    FROM (
        SELECT
            utilizador.*,
            (
                SELECT json_agg(utilizador_perfil)
                FROM utilizador_perfil
                WHERE utilizador_perfil.id = utilizador.perfil_id
            ) utilizador_perfil
        FROM utilizador
	) utilizador;

    RETURN json;
END;
$$ LANGUAGE plpgsql;