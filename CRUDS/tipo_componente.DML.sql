CREATE OR REPLACE FUNCTION sp_tipo_componente_create(
    p_tipo VARCHAR(100)
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO tipo_componente (tipo) VALUES (p_tipo);
END;
$$ LANGUAGE plpgsql;





CREATE OR REPLACE FUNCTION sp_tipo_componente_update(
    p_id INT,
    p_tipo VARCHAR(100)
)
RETURNS VOID AS $$
BEGIN
    UPDATE tipo_componente SET tipo = p_tipo WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;






CREATE OR REPLACE FUNCTION sp_tipo_componente_delete(
    p_id INT
)
RETURNS VOID AS $$
BEGIN
    DELETE FROM tipo_componente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;








CREATE OR REPLACE VIEW vw_tipo_componente_read AS
SELECT * FROM tipo_componente;





CREATE OR REPLACE FUNCTION sp_tipo_componente_readOne(
    p_id INT
)
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    tipo VARCHAR(100)
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM tipo_componente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;




