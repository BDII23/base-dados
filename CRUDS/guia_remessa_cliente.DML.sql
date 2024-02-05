CREATE OR REPLACE FUNCTION readjson_guia_remessa_clientes_componentes()
RETURNS JSON
LANGUAGE plpgsql
AS $$
DECLARE
    resultado_json JSON;
BEGIN
    SELECT jsonb_agg(
        jsonb_build_object(
            'detalhe_id', dec.id,
            'equipamento_id', e.id,
            'tipo_equipamento', te.tipo,
            'encomenda_id', ec.id
        )
    ) INTO resultado_json
    FROM detalhe_encomenda_cliente dec
    JOIN equipamento e
        ON e.id = dec.equipamento_id
	JOIN tipo_equipamento te
		ON te.id = e.tipo_id
    JOIN encomenda_cliente ec
        ON ec.id = dec.encomenda_id;

    RETURN resultado_json;
END;
$$;



CREATE OR REPLACE PROCEDURE create_guia_remessa_cliente(
    p_data_envio TIMESTAMP,
    p_data_entrega TIMESTAMP,
    p_endereco_origem VARCHAR,
    p_endereco_chegada VARCHAR,
    p_utilizador_id INT,
    p_fatura_descricao TEXT,
    p_detalhe_encomendas INT[]
)
LANGUAGE plpgsql
AS $$
DECLARE
    aux_fatura_id INT;
    aux_remessa_id INT;
BEGIN
    INSERT INTO fatura_cliente(descricao)
    VALUES (p_fatura_descricao)
    RETURNING id INTO aux_fatura_id;

    INSERT INTO guia_remessa_cliente (data_envio, data_entrega, endereco_origem, endereco_chegada, utilizador_id, fatura_id)
    VALUES (p_data_envio, p_data_entrega, p_endereco_origem, p_endereco_chegada, p_utilizador_id, aux_fatura_id)
    RETURNING id INTO aux_remessa_id;

    FOR i IN 1..array_length(p_detalhe_encomendas, 1) LOOP
        INSERT INTO detalhe_remessa_cliente(detalhe_encomenda_id, remessa_id)
        VALUES (p_detalhe_encomendas[i], aux_remessa_id);
    END LOOP;
END;
$$;



CREATE OR REPLACE PROCEDURE update_guia_remessa_cliente(
    p_id INT,
    p_data_envio TIMESTAMP,
    p_data_entrega TIMESTAMP,
    p_endereco_origem VARCHAR,
    p_endereco_chegada VARCHAR,
    p_utilizador_id INT,
    p_fatura_descricao TEXT,
    p_detalhe_encomendas INT[]
)
AS $$
DECLARE
	aux_fatura_id INT;
	it INT;
BEGIN
    UPDATE guia_remessa_cliente
    SET
        data_envio = p_data_envio,
        data_entrega = p_data_entrega,
        endereco_origem = p_endereco_origem,
        endereco_chegada = p_endereco_chegada,
        utilizador_id = p_utilizador_id
    WHERE id = p_id
	RETURNING fatura_id INTO aux_fatura_id;
	
	UPDATE fatura_cliente
	SET
		descricao = p_fatura_descricao
	WHERE id = aux_fatura_id;
	
	FOR it IN (
		SELECT detalhe_encomenda_id 
		FROM detalhe_remessa_cliente 
		WHERE remessa_id = p_id
	) LOOP
        IF it NOT IN (SELECT UNNEST(p_detalhe_encomendas)) THEN
            DELETE FROM detalhe_remessa_cliente WHERE remessa_id = p_id AND detalhe_encomenda_id = it;
        END IF;
    END LOOP;

    FOR i IN 1..array_length(p_detalhe_encomendas, 1) LOOP
        SELECT detalhe_encomenda_id INTO it
        FROM detalhe_remessa_cliente
        WHERE detalhe_encomenda_id = p_detalhe_encomendas[i] AND remessa_id = p_id;
	
        IF it IS NULL THEN
            INSERT INTO detalhe_remessa_cliente (detalhe_encomenda_id, remessa_id)
            VALUES (p_detalhe_encomendas[i], p_id);
        END IF;
    END LOOP;
	
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE delete_guia_remessa_cliente(p_id INT)
AS $$
BEGIN
    DELETE FROM guia_remessa_cliente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readone_guia_remessa_cliente(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(guia_remessa_cliente)
    INTO json
    FROM (
        SELECT
            guia_remessa_cliente.*,
            (
                SELECT json_agg(detalhe_remessa_cliente)
                FROM (
					SELECT detalhe_remessa_cliente.*,
						(
							SELECT json_agg(detalhe_encomenda_cliente)
							FROM (
								SELECT detalhe_encomenda_cliente.*,
									readone_equipamento(detalhe_encomenda_cliente.equipamento_id) AS equipamento
								FROM detalhe_encomenda_cliente
							) detalhe_encomenda_cliente
							WHERE detalhe_encomenda_cliente.id = detalhe_remessa_cliente.detalhe_encomenda_id
						) detalhe_encomenda_cliente
					FROM detalhe_remessa_cliente
				) detalhe_remessa_cliente
                WHERE detalhe_remessa_cliente.remessa_id = guia_remessa_cliente.id
            ) detalhe_remessa_cliente,
			(
				SELECT json_agg(fatura_cliente)
                FROM fatura_cliente
                WHERE fatura_cliente.id = guia_remessa_cliente.fatura_id
			) fatura_cliente
        FROM guia_remessa_cliente
	) guia_remessa_cliente
	WHERE guia_remessa_cliente.id = p_id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_guia_remessa_cliente()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(guia_remessa_cliente)
    INTO json
    FROM (
        SELECT
            guia_remessa_cliente.*,
            (
                SELECT json_agg(detalhe_remessa_cliente)
                FROM (
					SELECT detalhe_remessa_cliente.*,
						(
							SELECT json_agg(detalhe_encomenda_cliente)
							FROM (
								SELECT detalhe_encomenda_cliente.*,
									readone_equipamento(detalhe_encomenda_cliente.equipamento_id) AS equipamento
								FROM detalhe_encomenda_cliente
							) detalhe_encomenda_cliente
							WHERE detalhe_encomenda_cliente.id = detalhe_remessa_cliente.detalhe_encomenda_id
						) detalhe_encomenda_cliente
					FROM detalhe_remessa_cliente
				) detalhe_remessa_cliente
                WHERE detalhe_remessa_cliente.remessa_id = guia_remessa_cliente.id
            ) detalhe_remessa_cliente,
			(
				SELECT json_agg(fatura_cliente)
                FROM fatura_cliente
                WHERE fatura_cliente.id = guia_remessa_cliente.fatura_id
			) fatura_cliente
        FROM guia_remessa_cliente
	) guia_remessa_cliente;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION custo_total_guia_remessa_cliente(p_id INT)
RETURNS MONEY
AS $$
DECLARE
    custo_total MONEY;
BEGIN
    SELECT 
    	SUM(dec.quantidade * dec.custo_unidade) INTO custo_total
	FROM guia_remessa_cliente grc
	JOIN detalhe_remessa_cliente drc ON drc.remessa_id = grc.id
	JOIN detalhe_encomenda_cliente dec ON dec.id = drc.detalhe_encomenda_id
	WHERE grc.id = p_id;

    RETURN custo_total;
END;
$$ LANGUAGE plpgsql;