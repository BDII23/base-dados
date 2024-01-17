CREATE OR REPLACE FUNCTION delete_encomenda_cliente(p_id INT)
RETURNS VOID AS
$$
BEGIN
    DELETE FROM encomenda_cliente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION create_encomenda_cliente(
    p_data_criacao TIMESTAMP,
    p_estado_id INT,
    p_cliente_id INT,
    p_fatura_id INT)
RETURNS VOID AS
$$
BEGIN
    INSERT INTO encomenda_cliente (data_criacao, estado_id, cliente_id, fatura_id)
    VALUES (p_data_criacao, p_estado_id, p_cliente_id, p_fatura_id);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION update_encomenda_cliente(
    p_id INT,
    p_data_criacao TIMESTAMP,
    p_estado_id INT,
    p_cliente_id INT,
    p_fatura_id INT)
RETURNS VOID AS
$$
BEGIN
    UPDATE encomenda_cliente
    SET 
        data_criacao = p_data_criacao,
        estado_id = p_estado_id,
        estado_algumacoisa_id = p_estado_id,
        cliente_id = p_cliente_id,
        fatura_id = p_fatura_id
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION read_encomenda_cliente()
RETURNS SETOF encomenda_cliente
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM encomenda_cliente;
END;
$$;



CREATE OR REPLACE FUNCTION readone_encomenda_cliente(p_id INT)
RETURNS SETOF encomenda_cliente
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM encomenda_cliente WHERE id = p_id;
END;
$$;