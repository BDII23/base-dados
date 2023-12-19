-- Create

CREATE OR REPLACE FUNCTION criar_ficha_producao(
    quantidade_equipamentos INT,
    descricao TEXT,
    horas INT,
    detalhe_id INT,
    utilizador_id INT,
    tipo_mao_obra_id INT,
    equipamento_id INT
)
RETURNS VOID AS $$
BEGIN

    IF quantidade_equipamentos < 0 THEN
        RAISE EXCEPTION 'A quantidade de equipamentos não pode ser negativo';
    END IF;

    IF  descricao is null or descricao = '' THEN
        RAISE EXCEPTION 'A descricao de equipamentos não pode ser negativa ou nula';
    END IF;

    IF horas < 0 THEN
        RAISE EXCEPTION 'O numero de horas não pode ser negativo';
    END IF;

    IF detalhe_id < 0 THEN
        RAISE EXCEPTION 'O detalhe ID não pode ser negativo';
    END IF;

    IF utilizador_id < 0 THEN
        RAISE EXCEPTION 'O utilizador ID não pode ser negativo';
    END IF;

    IF tipo_mao_obra_id < 0 THEN
        RAISE EXCEPTION 'O tipo de mão de obra ID não pode ser negativo';
    END IF;

    IF equipamento_id < 0 THEN
        RAISE EXCEPTION 'O equipamento ID não pode ser negativo';
    END IF;

    INSERT INTO ficha_producao(
        quantidade_equipamentos,
        descricao,
        horas,
        detalhe_id,
        utilizador_id,
        tipo_mao_obra_id,
        equipamento_id
    ) VALUES (
        quantidade_equipamentos,
        descricao,
        horas,
        detalhe_id,
        utilizador_id,
        tipo_mao_obra_id,
        equipamento_id
    );
END;
$$ LANGUAGE plpgsql;

--Update
CREATE OR REPLACE FUNCTION atualizar_ficha_producao(
    ficha_id INT,
    quantidade_equipamentos INT,
    descricao TEXT,
    horas INT,
    detalhe_id INT,
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
        detalhe_id = detalhe_id,
        utilizador_id = utilizador_id,
        tipo_mao_obra_id = tipo_mao_obra_id,
        equipamento_id = equipamento_id
    WHERE id = ficha_id;
END;
$$ LANGUAGE plpgsql;

--Delete
CREATE OR REPLACE FUNCTION excluir_ficha_producao(ficha_id INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM ficha_producao WHERE id = ficha_id;
END;
$$ LANGUAGE plpgsql;


--Read
CREATE OR REPLACE FUNCTION obter_todas_fichas_producao()
RETURNS SETOF ficha_producao AS $$
BEGIN
    RETURN QUERY SELECT * FROM ficha_producao;
END;
$$ LANGUAGE plpgsql;

--Read One
CREATE OR REPLACE FUNCTION obter_ficha_producao_por_id(ficha_id INT)
RETURNS ficha_producao AS $$
DECLARE
    ficha ficha_producao;
BEGIN
    SELECT * INTO ficha FROM ficha_producao WHERE id = ficha_id;
    RETURN ficha;
END;
$$ LANGUAGE plpgsql;
