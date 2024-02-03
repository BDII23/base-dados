CREATE OR REPLACE FUNCTION update_stock_componente_ficha_producao()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE componente
  SET quantidade = quantidade - NEW.quantidade
  WHERE id = NEW.componente_id;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_stock_componente_ficha_producao
AFTER INSERT ON detalhe_ficha_producao
FOR EACH ROW
EXECUTE FUNCTION update_stock_componente_ficha_producao();



CREATE OR REPLACE FUNCTION update_stock_fornecedor()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE componente
    SET quantidade = componente.quantidade + NEW.quantidade
    FROM detalhe_encomenda_fornecedor
    WHERE componente.id = detalhe_encomenda_fornecedor.componente_id
      AND detalhe_encomenda_fornecedor.id = NEW.detalhe_encomenda_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_stock_fornecedor
AFTER INSERT ON detalhe_remessa_fornecedor
FOR EACH ROW
EXECUTE FUNCTION update_stock_fornecedor();



CREATE OR REPLACE FUNCTION update_stock_equipamento_ficha_producao()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE equipamento
    SET quantidade = NEW.quantidade_equipamentos
    WHERE id = NEW.equipamento_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_stock_equipamento_ficha_producao
AFTER INSERT ON ficha_producao
FOR EACH ROW
EXECUTE FUNCTION update_stock_equipamento_ficha_producao();



CREATE OR REPLACE FUNCTION update_stock_cliente()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE equipamento
    SET quantidade = equipamento.quantidade - NEW.quantidade
    FROM detalhe_encomenda_cliente
    WHERE equipamento.id = detalhe_encomenda_cliente.equipamento_id
      AND detalhe_encomenda_cliente.id = NEW.detalhe_encomenda_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_stock_cliente
AFTER INSERT ON detalhe_remessa_cliente
FOR EACH ROW
EXECUTE FUNCTION update_stock_cliente();
