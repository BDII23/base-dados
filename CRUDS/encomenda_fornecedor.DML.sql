CREATE OR REPLACE PROCEDURE sp_delete_encomenda_fornecedor(
    in_id INT
)
AS $$
BEGIN
    DELETE FROM encomenda_fornecedor WHERE id = in_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE sp_create_encomenda_fornecedor(
    in_estado_id INT,
    in_fornecedor_id INT
)
AS $$
BEGIN

    IF in_estado_id IS NULL OR in_estado_id < 0 THEN
        RAISE EXCEPTION 'O estado ID da encomenda do fornecedor não pode ser nulo ou negativo.';
    END IF;

    IF in_fornecedor_id IS NULL OR in_fornecedor_id < 0 THEN
        RAISE EXCEPTION 'O fornecedor ID da encomenda do fornecedor não pode ser nulo ou negativo.';
    END IF;

    IF in_fatura_id < 0 THEN
        RAISE EXCEPTION 'A fatura ID da encomenda do fornecedor não pode ser negativo.';
    END IF;

    INSERT INTO encomenda_fornecedor (estado_id, fornecedor_id, fatura_id)
    VALUES (in_estado_id, in_fornecedor_id, in_fatura_id);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE sp_update_encomenda_fornecedor(
    in_id INT,
    in_estado_id INT,
    in_fornecedor_id INT
)
AS $$
BEGIN
    UPDATE encomenda_fornecedor
    SET estado_id = in_estado_id,
        fornecedor_id = in_fornecedor_id,
        fatura_id = in_fatura_id
    WHERE id = in_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_read_encomenda_fornecedor()
RETURNS TABLE (
    out_id INT,
    out_data_criacao TIMESTAMP,
    out_estado_id INT,
    out_fornecedor_id INT
)
AS $$
BEGIN
    RETURN QUERY SELECT id, data_criacao, estado_id, fornecedor_id, fatura_id FROM encomenda_fornecedor;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_readone_encomenda_fornecedor(in_id INT)
RETURNS TABLE (
    out_id INT,
    out_data_criacao TIMESTAMP,
    out_estado_id INT,
    out_fornecedor_id INT
)
AS $$
BEGIN
    RETURN QUERY SELECT id, data_criacao, estado_id, fornecedor_id, fatura_id FROM encomenda_fornecedor WHERE id = in_id;
END;
$$ LANGUAGE plpgsql;
