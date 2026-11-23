-- Esquema PostgreSQL para Nexus Software Studio
-- Diseñado por Mateo (Backend & Database Engineer)

CREATE TABLE IF NOT EXISTS clientes (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  empresa VARCHAR(255),
  email VARCHAR(255),
  telefono VARCHAR(50) NOT NULL,
  pais VARCHAR(100) DEFAULT 'Argentina',
  creado_en TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cotizaciones (
  id SERIAL PRIMARY KEY,
  cliente_id INT REFERENCES clientes(id) ON DELETE CASCADE,
  tipo_solucion VARCHAR(100) NOT NULL,
  presupuesto_estimado_ars NUMERIC(14,2) NOT NULL,
  presupuesto_estimado_usd NUMERIC(14,2) NOT NULL,
  incluye_bot_ia BOOLEAN DEFAULT true,
  incluye_db_postgres BOOLEAN DEFAULT true,
  incluye_qa_playwright BOOLEAN DEFAULT true,
  urgencia VARCHAR(50) DEFAULT 'express',
  estado VARCHAR(50) DEFAULT 'pendiente_contacto',
  notas_tecnicas TEXT,
  creado_en TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS leads_interacciones (
  id SERIAL PRIMARY KEY,
  cliente_id INT REFERENCES clientes(id) ON DELETE CASCADE,
  canal VARCHAR(50) DEFAULT 'whatsapp',
  mensaje_cliente TEXT NOT NULL,
  respuesta_ia TEXT,
  latencia_ms INT DEFAULT 45,
  score_calificacion INT DEFAULT 90,
  timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_clientes_telefono ON clientes(telefono);
CREATE INDEX IF NOT EXISTS idx_cotizaciones_estado ON cotizaciones(estado);
CREATE INDEX IF NOT EXISTS idx_interacciones_cliente ON leads_interacciones(cliente_id);
