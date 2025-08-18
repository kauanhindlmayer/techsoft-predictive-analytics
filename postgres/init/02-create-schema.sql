-- SCHEMA TECHSOFT ANALYTICS - Safe creation with IF NOT EXISTS

-- Create tables only if they don't exist
CREATE TABLE IF NOT EXISTS regioes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS produtos (
    id SERIAL PRIMARY KEY,
    produto_id VARCHAR(20) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS vendas_mensais (
    id SERIAL PRIMARY KEY,
    mes INTEGER NOT NULL,
    vendas_valor DECIMAL(12,2) NOT NULL,
    num_clientes INTEGER NOT NULL,
    chamados_suporte INTEGER DEFAULT 0,
    satisfacao_cliente DECIMAL(3,2) CHECK (satisfacao_cliente BETWEEN 1.0 AND 5.0),
    categoria_produto VARCHAR(50) NOT NULL,
    canal_venda VARCHAR(20) NOT NULL,
    regiao_id INTEGER REFERENCES regioes(id),
    valor_por_cliente DECIMAL(10,2) GENERATED ALWAYS AS (vendas_valor / NULLIF(num_clientes, 0)) STORED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Safe index creation
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = 'idx_vendas_mes') THEN
        CREATE INDEX idx_vendas_mes ON vendas_mensais(mes);
    END IF;
END $$;

DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_indexes WHERE indexname = 'idx_vendas_categoria') THEN
        CREATE INDEX idx_vendas_categoria ON vendas_mensais(categoria_produto);
    END IF;
END $$;

-- Safe view creation
DROP VIEW IF EXISTS view_vendas_detalhadas;
CREATE VIEW view_vendas_detalhadas AS
SELECT v.*, r.nome as regiao_nome
FROM vendas_mensais v
LEFT JOIN regioes r ON v.regiao_id = r.id;

-- Display success message
DO $$
BEGIN
    RAISE NOTICE 'Schema created/updated successfully!';
END $$;