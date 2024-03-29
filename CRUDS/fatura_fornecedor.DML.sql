CREATE OR REPLACE PROCEDURE delete_fatura_fornecedor(IN p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM fatura_fornecedor WHERE id = p_id;
END;
$$;



CREATE OR REPLACE PROCEDURE create_fatura_fornecedor(
  IN p_descricao TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO fatura_fornecedor (descricao) VALUES (p_descricao);
END;
$$;



CREATE OR REPLACE PROCEDURE update_fatura_fornecedor(
  IN p_id INT,
  IN p_descricao TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE fatura_fornecedor SET descricao = p_descricao WHERE id = p_id;
END;
$$;



CREATE OR REPLACE FUNCTION readone_fatura_fornecedor(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(fatura_fornecedor)
    INTO json
    FROM fatura_fornecedor
	WHERE p_id = fatura_fornecedor.id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_fatura_fornecedor()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT array_to_json(array_agg(row_to_json(row)))
    INTO json
    FROM (SELECT * FROM fatura_fornecedor) row;

    RETURN json;
END;
$$ LANGUAGE plpgsql;