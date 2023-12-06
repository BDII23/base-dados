-- Procedure para criar uma nova fatura de fornecedor
CREATE OR REPLACE PROCEDURE sp_fatura_fornecedor_create(
    descricao_param TEXT
)
AS $$
DECLARE
    new_id INT;
BEGIN
    INSERT INTO fatura_fornecedor (descricao)
    VALUES (descricao_param)
    RETURNING id INTO new_id;
END;
$$ LANGUAGE plpgsql;

-- Procedure para atualizar uma fatura de fornecedor existente
CREATE OR REPLACE PROCEDURE sp_fatura_fornecedor_update(
    fatura_id INT,
    nova_descricao TEXT
)
AS $$
BEGIN
    UPDATE fatura_fornecedor
    SET descricao = nova_descricao
    WHERE id = fatura_id;
END;
$$ LANGUAGE plpgsql;

-- Procedure para excluir uma fatura de fornecedor
CREATE OR REPLACE PROCEDURE sp_fatura_fornecedor_delete(
    fatura_id INT
)
AS $$
BEGIN
    DELETE FROM fatura_fornecedor
    WHERE id = fatura_id;
END;
$$ LANGUAGE plpgsql;

-- View para ler todas as faturas de fornecedor
CREATE OR REPLACE VIEW vw_fatura_fornecedor_read AS
SELECT * FROM fatura_fornecedor;

-- Procedure para ler uma fatura de fornecedor específica
CREATE OR REPLACE PROCEDURE sp_fatura_fornecedor_readOne(
    fatura_id INT
)
AS $$
BEGIN
    RETURN QUERY SELECT id, data_criacao, descricao
    FROM fatura_fornecedor
    WHERE id = fatura_id;
END;
$$ LANGUAGE plpgsql;
