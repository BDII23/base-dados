--Insert

CREATE OR REPLACE PROCEDURE sp_create_guia_remessa_cliente(
    p_data_envio TIMESTAMP,
    p_data_entrega TIMESTAMP,
    p_endereco_origem VARCHAR(300),
    p_endereco_chegada VARCHAR(300),
    p_estado_id INT,
    p_detalhe_encomenda_id INT,
    p_utilizador_id INT
)
AS $$
BEGIN
    INSERT INTO guia_remessa_cliente (
        data_envio,
        data_entrega,
        endereco_origem,
        endereco_chegada,
        estado_id,
        detalhe_encomenda_id,
        utilizador_id
    ) VALUES (
        p_data_envio,
        p_data_entrega,
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
    p_data_entrega TIMESTAMP,
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
        data_entrega = p_data_entrega,
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

