-- Utilizador_Perfil
INSERT INTO utilizador_perfil (perfil) VALUES
  ('Administrador'),
  ('Utilizador Padrão'),
  ('Gestor de Produção');

-- Utilizador
INSERT INTO utilizador (email, senha, nome, sobrenome, perfil_id) VALUES
  ('admin@example.com', 'admin123', 'Admin', 'istrator', 1),
  ('user1@example.com', 'user123', 'User', 'One', 2),
  ('manager@example.com', 'manager123', 'Manager', 'One', 3);

-- Tipo_Equipamento
INSERT INTO tipo_equipamento (tipo) VALUES
  ('Laptop'),
  ('Impressora 3D'),
  ('Máquina CNC');

-- Equipamento
INSERT INTO equipamento (tipo_id) VALUES
  (1),
  (2),
  (3);

-- Tipo_Componente
INSERT INTO tipo_componente (tipo) VALUES
  ('Placa de Circuito'),
  ('Motor Elétrico'),
  ('Estrutura Metálica');

-- Armazem
INSERT INTO armazem (endereco) VALUES
  ('Armazém A, Rua Principal, 123'),
  ('Armazém B, Rua Secundária, 456'),
  ('Armazém C, Rua Alternativa, 789');

-- Componente
INSERT INTO componente (descricao, quantidade, tipo_id, armazem_id) VALUES
  ('C1', 50, 1, 1),
  ('C2', 100, 2, 2),
  ('C3', 50, 1, 1),
  ('C4', 100, 2, 2),
  ('C5', 50, 1, 1),
  ('C6', 100, 2, 2),
  ('C7', 50, 1, 1),
  ('C8', 100, 2, 2),
  ('C9', 50, 1, 1),
  ('C10', 100, 2, 2),
  ('C11', 50, 1, 1),
  ('C12', 100, 2, 2);

-- Tipo_Mao_Obra
INSERT INTO tipo_mao_obra (tipo, custo) VALUES
  ('Montagem', 20.5),
  ('Soldagem', 15.75),
  ('Programação CNC', 30.0);

-- Ficha_Producao
INSERT INTO ficha_producao (quantidade_equipamentos, descricao, horas, utilizador_id, tipo_mao_obra_id, equipamento_id) VALUES
  (100, 'Produção em Massa', 120, 2, 1, 3),
  (50, 'Prototipagem', 40, 3, 2, 2),
  (200, 'Produção Personalizada', 180, 1, 3, 1);

-- Detalhe_Ficha_Producao
INSERT INTO detalhe_ficha_producao (componente_id, ficha_producao_id) VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 1),
  (5, 2),
  (6, 3),
  (7, 1),
  (8, 2),
  (9, 3),
  (10, 1),
  (11, 2),
  (12, 3);

-- Estado_Encomenda
INSERT INTO estado_encomenda (estado) VALUES
  ('Pendente'),
  ('Em Processamento'),
  ('Concluída');

-- Cliente
INSERT INTO cliente (email, senha, nome, nif) VALUES
  ('cliente1@example.com', 'cliente123', 'Cliente Um', '123456789'),
  ('cliente2@example.com', 'cliente456', 'Cliente Dois', '987654321'),
  ('cliente3@example.com', 'cliente789', 'Cliente Três', '111222333');

-- Fatura_Cliente
INSERT INTO fatura_cliente (descricao) VALUES
  ('Fatura 001'),
  ('Fatura 002'),
  ('Fatura 003');

-- Encomenda_Cliente
INSERT INTO encomenda_cliente (estado_id, cliente_id) VALUES
  (1, 1),
  (2, 2),
  (3, 3);

-- Detalhe_Encomenda_Cliente
INSERT INTO detalhe_encomenda_cliente (quantidade, custo_unidade, equipamento_id, encomenda_id) VALUES
  (10, 50.25, 1, 1),
  (5, 30.75, 2, 2),
  (20, 15.50, 3, 3);

-- Guia_Remessa_Cliente
INSERT INTO guia_remessa_cliente (data_envio, data_entrega, endereco_origem, endereco_chegada, estado_id, detalhe_encomenda_id, utilizador_id, fatura_id) VALUES
  ('2024-01-10', '2024-01-15', 'Armazém A', 'Endereço Cliente 1', 1, 2, 1),
  ('2024-01-12', '2024-01-18', 'Armazém B', 'Endereço Cliente 2', 2, 3, 2),
  ('2024-01-15', '2024-01-20', 'Armazém C', 'Endereço Cliente 3', 3, 1, 3);

-- Detalhe_Remessa_Cliente
INSERT INTO detalhe_remessa_cliente (quantidade, detalhe_encomenda_id, remessa_id) VALUES
  (10, 1, 1),
  (5, 2, 2),
  (20, 3, 3);

-- Fatura_Fornecedor
INSERT INTO fatura_fornecedor (descricao) VALUES
  ('Fatura Fornecedor 001'),
  ('Fatura Fornecedor 002'),
  ('Fatura Fornecedor 003');

-- Fornecedor
INSERT INTO fornecedor (nome, nif, email, telefone, endereco) VALUES
  ('Fornecedor 1', '987654321', 'fornecedor1@example.com', '123456789', 'Rua Fornecedor 1, 123'),
  ('Fornecedor 2', '111222333', 'fornecedor2@example.com', '987654321', 'Rua Fornecedor 2, 456'),
  ('Fornecedor 3', '444555666', 'fornecedor3@example.com', '654321987', 'Rua Fornecedor 3, 789');

-- Encomenda_Fornecedor
INSERT INTO encomenda_fornecedor (estado_id, fornecedor_id) VALUES
  (1, 1),
  (2, 2),
  (3, 3);

-- Detalhe_Encomenda_Fornecedor
INSERT INTO detalhe_encomenda_fornecedor (quantidade, custo_entidade, componente_id, encomenda_id) VALUES
  (10, 50.25, 1, 1),
  (5, 30.75, 2, 2),
  (20, 15.50, 3, 3);

-- Guia_Remessa_Fornecedor
INSERT INTO guia_remessa_fornecedor (data_envio, data_entrega, endereco_origem, endereco_chegada, estado_id, detalhe_encomenda_id, utilizador_id, fatura_id) VALUES
  ('2024-01-10', '2024-01-15', 'Armazém Fornecedor 1', 'Endereço Fornecedor 1', 1, 2, 1),
  ('2024-01-12', '2024-01-18', 'Armazém Fornecedor 2', 'Endereço Fornecedor 2', 2, 3, 2),
  ('2024-01-15', '2024-01-20', 'Armazém Fornecedor 3', 'Endereço Fornecedor 3', 3, 1, 3);

-- Detalhe_Remessa_Fornecedor
INSERT INTO detalhe_remessa_fornecedor (quantidade, detalhe_encomenda_id, remessa_id) VALUES
  (10, 1, 1),
  (5, 2, 2),
  (20, 3, 3);

-- Detalhe_Remessa_Fornecedor (continuação)
INSERT INTO detalhe_remessa_fornecedor (quantidade, detalhe_encomenda_id, remessa_id) VALUES
  (10, 1, 1),
  (5, 2, 2),
  (20, 3, 3);