# consulta com ALL
SELECT * FROM addresses;
# consulta com DISTINCT
SELECT DISTINCT state FROM addresses;
# consulta com NULL
SELECT * FROM addresses WHERE state IS NULL;

# UPDATE
UPDATE addresses SET state = 'CE', city = 'Fortaleza' WHERE state = 'SP';
# DELETE

DELETE FROM users WHERE name = 'Maria Souza';
# INSERT
INSERT INTO users (name, email, password_digest, role, market_id, status, created_at, updated_at)
VALUES 
('Maria Souza', 'maria@supermercadorio.com', 'senha_hash_2', 'manager', (SELECT id FROM markets WHERE name = 'Supermercado do Rio'), true, NOW(), NOW());

# Consultas aninhadas
SELECT * FROM users WHERE market_id = (SELECT id FROM markets WHERE name = 'Supermercado do Rio');
# Trigger

# View

# Procedimentos armazenados