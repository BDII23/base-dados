CREATE OR REPLACE PROCEDURE sp_detalhe_ficha_producao_create(
    IN p_descricao TEXT,
    IN p_componente_id INT
)
AS $$
BEGIN
    INSERT INTO detalhe_ficha_producao (descricao, componente_id)
    VALUES (p_descricao, p_componente_id);
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE sp_detalhe_ficha_producao_update(
    IN p_id INT,
    IN p_descricao TEXT,
    IN p_componente_id INT
)
AS $$
BEGIN
    UPDATE detalhe_ficha_producao
    SET descricao = p_descricao, componente_id = p_componente_id
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE sp_detalhe_ficha_producao_delete(
    IN p_id INT
)
AS $$
BEGIN
    DELETE FROM detalhe_ficha_producao WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE VIEW vw_detalhe_ficha_producao_read AS
SELECT * FROM detalhe_ficha_producao;




CREATE OR REPLACE PROCEDURE sp_detalhe_ficha_producao_readOne(
    IN p_id INT
)
AS $$
BEGIN
    SELECT * FROM detalhe_ficha_producao WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



