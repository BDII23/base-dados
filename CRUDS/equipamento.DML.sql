CREATE OR REPLACE FUNCTION delete_equipamento(in_id INT)
RETURNS VOID AS $$
BEGIN
  DELETE FROM equipamento WHERE id = in_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION create_equipamento(
    in_descricao TEXT,
    in_tipo_id INT
)
RETURNS VOID AS $$
BEGIN
  INSERT INTO equipamento (descricao, tipo_id) VALUES (in_descricao, in_tipo_id);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION update_equipamento(
    in_id INT,
    in_descricao TEXT,
    in_tipo_id INT
)
RETURNS VOID AS $$
BEGIN
  UPDATE equipamento SET descricao = in_descricao, tipo_id = in_tipo_id WHERE id = in_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION read_equipamento()
RETURNS SETOF equipamento
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM equipamento;
END;
$$;



CREATE OR REPLACE FUNCTION readone_equipamento(p_id INT)
RETURNS SETOF equipamento
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM equipamento WHERE id = p_id;
END;
$$;



CREATE OR REPLACE FUNCTION readjson_equipamento()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(equipamento)
    INTO json
    FROM (
        SELECT
            equipamento.*,
            (
                SELECT json_agg(tipo_equipamento)
                FROM tipo_equipamento
                WHERE tipo_equipamento.id = equipamento.tipo_id
            ) tipo_equipamento
        FROM equipamento
		) equipamento;

    RETURN json;
END;
$$ LANGUAGE plpgsql;