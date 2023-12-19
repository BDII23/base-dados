--create

CREATE OR REPLACE PROCEDURE sp_create_guia_remessa_fornecedor(
    IN p_data_envio TIMESTAMPTZ,
    IN p_data_entrega_prevista TIMESTAMPTZ,
    IN p_endereco_origem VARCHAR(300),
    IN p_endereco_chegada VARCHAR(300),
    IN p_estado_id INT,
    IN p_detalhe_encomenda_id INT,
    IN p_utilizador_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN

    IF p_data_envio IS NULL THEN
        RAISE EXCEPTION 'A data de envio não pode ser nula.';
    END IF;

    IF p_data_entrega_prevista IS NULL THEN
        RAISE EXCEPTION 'A data de entrega prevista não pode ser nula.';
    END IF;

    IF p_endereco_origem IS NULL OR p_endereco_origem = '' THEN
        RAISE EXCEPTION 'O endereço de origem não pode ser nulo ou vazio.';
    END IF;

    IF p_endereco_chegada IS NULL OR p_endereco_chegada = '' THEN
        RAISE EXCEPTION 'O endereço de chegada não pode ser nulo ou vazio.';
    END IF;

    IF p_estado_id IS NULL THEN
        RAISE EXCEPTION 'O estado_id não pode ser nulo.';
    END IF;

    IF p_detalhe_encomenda_id IS NULL THEN
        RAISE EXCEPTION 'O detalhe_encomenda_id não pode ser nulo.';
    END IF;

    IF p_utilizador_id IS NULL THEN
        RAISE EXCEPTION 'O utilizador_id não pode ser nulo.';
    END IF;
    
    INSERT INTO guia_remessa_fornecedor (
        data_envio,
        data_entrega_prevista,
        endereco_origem,
        endereco_chegada,
        estado_id,
        detalhe_encomenda_id,
        utilizador_id
    ) VALUES (
        p_data_envio,
        p_data_entrega_prevista,
        p_endereco_origem,
        p_endereco_chegada,
        p_estado_id,
        p_detalhe_encomenda_id,
        p_utilizador_id
    );
END;
$$;

--Update 
CREATE OR REPLACE PROCEDURE sp_update_guia_remessa_fornecedor(
    IN p_id INT,
    IN p_data_envio TIMESTAMPTZ,
    IN p_data_entrega_prevista TIMESTAMPTZ,
    IN p_endereco_origem VARCHAR(300),
    IN p_endereco_chegada VARCHAR(300),
    IN p_estado_id INT,
    IN p_detalhe_encomenda_id INT,
    IN p_utilizador_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE guia_remessa_fornecedor
    SET
        data_envio = p_data_envio,
        data_entrega_prevista = p_data_entrega_prevista,
        endereco_origem = p_endereco_origem,
        endereco_chegada = p_endereco_chegada,
        estado_id = p_estado_id,
        detalhe_encomenda_id = p_detalhe_encomenda_id,
        utilizador_id = p_utilizador_id
    WHERE id = p_id;
END;
$$;

--delete 
CREATE OR REPLACE PROCEDURE sp_delete_guia_remessa_fornecedor(IN p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM guia_remessa_fornecedor WHERE id = p_id;
END;
$$;

--read
CREATE OR REPLACE FUNCTION fn_read_guia_remessa_fornecedor()
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMPTZ,
    data_envio TIMESTAMPTZ,
    data_entrega_prevista TIMESTAMPTZ,
    data_recebida TIMESTAMPTZ,
    endereco_origem VARCHAR(300),
    endereco_chegada VARCHAR(300),
    estado_id INT,
    detalhe_encomenda_id INT,
    utilizador_id INT
)
AS $$
BEGIN
    RETURN QUERY SELECT * FROM guia_remessa_fornecedor;
END;
$$
LANGUAGE plpgsql;


--read one
CREATE OR REPLACE FUNCTION fn_readone_guia_remessa_fornecedor(p_id INT)
RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMPTZ,
    data_envio TIMESTAMPTZ,
    data_entrega_prevista TIMESTAMPTZ,
    data_recebida TIMESTAMPTZ,
    endereco_origem VARCHAR(300),
    endereco_chegada VARCHAR(300),
    estado_id INT,
    detalhe_encomenda_id INT,
    utilizador_id INT
)
AS $$
BEGIN
    RETURN QUERY SELECT * FROM guia_remessa_fornecedor WHERE id = p_id;
END;
$$
LANGUAGE plpgsql;

