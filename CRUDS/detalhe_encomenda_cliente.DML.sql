CREATE OR REPLACE FUNCTION sp_delete_detalhe_encomenda_cliente(_id INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM detalhe_encomenda_cliente WHERE id = _id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION sp_create_detalhe_encomenda_cliente(
    _quantidade INT,
    _custo_unidade MONEY,
    _equipamento_id INT,
    _encomenda_id INT)
RETURNS VOID AS $$
BEGIN
    
    IF _quantidade <= 0 THEN
        RAISE EXCEPTION 'A quantidade deve ser maior que zero.';
    END IF;

    IF _custo_unidade < 0 THEN
        RAISE EXCEPTION 'O custo por unidade não pode ser negativo.';
    END IF;

    IF _equipamento_id IS NULL THEN
        RAISE EXCEPTION 'O equipamento_id não pode ser nulo.';
    END IF;

    IF _encomenda_id IS NULL THEN
        RAISE EXCEPTION 'O encomenda_id não pode ser nulo.';
    END IF;

    INSERT INTO detalhe_encomenda_cliente (quantidade, custo_unidade, equipamento_id, encomenda_id)
    VALUES (_quantidade, _custo_unidade, _equipamento_id, _encomenda_id);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION sp_update_detalhe_encomenda_cliente(
    _id INT,
    _quantidade INT,
    _custo_unidade MONEY,
    _equipamento_id INT,
    _encomenda_id INT)
RETURNS VOID AS $$
BEGIN
    UPDATE detalhe_encomenda_cliente
    SET 
        quantidade = _quantidade,
        custo_unidade = _custo_unidade,
        equipamento_id = _equipamento_id,
        encomenda_id = _encomenda_id
    WHERE id = _id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_read_detalhe_encomenda_cliente()
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    quantidade INT,
    custo_unidade MONEY,
    equipamento_id INT,
    encomenda_id INT
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM detalhe_encomenda_cliente;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_readone_detalhe_encomenda_cliente(_id INT)
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    quantidade INT,
    custo_unidade MONEY,
    equipamento_id INT,
    encomenda_id INT
) AS $$
BEGIN
    RETURN QUERY SELECT * FROM detalhe_encomenda_cliente WHERE id = _id;
END;
$$ LANGUAGE plpgsql;
