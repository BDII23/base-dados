CREATE OR REPLACE FUNCTION readjson_guia_remessa_fornecedores_componentes()
RETURNS JSON
LANGUAGE plpgsql
AS $$
DECLARE
    resultado_json JSON;
BEGIN
    SELECT jsonb_agg(
        jsonb_build_object(
            'detalhe_id', def.id,
            'componente_id', c.id,
            'componente_descricao', c.descricao,
            'encomenda_id', ef.id
        )
    ) INTO resultado_json
    FROM detalhe_encomenda_fornecedor def
    JOIN componente c
        ON c.id = def.componente_id
    JOIN encomenda_fornecedor ef
        ON ef.id = def.encomenda_id;

    RETURN resultado_json;
END;
$$;



CREATE OR REPLACE PROCEDURE create_guia_remessa_fornecedor(
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
    INSERT INTO fatura_fornecedor(descricao)
    VALUES (p_fatura_descricao)
    RETURNING id INTO aux_fatura_id;

    INSERT INTO guia_remessa_fornecedor (data_envio, data_entrega, endereco_origem, endereco_chegada, utilizador_id, fatura_id)
    VALUES (p_data_envio, p_data_entrega, p_endereco_origem, p_endereco_chegada, p_utilizador_id, aux_fatura_id)
    RETURNING id INTO aux_remessa_id;

    FOR i IN 1..array_length(p_detalhe_encomendas, 1) LOOP
        INSERT INTO detalhe_remessa_fornecedor(detalhe_encomenda_id, remessa_id)
        VALUES (p_detalhe_encomendas[i], aux_remessa_id);
    END LOOP;
END;
$$;



CREATE OR REPLACE PROCEDURE update_guia_remessa_fornecedor(
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
    UPDATE guia_remessa_fornecedor
    SET
        data_envio = p_data_envio,
        data_entrega = p_data_entrega,
        endereco_origem = p_endereco_origem,
        endereco_chegada = p_endereco_chegada,
        utilizador_id = p_utilizador_id
    WHERE id = p_id
	RETURNING fatura_id INTO aux_fatura_id;
	
	UPDATE fatura_fornecedor
	SET
		descricao = p_fatura_descricao
	WHERE id = aux_fatura_id;
	
	FOR it IN (
		SELECT detalhe_encomenda_id 
		FROM detalhe_remessa_fornecedor 
		WHERE remessa_id = p_id
	) LOOP
        IF it NOT IN (SELECT UNNEST(p_detalhe_encomendas)) THEN
            DELETE FROM detalhe_remessa_fornecedor WHERE remessa_id = p_id AND detalhe_encomenda_id = it;
        END IF;
    END LOOP;

    FOR i IN 1..array_length(p_detalhe_encomendas, 1) LOOP
        SELECT detalhe_encomenda_id INTO it
        FROM detalhe_remessa_fornecedor
        WHERE detalhe_encomenda_id = p_detalhe_encomendas[i] AND remessa_id = p_id;
	
        IF it IS NULL THEN
            INSERT INTO detalhe_remessa_fornecedor (detalhe_encomenda_id, remessa_id)
            VALUES (p_detalhe_encomendas[i], p_id);
        END IF;
    END LOOP;
	
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE delete_guia_remessa_fornecedor(IN p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM guia_remessa_fornecedor WHERE id = p_id;
END;
$$;



CREATE OR REPLACE FUNCTION readone_guia_remessa_fornecedor(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
	SELECT json_agg(guia_remessa_fornecedor)
    INTO json
    FROM (
        SELECT
            guia_remessa_fornecedor.*,
            (
                SELECT json_agg(detalhe_remessa_fornecedor)
                FROM (
					SELECT detalhe_remessa_fornecedor.*,
						(
							SELECT json_agg(detalhe_encomenda_fornecedor)
							FROM (
								SELECT detalhe_encomenda_fornecedor.*,
									readone_componente(detalhe_encomenda_fornecedor.componente_id) AS componente
								FROM detalhe_encomenda_fornecedor
							) detalhe_encomenda_fornecedor
							WHERE detalhe_encomenda_fornecedor.id = detalhe_remessa_fornecedor.detalhe_encomenda_id
						) detalhe_encomenda_fornecedor
					FROM detalhe_remessa_fornecedor
				) detalhe_remessa_fornecedor
                WHERE detalhe_remessa_fornecedor.remessa_id = guia_remessa_fornecedor.id
            ) detalhe_remessa_fornecedor,
			(
				SELECT json_agg(fatura_fornecedor)
                FROM fatura_fornecedor
                WHERE fatura_fornecedor.id = guia_remessa_fornecedor.fatura_id
			) fatura_fornecedor
        FROM guia_remessa_fornecedor
	) guia_remessa_fornecedor
	WHERE guia_remessa_fornecedor.id = p_id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_guia_remessa_fornecedor()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
	SELECT json_agg(guia_remessa_fornecedor)
    INTO json
    FROM (
        SELECT
            guia_remessa_fornecedor.*,
            (
                SELECT json_agg(detalhe_remessa_fornecedor)
                FROM (
					SELECT detalhe_remessa_fornecedor.*,
						(
							SELECT json_agg(detalhe_encomenda_fornecedor)
							FROM (
								SELECT detalhe_encomenda_fornecedor.*,
									readone_componente(detalhe_encomenda_fornecedor.componente_id) AS componente
								FROM detalhe_encomenda_fornecedor
							) detalhe_encomenda_fornecedor
							WHERE detalhe_encomenda_fornecedor.id = detalhe_remessa_fornecedor.detalhe_encomenda_id
						) detalhe_encomenda_fornecedor
					FROM detalhe_remessa_fornecedor
				) detalhe_remessa_fornecedor
                WHERE detalhe_remessa_fornecedor.remessa_id = guia_remessa_fornecedor.id
            ) detalhe_remessa_fornecedor,
			(
				SELECT json_agg(fatura_fornecedor)
                FROM fatura_fornecedor
                WHERE fatura_fornecedor.id = guia_remessa_fornecedor.fatura_id
			) fatura_fornecedor
        FROM guia_remessa_fornecedor
	) guia_remessa_fornecedor;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION custo_total_guia_remessa_fornecedor(p_id INT)
RETURNS MONEY
AS $$
DECLARE
    custo_total MONEY;
BEGIN
    SELECT 
    	SUM(def.quantidade * def.custo_entidade) INTO custo_total
	FROM guia_remessa_fornecedor grf
	JOIN detalhe_remessa_fornecedor drf ON drf.remessa_id = grf.id
	JOIN detalhe_encomenda_fornecedor def ON def.id = drf.detalhe_encomenda_id
	WHERE grf.id = p_id;

    RETURN custo_total;
END;
$$ LANGUAGE plpgsql;