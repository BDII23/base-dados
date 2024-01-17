CREATE OR REPLACE FUNCTION delete_detalhe_encomenda_cliente(_id INT)
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
    INSERT INTO detalhe_encomenda_cliente (quantidade, custo_unidade, equipamento_id, encomenda_id)
    VALUES (_quantidade, _custo_unidade, _equipamento_id, _encomenda_id);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION update_detalhe_encomenda_cliente(
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



CREATE OR REPLACE FUNCTION read_detalhe_encomenda_cliente()
RETURNS SETOF detalhe_encomenda_cliente
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM detalhe_encomenda_cliente;
END;
$$;



CREATE OR REPLACE FUNCTION readone_detalhe_encomenda_cliente(p_id INT)
RETURNS SETOF detalhe_encomenda_cliente
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM detalhe_encomenda_cliente WHERE id = p_id;
END;
$$;




CREATE OR REPLACE FUNCTION readjson_detalhe_encomenda_cliente()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT array_to_json(array_agg(row_to_json(row)))
    INTO json
    FROM (SELECT * FROM detalhe_encomenda_cliente) row;

    RETURN json;
END;
$$ LANGUAGE plpgsql;