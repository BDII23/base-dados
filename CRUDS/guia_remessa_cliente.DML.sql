--Insert

CREATE OR REPLACE PROCEDURE sp_create_guia_remessa_cliente(
    p_data_envio TIMESTAMP,
    p_data_entrega_prevista TIMESTAMP,
    p_endereco_origem VARCHAR(300),
    p_endereco_chegada VARCHAR(300),
    p_estado_id INT,
    p_detalhe_encomenda_id INT,
    p_utilizador_id INT
)
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

    INSERT INTO guia_remessa_cliente (
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
$$ LANGUAGE plpgsql;

--Update
CREATE OR REPLACE PROCEDURE sp_update_guia_remessa_cliente(
    p_id INT,
    p_data_envio TIMESTAMP,
    p_data_entrega_prevista TIMESTAMP,
    p_endereco_origem VARCHAR(300),
    p_endereco_chegada VARCHAR(300),
    p_estado_id INT,
    p_detalhe_encomenda_id INT,
    p_utilizador_id INT
)
AS $$
BEGIN
    UPDATE guia_remessa_cliente
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
$$ LANGUAGE plpgsql;

--Delete
CREATE OR REPLACE PROCEDURE sp_delete_guia_remessa_cliente(p_id INT)
AS $$
BEGIN
    DELETE FROM guia_remessa_cliente WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;

--Read 
CREATE OR REPLACE FUNCTION fn_read_guia_remessa_cliente()
RETURNS SETOF guia_remessa_cliente AS $$
BEGIN
    RETURN QUERY SELECT * FROM guia_remessa_cliente;
END;
$$ LANGUAGE plpgsql;

--Read One
CREATE OR REPLACE FUNCTION fn_read_one_guia_remessa_cliente(p_id INT)
RETURNS guia_remessa_cliente AS $$
DECLARE
    result guia_remessa_cliente;
BEGIN
    SELECT * INTO result FROM guia_remessa_cliente WHERE id = p_id;
    RETURN result;
END;
$$ LANGUAGE plpgsql;

