DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'ingredient_category') THEN
        CREATE TYPE ingredient_category AS ENUM ('masa', 'salsa', 'queso', 'extra');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'order_status') THEN
        CREATE TYPE order_status AS ENUM ('Pendiente', 'Preparando', 'Listo', 'Entregado');
    END IF;
END$$;

CREATE TABLE IF NOT EXISTS "Sizes" (
  "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "nombre" VARCHAR(100) NOT NULL UNIQUE,
  "medida" VARCHAR(100) NOT NULL,
  "precio" DOUBLE PRECISION NOT NULL CHECK ("precio" >= 0),
  "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "Ingredients" (
  "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "nombre" VARCHAR(100) NOT NULL UNIQUE,
  "precio" DOUBLE PRECISION NOT NULL CHECK ("precio" >= 0),
  "categoria" ingredient_category NOT NULL,
  "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
SELECT *FROM Pizzas

CREATE TABLE IF NOT EXISTS "Pizzas" (
  "id" VARCHAR(100) PRIMARY KEY,
  "nombre" VARCHAR(100) NOT NULL UNIQUE,
  "descripcion" TEXT,
  "imagen" VARCHAR(255) DEFAULT '',
  "precioBase" DOUBLE PRECISION NOT NULL CHECK ("precioBase" >= 0),
  "defaultMasa" VARCHAR(100) DEFAULT 'Tradicional',
  "defaultSalsa" VARCHAR(100) DEFAULT 'Salsa de Tomate',
  "defaultQueso" VARCHAR(100) DEFAULT 'Mozzarella',
  "defaultExtras" JSONB DEFAULT '[]'::jsonb,
  "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS "Orders" (
  "id" UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  "orderNumber" VARCHAR(20) NOT NULL UNIQUE,
  "items" JSONB NOT NULL,
  "total" DOUBLE PRECISION NOT NULL CHECK ("total" >= 0),
  "status" order_status NOT NULL DEFAULT 'Pendiente',
  "paymentStatus" VARCHAR(50) NOT NULL DEFAULT 'pending',
  "paymentId" VARCHAR(100),
  "preferenceId" VARCHAR(100),
  "time" VARCHAR(50),
  "timestamp" BIGINT NOT NULL DEFAULT (EXTRACT(EPOCH FROM NOW()) * 1000)::BIGINT,
  "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);



[nodemon] starting `node src/index.js`
Servidor de Planet Pizza corriendo en puerto 3000 en modo development
PostgreSQL Conectado exitosamente.
Error de conexión o sincronización a PostgreSQL: no se puede convertir el tipo ingredient_category a "enum_Ingredients_categoria"
[nodemon] app crashed - waiting for file changes before starting...

