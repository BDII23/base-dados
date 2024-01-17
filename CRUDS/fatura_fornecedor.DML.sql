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

CREATE OR REPLACE FUNCTION read_fatura_fornecedor()
RETURNS TABLE (
  id INT,
  data_criacao TIMESTAMP,
  descricao TEXT
)
AS $$
BEGIN
  RETURN QUERY SELECT * FROM fatura_fornecedor;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION readone_fatura_fornecedor(IN p_id INT)
RETURNS TABLE (
  id INT,
  data_criacao TIMESTAMP,
  descricao TEXT
)
AS $$
BEGIN
  RETURN QUERY SELECT * FROM fatura_fornecedor WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;