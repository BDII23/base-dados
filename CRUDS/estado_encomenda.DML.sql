-- Procedimento Armazenado: sp_estado_encomenda_create
CREATE OR REPLACE PROCEDURE sp_estado_encomenda_create(
    IN p_estado VARCHAR(100)
)
LANGUAGE PLPGSQL
AS $$
BEGIN
    INSERT INTO estado_encomenda (estado) VALUES (p_estado);
END;
$$;




-- Procedimento Armazenado: sp_estado_encomenda_update
CREATE OR REPLACE PROCEDURE sp_estado_encomenda_update(
    IN p_id INT,
    IN p_estado VARCHAR(100)
)
LANGUAGE PLPGSQL
AS $$
BEGIN
    UPDATE estado_encomenda SET estado = p_estado WHERE id = p_id;
END;
$$;





-- Procedimento Armazenado: sp_estado_encomenda_delete
CREATE OR REPLACE PROCEDURE sp_estado_encomenda_delete(
    IN p_id INT
)
LANGUAGE PLPGSQL
AS $$
BEGIN
    DELETE FROM estado_encomenda WHERE id = p_id;
END;
$$;





-- View: vw_estado_encomenda_read
CREATE OR REPLACE VIEW vw_estado_encomenda_read AS
SELECT * FROM estado_encomenda;




-- Procedimento Armazenado: sp_estado_encomenda_readOne
CREATE OR REPLACE PROCEDURE sp_estado_encomenda_readOne(
    IN p_id INT
)
LANGUAGE PLPGSQL
AS $$
BEGIN
    SELECT * FROM estado_encomenda WHERE id = p_id;
END;
$$;
