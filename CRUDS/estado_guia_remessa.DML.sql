CREATE OR REPLACE FUNCTION sp_estado_guia_remessa_create(
    p_estado VARCHAR(100)
) RETURNS VOID AS $$
BEGIN
    INSERT INTO estado_guia_remessa (estado) VALUES (p_estado);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION sp_estado_guia_remessa_update(
    p_id INT,
    p_estado VARCHAR(100)
) RETURNS VOID AS $$
BEGIN
    UPDATE estado_guia_remessa
    SET estado = p_estado
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION sp_estado_guia_remessa_delete(
    p_id INT
) RETURNS VOID AS $$
BEGIN
    DELETE FROM estado_guia_remessa
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE VIEW vw_estado_guia_remessa_read AS
    SELECT id, data_criacao, estado
    FROM estado_guia_remessa;




CREATE OR REPLACE FUNCTION sp_estado_guia_remessa_readOne(
    p_id INT
) RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    estado VARCHAR(100)
) AS $$
BEGIN
    RETURN QUERY SELECT id, data_criacao, estado
                 FROM estado_guia_remessa
                 WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;