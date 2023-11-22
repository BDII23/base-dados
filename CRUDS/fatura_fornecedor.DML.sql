
CREATE OR REPLACE FUNCTION sp_fatura_fornecedor_create(
    descricao_param TEXT
) RETURNS INT AS $$
DECLARE
    new_id INT;
BEGIN
    INSERT INTO fatura_fornecedor (descricao)
    VALUES (descricao_param)
    RETURNING id INTO new_id;
    
    RETURN new_id;
END;
$$ LANGUAGE plpgsql;

---------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION sp_fatura_fornecedor_update(
    fatura_id INT,
    nova_descricao TEXT
) RETURNS VOID AS $$
BEGIN
    UPDATE fatura_fornecedor
    SET descricao = nova_descricao
    WHERE id = fatura_id;
END;
$$ LANGUAGE plpgsql;

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION sp_fatura_fornecedor_delete(
    fatura_id INT
) RETURNS VOID AS $$
BEGIN
    DELETE FROM fatura_fornecedor
    WHERE id = fatura_id;
END;
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW vw_fatura_fornecedor_read AS
SELECT * FROM fatura_fornecedor;

-------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION sp_fatura_fornecedor_readOne(
    fatura_id INT
) RETURNS TABLE (
    id INT,
    data_criacao TIMESTAMP,
    descricao TEXT
) AS $$
BEGIN
    RETURN QUERY SELECT id, data_criacao, descricao
    FROM fatura_fornecedor
    WHERE id = fatura_id;
END;
$$ LANGUAGE plpgsql;