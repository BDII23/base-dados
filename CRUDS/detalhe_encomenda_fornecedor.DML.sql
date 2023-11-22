CREATE OR REPLACE PROCEDURE sp_detalhe_encomenda_fornecedor_create(
    p_quantidade INT,
    p_custo_entidade MONEY,
    p_componente_id INT,
    p_encomenda_id INT
)
AS
$$
BEGIN
    INSERT INTO detalhe_encomenda_fornecedor(
        quantidade,
        custo_entidade,
        componente_id,
        encomenda_id
    ) VALUES (
        p_quantidade,
        p_custo_entidade,
        p_componente_id,
        p_encomenda_id
    );
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE sp_detalhe_encomenda_fornecedor_update(
    p_id INT,
    p_quantidade INT,
    p_custo_entidade MONEY,
    p_componente_id INT,
    p_encomenda_id INT
)
AS
$$
BEGIN
    UPDATE detalhe_encomenda_fornecedor
    SET
        quantidade = p_quantidade,
        custo_entidade = p_custo_entidade,
        componente_id = p_componente_id,
        encomenda_id = p_encomenda_id
    WHERE id = p_id;
END;
$$
LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE sp_detalhe_encomenda_fornecedor_delete(p_id INT)
AS
$$
BEGIN
    DELETE FROM detalhe_encomenda_fornecedor WHERE id = p_id;
END;
$$
LANGUAGE plpgsql;




CREATE OR REPLACE VIEW vw_detalhe_encomenda_fornecedor_read AS
SELECT
    id,
    data_criacao,
    quantidade,
    custo_entidade,
    componente_id,
    encomenda_id
FROM detalhe_encomenda_fornecedor;




CREATE OR REPLACE PROCEDURE sp_detalhe_encomenda_fornecedor_readOne(p_id INT)
AS
$$
BEGIN
    SELECT
        id,
        data_criacao,
        quantidade,
        custo_entidade,
        componente_id,
        encomenda_id
    FROM detalhe_encomenda_fornecedor
    WHERE id = p_id;
END;
$$
LANGUAGE plpgsql;
