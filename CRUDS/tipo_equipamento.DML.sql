CREATE OR REPLACE FUNCTION sp_tipo_equipamento_create(
    p_tipo VARCHAR(150)
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO tipo_equipamento(tipo)
    VALUES (p_tipo);
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION sp_tipo_equipamento_update(
    p_id INT,
    p_tipo VARCHAR(150)
)
RETURNS VOID AS $$
BEGIN
    UPDATE tipo_equipamento
    SET tipo = p_tipo
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION sp_tipo_equipamento_delete(
    p_id INT
)
RETURNS VOID AS $$
BEGIN
    DELETE FROM tipo_equipamento
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE VIEW vw_tipo_equipamento_read AS
SELECT * FROM tipo_equipamento;




CREATE OR REPLACE FUNCTION sp_tipo_equipamento_readOne(
    p_id INT
)
RETURNS TABLE(
    id INT,
    data_criacao TIMESTAMP,
    tipo VARCHAR(150)
) AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM tipo_equipamento WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;
