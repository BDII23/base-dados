CREATE OR REPLACE FUNCTION sp_guia_remessa_cliente_create(
    -- Parâmetros necessários para a criação
    -- Utilize os campos da tabela conforme necessário
    p_data_envio TIMESTAMPTZ,
    p_data_entrega_prevista TIMESTAMPTZ,
    p_endereco_origem VARCHAR(300),
    p_endereco_chegada VARCHAR(300),
    p_estado_id INT,
    p_detalhe_encomenda_id INT,
    p_fatura_id INT,
    p_utilizador_id INT
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO guia_remessa_cliente(
        data_envio,
        data_entrega_prevista,
        endereco_origem,
        endereco_chegada,
        estado_id,
        detalhe_encomenda_id,
        fatura_id,
        utilizador_id
    ) VALUES (
        p_data_envio,
        p_data_entrega_prevista,
        p_endereco_origem,
        p_endereco_chegada,
        p_estado_id,
        p_detalhe_encomenda_id,
        p_fatura_id,
        p_utilizador_id
    );
END;
$$ LANGUAGE plpgsql;





CREATE OR REPLACE FUNCTION sp_guia_remessa_cliente_update(
    -- Parâmetros necessários para a atualização
    -- Utilize os campos da tabela conforme necessário
    p_id INT,
    p_data_envio TIMESTAMPTZ,
    p_data_entrega_prevista TIMESTAMPTZ,
    p_endereco_origem VARCHAR(300),
    p_endereco_chegada VARCHAR(300),
    p_estado_id INT,
    p_detalhe_encomenda_id INT,
    p_fatura_id INT,
    p_utilizador_id INT
)
RETURNS VOID AS $$
BEGIN
    UPDATE guia_remessa_cliente
    SET
        data_envio = p_data_envio,
        data_entrega_prevista = p_data_entrega_prevista,
        endereco_origem = p_endereco_origem,
        endereco_chegada = p_endereco_chegada,
        estado_id = p_estado_id,
        detalhe_encomenda_id = p_detalhe_encomenda_id,
        fatura_id = p_fatura_id,
        utilizador_id = p_utilizador_id
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION sp_guia_remessa_cliente_delete(
    -- Parâmetros necessários para a exclusão
    p_id INT
)
RETURNS VOID AS $$
BEGIN
    DELETE FROM guia_remessa_cliente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;





CREATE OR REPLACE VIEW vw_guia_remessa_cliente_read AS
SELECT * FROM guia_remessa_cliente;





CREATE OR REPLACE FUNCTION sp_guia_remessa_cliente_readOne(
    -- Parâmetros necessários para a leitura de um registro
    p_id INT
)
RETURNS SETOF guia_remessa_cliente AS $$
BEGIN
    RETURN QUERY SELECT * FROM guia_remessa_cliente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;
