set autocommit off;

-- Reiniciar absolutamente todo
BEGIN
   FOR rec IN (SELECT table_name FROM user_tables)
   LOOP
      EXECUTE IMMEDIATE 'DROP TABLE ' || rec.table_name || ' CASCADE CONSTRAINTS';
   END LOOP;
END;
/

CREATE TABLE bodegas (
    id          INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL primary key,
    nombre      VARCHAR2(255 BYTE) unique NOT NULL,
    tamanio     VARCHAR2(255 BYTE),
    id_sucursal INTEGER NOT NULL
);

CREATE TABLE ciudades (
    id     INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    nombre VARCHAR2(255 BYTE) unique NOT NULL
);

CREATE TABLE compra (
    id_orden_compra INTEGER NOT NULL,
    id_producto     INTEGER NOT NULL,
    cantidad        INTEGER NOT NULL CHECK(cantidad >= 0),
    precio_unitario FLOAT NOT NULL CHECK(precio_unitario >= 0),
    primary key (id_orden_compra, id_producto)
);

CREATE TABLE contiene (
    id_bodega       INTEGER NOT NULL,
    id_producto     INTEGER NOT NULL,
    cantidad        INTEGER NOT NULL CHECK(cantidad >= 0),
    capacidad       INTEGER NOT NULL CHECK(capacidad >= 0),
    costo_promedio  FLOAT NOT NULL CHECK(costo_promedio >= 0),
    cantidad_minima INTEGER NOT NULL CHECK(cantidad_minima >= 0),
    check (cantidad_minima <= capacidad),
    check (cantidad<= capacidad),
    PRIMARY KEY ( id_bodega, id_producto )
);

CREATE TABLE documentos (
    id              INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_orden_compra INTEGER NOT NULL,
    fecha_creacion  Date DEFAULT SYSDATE
);

CREATE TABLE ofrece (
    id_proveedor INTEGER NOT NULL,
    id_producto  INTEGER NOT NULL,
    PRIMARY KEY (id_proveedor,id_producto )
);

CREATE TABLE ordenes_compra (
    id             INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    fecha_creacion DATE NOT NULL,
    fecha_esperada DATE NOT NULL,
    estado         VARCHAR2(255 BYTE) NOT NULL CHECK (estado IN ('vigente','entregada','anulada')),
    id_bodega      INTEGER NOT NULL,
    id_proveedor   INTEGER NOT NULL
);

CREATE TABLE productos (
    id                INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    nombre            VARCHAR2(255 BYTE) unique NOT NULL,
    fecha_expiracion  DATE,
    codigo_barras     VARCHAR2(255 BYTE) unique NOT NULL,
    volumen           FLOAT check(volumen > 0),
    peso              FLOAT check(peso > 0),
    id_tipo_categoria INTEGER NOT NULL
);

CREATE TABLE proveedores (
    id        INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    nombre    VARCHAR2(255 BYTE) unique NOT NULL,
    telefono  VARCHAR2(255 BYTE) unique not null,
    direccion VARCHAR2(255 BYTE) unique not null
);

CREATE TABLE sucursales (
    id        INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    nombre    VARCHAR2(255 BYTE) unique NOT NULL,
    tamanio   VARCHAR2(255 BYTE),
    telefono  VARCHAR2(255 BYTE) unique,
    direccion VARCHAR2(255 BYTE) unique,
    id_ciudad INTEGER NOT NULL
);

CREATE TABLE tipos_categoria (
    id              INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    nombre          VARCHAR2(255 BYTE) unique NOT NULL,
    descripcion     VARCHAR2(255 BYTE),
    caracteristicas VARCHAR2(255 BYTE)
);

ALTER TABLE bodegas
    ADD CONSTRAINT bodega_sucursal_fk FOREIGN KEY ( id_sucursal )
        REFERENCES sucursales ( id )
            ON DELETE CASCADE;

ALTER TABLE compra
    ADD CONSTRAINT compra_orden_compra_fk FOREIGN KEY ( id_orden_compra )
        REFERENCES ordenes_compra ( id )
            ON DELETE CASCADE;

ALTER TABLE compra
    ADD CONSTRAINT compra_producto_fk FOREIGN KEY ( id_producto )
        REFERENCES productos ( id )
            ON DELETE CASCADE;

ALTER TABLE contiene
    ADD CONSTRAINT contiene_bodega_fk FOREIGN KEY ( id_bodega )
        REFERENCES bodegas ( id )
            ON DELETE CASCADE;

ALTER TABLE contiene
    ADD CONSTRAINT contiene_producto_fk FOREIGN KEY ( id_producto )
        REFERENCES productos ( id )
            ON DELETE CASCADE;

ALTER TABLE documentos
    ADD CONSTRAINT documento_orden_compra_fk FOREIGN KEY ( id_orden_compra )
        REFERENCES ordenes_compra ( id )
            ON DELETE CASCADE;

ALTER TABLE ofrece
    ADD CONSTRAINT ofrece_producto_fk FOREIGN KEY ( id_producto )
        REFERENCES productos ( id )
            ON DELETE CASCADE;

ALTER TABLE ofrece
    ADD CONSTRAINT ofrece_proveedor_fk FOREIGN KEY ( id_proveedor )
        REFERENCES proveedores ( id )
            ON DELETE CASCADE;

ALTER TABLE ordenes_compra
    ADD CONSTRAINT orden_compra_bodega_fk FOREIGN KEY ( id_bodega )
        REFERENCES bodegas ( id )
            ON DELETE CASCADE;

ALTER TABLE ordenes_compra
    ADD CONSTRAINT orden_compra_proveedor_fk FOREIGN KEY ( id_proveedor )
        REFERENCES proveedores ( id )
            ON DELETE CASCADE;

ALTER TABLE productos
    ADD CONSTRAINT producto_tipo_categoria_fk FOREIGN KEY ( id_tipo_categoria )
        REFERENCES tipos_categoria ( id )
            ON DELETE CASCADE;

ALTER TABLE sucursales
    ADD CONSTRAINT sucursal_ciudad_fk FOREIGN KEY ( id_ciudad )
        REFERENCES ciudades ( id )
            ON DELETE CASCADE;
            
INSERT INTO ciudades (nombre) VALUES ('Bogota');
INSERT INTO ciudades (nombre) VALUES ('Bucaramanga');
    
INSERT INTO sucursales (nombre, tamanio, telefono, direccion, id_ciudad) 
VALUES ('Sucursal Norte Bucaramanga', '300 m²', '6376001', 'Calle 45 Norte #23-45', 
    (SELECT id FROM ciudades WHERE nombre = 'Bucaramanga'));

INSERT INTO sucursales (nombre, tamanio, telefono, direccion, id_ciudad) 
VALUES ('Sucursal Sur Bucaramanga', '350 m²', '6376002', 'Carrera 33 Sur #12-67', 
    (SELECT id FROM ciudades WHERE nombre = 'Bucaramanga'));

INSERT INTO sucursales (nombre, tamanio, telefono, direccion, id_ciudad) 
VALUES ('Sucursal Occidente Bogota', '400 m²', '3125551', 'Avenida Suba #78-90', 
    (SELECT id FROM ciudades WHERE nombre = 'Bogota'));

INSERT INTO sucursales (nombre, tamanio, telefono, direccion, id_ciudad) 
VALUES ('Sucursal Oriente Bogota', '380 m²', '3125552', 'Carrera 7 #100-25', 
    (SELECT id FROM ciudades WHERE nombre = 'Bogota'));
    
INSERT INTO bodegas (nombre, tamanio, id_sucursal)
VALUES ('Bodega Norte Bucaramanga', '250 m²',
    (SELECT id FROM sucursales WHERE nombre = 'Sucursal Norte Bucaramanga'));

INSERT INTO bodegas (nombre, tamanio, id_sucursal)
VALUES ('Bodega Sur Bucaramanga', '280 m²',
    (SELECT id FROM sucursales WHERE nombre = 'Sucursal Sur Bucaramanga'));

INSERT INTO bodegas (nombre, tamanio, id_sucursal)
VALUES ('Bodega Occidente Bogota', '300 m²',
    (SELECT id FROM sucursales WHERE nombre = 'Sucursal Occidente Bogota'));

INSERT INTO bodegas (nombre, tamanio, id_sucursal)
VALUES ('Bodega Oriente Bogota', '290 m²',
    (SELECT id FROM sucursales WHERE nombre = 'Sucursal Oriente Bogota'));
    
INSERT INTO proveedores (nombre, telefono, direccion)
VALUES ('Alimentos del Valle', '3157894561', 'Carrera 15 #45-67, Cali');

INSERT INTO proveedores (nombre, telefono, direccion)
VALUES ('Distribuidora Nacional', '3209876543', 'Avenida Boyacá #89-12, Bogota');

INSERT INTO proveedores (nombre, telefono, direccion)
VALUES ('Lácteos La Vaca Feliz', '3005467890', 'Calle 80 #23-45, Medellín');

INSERT INTO proveedores (nombre, telefono, direccion)
VALUES ('Abarrotes El Surtidor', '3184567890', 'Carrera 45 #34-56, Barranquilla');

INSERT INTO proveedores (nombre, telefono, direccion)
VALUES ('Industrias Santa Clara', '3112345678', 'Avenida 68 #78-90, Bogota');

INSERT INTO proveedores (nombre, telefono, direccion)
VALUES ('Productos Del Campo', '3143216547', 'Calle 23 #12-34, Bucaramanga');

INSERT INTO tipos_categoria (nombre, descripcion, caracteristicas)
VALUES ('Perecederos', 'Productos con fecha de vencimiento limitada', 'Requieren control de fecha de vencimiento, temperatura ambiente controlada, rotación FIFO');

INSERT INTO tipos_categoria (nombre, descripcion, caracteristicas)
VALUES ('No Perecederos', 'Productos de larga duración', 'Almacenamiento a temperatura ambiente, vida útil extendida');

INSERT INTO tipos_categoria (nombre, descripcion, caracteristicas)
VALUES ('Aseo', 'Productos de limpieza y cuidado', 'Almacenamiento separado de alimentos, ventilación adecuada, control de derrames');

INSERT INTO tipos_categoria (nombre, descripcion, caracteristicas)
VALUES ('Congelados', 'Productos que requieren refrigeración', 'Temperatura bajo 0°C, control de cadena de frío, empaque especial');

INSERT INTO tipos_categoria (nombre, descripcion, caracteristicas)
VALUES ('Prendas de Vestir', 'Ropa y accesorios', 'Ambiente seco, protección contra polvo, control de humedad');

INSERT INTO tipos_categoria (nombre, descripcion, caracteristicas)
VALUES ('Muebles', 'Mobiliario para el hogar', 'Área espaciosa, protección contra humedad, manipulación cuidadosa');

INSERT INTO tipos_categoria (nombre, descripcion, caracteristicas)
VALUES ('Herramientas', 'Instrumentos y herramientas', 'Organización por tipo, control de inventario, seguridad');

INSERT INTO tipos_categoria (nombre, descripcion, caracteristicas)
VALUES ('Electrodomésticos', 'Aparatos eléctricos', 'Área seca, embalaje protector, control de manipulación');

INSERT INTO productos (nombre, fecha_expiracion, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Leche Entera', TO_DATE('2024-12-31', 'YYYY-MM-DD'), 'PRD001', 1.0, 1.1,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Perecederos'));

INSERT INTO productos (nombre, fecha_expiracion, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Yogurt Natural', TO_DATE('2024-11-30', 'YYYY-MM-DD'), 'PRD002', 0.5, 0.6,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Perecederos'));

INSERT INTO productos (nombre, fecha_expiracion, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Pan Integral', TO_DATE('2024-10-15', 'YYYY-MM-DD'), 'PRD003', 0.8, 0.4,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Perecederos'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Arroz Premium', 'PRD004', 1.0, 1.0,
    (SELECT id FROM tipos_categoria WHERE nombre = 'No Perecederos'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Frijoles Enlatados', 'PRD005', 0.4, 0.5,
    (SELECT id FROM tipos_categoria WHERE nombre = 'No Perecederos'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Pasta Espagueti', 'PRD006', 0.5, 0.5,
    (SELECT id FROM tipos_categoria WHERE nombre = 'No Perecederos'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Detergente Líquido', 'PRD007', 2.0, 2.2,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Aseo'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Jabón de Baño', 'PRD008', 0.2, 0.15,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Aseo'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Limpiador Multiusos', 'PRD009', 1.5, 1.6,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Aseo'));

INSERT INTO productos (nombre, fecha_expiracion, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Helado Vainilla', TO_DATE('2025-06-30', 'YYYY-MM-DD'), 'PRD010', 2.0, 1.0,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Congelados'));

INSERT INTO productos (nombre, fecha_expiracion, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Pollo Congelado', TO_DATE('2025-05-30', 'YYYY-MM-DD'), 'PRD011', 1.5, 1.2,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Congelados'));

INSERT INTO productos (nombre, fecha_expiracion, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Verduras Mixtas Congeladas', TO_DATE('2025-04-30', 'YYYY-MM-DD'), 'PRD012', 1.0, 0.8,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Congelados'));

-- Prendas de Vestir
INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Camiseta Básica', 'PRD013', 0.3, 0.2,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Prendas de Vestir'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Pantalón Jean', 'PRD014', 0.5, 0.6,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Prendas de Vestir'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Chaqueta Deportiva', 'PRD015', 0.8, 0.5,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Prendas de Vestir'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Mesa de Comedor', 'PRD016', 120.0, 25.0,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Muebles'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Silla Ergonómica', 'PRD017', 50.0, 8.0,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Muebles'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Sofá 3 Puestos', 'PRD018', 200.0, 40.0,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Muebles'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Martillo Profesional', 'PRD019', 0.3, 0.5,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Herramientas'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Destornillador Set', 'PRD020', 0.4, 0.6,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Herramientas'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Taladro Eléctrico', 'PRD021', 2.0, 2.5,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Herramientas'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Licuadora', 'PRD022', 5.0, 3.0,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Electrodomésticos'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Microondas', 'PRD023', 30.0, 12.0,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Electrodomésticos'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Batidora Eléctrica', 'PRD024', 3.0, 2.0,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Electrodomésticos'));

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
SELECT 
    b.id,
    p.id,
    100, 200, 2800, 20
FROM bodegas b, productos p
WHERE p.nombre = 'Arroz Premium';

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Norte Bucaramanga'),
    (SELECT id FROM productos WHERE nombre = 'Leche Entera'),
    100, 200, 3500, 20
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Sur Bucaramanga'),
    (SELECT id FROM productos WHERE nombre = 'Yogurt Natural'),
    80, 150, 4000, 15
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Occidente Bogota'),
    (SELECT id FROM productos WHERE nombre = 'Pan Integral'),
    120, 200, 3000, 25
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Oriente Bogota'),
    (SELECT id FROM productos WHERE nombre = 'Frijoles Enlatados'),
    150, 300, 2500, 30
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Norte Bucaramanga'),
    (SELECT id FROM productos WHERE nombre = 'Detergente Líquido'),
    80, 150, 15000, 15
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Sur Bucaramanga'),
    (SELECT id FROM productos WHERE nombre = 'Detergente Líquido'),
    90, 160, 15000, 15
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Occidente Bogota'),
    (SELECT id FROM productos WHERE nombre = 'Jabón de Baño'),
    200, 400, 2000, 40
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Oriente Bogota'),
    (SELECT id FROM productos WHERE nombre = 'Limpiador Multiusos'),
    100, 200, 8000, 20
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Norte Bucaramanga'),
    (SELECT id FROM productos WHERE nombre = 'Helado Vainilla'),
    50, 100, 8000, 10
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Sur Bucaramanga'),
    (SELECT id FROM productos WHERE nombre = 'Pollo Congelado'),
    60, 120, 12000, 12
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Occidente Bogota'),
    (SELECT id FROM productos WHERE nombre = 'Verduras Mixtas Congeladas'),
    70, 140, 6000, 14
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Norte Bucaramanga'),
    (SELECT id FROM productos WHERE nombre = 'Camiseta Básica'),
    200, 400, 25000, 40
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Sur Bucaramanga'),
    (SELECT id FROM productos WHERE nombre = 'Pantalón Jean'),
    150, 300, 45000, 30
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Occidente Bogota'),
    (SELECT id FROM productos WHERE nombre = 'Chaqueta Deportiva'),
    100, 200, 55000, 20
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Oriente Bogota'),
    (SELECT id FROM productos WHERE nombre = 'Mesa de Comedor'),
    10, 20, 450000, 2
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Norte Bucaramanga'),
    (SELECT id FROM productos WHERE nombre = 'Silla Ergonómica'),
    20, 40, 180000, 4
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Sur Bucaramanga'),
    (SELECT id FROM productos WHERE nombre = 'Sofá 3 Puestos'),
    8, 15, 850000, 2
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Occidente Bogota'),
    (SELECT id FROM productos WHERE nombre = 'Martillo Profesional'),
    30, 60, 35000, 5
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Oriente Bogota'),
    (SELECT id FROM productos WHERE nombre = 'Destornillador Set'),
    40, 80, 25000, 8
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Norte Bucaramanga'),
    (SELECT id FROM productos WHERE nombre = 'Taladro Eléctrico'),
    15, 30, 150000, 3
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Sur Bucaramanga'),
    (SELECT id FROM productos WHERE nombre = 'Licuadora'),
    25, 50, 120000, 5
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Occidente Bogota'),
    (SELECT id FROM productos WHERE nombre = 'Microondas'),
    12, 24, 280000, 3
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Oriente Bogota'),
    (SELECT id FROM productos WHERE nombre = 'Batidora Eléctrica'),
    20, 40, 95000, 4
);

INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Occidente Bogota'),
    (SELECT id FROM productos WHERE nombre = 'Pollo Congelado'),
    5, 100, 12000, 20
);

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Alimentos del Valle'),
     (SELECT id FROM productos WHERE nombre = 'Leche Entera'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Lácteos La Vaca Feliz'),
     (SELECT id FROM productos WHERE nombre = 'Leche Entera'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Alimentos del Valle'),
     (SELECT id FROM productos WHERE nombre = 'Yogurt Natural'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Lácteos La Vaca Feliz'),
     (SELECT id FROM productos WHERE nombre = 'Yogurt Natural'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Alimentos del Valle'),
     (SELECT id FROM productos WHERE nombre = 'Pan Integral'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Distribuidora Nacional'),
     (SELECT id FROM productos WHERE nombre = 'Pan Integral'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Distribuidora Nacional'),
     (SELECT id FROM productos WHERE nombre = 'Arroz Premium'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Abarrotes El Surtidor'),
     (SELECT id FROM productos WHERE nombre = 'Arroz Premium'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Distribuidora Nacional'),
     (SELECT id FROM productos WHERE nombre = 'Frijoles Enlatados'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Productos Del Campo'),
     (SELECT id FROM productos WHERE nombre = 'Frijoles Enlatados'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Distribuidora Nacional'),
     (SELECT id FROM productos WHERE nombre = 'Pasta Espagueti'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Abarrotes El Surtidor'),
     (SELECT id FROM productos WHERE nombre = 'Pasta Espagueti'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Industrias Santa Clara'),
     (SELECT id FROM productos WHERE nombre = 'Detergente Líquido'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Distribuidora Nacional'),
     (SELECT id FROM productos WHERE nombre = 'Detergente Líquido'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Industrias Santa Clara'),
     (SELECT id FROM productos WHERE nombre = 'Jabón de Baño'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Abarrotes El Surtidor'),
     (SELECT id FROM productos WHERE nombre = 'Jabón de Baño'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Industrias Santa Clara'),
     (SELECT id FROM productos WHERE nombre = 'Limpiador Multiusos'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Distribuidora Nacional'),
     (SELECT id FROM productos WHERE nombre = 'Limpiador Multiusos'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Alimentos del Valle'),
     (SELECT id FROM productos WHERE nombre = 'Helado Vainilla'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Distribuidora Nacional'),
     (SELECT id FROM productos WHERE nombre = 'Helado Vainilla'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Alimentos del Valle'),
     (SELECT id FROM productos WHERE nombre = 'Pollo Congelado'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Productos Del Campo'),
     (SELECT id FROM productos WHERE nombre = 'Pollo Congelado'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Alimentos del Valle'),
     (SELECT id FROM productos WHERE nombre = 'Verduras Mixtas Congeladas'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Productos Del Campo'),
     (SELECT id FROM productos WHERE nombre = 'Verduras Mixtas Congeladas'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Distribuidora Nacional'),
     (SELECT id FROM productos WHERE nombre = 'Camiseta Básica'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Abarrotes El Surtidor'),
     (SELECT id FROM productos WHERE nombre = 'Camiseta Básica'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Distribuidora Nacional'),
     (SELECT id FROM productos WHERE nombre = 'Pantalón Jean'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Industrias Santa Clara'),
     (SELECT id FROM productos WHERE nombre = 'Pantalón Jean'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Distribuidora Nacional'),
     (SELECT id FROM productos WHERE nombre = 'Chaqueta Deportiva'));

INSERT INTO ofrece (id_proveedor, id_producto)
VALUES 
    ((SELECT id FROM proveedores WHERE nombre = 'Abarrotes El Surtidor'),
     (SELECT id FROM productos WHERE nombre = 'Chaqueta Deportiva'));
     
INSERT INTO ordenes_compra (fecha_creacion, fecha_esperada, estado, id_bodega, id_proveedor)
VALUES (DATE '2024-10-15', DATE '2024-10-30', 'vigente', 1, 3);

INSERT INTO ordenes_compra (fecha_creacion, fecha_esperada, estado, id_bodega, id_proveedor)
VALUES (DATE '2024-10-20', DATE '2024-11-05', 'vigente', 2, 1);

INSERT INTO ordenes_compra (fecha_creacion, fecha_esperada, estado, id_bodega, id_proveedor)
VALUES (DATE '2024-10-25', DATE '2024-11-10', 'vigente', 3, 4);

INSERT INTO ordenes_compra (fecha_creacion, fecha_esperada, estado, id_bodega, id_proveedor)
VALUES (DATE '2024-09-01', DATE '2024-09-15', 'entregada', 1, 2);

INSERT INTO ordenes_compra (fecha_creacion, fecha_esperada, estado, id_bodega, id_proveedor)
VALUES (DATE '2024-09-10', DATE '2024-09-25', 'entregada', 4, 5);

INSERT INTO ordenes_compra (fecha_creacion, fecha_esperada, estado, id_bodega, id_proveedor)
VALUES (DATE '2024-09-20', DATE '2024-10-05', 'entregada', 2, 6);

INSERT INTO ordenes_compra (fecha_creacion, fecha_esperada, estado, id_bodega, id_proveedor)
VALUES (DATE '2024-10-01', DATE '2024-10-15', 'anulada', 3, 1);

INSERT INTO ordenes_compra (fecha_creacion, fecha_esperada, estado, id_bodega, id_proveedor)
VALUES (DATE '2024-10-05', DATE '2024-10-20', 'anulada', 4, 3);

INSERT INTO ordenes_compra (fecha_creacion, fecha_esperada, estado, id_bodega, id_proveedor)
VALUES (DATE '2024-10-10', DATE '2024-10-25', 'anulada', 1, 4);

INSERT INTO ordenes_compra (fecha_creacion, fecha_esperada, estado, id_bodega, id_proveedor)
VALUES (DATE '2024-10-28', DATE '2024-11-15', 'vigente', 4, 2);

INSERT INTO ordenes_compra (fecha_creacion, fecha_esperada, estado, id_bodega, id_proveedor)
VALUES (DATE '2024-10-29', DATE '2024-11-20', 'vigente', 2, 5);

INSERT INTO ordenes_compra (fecha_creacion, fecha_esperada, estado, id_bodega, id_proveedor)
VALUES (DATE '2024-10-30', DATE '2024-11-25', 'vigente', 3, 6);

INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (1, 1, 50, 4500);
INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (1, 5, 30, 8500);  
INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (1, 8, 20, 6800); 

INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (2, 2, 100, 3500);  
INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (2, 10, 45, 15000); 

INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (3, 15, 75, 180000); 
INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (3, 20, 60, 45000);
INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (3, 24, 25, 150000);

INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (4, 3, 40, 5500);  
INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (4, 7, 35, 22000);

INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (5, 12, 90, 12000);  
INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (5, 18, 65, 1200000); 

INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (6, 4, 55, 7500); 

INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (7, 6, 70, 4200);
INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (7, 11, 40, 18000); 
INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (7, 16, 30, 800000);

INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (8, 9, 85, 15500);
INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (8, 14, 50, 120000); 

INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (9, 13, 45, 45000); 

INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (10, 17, 60, 350000); 
INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (10, 21, 40, 280000);  

INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (11, 19, 95, 35000); 
INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (11, 22, 70, 450000); 

INSERT INTO compra (id_orden_compra, id_producto, cantidad, precio_unitario)
VALUES (12, 23, 55, 580000);

insert into documentos(id_orden_compra) values(4);
insert into documentos(id_orden_compra) values(5);
insert into documentos(id_orden_compra) values(6);

commit;