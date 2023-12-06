-- Utilizador_perfil
INSERT INTO utilizador_perfil (perfil) VALUES
('Administrador'),
('Utilizador Padrão'),
('Gestor de Produção');

-- Utilizador
INSERT INTO utilizador (email, senha, nome, sobrenome, perfil_id) VALUES
('admin@example.com', 'senha_admin', 'Admin', 'Admin', 1),
('user1@example.com', 'senha_user1', 'User', 'One', 2),
('manager@example.com', 'senha_manager', 'Manager', 'Production', 3);

-- Tipo_equipamento
INSERT INTO tipo_equipamento (tipo) VALUES
('Computador'),
('Impressora'),
('Servidor'),
('Router'),
('Switch');

-- Equipamento
INSERT INTO equipamento (descricao, tipo_id) VALUES
('Laptop Dell', 1),
('HP LaserJet', 2),
('HP ProLiant', 3),
('Cisco Router', 4),
('Cisco Switch', 5);

-- Atributo_equipamento
INSERT INTO atributo_equipamento (atributo) VALUES
('Peso'),
('Voltagem'),
('Cor'),
('Velocidade');

-- Valor_equipamento
INSERT INTO valor_equipamento (valor, atributo_id) VALUES
('2.5 kg', 1),
('110V', 2),
('Preto', 3),
('1000 Mbps', 4);

-- Valor_atributo_equipamento
INSERT INTO valor_atributo_equipamento (valor_id, equipamento_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(1, 5);

-- Tipo_componente
INSERT INTO tipo_componente (tipo) VALUES
('Processador'),
('Memória RAM'),
('Disco Rígido'),
('Placa de Rede'),
('Fonte de Alimentação');

-- Armazem
INSERT INTO armazem (endereco) VALUES
('Armazém A, Rua 1'),
('Armazém B, Rua 2'),
('Armazém C, Rua 3');

-- Componente
INSERT INTO componente (descricao, quantidade, tipo_id, armazem_id) VALUES
('Intel Core i7', 50, 1, 1),
('Kingston 8GB', 100, 2, 2),
('Seagate 1TB', 200, 3, 3),
('Realtek PCIe', 150, 4, 1),
('Corsair 500W', 80, 5, 2);

-- Detalhe_ficha_producao
INSERT INTO detalhe_ficha_producao (descricao, componente_id) VALUES
('Detalhe 1', 1),
('Detalhe 2', 2),
('Detalhe 3', 3),
('Detalhe 4', 4),
('Detalhe 5', 5);

-- Tipo_mao_obra
INSERT INTO tipo_mao_obra (tipo, custo) VALUES
('Montagem', 30.00),
('Teste', 25.00),
('Manutenção', 20.00);

-- Ficha_producao
INSERT INTO ficha_producao (quantidade_equipamentos, descricao, horas, detalhe_id, utilizador_id, tipo_mao_obra_id, equipamento_id) VALUES
(100, 'Produção em Lote', 8, 1, 3, 1, 3),
(50, 'Teste de Qualidade', 4, 2, 3, 2, 1),
(200, 'Montagem Rápida', 10, 3, 2, 3, 2),
(80, 'Manutenção Preventiva', 6, 4, 1, 1, 4),
(120, 'Teste de Rede', 5, 2, 2, 2, 5);

-- Estado_encomenda
INSERT INTO estado_encomenda (estado) VALUES
('Pendente'),
('Em Processamento'),
('Enviada'),
('Entregue');

-- Cliente
INSERT INTO cliente (email, senha, nome, nif) VALUES
('client1@example.com', 'senha_client1', 'Cliente 1', '123456789'),
('client2@example.com', 'senha_client2', 'Cliente 2', '987654321'),
('client3@example.com', 'senha_client3', 'Cliente 3', '111222333');

-- Fatura_cliente
INSERT INTO fatura_cliente (descricao) VALUES
('Fatura Cliente 1'),
('Fatura Cliente 2'),
('Fatura Cliente 3');

-- Encomenda_cliente
INSERT INTO encomenda_cliente (estado_id, cliente_id, fatura_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

-- Detalhe_encomenda_cliente
INSERT INTO detalhe_encomenda_cliente (quantidade, custo_unidade, equipamento_id, encomenda_id) VALUES
(10, 500.00, 1, 1),
(5, 300.00, 2, 2),
(8, 700.00, 3, 3);

-- Detalhe_fatura_cliente
INSERT INTO detalhe_fatura_cliente (quantidade, detalhe_encomenda_id, fatura_id) VALUES
(10, 1, 1),
(5, 2, 2),
(8, 3, 3);

-- Estado_guia_remessa
INSERT INTO estado_guia_remessa (estado) VALUES
('Em Processamento'),
('Enviada'),
('Recebida');

-- Guia_remessa_cliente
INSERT INTO guia_remessa_cliente (data_envio, data_entrega_prevista, endereco_origem, endereco_chegada, estado_id, detalhe_encomenda_id, utilizador_id) VALUES
('2023-01-10', '2023-01-15', 'Armazém A, Rua 1', 'Endereço Cliente 1', 1, 1, 3),
('2023-02-05', '2023-02-10', 'Armazém B, Rua 2', 'Endereço Cliente 2', 2, 2, 3),
('2023-03-20', '2023-03-25', 'Armazém C, Rua 3', 'Endereço Cliente 3', 3, 3, 2);

-- Detalhe_remessa_cliente
INSERT INTO detalhe_remessa_cliente (quantidade, detalhe_encomenda_id, remessa_id) VALUES
(10, 1, 1),
(5, 2, 2),
(8, 3, 3);

-- Fatura_fornecedor
INSERT INTO fatura_fornecedor (descricao) VALUES
('Fatura Fornecedor 1'),
('Fatura Fornecedor 2'),
('Fatura Fornecedor 3');

-- Fornecedor
INSERT INTO fornecedor (nome, nif, email, telefone, endereco) VALUES
('Fornecedor A', '987654321', 'fornecedorA@example.com', '123456789', 'Rua Fornecedor, 123'),
('Fornecedor B', '123456789', 'fornecedorB@example.com', '987654321', 'Avenida do Fornecedor, 456'),
('Fornecedor C', '111222333', 'fornecedorC@example.com', '555555555', 'Travessa dos Fornecedores, 789');

-- Encomenda_fornecedor
INSERT INTO encomenda_fornecedor (estado_id, fornecedor_id, fatura_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

-- Detalhe_encomenda_fornecedor
INSERT INTO detalhe_encomenda_fornecedor (quantidade, custo_entidade, componente_id, encomenda_id) VALUES
(20, 1500.00, 1, 1),
(15, 800.00, 2, 2),
(25, 1200.00, 3, 3);

-- Detalhe_fatura_fornecedor
INSERT INTO detalhe_fatura_fornecedor (quantidade, detalhe_encomenda_id, fatura_id) VALUES
(20, 1, 1),
(15, 2, 2),
(25, 3, 3);

-- Estado_guia_remessa
INSERT INTO estado_guia_remessa (estado) VALUES
('Em Processamento'),
('Enviada'),
('Recebida');

-- Guia_remessa_fornecedor
INSERT INTO guia_remessa_fornecedor (data_envio, data_entrega_prevista, endereco_origem, endereco_chegada, estado_id, detalhe_encomenda_id, utilizador_id) VALUES
('2023-04-05', '2023-04-10', 'Armazém Fornecedor A, Rua 1', 'Endereço Armazém Fornecedor A', 1, 1, 3),
('2023-05-15', '2023-05-20', 'Armazém Fornecedor B, Rua 2', 'Endereço Armazém Fornecedor B', 2, 2, 3),
('2023-06-25', '2023-06-30', 'Armazém Fornecedor C, Rua 3', 'Endereço Armazém Fornecedor C', 3, 3, 2);

-- Detalhe_remessa_fornecedor
INSERT INTO detalhe_remessa_fornecedor (quantidade, detalhe_encomenda_id, remessa_id) VALUES
(20, 1, 1),
(15, 2, 2),
(25, 3, 3);
