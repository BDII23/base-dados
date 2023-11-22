-- Procedimento Armazenado: sp_detalhe_encomenda_cliente_create
CREATE OR REPLACE PROCEDURE sp_detalhe_encomenda_cliente_create(
    IN p_quantidade INT,
    IN p_custo MONEY,
    IN p_equipamento_id INT,
    IN p_encomenda_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO detalhe_encomenda_cliente (quantidade, custo, equipamento_id, encomenda_id)
    VALUES (p_quantidade, p_custo, p_equipamento_id, p_encomenda_id);
END;
$$;

-- Procedimento Armazenado: sp_detalhe_encomenda_cliente_update
CREATE OR REPLACE PROCEDURE sp_detalhe_encomenda_cliente_update(
    IN p_id INT,
    IN p_quantidade INT,
    IN p_custo MONEY,
    IN p_equipamento_id INT,
    IN p_encomenda_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE detalhe_encomenda_cliente
    SET quantidade = p_quantidade,
        custo = p_custo,
        equipamento_id = p_equipamento_id,
        encomenda_id = p_encomenda_id
    WHERE id = p_id;
END;
$$;

-- Procedimento Armazenado: sp_detalhe_encomenda_cliente_delete
CREATE OR REPLACE PROCEDURE sp_detalhe_encomenda_cliente_delete(
    IN p_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM detalhe_encomenda_cliente WHERE id = p_id;
END;
$$;

-- View: vw_detalhe_encomenda_cliente_read
CREATE OR REPLACE VIEW vw_detalhe_encomenda_cliente_read AS
SELECT * FROM detalhe_encomenda_cliente;

-- Procedimento Armazenado: sp_detalhe_encomenda_cliente_readOne
CREATE OR REPLACE PROCEDURE sp_detalhe_encomenda_cliente_readOne(
    IN p_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM detalhe_encomenda_cliente WHERE id = p_id;
END;
$$;




