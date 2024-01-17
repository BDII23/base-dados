CREATE OR REPLACE FUNCTION screate_armazem(p_endereco VARCHAR(100))
RETURNS VOID AS $$
BEGIN
    INSERT INTO armazem (endereco) VALUES (p_endereco);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION update_armazem(p_id INT, p_endereco VARCHAR(100))
RETURNS VOID AS $$
BEGIN
    UPDATE armazem SET endereco = p_endereco WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION delete_armazem(p_id INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM armazem WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION read_armazem()
RETURNS SETOF armazem AS $$
BEGIN
    RETURN QUERY SELECT * FROM armazem;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION readone_armazem(p_id INT)
RETURNS SETOF armazem AS $$
BEGIN
    RETURN QUERY SELECT * FROM armazem WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;