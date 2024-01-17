CREATE OR REPLACE FUNCTION delete_detalhe_encomenda_fornecedor(p_id INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM detalhe_encomenda_fornecedor WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION create_detalhe_encomenda_fornecedor(
    p_quantidade INT,
    p_custo_entidade MONEY,
    p_componente_id INT,
    p_encomenda_id INT
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO detalhe_encomenda_fornecedor(
        quantidade, custo_entidade, componente_id, encomenda_id
    ) VALUES (
        p_quantidade, p_custo_entidade, p_componente_id, p_encomenda_id
    );
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION update_detalhe_encomenda_fornecedor(
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



CREATE OR REPLACE FUNCTION read_detalhe_encomenda_fornecedor()
RETURNS SETOF detalhe_encomenda_fornecedor
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM detalhe_encomenda_fornecedor;
END;
$$;



CREATE OR REPLACE FUNCTION readone_detalhe_encomenda_fornecedor(p_id INT)
RETURNS SETOF detalhe_encomenda_fornecedor
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM detalhe_encomenda_fornecedor WHERE id = p_id;
END;
$$;



CREATE OR REPLACE FUNCTION readjson_detalhe_encomenda_fornecedor()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT array_to_json(array_agg(row_to_json(row)))
    INTO json
    FROM (SELECT * FROM detalhe_encomenda_fornecedor) row;

    RETURN json;
END;
$$ LANGUAGE plpgsql;