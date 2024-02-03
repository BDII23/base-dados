-- Vista materializada para utilizador_perfil
CREATE MATERIALIZED VIEW utilizador_perfil
AS
SELECT *
FROM utilizador_perfil;

-- Vista materializada para utilizador
CREATE MATERIALIZED VIEW utilizador
AS
SELECT *
FROM utilizador;

-- Vista materializada para tipo_equipamento
CREATE MATERIALIZED VIEW tipo_equipamento
AS
SELECT *
FROM tipo_equipamento;

-- Vista materializada para equipamento
CREATE MATERIALIZED VIEW equipamento
AS
SELECT *
FROM equipamento;

-- Vista materializada para tipo_componente
CREATE MATERIALIZED VIEW tipo_componente
AS
SELECT *
FROM tipo_componente;

-- Vista materializada para armazem
CREATE MATERIALIZED VIEW armazem
AS
SELECT *
FROM armazem;

-- Vista materializada para componente
CREATE MATERIALIZED VIEW componente
AS
SELECT *
FROM componente;

-- Vista materializada para detalhe_ficha_producao
CREATE MATERIALIZED VIEW detalhe_ficha_producao
AS
SELECT *
FROM detalhe_ficha_producao;

-- Vista materializada para tipo_mao_obra
CREATE MATERIALIZED VIEW tipo_mao_obra
AS
SELECT *
FROM tipo_mao_obra;

-- Vista materializada para ficha_producao
CREATE MATERIALIZED VIEW ficha_producao
AS
SELECT *
FROM ficha_producao;

-- Vista materializada para estado_encomenda
CREATE MATERIALIZED VIEW estado_encomenda
AS
SELECT *
FROM estado_encomenda;

-- Vista materializada para cliente
CREATE MATERIALIZED VIEW cliente
AS
SELECT *
FROM cliente;

-- Vista materializada para encomenda_cliente
CREATE MATERIALIZED VIEW encomenda_cliente
AS
SELECT *
FROM encomenda_cliente;

-- Vista materializada para detalhe_encomenda_cliente
CREATE MATERIALIZED VIEW detalhe_encomenda_cliente
AS
SELECT *
FROM detalhe_encomenda_cliente;

-- Vista materializada para detalhe_remessa_cliente
CREATE MATERIALIZED VIEW detalhe_remessa_cliente
AS
SELECT *
FROM detalhe_remessa_cliente;

-- Vista materializada para fatura_cliente
CREATE MATERIALIZED VIEW fatura_cliente
AS
SELECT *
FROM fatura_cliente;

-- Vista materializada para guia_remessa_cliente
CREATE MATERIALIZED VIEW guia_remessa_cliente
AS
SELECT *
FROM guia_remessa_cliente;

-- Vista materializada para fatura_fornecedor
CREATE MATERIALIZED VIEW fatura_fornecedor
AS
SELECT *
FROM fatura_fornecedor;

-- Vista materializada para fornecedor
CREATE MATERIALIZED VIEW fornecedor
AS
SELECT *
FROM fornecedor;

-- Vista materializada para encomenda_fornecedor
CREATE MATERIALIZED VIEW encomenda_fornecedor
AS
SELECT *
FROM encomenda_fornecedor;

-- Vista materializada para detalhe_encomenda_fornecedor
CREATE MATERIALIZED VIEW detalhe_encomenda_fornecedor
AS
SELECT *
FROM detalhe_encomenda_fornecedor;

-- Vista materializada para detalhe_remessa_fornecedor
CREATE MATERIALIZED VIEW detalhe_remessa_fornecedor
AS
SELECT *
FROM detalhe_remessa_fornecedor;

-- Vista materializada para guia_remessa_fornecedor
CREATE MATERIALIZED VIEW guia_remessa_fornecedor
AS
SELECT *
FROM guia_remessa_fornecedor;