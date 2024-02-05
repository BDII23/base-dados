CREATE OR REPLACE PROCEDURE importar_encomenda_cliente(
    in_dados_encomendas JSONB
)
AS $$
DECLARE
    ID_AUX INT;
    converter INT;
    encomenda JSONB;
    equipamento JSONB;
BEGIN
    FOR encomenda IN SELECT * FROM jsonb_array_elements(in_dados_encomendas)
    LOOP
        converter := (encomenda ->> 'cliente_id')::INT;

        INSERT INTO encomenda_cliente (cliente_id, estado_id)
        VALUES (converter, 1)
        RETURNING id INTO ID_AUX;

        FOR equipamento IN SELECT * FROM jsonb_array_elements(encomenda->'equipamento')
        LOOP
            converter := (equipamento ->> 'equipamento_id')::INT;

            INSERT INTO detalhe_encomenda_cliente (quantidade, custo_unidade, equipamento_id, encomenda_id)
            VALUES (floor(random() * 10), (floor(random() * 100)::numeric::money), converter, ID_AUX);
        END LOOP;
    END LOOP;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION exportar_encomenda_cliente()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(encomenda_simplificada)
    INTO json
    FROM (
        SELECT
            encomenda_cliente.id,
            encomenda_cliente.data_criacao,
            encomenda_cliente.estado_id,
            encomenda_cliente.cliente_id,
            (
                SELECT json_agg(equipamento)
                FROM (
                    SELECT
                        equipamento.id AS equipamento_id,
                        equipamento.data_criacao AS equipamento_data_criacao,
                        equipamento.tipo_id AS equipamento_tipo_id,
                        equipamento.quantidade AS equipamento_quantidade,
                        tipo_equipamento.tipo AS equipamento_tipo
                    FROM equipamento
                    JOIN tipo_equipamento ON equipamento.tipo_id = tipo_equipamento.id
                    WHERE equipamento.id = detalhe_encomenda_cliente.equipamento_id
                ) equipamento
            ) equipamento
        FROM encomenda_cliente
        JOIN detalhe_encomenda_cliente ON encomenda_cliente.id = detalhe_encomenda_cliente.encomenda_id
    ) encomenda_simplificada;

    RETURN json;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE delete_encomenda_cliente(p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM encomenda_cliente WHERE id = p_id;
END;
$$;



CREATE OR REPLACE PROCEDURE create_encomenda_cliente(
    in_equipamentos INT[],
    in_cliente_id INT
)
AS $$
DECLARE
    ID_AUX INT;
    i INT;
BEGIN
    INSERT INTO encomenda_cliente (cliente_id, estado_id)
    VALUES (in_cliente_id, 1)
    RETURNING id INTO ID_AUX;

    FOR i IN 1..array_length(in_equipamentos, 1) LOOP
        INSERT INTO detalhe_encomenda_cliente (quantidade, custo_unidade, equipamento_id, encomenda_id)
        VALUES (floor(random() * 10), (floor(random() * 100)::numeric::money), in_equipamentos[i], ID_AUX);
    END LOOP;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_encomenda_cliente(
    in_id INT,
    in_equipamentos INT[],
    in_cliente_id INT
)
AS $$
DECLARE
    ID_AUX INT;
BEGIN
    UPDATE encomenda_cliente
    SET
        cliente_id = in_cliente_id
    WHERE id = in_id;

	FOR ID_AUX IN (
		SELECT equipamento_id 
		FROM detalhe_encomenda_cliente 
		WHERE encomenda_id = in_id
	) LOOP
        IF ID_AUX NOT IN (SELECT UNNEST(in_equipamentos)) THEN
            DELETE FROM detalhe_encomenda_cliente WHERE encomenda_id = in_id AND equipamento_id = ID_AUX;
        END IF;
    END LOOP;

    FOR i IN 1..array_length(in_equipamentos, 1) LOOP
        SELECT equipamento_id INTO ID_AUX
        FROM detalhe_encomenda_cliente
        WHERE equipamento_id = in_equipamentos[i] AND encomenda_id = in_id;
	
        IF ID_AUX IS NULL THEN
            INSERT INTO detalhe_encomenda_cliente (quantidade, custo_unidade, equipamento_id, encomenda_id)
            VALUES (floor(random() * 10), (floor(random() * 100)::numeric::money), in_equipamentos[i], in_id);
        END IF;
    END LOOP;
	
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readone_encomenda_cliente(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(encomenda_cliente)
    INTO json
    FROM (
        SELECT
            encomenda_cliente.*,
            (
                SELECT json_agg(detalhe_encomenda_cliente)
                FROM (
					SELECT detalhe_encomenda_cliente.*,
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
							) equipamento
							WHERE equipamento.id = detalhe_encomenda_cliente.equipamento_id
						) equipamento
					FROM detalhe_encomenda_cliente
				) detalhe_encomenda_cliente
                WHERE detalhe_encomenda_cliente.encomenda_id = encomenda_cliente.id
            ) detalhe_encomenda_cliente,
			(
				SELECT json_agg(estado_encomenda)
                FROM estado_encomenda
                WHERE estado_encomenda.id = encomenda_cliente.estado_id
			) estado_encomenda,
			(
				SELECT json_agg(cliente)
                FROM cliente
                WHERE cliente.id = encomenda_cliente.cliente_id
			) cliente
        FROM encomenda_cliente
	) encomenda_cliente
	WHERE encomenda_cliente.id = p_id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_encomenda_cliente()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(encomenda_cliente)
    INTO json
    FROM (
        SELECT
            encomenda_cliente.*,
            (
                SELECT json_agg(detalhe_encomenda_cliente)
                FROM (
					SELECT detalhe_encomenda_cliente.*,
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
							) equipamento
							WHERE equipamento.id = detalhe_encomenda_cliente.equipamento_id
						) equipamento
					FROM detalhe_encomenda_cliente
				) detalhe_encomenda_cliente
                WHERE detalhe_encomenda_cliente.encomenda_id = encomenda_cliente.id
            ) detalhe_encomenda_cliente,
			(
				SELECT json_agg(estado_encomenda)
                FROM estado_encomenda
                WHERE estado_encomenda.id = encomenda_cliente.estado_id
			) estado_encomenda,
			(
				SELECT json_agg(cliente)
                FROM cliente
                WHERE cliente.id = encomenda_cliente.cliente_id
			) cliente
        FROM encomenda_cliente
	) encomenda_cliente;

    RETURN json;
END;
$$ LANGUAGE plpgsql;