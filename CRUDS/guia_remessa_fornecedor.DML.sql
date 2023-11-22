CREATE OR REPLACE PROCEDURE sp_guia_remessa_fornecedor_create(
    -- parâmetros da tabela
    IN data_envio TIMESTAMP,
    IN data_entrega_prevista TIMESTAMP,
    IN endereco_origem VARCHAR(300),
    IN endereco_chegada VARCHAR(300),
    IN estado_id INT,
    IN detalhe_encomenda_id INT,
    IN fatura_id INT,
    IN utilizador_id INT
)
AS $$
BEGIN
    INSERT INTO guia_remessa_fornecedor (
        data_envio,
        data_entrega_prevista,
        endereco_origem,
        endereco_chegada,
        estado_id,
        detalhe_encomenda_id,
        fatura_id,
        utilizador_id
    )
    VALUES (
        data_envio,
        data_entrega_prevista,
        endereco_origem,
        endereco_chegada,
        estado_id,
        detalhe_encomenda_id,
        fatura_id,
        utilizador_id
    );
END;
$$
LANGUAGE plpgsql;





CREATE OR REPLACE PROCEDURE sp_guia_remessa_fornecedor_update(
    IN guia_remessa_id INT,
    IN data_recebida TIMESTAMP
)
AS $$
BEGIN
    UPDATE guia_remessa_fornecedor
    SET data_recebida = data_recebida
    WHERE id = guia_remessa_id;
END;
$$
LANGUAGE plpgsql;





CREATE OR REPLACE PROCEDURE sp_guia_remessa_fornecedor_delete(
    IN guia_remessa_id INT
)
AS $$
BEGIN
    DELETE FROM guia_remessa_fornecedor
    WHERE id = guia_remessa_id;
END;
$$
LANGUAGE plpgsql;





CREATE OR REPLACE VIEW vw_guia_remessa_fornecedor_read AS
SELECT * FROM guia_remessa_fornecedor;





CREATE OR REPLACE PROCEDURE sp_guia_remessa_fornecedor_readOne(
    IN guia_remessa_id INT
)
AS $$
BEGIN
    SELECT * FROM guia_remessa_fornecedor
    WHERE id = guia_remessa_id;
END;
$$
LANGUAGE plpgsql;




