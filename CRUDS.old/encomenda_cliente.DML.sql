CREATE OR REPLACE FUNCTION sp_delete_encomenda_cliente(p_id INT)
RETURNS VOID AS
$$
BEGIN
    DELETE FROM encomenda_cliente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION sp_create_encomenda_cliente(
    p_data_criacao TIMESTAMP,
    p_estado_id INT,
    p_cliente_id INT)
RETURNS VOID AS
$$
BEGIN
    INSERT INTO encomenda_cliente (data_criacao, estado_id, cliente_id)
    VALUES (p_data_criacao, p_estado_id, p_cliente_id);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION sp_update_encomenda_cliente(
    p_id INT,
    p_data_criacao TIMESTAMP,
    p_estado_id INT,
    p_cliente_id INT)
RETURNS VOID AS
$$
BEGIN
    UPDATE encomenda_cliente
    SET 
        data_criacao = p_data_criacao,
        estado_id = p_estado_id,
        estado_algumacoisa_id = p_estado_id,
        cliente_id = p_cliente_id
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_read_encomenda_cliente()
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    estado_id INT,
    cliente_id INT
) AS
$$
BEGIN
    RETURN QUERY SELECT * FROM encomenda_cliente;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_readOne_encomenda_cliente(p_id INT)
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    estado_id INT,
    cliente_id INT
) AS
$$
BEGIN
    RETURN QUERY SELECT * FROM encomenda_cliente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;
