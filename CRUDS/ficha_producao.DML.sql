CREATE OR REPLACE FUNCTION create_ficha_producao(
    quantidade_equipamentos INT,
    descricao TEXT,
    horas INT,
    utilizador_id INT,
    tipo_mao_obra_id INT,
    equipamento_id INT
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO ficha_producao(
        quantidade_equipamentos,
        descricao,
        horas,
        utilizador_id,
        tipo_mao_obra_id,
        equipamento_id
    ) VALUES (
        quantidade_equipamentos,
        descricao,
        horas,
        utilizador_id,
        tipo_mao_obra_id,
        equipamento_id
    );
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION update_ficha_producao(
    ficha_id INT,
    quantidade_equipamentos INT,
    descricao TEXT,
    horas INT,
    utilizador_id INT,
    tipo_mao_obra_id INT,
    equipamento_id INT
)
RETURNS VOID AS $$
BEGIN
    UPDATE ficha_producao
    SET
        quantidade_equipamentos = quantidade_equipamentos,
        descricao = descricao,
        horas = horas,
        utilizador_id = utilizador_id,
        tipo_mao_obra_id = tipo_mao_obra_id,
        equipamento_id = equipamento_id
    WHERE id = ficha_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION delete_ficha_producao(ficha_id INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM ficha_producao WHERE id = ficha_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION read_ficha_producao()
RETURNS SETOF ficha_producao
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM ficha_producao;
END;
$$;



CREATE OR REPLACE FUNCTION readone_ficha_producao(p_id INT)
RETURNS SETOF ficha_producao
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM ficha_producao WHERE id = p_id;
END;
$$;