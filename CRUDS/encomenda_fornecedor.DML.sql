CREATE OR REPLACE PROCEDURE sp_encomenda_fornecedor_create(
    p_estado_id INT,
    p_fornecedor_id INT
)
AS
$$
BEGIN
    INSERT INTO encomenda_fornecedor (estado_id, fornecedor_id) VALUES (p_estado_id, p_fornecedor_id);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE sp_encomenda_fornecedor_update(
    p_id INT,
    p_estado_id INT,
    p_fornecedor_id INT
)
AS
$$
BEGIN
    UPDATE encomenda_fornecedor
    SET estado_id = p_estado_id, fornecedor_id = p_fornecedor_id
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE sp_encomenda_fornecedor_delete(
    p_id INT
)
AS
$$
BEGIN
    DELETE FROM encomenda_fornecedor WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE VIEW vw_encomenda_fornecedor_read AS
SELECT
    id,
    data_criacao,
    estado_id,
    fornecedor_id
FROM encomenda_fornecedor;


CREATE OR REPLACE PROCEDURE sp_encomenda_fornecedor_readOne(
    p_id INT
)
AS
$$
BEGIN
    SELECT *
    FROM encomenda_fornecedor
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;
