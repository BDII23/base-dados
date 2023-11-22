CREATE OR REPLACE FUNCTION sp_tipo_mao_obra_create(
    p_tipo VARCHAR(100),
    p_custo MONEY
) RETURNS VOID AS $$
BEGIN
    INSERT INTO tipo_mao_obra(tipo, custo) VALUES (p_tipo, p_custo);
END;
$$ LANGUAGE plpgsql;





CREATE OR REPLACE FUNCTION sp_tipo_mao_obra_update(
    p_id INT,
    p_tipo VARCHAR(100),
    p_custo MONEY
) RETURNS VOID AS $$
BEGIN
    UPDATE tipo_mao_obra
    SET tipo = p_tipo, custo = p_custo
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;






CREATE OR REPLACE FUNCTION sp_tipo_mao_obra_delete(
    p_id INT
) RETURNS VOID AS $$
BEGIN
    DELETE FROM tipo_mao_obra WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;






CREATE OR REPLACE VIEW vw_tipo_mao_obra_read AS
SELECT * FROM tipo_mao_obra;





CREATE OR REPLACE FUNCTION sp_tipo_mao_obra_readOne(
    p_id INT
) RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    tipo VARCHAR(100),
    custo MONEY
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM tipo_mao_obra WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;
