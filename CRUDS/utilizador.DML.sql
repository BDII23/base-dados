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



CREATE OR REPLACE FUNCTION read_utilizador()
RETURNS SETOF utilizador
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM utilizador;
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
    SELECT array_to_json(array_agg(row_to_json(row)))
    INTO json
    FROM (SELECT * FROM utilizador) row;

    RETURN json;
END;
$$ LANGUAGE plpgsql;