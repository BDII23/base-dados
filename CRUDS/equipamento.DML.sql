CREATE OR REPLACE PROCEDURE sp_equipamento_create(
    p_descricao TEXT,
    p_tipo_id INT
)
AS $$
BEGIN
    INSERT INTO equipamento (descricao, tipo_id) VALUES (p_descricao, p_tipo_id);
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE sp_equipamento_update(
    p_id INT,
    p_descricao TEXT,
    p_tipo_id INT
)
AS $$
BEGIN
    UPDATE equipamento
    SET descricao = p_descricao, tipo_id = p_tipo_id
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE sp_equipamento_delete(
    p_id INT
)
AS $$
BEGIN
    DELETE FROM equipamento WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE VIEW vw_equipamento_read AS
SELECT * FROM equipamento;





CREATE OR REPLACE PROCEDURE sp_equipamento_readOne(
    p_id INT
)
AS $$
BEGIN
    SELECT * FROM equipamento WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;
