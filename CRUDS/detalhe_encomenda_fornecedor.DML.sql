CREATE OR REPLACE PROCEDURE delete_detalhe_encomenda_fornecedor(p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM detalhe_encomenda_fornecedor WHERE id = p_id;
END;
$$;



CREATE OR REPLACE PROCEDURE create_detalhe_encomenda_fornecedor(
    p_quantidade INT,
    p_custo_entidade MONEY,
    p_componente_id INT,
    p_encomenda_id INT
)
AS $$
BEGIN
    INSERT INTO detalhe_encomenda_fornecedor(quantidade, custo_entidade, componente_id, encomenda_id)
    VALUES (p_quantidade, p_custo_entidade, p_componente_id, p_encomenda_id);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_detalhe_encomenda_fornecedor(
    p_id INT,
    p_quantidade INT,
    p_custo_entidade MONEY,
    p_componente_id INT,
    p_encomenda_id INT)
AS $$
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



CREATE OR REPLACE FUNCTION readone_detalhe_encomenda_fornecedor(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(detalhe_encomenda_fornecedor)
    INTO json
    FROM detalhe_encomenda_fornecedor
	WHERE p_id = detalhe_encomenda_fornecedor.id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



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