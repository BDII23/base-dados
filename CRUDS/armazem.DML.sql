CREATE OR REPLACE PROCEDURE sp_armazem_create(
    p_endereco VARCHAR(100)
)
AS
$$
BEGIN
    INSERT INTO armazem (endereco)
    VALUES (p_endereco);
END;
$$
LANGUAGE plpgsql;





CREATE OR REPLACE PROCEDURE sp_armazem_update(
    p_id INT,
    p_endereco VARCHAR(100)
)
AS
$$
BEGIN
    UPDATE armazem
    SET endereco = p_endereco
    WHERE id = p_id;
END;
$$
LANGUAGE plpgsql;





CREATE OR REPLACE PROCEDURE sp_armazem_delete(
    p_id INT
)
AS
$$
BEGIN
    DELETE FROM armazem WHERE id = p_id;
END;
$$
LANGUAGE plpgsql;





CREATE OR REPLACE VIEW vw_armazem_read AS
SELECT * FROM armazem;





CREATE OR REPLACE PROCEDURE sp_armazem_readOne(
    p_id INT
)
AS
$$
BEGIN
    SELECT * FROM armazem WHERE id = p_id;
END;
$$
LANGUAGE plpgsql;
