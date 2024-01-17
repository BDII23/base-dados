CREATE OR REPLACE PROCEDURE delete_estado_encomenda(IN p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM estado_encomenda WHERE id = p_id;
END;
$$;

CREATE OR REPLACE PROCEDURE create_estado_encomenda(
    IN p_data_criacao TIMESTAMP,
    IN p_estado VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO estado_encomenda (data_criacao, estado) VALUES (p_data_criacao, p_estado);
END;
$$;

CREATE OR REPLACE PROCEDURE update_estado_encomenda(
    IN p_id INT,
    IN p_data_criacao TIMESTAMP,
    IN p_estado VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE estado_encomenda SET data_criacao = p_data_criacao, estado = p_estado WHERE id = p_id;
END;
$$;

CREATE OR REPLACE FUNCTION read_estado_encomenda()
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    estado VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM estado_encomenda;
END;
$$;

CREATE OR REPLACE FUNCTION readone_estado_encomenda(IN p_id INT)
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    estado VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM estado_encomenda WHERE id = p_id;
END;
$$;