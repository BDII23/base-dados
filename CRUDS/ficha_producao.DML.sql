CREATE OR REPLACE PROCEDURE sp_ficha_producao_create(
    IN p_quantidade_equipamentos INT,
    IN p_descricao TEXT,
    IN p_horas INT,
    IN p_detalhe_id INT,
    IN p_utilizador_id INT,
    IN p_tipo_mao_obra_id INT,
    IN p_equipamento_id INT
)
LANGUAGE SQL
AS $$
INSERT INTO ficha_producao (
    quantidade_equipamentos,
    descricao,
    horas,
    detalhe_id,
    utilizador_id,
    tipo_mao_obra_id,
    equipamento_id
) VALUES (
    p_quantidade_equipamentos,
    p_descricao,
    p_horas,
    p_detalhe_id,
    p_utilizador_id,
    p_tipo_mao_obra_id,
    p_equipamento_id
) RETURNING *;
$$;






CREATE OR REPLACE PROCEDURE sp_ficha_producao_update(
    IN p_id INT,
    IN p_quantidade_equipamentos INT,
    IN p_descricao TEXT,
    IN p_horas INT,
    IN p_detalhe_id INT,
    IN p_utilizador_id INT,
    IN p_tipo_mao_obra_id INT,
    IN p_equipamento_id INT
)
LANGUAGE SQL
AS $$
UPDATE ficha_producao
SET
    quantidade_equipamentos = p_quantidade_equipamentos,
    descricao = p_descricao,
    horas = p_horas,
    detalhe_id = p_detalhe_id,
    utilizador_id = p_utilizador_id,
    tipo_mao_obra_id = p_tipo_mao_obra_id,
    equipamento_id = p_equipamento_id
WHERE id = p_id
RETURNING *;
$$;






CREATE OR REPLACE PROCEDURE sp_ficha_producao_delete(IN p_id INT)
LANGUAGE SQL
AS $$
DELETE FROM ficha_producao WHERE id = p_id;
$$;





CREATE OR REPLACE PROCEDURE sp_ficha_producao_readOne(IN p_id INT)
LANGUAGE SQL
AS $$
SELECT * FROM ficha_producao WHERE id = p_id;
$$;






CREATE OR REPLACE VIEW vw_ficha_producao_read AS
SELECT * FROM ficha_producao;
