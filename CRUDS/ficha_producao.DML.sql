CREATE OR REPLACE PROCEDURE create_ficha_producao(
    quantidade_equipamentos INT,
    descricao TEXT,
    horas INT,
    utilizador_id INT,
    tipo_mao_obra_id INT,
    equipamento_id INT
)
AS $$
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



CREATE OR REPLACE PROCEDURE update_ficha_producao(
    ficha_id INT,
    quantidade_equipamentos INT,
    descricao TEXT,
    horas INT,
    utilizador_id INT,
    tipo_mao_obra_id INT,
    equipamento_id INT)
AS $$
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



CREATE OR REPLACE PROCEDURE delete_ficha_producao(p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM ficha_producao WHERE id = ficha_id;
END;
$$;



CREATE OR REPLACE FUNCTION read_ficha_producao()
RETURNS SETOF ficha_producao
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM ficha_producao;
END;
$$;



CREATE OR REPLACE FUNCTION readone_ficha_producao(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(ficha_producao)
    INTO json
    FROM ficha_producao
	WHERE p_id = ficha_producao.id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readonejson_ficha_producao(_ficha_producao_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(ficha_producao)
    INTO json
    FROM (
        SELECT ficha_producao.*,
            (
                SELECT json_agg(detalhe_ficha_producao)
                FROM (
                    SELECT detalhe_ficha_producao.*,
                        (
                            SELECT json_agg(componente)
                            FROM (
                                SELECT componente.*,
                                    (
                                        SELECT json_agg(tipo_componente)
                                        FROM tipo_componente
                                        WHERE tipo_componente.id = componente.tipo_id
                                    ) tipo_componente,
                                    (
                                        SELECT json_agg(armazem)
                                        FROM armazem
                                        WHERE armazem.id = componente.armazem_id
                                    ) armazem
                                FROM componente
                            ) componente
                            WHERE componente.id = detalhe_ficha_producao.componente_id
                        ) componente
                    FROM detalhe_ficha_producao
                    WHERE detalhe_ficha_producao.ficha_producao_id = ficha_producao.id
                ) detalhe_ficha_producao
            ) detalhe_ficha_producao,
            (
                SELECT json_agg(equipamento)
                FROM (
                    SELECT equipamento.*,
                        (
                            SELECT json_agg(tipo_equipamento)
                            FROM tipo_equipamento
                            WHERE tipo_equipamento.id = equipamento.tipo_id
                        ) tipo_equipamento
                    FROM equipamento
                    WHERE equipamento.id = ficha_producao.equipamento_id
                ) equipamento
            ) equipamento,
            (
                SELECT json_agg(tipo_mao_obra)
                FROM tipo_mao_obra
                WHERE tipo_mao_obra.id = ficha_producao.tipo_mao_obra_id
            ) tipo_mao_obra
        FROM ficha_producao
		WHERE ficha_producao.id = _ficha_producao_id
    ) ficha_producao;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_ficha_producao()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(ficha_producao)
    INTO json
    FROM (
        SELECT ficha_producao.*,
            (
                SELECT json_agg(detalhe_ficha_producao)
                FROM (
                    SELECT detalhe_ficha_producao.*,
                        (
                            SELECT json_agg(componente)
                            FROM (
                                SELECT componente.*,
                                    (
                                        SELECT json_agg(tipo_componente)
                                        FROM tipo_componente
                                        WHERE tipo_componente.id = componente.tipo_id
                                    ) tipo_componente,
                                    (
                                        SELECT json_agg(armazem)
                                        FROM armazem
                                        WHERE armazem.id = componente.armazem_id
                                    ) armazem
                                FROM componente
                            ) componente
                            WHERE componente.id = detalhe_ficha_producao.componente_id
                        ) componente
                    FROM detalhe_ficha_producao
                    WHERE detalhe_ficha_producao.ficha_producao_id = ficha_producao.id
                ) detalhe_ficha_producao
            ) detalhe_ficha_producao,
            (
                SELECT json_agg(equipamento)
                FROM (
                    SELECT equipamento.*,
                        (
                            SELECT json_agg(tipo_equipamento)
                            FROM tipo_equipamento
                            WHERE tipo_equipamento.id = equipamento.tipo_id
                        ) tipo_equipamento
                    FROM equipamento
                    WHERE equipamento.id = ficha_producao.equipamento_id
                ) equipamento
            ) equipamento,
            (
                SELECT json_agg(tipo_mao_obra)
                FROM tipo_mao_obra
                WHERE tipo_mao_obra.id = ficha_producao.tipo_mao_obra_id
            ) tipo_mao_obra
        FROM ficha_producao
    ) ficha_producao;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_ficha_producao_OLD()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT array_to_json(array_agg(row_to_json(row)))
    INTO json
    FROM (SELECT * FROM ficha_producao) row;

    RETURN json;
END;
$$ LANGUAGE plpgsql;