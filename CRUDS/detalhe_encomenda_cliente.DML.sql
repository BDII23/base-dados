CREATE OR REPLACE PROCEDURE delete_detalhe_encomenda_cliente(p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM detalhe_encomenda_cliente WHERE id = _id;
END;
$$;



CREATE OR REPLACE PROCEDURE create_detalhe_encomenda_cliente(
    _quantidade INT,
    _custo_unidade MONEY,
    _equipamento_id INT,
    _encomenda_id INT
)
AS $$
BEGIN
    INSERT INTO detalhe_encomenda_cliente (quantidade, custo_unidade, equipamento_id, encomenda_id)
    VALUES (_quantidade, _custo_unidade, _equipamento_id, _encomenda_id);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_detalhe_encomenda_cliente(
    _id INT,
    _quantidade INT,
    _custo_unidade MONEY,
    _equipamento_id INT,
    _encomenda_id INT)
AS $$
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



CREATE OR REPLACE FUNCTION readone_detalhe_encomenda_cliente(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(detalhe_encomenda_cliente)
    INTO json
    FROM detalhe_encomenda_cliente
	WHERE p_id = detalhe_encomenda_cliente.id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;




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