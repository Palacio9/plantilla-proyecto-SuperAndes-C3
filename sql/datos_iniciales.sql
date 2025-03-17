INSERT INTO ciudades (nombre) VALUES ('Bogota');
INSERT INTO ciudades (nombre) VALUES ('Bucaramanga');
    
----select * from ciudades;

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
    
----select * from sucursales;

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
    
----select * from bodegas;

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

----select * from proveedores;

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

--select * from tipos_categoria;

-- Productos Perecederos
INSERT INTO productos (nombre, fecha_expiracion, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Leche Entera', TO_DATE('2024-12-31', 'YYYY-MM-DD'), 'PRD001', 1.0, 1.1,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Perecederos'));

INSERT INTO productos (nombre, fecha_expiracion, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Yogurt Natural', TO_DATE('2024-11-30', 'YYYY-MM-DD'), 'PRD002', 0.5, 0.6,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Perecederos'));

INSERT INTO productos (nombre, fecha_expiracion, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Pan Integral', TO_DATE('2024-10-15', 'YYYY-MM-DD'), 'PRD003', 0.8, 0.4,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Perecederos'));

-- Productos No Perecederos
INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Arroz Premium', 'PRD004', 1.0, 1.0,
    (SELECT id FROM tipos_categoria WHERE nombre = 'No Perecederos'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Frijoles Enlatados', 'PRD005', 0.4, 0.5,
    (SELECT id FROM tipos_categoria WHERE nombre = 'No Perecederos'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Pasta Espagueti', 'PRD006', 0.5, 0.5,
    (SELECT id FROM tipos_categoria WHERE nombre = 'No Perecederos'));

-- Productos de Aseo
INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Detergente Líquido', 'PRD007', 2.0, 2.2,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Aseo'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Jabón de Baño', 'PRD008', 0.2, 0.15,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Aseo'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Limpiador Multiusos', 'PRD009', 1.5, 1.6,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Aseo'));

-- Productos Congelados
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

-- Muebles
INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Mesa de Comedor', 'PRD016', 120.0, 25.0,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Muebles'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Silla Ergonómica', 'PRD017', 50.0, 8.0,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Muebles'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Sofá 3 Puestos', 'PRD018', 200.0, 40.0,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Muebles'));

-- Herramientas
INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Martillo Profesional', 'PRD019', 0.3, 0.5,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Herramientas'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Destornillador Set', 'PRD020', 0.4, 0.6,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Herramientas'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Taladro Eléctrico', 'PRD021', 2.0, 2.5,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Herramientas'));

-- Electrodomésticos
INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Licuadora', 'PRD022', 5.0, 3.0,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Electrodomésticos'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Microondas', 'PRD023', 30.0, 12.0,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Electrodomésticos'));

INSERT INTO productos (nombre, codigo_barras, volumen, peso, id_tipo_categoria)
VALUES ('Batidora Eléctrica', 'PRD024', 3.0, 2.0,
    (SELECT id FROM tipos_categoria WHERE nombre = 'Electrodomésticos'));

--select * from productos;

-- Producto que estará en todas las bodegas (Arroz Premium como ejemplo)
INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
SELECT 
    b.id,
    p.id,
    100, 200, 2800, 20
FROM bodegas b, productos p
WHERE p.nombre = 'Arroz Premium';

-- Productos Perecederos
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

-- Productos No Perecederos
INSERT INTO contiene (id_bodega, id_producto, cantidad, capacidad, costo_promedio, cantidad_minima)
VALUES (
    (SELECT id FROM bodegas WHERE nombre = 'Bodega Oriente Bogota'),
    (SELECT id FROM productos WHERE nombre = 'Frijoles Enlatados'),
    150, 300, 2500, 30
);

-- El producto 'Pasta Espagueti' será el que no esté en ninguna bodega

-- Productos de Aseo (en múltiples bodegas)
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

-- Productos Congelados
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

-- Prendas de Vestir
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

-- Muebles
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

-- Herramientas
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

-- Electrodomésticos
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

--select * from contiene;

-- Productos Perecederos
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

-- Productos No Perecederos
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

-- Productos de Aseo
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

-- Productos Congelados
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

-- Resto de productos (cada uno ofrecido por al menos dos proveedores)
-- Continuaré con el mismo patrón para los productos restantes

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

--select * from ofrece;