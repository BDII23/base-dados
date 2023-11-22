CREATE OR REPLACE PROCEDURE sp_encomenda_cliente_create(
    p_data_criacao TIMESTAMP,
    p_estado_id INT,
    p_cliente_id INT
)
AS $$
BEGIN
    INSERT INTO encomenda_cliente (data_criacao, estado_id, cliente_id)
    VALUES (p_data_criacao, p_estado_id, p_cliente_id);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE sp_encomenda_cliente_update(
    p_id INT,
    p_data_criacao TIMESTAMP,
    p_estado_id INT,
    p_cliente_id INT
)
AS $$
BEGIN
    UPDATE encomenda_cliente
    SET data_criacao = p_data_criacao, estado_id = p_estado_id, cliente_id = p_cliente_id
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE sp_encomenda_cliente_delete(
    p_id INT
)
AS $$
BEGIN
    DELETE FROM encomenda_cliente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE VIEW vw_encomenda_cliente_read AS
SELECT
    id,
    data_criacao,
    estado_id,
    cliente_id
FROM encomenda_cliente;




CREATE OR REPLACE PROCEDURE sp_encomenda_cliente_readOne(
    p_id INT
)
AS $$
BEGIN
    SELECT
        id,
        data_criacao,
        estado_id,
        cliente_id
    FROM encomenda_cliente
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;
