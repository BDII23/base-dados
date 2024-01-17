--create

CREATE OR REPLACE PROCEDURE sp_create_guia_remessa_fornecedor(
    IN p_data_envio TIMESTAMPTZ,
    IN p_data_entrega TIMESTAMPTZ,
    IN p_endereco_origem VARCHAR(300),
    IN p_endereco_chegada VARCHAR(300),
    IN p_estado_id INT,
    IN p_detalhe_encomenda_id INT,
    IN p_utilizador_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN   
    INSERT INTO guia_remessa_fornecedor (
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
$$;

--Update 
CREATE OR REPLACE PROCEDURE sp_update_guia_remessa_fornecedor(
    IN p_id INT,
    IN p_data_envio TIMESTAMPTZ,
    IN p_data_entrega TIMESTAMPTZ,
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
        data_entrega = p_data_entrega,
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
RETURNS SETOF guia_remessa_fornecedor
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM guia_remessa_fornecedor;
END;
$$;

CREATE OR REPLACE FUNCTION fn_readone_guia_remessa_fornecedor(p_id INT)
RETURNS SETOF guia_remessa_fornecedor
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT * FROM guia_remessa_fornecedor WHERE id = p_id;
END;
$$;
