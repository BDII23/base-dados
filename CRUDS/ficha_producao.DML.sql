CREATE OR REPLACE PROCEDURE create_ficha_producao(
    quantidade_equipamentos INT,
    descricao TEXT,
    horas INT,
    utilizador_id INT,
    tipo_mao_obra_id INT,
	tipo_equipamento_id INT,
	componentes INT[]
)
AS $$
DECLARE
	ID_AUX INT;
BEGIN
	INSERT INTO equipamento(tipo_id)
	VALUES (tipo_equipamento_id)
	RETURNING id INTO ID_AUX;

    INSERT INTO ficha_producao(quantidade_equipamentos, descricao, horas, utilizador_id, tipo_mao_obra_id, equipamento_id)
	VALUES (quantidade_equipamentos, descricao, horas, utilizador_id, tipo_mao_obra_id, ID_AUX)
	RETURNING id INTO ID_AUX;

    FOR i IN 1..array_length(componentes, 1) LOOP
        CALL create_detalhe_ficha_producao(componentes[i], ID_AUX);
    END LOOP;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_ficha_producao(
    _ficha_id INT,
    _quantidade_equipamentos INT,
    _descricao TEXT,
    _horas INT,
    _utilizador_id INT,
    _tipo_mao_obra_id INT,
    _tipo_equipamento_id INT,
    _componentes INT[])
AS $$
DECLARE
    ID_AUX INT;
BEGIN
    UPDATE ficha_producao
    SET
        quantidade_equipamentos = _quantidade_equipamentos,
        descricao = _descricao,
        horas = _horas,
        utilizador_id = _utilizador_id,
        tipo_mao_obra_id = _tipo_mao_obra_id
    WHERE id = _ficha_id
	RETURNING equipamento_id INTO ID_AUX;

    UPDATE equipamento
    SET tipo_id = _tipo_equipamento_id
    WHERE id = ID_AUX;

	FOR ID_AUX IN (
		SELECT componente_id 
		FROM detalhe_ficha_producao 
		WHERE ficha_producao_id = _ficha_id
	) LOOP
        IF ID_AUX NOT IN (SELECT UNNEST(_componentes)) THEN
            DELETE FROM detalhe_ficha_producao WHERE ficha_producao_id = _ficha_id AND componente_id = ID_AUX;
        END IF;
    END LOOP;

    FOR i IN 1..array_length(_componentes, 1) LOOP
        SELECT componente_id INTO ID_AUX
        FROM detalhe_ficha_producao
        WHERE componente_id = _componentes[i] AND ficha_producao_id = _ficha_id;
	
    	--RAISE NOTICE 'ID_AUX: %', ID_AUX;
        IF ID_AUX IS NULL THEN
            INSERT INTO detalhe_ficha_producao(componente_id, ficha_producao_id)
            VALUES (_componentes[i], _ficha_id);
        END IF;
    END LOOP;
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