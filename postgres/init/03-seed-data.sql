-- Seed data for the TechSoft database - Safe insertion with conflict handling

-- Insert sample regions (ignore if already exists)
INSERT INTO regioes (nome) VALUES
('Norte'),
('Sul'),
('Leste'),
('Oeste'),
('Centro')
ON CONFLICT (nome) DO NOTHING;

-- Insert sample products (ignore if already exists)
INSERT INTO produtos (produto_id, nome, categoria) VALUES
('TECH001', 'TechSoft Pro 1', 'Software'),
('TECH002', 'TechSoft Pro 2', 'Consultoria'),
('TECH003', 'TechSoft Pro 3', 'Suporte')
ON CONFLICT (produto_id) DO NOTHING;

-- Insert sample sales data (update if already exists)
INSERT INTO vendas_mensais (mes, vendas_valor, num_clientes, chamados_suporte, satisfacao_cliente, categoria_produto, canal_venda, regiao_id) VALUES
(1, 350000.00, 60, 5, 4.5, 'Software', 'Online', 1),
(2, 400000.00, 70, 3, 4.7, 'Consultoria', 'Presencial', 2),
(3, 300000.00, 50, 4, 4.2, 'Suporte', 'Online', 3)
ON CONFLICT DO NOTHING;

-- Alternative: Update existing data
-- INSERT INTO vendas_mensais (...) VALUES (...)
-- ON CONFLICT (mes, categoria_produto, regiao_id) 
-- DO UPDATE SET 
--     vendas_valor = EXCLUDED.vendas_valor,
--     num_clientes = EXCLUDED.num_clientes,
--     updated_at = CURRENT_TIMESTAMP;

-- Show summary
DO $$
DECLARE
    regiao_count INTEGER;
    produto_count INTEGER;
    vendas_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO regiao_count FROM regioes;
    SELECT COUNT(*) INTO produto_count FROM produtos;
    SELECT COUNT(*) INTO vendas_count FROM vendas_mensais;
    
    RAISE NOTICE 'Data seeding completed!';
    RAISE NOTICE 'Regions: % records', regiao_count;
    RAISE NOTICE 'Products: % records', produto_count;
    RAISE NOTICE 'Sales: % records', vendas_count;
END $$;