-- Procedimento Armazenado para DELETE
CREATE OR REPLACE PROCEDURE delete_fatura_fornecedor(IN p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM fatura_fornecedor WHERE id = p_id;
END;
$$;

-- Procedimento Armazenado para CREATE
CREATE OR REPLACE PROCEDURE create_fatura_fornecedor(
  IN p_descricao TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN

  IF p_descricao IS NULL OR p_descricao = '' THEN
        RAISE EXCEPTION 'A descrição não pode ser nula ou vazia.';
    END IF;
    
  INSERT INTO fatura_fornecedor (descricao) VALUES (p_descricao);
END;
$$;

-- Procedimento Armazenado para UPDATE
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

-- Função para READ
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

-- Função para READOne com base no ID
CREATE OR REPLACE FUNCTION read_one_fatura_fornecedor(IN p_id INT)
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