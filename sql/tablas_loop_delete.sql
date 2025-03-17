
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
    PRIMARY KEY ( id_bodega, id_producto )
);

CREATE TABLE documentos (
    id              INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
    id_orden_compra INTEGER NOT NULL
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
/*
-- Reiniciar absolutamente todo
BEGIN
   FOR rec IN (SELECT table_name FROM user_tables)
   LOOP
      EXECUTE IMMEDIATE 'DROP TABLE ' || rec.table_name || ' CASCADE CONSTRAINTS';
   END LOOP;
END;
/

*/