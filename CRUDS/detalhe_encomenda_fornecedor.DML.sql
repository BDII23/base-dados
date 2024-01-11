CREATE OR REPLACE FUNCTION sp_delete_detalhe_encomenda_fornecedor(p_id INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM detalhe_encomenda_fornecedor WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION sp_create_detalhe_encomenda_fornecedor(
    p_quantidade INT,
    p_custo_entidade MONEY,
    p_componente_id INT,
    p_encomenda_id INT
)
RETURNS VOID AS $$
BEGIN
    
    IF p_quantidade <= 0 THEN
        RAISE EXCEPTION 'A quantidade deve ser maior que zero.';
    END IF;

    
    IF p_custo_entidade < 0 THEN
        RAISE EXCEPTION 'O custo por entidade não pode ser negativo.';
    END IF;


    IF p_componente_id IS NULL THEN
        RAISE EXCEPTION 'O componente_id não pode ser nulo.';
    END IF;

    
    IF p_encomenda_id IS NULL THEN
        RAISE EXCEPTION 'O encomenda_id não pode ser nulo.';
    END IF;
    
    INSERT INTO detalhe_encomenda_fornecedor(
        quantidade, custo_entidade, componente_id, encomenda_id
    ) VALUES (
        p_quantidade, p_custo_entidade, p_componente_id, p_encomenda_id
    );
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION sp_update_detalhe_encomenda_fornecedor(
    p_id INT,
    p_quantidade INT,
    p_custo_entidade MONEY,
    p_componente_id INT,
    p_encomenda_id INT
)
RETURNS VOID AS $$
BEGIN
    UPDATE detalhe_encomenda_fornecedor
    SET
        quantidade = p_quantidade,
        custo_entidade = p_custo_entidade,
        componente_id = p_componente_id,
        encomenda_id = p_encomenda_id
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_read_detalhe_encomenda_fornecedor()
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    quantidade INT,
    custo_entidade MONEY,
    componente_id INT,
    encomenda_id INT
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM detalhe_encomenda_fornecedor;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_readone_detalhe_encomenda_fornecedor(p_id INT)
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    quantidade INT,
    custo_entidade MONEY,
    componente_id INT,
    encomenda_id INT
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM detalhe_encomenda_fornecedor WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;