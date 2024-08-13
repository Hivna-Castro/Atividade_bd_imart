# consulta com ALL
SELECT * FROM addresses;
SELECT * FROM products;

# consulta com DISTINCT
SELECT DISTINCT state FROM addresses;
SELECT DISTINCT city FROM addresses;

# consulta com NULL
SELECT * FROM addresses WHERE state IS NULL;
SELECT * FROM suppliers WHERE name IS NULL;

# UPDATE
UPDATE addresses SET state = 'CE', city = 'Fortaleza' WHERE state = 'SP';
UPDATE suppliers SET name = 'Brownie LTDA' WHERE name = 'Fornecedor Guloseimas LTDA';

# DELETE
DELETE FROM users WHERE name = 'Maria Souza';
DELETE FROM users WHERE name = 'João Silva';

# INSERT
INSERT INTO users (name, email, password_digest, role, market_id, status, created_at, updated_at)
VALUES 
('Maria Souza', 'maria@supermercadorio.com', 'senha_hash_2', 'manager', (SELECT id FROM markets WHERE name = 'Supermercado do Rio'), true, NOW(), NOW());

INSERT INTO suppliers (name, cnpj, cellphone, email, active, market_id, created_at, updated_at)
VALUES 
('Fini LTDA', '23.212.232/0001-25', '(11) 98734-4331', 'fini@fornecedor.com', true, (SELECT id FROM markets WHERE name = 'Mercado Central'), NOW(), NOW()),


# Consultas aninhadas
SELECT * FROM users WHERE market_id = (SELECT id FROM markets WHERE name = 'Supermercado do Rio');

SELECT name FROM markets WHERE address_id = (SELECT id FROM addresses WHERE street = 'Av. Paulista');

# Trigger
CREATE OR REPLACE FUNCTION notify_delete()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'Registro com id % foi excluído.', OLD.id;
    RETURN OLD; -- Retorna o registro excluído
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_notify_delete_users
AFTER DELETE ON users
FOR EACH ROW
EXECUTE FUNCTION notify_delete();

select id from users;
DELETE FROM users WHERE id = 'abfbeefe-0112-43d8-9e4d-0361d3c43184';


SELECT tgname
FROM pg_trigger
WHERE tgrelid = 'users'::regclass;



# View

# Procedimentos armazenados

CREATE OR REPLACE PROCEDURE update_market_address(
    IN p_market_id UUID,
    IN p_new_address_id UUID
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE markets
    SET address_id = p_new_address_id
    WHERE id = p_market_id;
END;
$$;

CALL update_market_address(  'f0f9baea-17d2-48d5-ac75-fe1a0d9d169f', '7fa5ee83-93a4-4d28-8304-1e82bc39df1f');

SELECT DISTINCT a.id
FROM addresses a
JOIN markets m ON a.id = m.address_id;