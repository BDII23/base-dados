CREATE OR REPLACE PROCEDURE sp_delete_estado_guia_remessa(IN p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM estado_guia_remessa WHERE id = p_id;
END;
$$;



CREATE OR REPLACE PROCEDURE sp_create_estado_guia_remessa(IN p_estado VARCHAR(100))
LANGUAGE plpgsql
AS $$
BEGIN

  IF p_estado IS NULL OR p_estado = '' THEN
        RAISE EXCEPTION 'O estado não pode ser nulo ou vazio.';
    END IF;
    
  INSERT INTO estado_guia_remessa(estado) VALUES (p_estado);
END;
$$;



CREATE OR REPLACE PROCEDURE sp_update_estado_guia_remessa(IN p_id INT, IN p_estado VARCHAR(100))
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE estado_guia_remessa SET estado = p_estado WHERE id = p_id;
END;
$$;



CREATE OR REPLACE FUNCTION fn_read_estado_guia_remessa()
RETURNS SETOF estado_guia_remessa
AS
$$
BEGIN
    RETURN QUERY SELECT * FROM estado_guia_remessa;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_readone_estado_guia_remessa(IN p_id INT)
RETURNS SETOF estado_guia_remessa
AS
$$
BEGIN
    RETURN QUERY SELECT * FROM estado_guia_remessa WHERE id = p_id;
END;
$$
LANGUAGE plpgsql;