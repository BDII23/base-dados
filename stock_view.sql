CREATE VIEW view_stocks_componentes AS
SELECT
    c.id AS componente_id,
    c.descricao AS componente_descricao,
    c.quantidade AS componente_quantidade,
    a.id AS armazem_id,
    a.endereco AS armazem_endereco
FROM
    componente c
    JOIN armazem a ON c.armazem_id = a.id
WHERE
    c.id NOT IN (
        SELECT componente_id FROM detalhe_ficha_producao
    );