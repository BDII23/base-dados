CREATE OR REPLACE PROCEDURE sp_componente_create(
    p_descricao TEXT,
    p_quantidade INT,
    p_tipo_id INT,
    p_armazem_id INT
)
LANGUAGE SQL
AS $$
INSERT INTO componente (descricao, quantidade, tipo_id, armazem_id)
VALUES (p_descricao, p_quantidade, p_tipo_id, p_armazem_id);
$$;




CREATE OR REPLACE PROCEDURE sp_componente_update(
    p_id INT,
    p_descricao TEXT,
    p_quantidade INT,
    p_tipo_id INT,
    p_armazem_id INT
)
LANGUAGE SQL
AS $$
UPDATE componente
SET descricao = p_descricao,
    quantidade = p_quantidade,
    tipo_id = p_tipo_id,
    armazem_id = p_armazem_id
WHERE id = p_id;
$$;




CREATE OR REPLACE PROCEDURE sp_componente_delete(p_id INT)
LANGUAGE SQL
AS $$
DELETE FROM componente
WHERE id = p_id;
$$;





CREATE OR REPLACE VIEW vw_componente_read AS
SELECT * FROM componente;




CREATE OR REPLACE PROCEDURE sp_componente_readOne(p_id INT)
LANGUAGE SQL
AS $$
SELECT * FROM componente
WHERE id = p_id;
$$;

