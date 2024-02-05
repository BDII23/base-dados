CREATE OR REPLACE PROCEDURE delete_encomenda_fornecedor(
    in_id INT
)
AS $$
BEGIN
    DELETE FROM encomenda_fornecedor WHERE id = in_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE create_encomenda_fornecedor(
    in_componentes INT[],
    in_fornecedor_id INT
)
AS $$
DECLARE
    ID_AUX INT;
    i INT;
BEGIN
    INSERT INTO encomenda_fornecedor (fornecedor_id, estado_id)
    VALUES (in_fornecedor_id, 1)
    RETURNING id INTO ID_AUX;

    FOR i IN 1..array_length(in_componentes, 1) LOOP
        INSERT INTO detalhe_encomenda_fornecedor (quantidade, custo_entidade, componente_id, encomenda_id)
        VALUES (floor(random() * 10), (floor(random() * 100)::numeric::money), in_componentes[i], ID_AUX);
    END LOOP;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE update_encomenda_fornecedor(
    in_id INT,
    in_componentes INT[],
    in_fornecedor_id INT
)
AS $$
DECLARE
    ID_AUX INT;
BEGIN
    UPDATE encomenda_fornecedor
    SET
        fornecedor_id = in_fornecedor_id
    WHERE id = in_id;

	FOR ID_AUX IN (
		SELECT componente_id 
		FROM detalhe_encomenda_fornecedor 
		WHERE encomenda_id = in_id
	) LOOP
        IF ID_AUX NOT IN (SELECT UNNEST(in_componentes)) THEN
            DELETE FROM detalhe_encomenda_fornecedor WHERE encomenda_id = in_id AND componente_id = ID_AUX;
        END IF;
    END LOOP;

    FOR i IN 1..array_length(in_componentes, 1) LOOP
        SELECT componente_id INTO ID_AUX
        FROM detalhe_encomenda_fornecedor
        WHERE componente_id = in_componentes[i] AND encomenda_id = in_id;
	
        IF ID_AUX IS NULL THEN
            INSERT INTO detalhe_encomenda_fornecedor (quantidade, custo_entidade, componente_id, encomenda_id)
            VALUES (floor(random() * 10), (floor(random() * 100)::numeric::money), in_componentes[i], in_id);
        END IF;
    END LOOP;
	
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readone_encomenda_fornecedor(p_id INT)
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(encomenda_fornecedor)
    INTO json
    FROM (
        SELECT
            encomenda_fornecedor.*,
            (
                SELECT json_agg(detalhe_encomenda_fornecedor)
                FROM (
                    SELECT detalhe_encomenda_fornecedor.*,
                        (
                            SELECT readone_componente(detalhe_encomenda_fornecedor.componente_id) AS componente
                        ) componente
                    FROM detalhe_encomenda_fornecedor
                ) detalhe_encomenda_fornecedor
                WHERE detalhe_encomenda_fornecedor.encomenda_id = encomenda_fornecedor.id
            ) detalhe_encomenda_fornecedor,
            (
                SELECT json_agg(estado_encomenda)
                FROM estado_encomenda
                WHERE estado_encomenda.id = encomenda_fornecedor.estado_id
            ) estado_encomenda,
            (
                SELECT json_agg(fornecedor)
                FROM fornecedor
                WHERE fornecedor.id = encomenda_fornecedor.fornecedor_id
            ) fornecedor
        FROM encomenda_fornecedor
    ) encomenda_fornecedor
	WHERE encomenda_fornecedor.id = p_id;

    RETURN json;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION readjson_encomenda_fornecedor()
RETURNS JSON
AS $$
DECLARE
    json JSON;
BEGIN
    SELECT json_agg(encomenda_fornecedor)
    INTO json
    FROM (
        SELECT
            encomenda_fornecedor.*,
            (
                SELECT json_agg(detalhe_encomenda_fornecedor)
                FROM (
                    SELECT detalhe_encomenda_fornecedor.*,
                        (
                            SELECT readone_componente(detalhe_encomenda_fornecedor.componente_id) AS componente
                        ) componente
                    FROM detalhe_encomenda_fornecedor
                ) detalhe_encomenda_fornecedor
                WHERE detalhe_encomenda_fornecedor.encomenda_id = encomenda_fornecedor.id
            ) detalhe_encomenda_fornecedor,
            (
                SELECT json_agg(estado_encomenda)
                FROM estado_encomenda
                WHERE estado_encomenda.id = encomenda_fornecedor.estado_id
            ) estado_encomenda,
            (
                SELECT json_agg(fornecedor)
                FROM fornecedor
                WHERE fornecedor.id = encomenda_fornecedor.fornecedor_id
            ) fornecedor
        FROM encomenda_fornecedor
    ) encomenda_fornecedor;

    RETURN json;
END;
$$ LANGUAGE plpgsql;