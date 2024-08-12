INSERT INTO addresses (state, city, street, neighborhood, number, zipcode, created_at, updated_at)
VALUES 
('SP', 'São Paulo', 'Av. Paulista', 'Bela Vista', '1000', '01310-100', NOW(), NOW()),
('RJ', 'Rio de Janeiro', 'Rua do Ouvidor', 'Centro', '50', '20040-030', NOW(), NOW()),
('MG', 'Belo Horizonte', 'Av. Afonso Pena', 'Centro', '300', '30130-001', NOW(), NOW());

INSERT INTO markets (name, cnpj, cellphone, active, address_id, created_at, updated_at)
VALUES 
('Mercado Central', '00.123.456/0001-78', '(11) 91234-5678', true, 
 (SELECT id FROM addresses WHERE street = 'Av. Paulista'), NOW(), NOW()),
('Supermercado do Rio', '00.987.654/0001-12', '(21) 99876-5432', false, 
 (SELECT id FROM addresses WHERE street = 'Rua do Ouvidor'), NOW(), NOW()),
('Hipermercado BH', '11.111.111/0001-00', '(31) 93123-4567', true, 
 (SELECT id FROM addresses WHERE street = 'Av. Afonso Pena'), NOW(), NOW());

INSERT INTO categories (name, market_id, created_at, updated_at)
VALUES 
('Bebidas', (SELECT id FROM markets WHERE name = 'Mercado Central'), NOW(), NOW()),
('Hortifruti', (SELECT id FROM markets WHERE name = 'Supermercado do Rio'), NOW(), NOW()),
('Laticínios', (SELECT id FROM markets WHERE name = 'Hipermercado BH'), NOW(), NOW());

INSERT INTO suppliers (name, cnpj, cellphone, email, active, market_id, created_at, updated_at)
VALUES 
('Fornecedor Bebidas LTDA', '22.222.222/0001-22', '(11) 98765-4321', 'bebidas@fornecedor.com', true, 
 (SELECT id FROM markets WHERE name = 'Mercado Central'), NOW(), NOW()),
('Fornecedor Hortifruti LTDA', '33.333.333/0001-33', '(21) 97654-3210', 'hortifruti@fornecedor.com', true, 
 (SELECT id FROM markets WHERE name = 'Supermercado do Rio'), NOW(), NOW()),
('Fornecedor Laticínios LTDA', '44.444.444/0001-44', '(31) 96543-2109', 'laticinios@fornecedor.com', true, 
 (SELECT id FROM markets WHERE name = 'Hipermercado BH'), NOW(), NOW());

INSERT INTO products (barcode, name, price, category_id, supplier_id, market_id, created_at, updated_at)
VALUES 
('7891000100104', 'Cerveja', 4.99, 
 (SELECT id FROM categories WHERE name = 'Bebidas'), 
 (SELECT id FROM suppliers WHERE name = 'Fornecedor Bebidas LTDA'), 
 (SELECT id FROM markets WHERE name = 'Mercado Central'), NOW(), NOW()),
('7891000200201', 'Maçã', 3.49, 
 (SELECT id FROM categories WHERE name = 'Hortifruti'), 
 (SELECT id FROM suppliers WHERE name = 'Fornecedor Hortifruti LTDA'), 
 (SELECT id FROM markets WHERE name = 'Supermercado do Rio'), NOW(), NOW()),
('7891000300308', 'Leite', 6.99, 
 (SELECT id FROM categories WHERE name = 'Laticínios'), 
 (SELECT id FROM suppliers WHERE name = 'Fornecedor Laticínios LTDA'), 
 (SELECT id FROM markets WHERE name = 'Hipermercado BH'), NOW(), NOW());

INSERT INTO storages (product_id, batch, quantity, created_at, updated_at)
VALUES 
('7891000100104', 'Lote A1', 100.0, NOW(), NOW()),
('7891000200201', 'Lote B2', 200.0, NOW(), NOW()),
('7891000300308', 'Lote C3', 150.0, NOW(), NOW());

INSERT INTO users (name, email, password_digest, role, market_id, status, created_at, updated_at)
VALUES 
('João Silva', 'joao@mercadocentral.com', 'senha_hash_1', 'admin', 
 (SELECT id FROM markets WHERE name = 'Mercado Central'), true, NOW(), NOW()),
('Maria Souza', 'maria@supermercadorio.com', 'senha_hash_2', 'manager', 
 (SELECT id FROM markets WHERE name = 'Supermercado do Rio'), true, NOW(), NOW()),
('Carlos Santos', 'carlos@hipermercadobh.com', 'senha_hash_3', 'employee', 
 (SELECT id FROM markets WHERE name = 'Hipermercado BH'), true, NOW(), NOW());
