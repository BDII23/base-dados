CREATE OR REPLACE FUNCTION sp_create_armazem(p_endereco VARCHAR(100))
RETURNS VOID AS $$
BEGIN
    INSERT INTO armazem (endereco) VALUES (p_endereco);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION sp_update_armazem(p_id INT, p_endereco VARCHAR(100))
RETURNS VOID AS $$
BEGIN
    UPDATE armazem SET endereco = p_endereco WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION sp_delete_armazem(p_id INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM armazem WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_read_armazem()
RETURNS SETOF armazem AS $$
BEGIN
    RETURN QUERY SELECT * FROM armazem;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_readone_armazem(p_id INT)
RETURNS SETOF armazem AS $$
BEGIN
    RETURN QUERY SELECT * FROM armazem WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;