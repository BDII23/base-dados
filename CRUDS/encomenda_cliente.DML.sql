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
    p_cliente_id INT,
    p_fatura_id INT)
RETURNS VOID AS
$$
BEGIN

    IF p_data_criacao IS NULL THEN
        RAISE EXCEPTION 'A data de criação da encomenda do cliente não pode ser nula.';
    END IF;

    IF p_estado_id IS NULL OR p_estado_id < 0 THEN
        RAISE EXCEPTION 'O estado ID da encomenda do cliente não pode ser um valor nulo ou negativo.';
    END IF;

    IF p_cliente_id IS NULL OR p_cliente_id < 0 THEN
        RAISE EXCEPTION 'O cliente ID da encomenda do cliente não pode ser um valor nulo ou negativo.';
    END IF;

    IF p_fatura_id IS NOT NULL AND p_fatura_id < 0 THEN
        RAISE EXCEPTION 'O fatura ID da encomenda do cliente não pode ser negativo.';
    END IF;

    INSERT INTO encomenda_cliente (data_criacao, estado_id, cliente_id, fatura_id)
    VALUES (p_data_criacao, p_estado_id, p_cliente_id, p_fatura_id);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION sp_update_encomenda_cliente(
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



CREATE OR REPLACE FUNCTION fn_read_encomenda_cliente()
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    estado_id INT,
    cliente_id INT,
    fatura_id INT
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
    cliente_id INT,
    fatura_id INT
) AS
$$
BEGIN
    RETURN QUERY SELECT * FROM encomenda_cliente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;
