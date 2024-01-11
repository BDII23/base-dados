CREATE OR REPLACE FUNCTION sp_delete_equipamento(in_id INT)
RETURNS VOID AS $$
BEGIN
  DELETE FROM equipamento WHERE id = in_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION sp_create_equipamento(
    in_descricao TEXT,
    in_tipo_id INT
)
RETURNS VOID AS $$
BEGIN
    IF in_descricao is null or in_descricao = '' THEN
      RAISE EXCEPTION 'A descrição do equipamento não pode ser nula ou vazia.';
    END IF;

    IF in_tipo_id is null or in_tipo_id < 0 THEN
      RAISE EXCEPTION 'O tipo ID do equipamento não pode ser negativo ou vazio.';
    END IF;


  INSERT INTO equipamento (descricao, tipo_id) VALUES (in_descricao, in_tipo_id);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION sp_update_equipamento(
    in_id INT,
    in_descricao TEXT,
    in_tipo_id INT
)
RETURNS VOID AS $$
BEGIN
  UPDATE equipamento SET descricao = in_descricao, tipo_id = in_tipo_id WHERE id = in_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_read_equipamento()
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    descricao TEXT,
    tipo_id INT
) AS $$
BEGIN
  RETURN QUERY SELECT * FROM equipamento;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_readone_equipamento(in_id INT)
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    descricao TEXT,
    tipo_id INT
) AS $$
BEGIN
  RETURN QUERY SELECT * FROM equipamento WHERE id = in_id;
END;
$$ LANGUAGE plpgsql;
