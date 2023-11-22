CREATE OR REPLACE FUNCTION sp_fatura_cliente_create(
    descricao_param TEXT
) RETURNS INT AS $$
DECLARE
    new_id INT;
BEGIN
    INSERT INTO fatura_cliente (descricao)
    VALUES (descricao_param)
    RETURNING id INTO new_id;
    
    RETURN new_id;
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION sp_fatura_cliente_update(
    fatura_id INT,
    nova_descricao TEXT
) RETURNS VOID AS $$
BEGIN
    UPDATE fatura_cliente
    SET descricao = nova_descricao
    WHERE id = fatura_id;
END;
$$ LANGUAGE plpgsql;
-------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION sp_fatura_cliente_delete(
    fatura_id INT
) RETURNS VOID AS $$
BEGIN
    DELETE FROM fatura_cliente
    WHERE id = fatura_id;
END;
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW vw_fatura_cliente_read AS
SELECT * FROM fatura_cliente;

------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION sp_fatura_cliente_readOne(
    fatura_id INT
) RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    descricao TEXT
) AS $$
BEGIN
    RETURN QUERY SELECT id, data_criacao, descricao
    FROM fatura_cliente
    WHERE id = fatura_id;
END;
$$ LANGUAGE plpgsql;