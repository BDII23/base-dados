INSERT INTO utilizador_perfil (perfil)
VALUES
	('Admin'),
	('User'),
	('Manager');


INSERT INTO utilizador (email, senha, nome, perfil_id)
VALUES
	('admin@example.com', 'adminpassword', 'Admin User', 1),
	('user@example.com', 'userpassword', 'Regular User', 2),
	('manager@example.com', 'managerpassword', 'Manager User', 3),
	('lucasmsebastiao@gmail.com', '1234', 'Lucas Sebastião', 1),
	('joaosantos@gmail.com', '1234', 'João Santos', 1),
	('miguelmarques@gmail.com', '1234', 'Miguel Marques', 1),
	('cassamolatif@gmail.com', '1234', 'CassamoLatif', 1);


INSERT INTO equipamento (descricao, utilizador_id)
VALUES
	('Equipment 1', 2),
	('Equipment 2', 3),
	('Equipment 3', 1);


INSERT INTO atributo_equipamento (atributo)
VALUES
	('Attribute 1'),
	('Attribute 2'),
	('Attribute 3');


INSERT INTO valor_equipamento (valor, atributo_id)
VALUES
	('Value 1', 1),
	('Value 2', 2),
	('Value 3', 3);


INSERT INTO valor_atributo_equipamento (valor_id, equipamento_id)
VALUES
	(1, 1),
	(2, 2),
	(3, 3);


INSERT INTO tipo_componente (tipo)
VALUES
	('Type 1'),
	('Type 2'),
	('Type 3');


INSERT INTO armazem (endereco)
VALUES
	('Warehouse 1'),
	('Warehouse 2'),
	('Warehouse 3');


INSERT INTO componente (descricao, tipo_id, armazem_id)
VALUES
	('Component 1', 1, 2),
	('Component 2', 2, 3),
	('Component 3', 3, 1);


INSERT INTO estado_ficha_producao (estado)
VALUES
	('Pending'),
	('In Progress'),
	('Completed');


INSERT INTO ficha_producao (observacao, componente_id, equipamento_id, estado_id)
VALUES
	('Observation 1', 1, 2, 3),
	('Observation 2', 2, 3, 1),
	('Observation 3', 3, 1, 2);


INSERT INTO estado_encomenda (estado)
VALUES
	('Received'),
	('Processing'),
	('Shipped');


INSERT INTO cliente (email, senha, nome)
VALUES
	('client1@example.com', 'clientpassword', 'Client 1'),
	('client2@example.com', 'clientpassword', 'Client 2'),
	('client3@example.com', 'clientpassword', 'Client 3');


INSERT INTO encomenda_cliente (quantidade, estado_id, cliente_id)
VALUES
	(5, 2, 1),
	(10, 1, 2),
	(7, 3, 3);


INSERT INTO artigo_encomenda_cliente (equipamento_id, encomenda_id)
VALUES
	(1, 1),
	(2, 2),
	(3, 3);


INSERT INTO fatura_cliente (descricao)
VALUES
	('Invoice 1'),
	('Invoice 2'),
	('Invoice 3');


INSERT INTO estado_guia (estado)
VALUES
	('Pending'),
	('In Transit'),
	('Delivered');


INSERT INTO remessa_cliente (data_recebida, volume, peso, encomenda_id, fatura_id)
VALUES
	(NOW(), 50, 100, 1, 1),
	(NOW(), 75, 120, 2, 2),
	(NOW(), 60, 90, 3, 3);


INSERT INTO guia_cliente (data_envio, data_entrega_prevista, data_entrega, endereco_origem, endereco_chegada, transportadora, custo_envio, tipo_envio, remessa_id, estado_id)
VALUES
	(NOW(), NOW() + INTERVAL '7 days', NOW() + INTERVAL '8 days', 'Warehouse 1', 'Client 1 Address', 'ABC Logistics', '50.00', 'Express', 1, 3),
	(NOW(), NOW() + INTERVAL '5 days', NOW() + INTERVAL '6 days', 'Warehouse 2', 'Client 2 Address', 'XYZ Shipping', '75.00', 'Standard', 2, 2),
	(NOW(), NOW() + INTERVAL '6 days', NOW() + INTERVAL '7 days', 'Warehouse 3', 'Client 3 Address', 'DEF Couriers', '60.00', 'Express', 3, 1);


INSERT INTO fatura_fornecedor (descricao)
VALUES
	('Invoice 4'),
	('Invoice 5'),
	('Invoice 6'),
	('Invoice 4'),
	('Invoice 5'),
	('Invoice 6');


INSERT INTO fornecedor (nome, nif, email, telefone, endereco)
VALUES
	('Supplier 1', '123456789', 'supplier1@example.com', '123456789', 'Supplier 1 Address'),
	('Supplier 2', '987654321', 'supplier2@example.com', '987654321', 'Supplier 2 Address'),
	('Supplier 3', '111222333', 'supplier3@example.com', '111222333', 'Supplier 3 Address');


INSERT INTO encomenda_fornecedor (quantidade, estado_id, fornecedor_id, utilizador_id)
VALUES
	(15, 2, 1, 1),
	(20, 1, 2, 2),
	(12, 3, 3, 3);


INSERT INTO artigo_encomenda_fornecedor (componente_id, encomenda_id)
VALUES
	(1, 1),
	(2, 2),
	(3, 3);


INSERT INTO remessa_fornecedor (data_recebida, volume, peso, fatura_id, encomenda_id)
VALUES
	(NOW(), 100, 150, 4, 1),
	(NOW(), 120, 180, 5, 2),
	(NOW(), 90, 120, 6, 3);


INSERT INTO guia_fornecedor (data_envio, data_entrega_prevista, data_entrega, endereco_origem, endereco_chegada, transportadora, custo_envio, tipo_envio, remessa_id, estado_id)
VALUES
	(NOW(), NOW() + INTERVAL '7 days', NOW() + INTERVAL '8 days', 'Supplier 1 Warehouse', 'Warehouse 1', 'Supplier Logistics', '80.00', 'Express', 1, 3),
	(NOW(), NOW() + INTERVAL '5 days', NOW() + INTERVAL '6 days', 'Supplier 2 Warehouse', 'Warehouse 2', 'Supplier Shipping', '100.00', 'Standard', 2, 2),
	(NOW(), NOW() + INTERVAL '6 days', NOW() + INTERVAL '7 days', 'Supplier 3 Warehouse', 'Warehouse 3', 'Supplier Couriers', '90.00', 'Express', 3, 1);
