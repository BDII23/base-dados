CREATE INDEX idx_id_utilizador_perfil
ON utilizador_perfil (id);

CREATE INDEX idx_id_utilizador
ON utilizador (id);

CREATE INDEX idx_id_tipo_equipamento
ON tipo_equipamento (id);

CREATE INDEX idx_id_equipamento
ON equipamento (id);

CREATE INDEX idx_id_tipo_componente
ON tipo_componente (id);

CREATE INDEX idx_id_armazem
ON armazem (id);

CREATE INDEX idx_id_componente
ON componente (id);

CREATE INDEX idx_id_detalhe_ficha_producao
ON detalhe_ficha_producao (id);

CREATE INDEX idx_id_tipo_mao_obra
ON tipo_mao_obra (id);

CREATE INDEX idx_id_ficha_producao
ON ficha_producao (id);

CREATE INDEX idx_id_estado_encomenda
ON estado_encomenda (id);

CREATE INDEX idx_id_cliente
ON cliente (id);

CREATE INDEX idx_id_encomenda_cliente
ON encomenda_cliente (id);

CREATE INDEX idx_id_detalhe_encomenda_cliente
ON detalhe_encomenda_cliente (id);

CREATE INDEX idx_id_detalhe_remessa_cliente
ON detalhe_remessa_cliente (id);

CREATE INDEX idx_id_fatura_cliente
ON fatura_cliente (id);

CREATE INDEX idx_id_guia_remessa_cliente
ON guia_remessa_cliente (id);

CREATE INDEX idx_id_fatura_fornecedor
ON fatura_fornecedor (id);

CREATE INDEX idx_id_fornecedor
ON fornecedor (id);

CREATE INDEX idx_id_encomenda_fornecedor
ON encomenda_fornecedor (id);

CREATE INDEX idx_id_detalhe_encomenda_fornecedor
ON detalhe_encomenda_fornecedor (id);

CREATE INDEX idx_id_detalhe_remessa_fornecedor
ON detalhe_remessa_fornecedor (id);

CREATE INDEX idx_id_guia_remessa_fornecedor
ON guia_remessa_fornecedor (id);
