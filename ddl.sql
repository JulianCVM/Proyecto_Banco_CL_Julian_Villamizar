CREATE DATABASE Banco_CL
    DEFAULT CHARACTER SET = 'utf8mb4';


USE Banco_CL;
DROP DATABASE Banco_CL;

-- Eliminar tablas en orden correcto para evitar errores de FK



DROP TABLE IF EXISTS pago_cuota_manejo;
DROP TABLE IF EXISTS pagos_prestamo;
DROP TABLE IF EXISTS historial_de_pagos;
DROP TABLE IF EXISTS pagos;
DROP TABLE IF EXISTS cuotas_prestamo;
DROP TABLE IF EXISTS registro_prestamos;
DROP TABLE IF EXISTS historial_tarjetas;
DROP TABLE IF EXISTS descuentos_aplicados;
DROP TABLE IF EXISTS transacciones;
DROP TABLE IF EXISTS extracto_bancario;
DROP TABLE IF EXISTS registro_cuota;
DROP TABLE IF EXISTS cuotas_manejo;
DROP TABLE IF EXISTS prestamos;
DROP TABLE IF EXISTS tarjetas_bancarias;
DROP TABLE IF EXISTS cuenta_tarjeta;
DROP TABLE IF EXISTS metodos_de_pago_cuenta;
DROP TABLE IF EXISTS cuenta;
DROP TABLE IF EXISTS interes;
DROP TABLE IF EXISTS monedas;
DROP TABLE IF EXISTS metodos_de_pago;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS tipo_nit;
DROP TABLE IF EXISTS descuento;
DROP TABLE IF EXISTS tipo_cuota_de_manejo;
DROP TABLE IF EXISTS tipo_prestamo;
DROP TABLE IF EXISTS nivel_tarjeta;
DROP TABLE IF EXISTS marca_tarjeta;
DROP TABLE IF EXISTS tipo_tarjetas;
DROP TABLE IF EXISTS tipo_cuenta;
DROP TABLE IF EXISTS tipo_cliente;
DROP TABLE IF EXISTS estados;
DROP TABLE IF EXISTS frecuencias_pago;
DROP TABLE IF EXISTS tipos_operacion;
DROP TABLE IF EXISTS tipos_transaccion;
DROP TABLE IF EXISTS metodos_transaccion;
DROP TABLE IF EXISTS estados_pago;
DROP TABLE IF EXISTS estados_cuota;
DROP TABLE IF EXISTS eventos_tarjeta;
DROP TABLE IF EXISTS tipos_pago;

-- =============================================
-- TABLAS DE CATÁLOGOS/LOOKUPS
-- =============================================

CREATE TABLE IF NOT EXISTS tipo_cliente (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS tipo_cuenta (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS tipo_tarjetas (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS marca_tarjeta (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS nivel_tarjeta (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS tipo_prestamo (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS tipo_cuota_de_manejo (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS tipo_nit (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS metodos_de_pago (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS monedas (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(10) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    simbolo VARCHAR(5) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS estados (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    contexto VARCHAR(50) NOT NULL, -- 'CUENTA', 'TARJETA', 'PRESTAMO', etc.
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS frecuencias_pago (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    dias_frecuencia INT NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS tipos_operacion (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    tipo_movimiento ENUM('CREDITO', 'DEBITO') NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS tipos_transaccion (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS metodos_transaccion (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS estados_pago (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS estados_cuota (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS eventos_tarjeta (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS tipos_pago (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

-- =============================================
-- TABLAS PRINCIPALES
-- =============================================

CREATE TABLE IF NOT EXISTS descuento (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    valor DECIMAL(15,2) NOT NULL,
    tipo_valor ENUM('PORCENTAJE', 'MONTO_FIJO') NOT NULL,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin DATE NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS interes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(50) NOT NULL,
    tipo ENUM('FIJO', 'VARIABLE', 'MIXTO', 'SIMPLE', 'COMPUESTO', 'NOMINAL', 'EFECTIVO', 'MORA', 'NO_APLICA') NOT NULL,
    valor DECIMAL(8,6) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS clientes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nit VARCHAR(20) NOT NULL UNIQUE,
    primer_nombre VARCHAR(50),
    segundo_nombre VARCHAR(50),
    primer_apellido VARCHAR(50),
    segundo_apellido VARCHAR(50),
    num_contacto VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    tipo_persona ENUM('NATURAL', 'JURIDICA') NOT NULL,
    tipo_cliente_id BIGINT NOT NULL,
    tipo_nit_id BIGINT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (tipo_cliente_id) REFERENCES tipo_cliente(id) ON DELETE CASCADE,
    FOREIGN KEY (tipo_nit_id) REFERENCES tipo_nit(id) ON DELETE CASCADE,
    INDEX idx_nit (nit),
    INDEX idx_email (email)
);

CREATE TABLE IF NOT EXISTS cuenta (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cliente_id BIGINT NOT NULL,
    tipo_cuenta_id BIGINT NOT NULL,
    numero VARCHAR(30) NOT NULL UNIQUE,
    saldo_disponible DECIMAL(15,2) NOT NULL DEFAULT 0,
    transacciones_realizadas INT NOT NULL DEFAULT 0,
    estado_id BIGINT NOT NULL,
    moneda_id BIGINT NOT NULL,
    fecha_apertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_cierre TIMESTAMP NULL,
    interes_id BIGINT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE CASCADE,
    FOREIGN KEY (tipo_cuenta_id) REFERENCES tipo_cuenta(id)ON DELETE CASCADE,
    FOREIGN KEY (estado_id) REFERENCES estados(id) ON DELETE CASCADE,
    FOREIGN KEY (moneda_id) REFERENCES monedas(id) ON DELETE CASCADE,
    FOREIGN KEY (interes_id) REFERENCES interes(id) ON DELETE CASCADE,
    INDEX idx_numero (numero),
    INDEX idx_cliente (cliente_id),
    CHECK (saldo_disponible >= 0)
);

CREATE TABLE IF NOT EXISTS metodos_de_pago_cuenta (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    metodo_pago_id BIGINT NOT NULL,
    cuenta_id BIGINT NOT NULL,
    fecha_asociacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (metodo_pago_id) REFERENCES metodos_de_pago(id) ON DELETE CASCADE,
    FOREIGN KEY (cuenta_id) REFERENCES cuenta(id) ON DELETE CASCADE,
    UNIQUE KEY uk_metodo_cuenta (metodo_pago_id, cuenta_id)
);

CREATE TABLE IF NOT EXISTS tarjetas_bancarias (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(30) NOT NULL UNIQUE,
    codigo_seguridad VARCHAR(4) NOT NULL,
    estado_id BIGINT NOT NULL,
    fecha_emision TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_vencimiento DATE NOT NULL,
    tipo_tarjeta_id BIGINT NOT NULL,
    marca_tarjeta_id BIGINT NOT NULL,
    nivel_tarjeta_id BIGINT NOT NULL,
    limite_credito DECIMAL(15,2) DEFAULT 0,
    FOREIGN KEY (estado_id) REFERENCES estados(id) ON DELETE CASCADE,
    FOREIGN KEY (tipo_tarjeta_id) REFERENCES tipo_tarjetas(id) ON DELETE CASCADE,
    FOREIGN KEY (marca_tarjeta_id) REFERENCES marca_tarjeta(id) ON DELETE CASCADE,
    FOREIGN KEY (nivel_tarjeta_id) REFERENCES nivel_tarjeta(id) ON DELETE CASCADE,
    INDEX idx_numero_tarjeta (numero)
);

-- Tabla de relación entre cuentas y tarjetas
CREATE TABLE IF NOT EXISTS cuenta_tarjeta (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cuenta_id BIGINT NOT NULL,
    tarjeta_id BIGINT NOT NULL,
    fecha_asociacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (cuenta_id) REFERENCES cuenta(id) ON DELETE CASCADE,
    FOREIGN KEY (tarjeta_id) REFERENCES tarjetas_bancarias(id) ON DELETE CASCADE,
    UNIQUE KEY uk_cuenta_tarjeta (cuenta_id, tarjeta_id)
);

CREATE TABLE IF NOT EXISTS prestamos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cuenta_id BIGINT NOT NULL,
    tipo_prestamo_id BIGINT NOT NULL,
    monto_solicitado DECIMAL(15,2) NOT NULL,
    monto_aprobado DECIMAL(15,2) NOT NULL,
    interes_id BIGINT NOT NULL,
    fecha_solicitud TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_desembolso TIMESTAMP NULL,
    plazo_meses SMALLINT NOT NULL,
    frecuencia_pago_id BIGINT NOT NULL,
    estado_id BIGINT NOT NULL,
    saldo_restante DECIMAL(15,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (cuenta_id) REFERENCES cuenta(id) ON DELETE CASCADE,
    FOREIGN KEY (tipo_prestamo_id) REFERENCES tipo_prestamo(id) ON DELETE CASCADE,
    FOREIGN KEY (interes_id) REFERENCES interes(id) ON DELETE CASCADE,
    FOREIGN KEY (frecuencia_pago_id) REFERENCES frecuencias_pago(id) ON DELETE CASCADE,
    FOREIGN KEY (estado_id) REFERENCES estados(id) ON DELETE CASCADE,
    INDEX idx_cuenta (cuenta_id),
    CHECK (monto_solicitado > 0),
    CHECK (monto_aprobado >= 0),
    CHECK (plazo_meses > 0)
);

CREATE TABLE IF NOT EXISTS cuotas_manejo (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    tarjeta_id BIGINT NOT NULL,
    tipo_cuota_manejo_id BIGINT NOT NULL,
    monto_apertura DECIMAL(15,2) NOT NULL,
    fecha_inicio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    frecuencia_pago_id BIGINT NOT NULL,
    fecha_fin DATE NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (tarjeta_id) REFERENCES tarjetas_bancarias(id) ON DELETE CASCADE,
    FOREIGN KEY (tipo_cuota_manejo_id) REFERENCES tipo_cuota_de_manejo(id) ON DELETE CASCADE,
    FOREIGN KEY (frecuencia_pago_id) REFERENCES frecuencias_pago(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS registro_cuota (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cuota_manejo_id BIGINT NOT NULL,
    fecha_ultimo_cobro TIMESTAMP NOT NULL,
    monto_facturado DECIMAL(15,2) NOT NULL,
    fecha_corte TIMESTAMP NOT NULL,
    fecha_limite_pago TIMESTAMP NOT NULL,
    estado_cuota_id BIGINT NOT NULL,
    monto_a_pagar DECIMAL(15,2) NOT NULL,
    monto_abonado DECIMAL(15,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (cuota_manejo_id) REFERENCES cuotas_manejo(id) ON DELETE CASCADE,
    FOREIGN KEY (estado_cuota_id) REFERENCES estados_cuota(id) ON DELETE CASCADE,
    CHECK (monto_facturado >= 0),
    CHECK (monto_a_pagar >= 0),
    CHECK (monto_abonado >= 0)
);

CREATE TABLE IF NOT EXISTS extracto_bancario (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cuenta_id BIGINT NOT NULL,
    fecha_inicial_extracto TIMESTAMP NOT NULL,
    fecha_final_extracto DATE NOT NULL,
    monto DECIMAL(15,2) NOT NULL,
    saldo_post_operacion DECIMAL(15,2) NOT NULL,
    tipo_operacion_id BIGINT NOT NULL,
    referencia VARCHAR(30) NOT NULL UNIQUE,
    descripcion VARCHAR(120) NOT NULL,
    metodo_transaccion_id BIGINT NOT NULL,
    FOREIGN KEY (cuenta_id) REFERENCES cuenta(id) ON DELETE CASCADE,
    FOREIGN KEY (tipo_operacion_id) REFERENCES tipos_operacion(id) ON DELETE CASCADE,
    FOREIGN KEY (metodo_transaccion_id) REFERENCES metodos_transaccion(id) ON DELETE CASCADE,
    INDEX idx_referencia (referencia),
    INDEX idx_cuenta_fecha (cuenta_id, fecha_inicial_extracto)
);

CREATE TABLE IF NOT EXISTS transacciones (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cuenta_origen_id BIGINT NOT NULL,
    cuenta_destino_id BIGINT NULL, -- Puede ser NULL para retiros en efectivo
    tipo_transaccion_id BIGINT NOT NULL,
    monto DECIMAL(15,2) NOT NULL,
    descripcion VARCHAR(120),
    fecha_operacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cobro_operacion DECIMAL(15,2) NOT NULL DEFAULT 0,
    referencia VARCHAR(30) NOT NULL UNIQUE,
    FOREIGN KEY (cuenta_origen_id) REFERENCES cuenta(id) ON DELETE CASCADE,
    FOREIGN KEY (cuenta_destino_id) REFERENCES cuenta(id) ON DELETE CASCADE,
    FOREIGN KEY (tipo_transaccion_id) REFERENCES tipos_transaccion(id) ON DELETE CASCADE,
    INDEX idx_referencia_trans (referencia),
    INDEX idx_cuenta_origen (cuenta_origen_id),
    INDEX idx_fecha (fecha_operacion),
    CHECK (monto > 0)
);

CREATE TABLE IF NOT EXISTS descuentos_aplicados (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    tarjeta_id BIGINT NOT NULL,
    descuento_id BIGINT NOT NULL,
    monto_inicial DECIMAL(15,2) NOT NULL,
    descuento_aplicado DECIMAL(15,2) NOT NULL,
    monto_con_descuento DECIMAL(15,2) NOT NULL,
    fecha_aplicado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (tarjeta_id) REFERENCES tarjetas_bancarias(id) ON DELETE CASCADE,
    FOREIGN KEY (descuento_id) REFERENCES descuento(id) ON DELETE CASCADE,
    CHECK (monto_inicial >= 0),
    CHECK (descuento_aplicado >= 0),
    CHECK (monto_con_descuento >= 0)
);

CREATE TABLE IF NOT EXISTS historial_tarjetas (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    tarjeta_id BIGINT NOT NULL,
    evento_id BIGINT NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_id BIGINT NULL, -- Para auditoria
    FOREIGN KEY (tarjeta_id) REFERENCES tarjetas_bancarias(id) ON DELETE CASCADE,
    FOREIGN KEY (evento_id) REFERENCES eventos_tarjeta(id) ON DELETE CASCADE,
    INDEX idx_tarjeta_fecha (tarjeta_id, fecha_registro)
);

CREATE TABLE IF NOT EXISTS registro_prestamos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    prestamo_id BIGINT NOT NULL,
    ultimo_pago DECIMAL(15,2) NOT NULL,
    fecha_ultimo_pago TIMESTAMP NOT NULL,
    ultimo_estado_id BIGINT NOT NULL,
    monto_restante DECIMAL(15,2) NOT NULL,
    tiempo_restante_meses SMALLINT NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (prestamo_id) REFERENCES prestamos(id) ON DELETE CASCADE,
    FOREIGN KEY (ultimo_estado_id) REFERENCES estados(id) ON DELETE CASCADE,
    CHECK (ultimo_pago >= 0),
    CHECK (monto_restante >= 0)
);

CREATE TABLE IF NOT EXISTS cuotas_prestamo (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    prestamo_id BIGINT NOT NULL,
    numero_cuota SMALLINT NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    monto_cuota DECIMAL(15,2) NOT NULL,
    monto_capital DECIMAL(15,2) NOT NULL,
    monto_interes DECIMAL(15,2) NOT NULL,
    estado_cuota_id BIGINT NOT NULL,
    fecha_pago TIMESTAMP NULL,
    monto_pagado DECIMAL(15,2) DEFAULT 0,
    FOREIGN KEY (prestamo_id) REFERENCES prestamos(id) ON DELETE CASCADE,
    FOREIGN KEY (estado_cuota_id) REFERENCES estados_cuota(id) ON DELETE CASCADE,
    UNIQUE KEY uk_prestamo_cuota (prestamo_id, numero_cuota),
    CHECK (monto_cuota > 0),
    CHECK (numero_cuota > 0)
);

CREATE TABLE IF NOT EXISTS pagos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cuenta_id BIGINT NOT NULL,
    tipo_pago_id BIGINT NOT NULL,
    monto DECIMAL(15,2) NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado_pago_id BIGINT NOT NULL,
    referencia VARCHAR(40) NOT NULL UNIQUE,
    descripcion VARCHAR(120) NOT NULL,
    metodo_transaccion_id BIGINT NOT NULL,
    FOREIGN KEY (cuenta_id) REFERENCES cuenta(id) ON DELETE CASCADE,
    FOREIGN KEY (tipo_pago_id) REFERENCES tipos_pago(id) ON DELETE CASCADE,
    FOREIGN KEY (estado_pago_id) REFERENCES estados_pago(id) ON DELETE CASCADE,
    FOREIGN KEY (metodo_transaccion_id) REFERENCES metodos_transaccion(id) ON DELETE CASCADE,
    INDEX idx_referencia_pago (referencia),
    CHECK (monto > 0)
);

CREATE TABLE IF NOT EXISTS historial_de_pagos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    pago_id BIGINT NOT NULL,
    estado_pago_id BIGINT NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion VARCHAR(120) NOT NULL,
    metodo_pago_id BIGINT NOT NULL,
    usuario_id BIGINT NULL, -- Para auditoria
    FOREIGN KEY (pago_id) REFERENCES pagos(id) ON DELETE CASCADE,
    FOREIGN KEY (estado_pago_id) REFERENCES estados_pago(id) ON DELETE CASCADE,
    FOREIGN KEY (metodo_pago_id) REFERENCES metodos_de_pago(id) ON DELETE CASCADE,
    INDEX idx_pago_fecha (pago_id, fecha_registro)
);

CREATE TABLE IF NOT EXISTS pagos_prestamo (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cuota_prestamo_id BIGINT NOT NULL,
    pago_id BIGINT NOT NULL,
    monto_pagado DECIMAL(15,2) NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_pago_id BIGINT NOT NULL,
    descripcion VARCHAR(120) NOT NULL,
    FOREIGN KEY (cuota_prestamo_id) REFERENCES cuotas_prestamo(id) ON DELETE CASCADE,
    FOREIGN KEY (pago_id) REFERENCES pagos(id) ON DELETE CASCADE,
    FOREIGN KEY (metodo_pago_id) REFERENCES metodos_de_pago(id) ON DELETE CASCADE,
    CHECK (monto_pagado > 0)
);

CREATE TABLE IF NOT EXISTS pago_cuota_manejo (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    cuota_manejo_id BIGINT NOT NULL,
    pago_id BIGINT NOT NULL,
    monto_pagado DECIMAL(15,2) NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_pago_id BIGINT NOT NULL,
    FOREIGN KEY (cuota_manejo_id) REFERENCES cuotas_manejo(id) ON DELETE CASCADE,
    FOREIGN KEY (pago_id) REFERENCES pagos(id) ON DELETE CASCADE,
    FOREIGN KEY (metodo_pago_id) REFERENCES metodos_de_pago(id) ON DELETE CASCADE,
    CHECK (monto_pagado > 0)
);




-- -- INDEX
-- CLIENTE:
-- idx_nit
-- idx_email


-- CUENTA:
-- idx_numero
-- idx_cliente


-- TARJETAS_BANCARIAS:
-- idx_numero_tarjeta


-- PRESTAMOS:
-- idx_cuenta


-- EXTRACTO_BANCARIO:
-- idx_referencia
-- idx_cuenta_fecha


-- TRANSACCIONES:
-- idx_referencia_trans
-- idx_cuenta_origen
-- idx_fecha


-- HISTORIAL_TARJETAS:
-- idx_tarjeta_fecha


-- PAGOS:
-- idx_referencia_pago


-- HISTORIAL_DE_PAGOS:
-- idx_pago_fecha




-- ADMINISTRADOR
CREATE ROLE 'admin_banco'@'%';

GRANT ALL PRIVILEGES ON Banco_CL.* TO 'admin_banco'@'%';
GRANT EXECUTE ON Banco_CL.* TO 'admin_banco'@'%';
GRANT CREATE USER ON *.* TO 'admin_banco'@'%';
GRANT RELOAD ON *.* TO 'admin_banco'@'%';



-- OPERADOR DE PAGOS
CREATE ROLE 'operador_pagos'@'%';
GRANT SELECT, INSERT, UPDATE ON Banco_CL.pagos TO 'operador_pagos'@'%';
GRANT SELECT, INSERT, UPDATE ON Banco_CL.pago_cuota_manejo TO 'operador_pagos'@'%';
GRANT SELECT, INSERT, UPDATE ON Banco_CL.pagos_prestamo TO 'operador_pagos'@'%';
GRANT SELECT, INSERT ON Banco_CL.historial_de_pagos TO 'operador_pagos'@'%';



GRANT SELECT ON Banco_CL.clientes TO 'operador_pagos'@'%';
GRANT SELECT ON Banco_CL.cuenta TO 'operador_pagos'@'%';
GRANT SELECT ON Banco_CL.tarjetas_bancarias TO 'operador_pagos'@'%';
GRANT SELECT ON Banco_CL.cuotas_manejo TO 'operador_pagos'@'%';
GRANT SELECT ON Banco_CL.registro_cuota TO 'operador_pagos'@'%';
GRANT SELECT ON Banco_CL.prestamos TO 'operador_pagos'@'%';
GRANT SELECT ON Banco_CL.cuotas_prestamo TO 'operador_pagos'@'%';



GRANT SELECT ON Banco_CL.estados_pago TO 'operador_pagos'@'%';
GRANT SELECT ON Banco_CL.tipos_pago TO 'operador_pagos'@'%';
GRANT SELECT ON Banco_CL.metodos_de_pago TO 'operador_pagos'@'%';
GRANT SELECT ON Banco_CL.metodos_transaccion TO 'operador_pagos'@'%';








-- GERENTE
CREATE ROLE 'gerente_banco'@'%';

GRANT SELECT ON Banco_CL.* TO 'gerente_banco'@'%';



GRANT INSERT, UPDATE ON Banco_CL.descuento TO 'gerente_banco'@'%';
GRANT UPDATE ON Banco_CL.tipo_cuota_de_manejo TO 'gerente_banco'@'%';
GRANT UPDATE ON Banco_CL.interes TO 'gerente_banco'@'%';






-- CONSULTOR DE TARJETAS
CREATE ROLE 'consultor_tarjetas'@'%';
GRANT SELECT ON Banco_CL.tarjetas_bancarias TO 'consultor_tarjetas'@'%';
GRANT SELECT ON Banco_CL.cuotas_manejo TO 'consultor_tarjetas'@'%';
GRANT SELECT ON Banco_CL.registro_cuota TO 'consultor_tarjetas'@'%';
GRANT SELECT ON Banco_CL.descuentos_aplicados TO 'consultor_tarjetas'@'%';
GRANT SELECT ON Banco_CL.historial_tarjetas TO 'consultor_tarjetas'@'%';
GRANT SELECT ON Banco_CL.clientes TO 'consultor_tarjetas'@'%';
GRANT SELECT ON Banco_CL.cuenta TO 'consultor_tarjetas'@'%';
GRANT SELECT ON Banco_CL.cuenta_tarjeta TO 'consultor_tarjetas'@'%';
GRANT SELECT ON Banco_CL.tipo_tarjetas TO 'consultor_tarjetas'@'%';
GRANT SELECT ON Banco_CL.marca_tarjeta TO 'consultor_tarjetas'@'%';
GRANT SELECT ON Banco_CL.nivel_tarjeta TO 'consultor_tarjetas'@'%';
GRANT SELECT ON Banco_CL.tipo_cuota_de_manejo TO 'consultor_tarjetas'@'%';
GRANT SELECT ON Banco_CL.eventos_tarjeta TO 'consultor_tarjetas'@'%';
GRANT SELECT ON Banco_CL.estados_cuota TO 'consultor_tarjetas'@'%';
GRANT SELECT ON Banco_CL.descuento TO 'consultor_tarjetas'@'%';




-- AUDITOR
CREATE ROLE 'auditor_banco'@'%';
GRANT SELECT ON Banco_CL.* TO 'auditor_banco'@'%';

USE Banco_CL;

CREATE ROLE IF NOT EXISTS AdministradorGeneral;
GRANT ALL PRIVILEGES ON Banco_CL.* TO AdministradorGeneral;
GRANT EXECUTE ON Banco_CL.* TO AdministradorGeneral;
GRANT CREATE USER, RELOAD ON *.* TO AdministradorGeneral;

CREATE USER IF NOT EXISTS 'jefe_sistema'@'%' IDENTIFIED BY 'Sistema123!';
GRANT AdministradorGeneral TO 'jefe_sistema'@'%';
SET DEFAULT ROLE AdministradorGeneral TO 'jefe_sistema'@'%';


CREATE ROLE IF NOT EXISTS GestorPagos;

GRANT SELECT, INSERT, UPDATE ON Banco_CL.pagos TO GestorPagos;
GRANT SELECT, INSERT, UPDATE ON Banco_CL.pago_cuota_manejo TO GestorPagos;
GRANT SELECT, INSERT, UPDATE ON Banco_CL.pagos_prestamo TO GestorPagos;
GRANT SELECT, INSERT ON Banco_CL.historial_de_pagos TO GestorPagos;

GRANT SELECT ON Banco_CL.clientes TO GestorPagos;
GRANT SELECT ON Banco_CL.cuenta TO GestorPagos;
GRANT SELECT ON Banco_CL.tarjetas_bancarias TO GestorPagos;
GRANT SELECT ON Banco_CL.cuotas_manejo TO GestorPagos;
GRANT SELECT ON Banco_CL.registro_cuota TO GestorPagos;
GRANT SELECT ON Banco_CL.prestamos TO GestorPagos;
GRANT SELECT ON Banco_CL.cuotas_prestamo TO GestorPagos;

GRANT SELECT ON Banco_CL.estados_pago TO GestorPagos;
GRANT SELECT ON Banco_CL.tipos_pago TO GestorPagos;
GRANT SELECT ON Banco_CL.metodos_de_pago TO GestorPagos;
GRANT SELECT ON Banco_CL.metodos_transaccion TO GestorPagos;

CREATE USER IF NOT EXISTS 'cajero_pagos'@'%' IDENTIFIED BY 'Caja456!';
GRANT GestorPagos TO 'cajero_pagos'@'%';
SET DEFAULT ROLE GestorPagos TO 'cajero_pagos'@'%';


CREATE ROLE IF NOT EXISTS GerenteOperaciones;

GRANT SELECT ON Banco_CL.* TO GerenteOperaciones;
GRANT INSERT, UPDATE ON Banco_CL.descuento TO GerenteOperaciones;
GRANT UPDATE ON Banco_CL.tipo_cuota_de_manejo TO GerenteOperaciones;
GRANT UPDATE ON Banco_CL.interes TO GerenteOperaciones;

CREATE USER IF NOT EXISTS 'gerente_comercial'@'%' IDENTIFIED BY 'Gerencia789!';
GRANT GerenteOperaciones TO 'gerente_comercial'@'%';
SET DEFAULT ROLE GerenteOperaciones TO 'gerente_comercial'@'%';


CREATE ROLE IF NOT EXISTS AnalistaTarjetas;

GRANT SELECT ON Banco_CL.tarjetas_bancarias TO AnalistaTarjetas;
GRANT SELECT ON Banco_CL.cuotas_manejo TO AnalistaTarjetas;
GRANT SELECT ON Banco_CL.registro_cuota TO AnalistaTarjetas;
GRANT SELECT ON Banco_CL.descuentos_aplicados TO AnalistaTarjetas;
GRANT SELECT ON Banco_CL.historial_tarjetas TO AnalistaTarjetas;
GRANT SELECT ON Banco_CL.clientes TO AnalistaTarjetas;
GRANT SELECT ON Banco_CL.cuenta TO AnalistaTarjetas;
GRANT SELECT ON Banco_CL.cuenta_tarjeta TO AnalistaTarjetas;
GRANT SELECT ON Banco_CL.tipo_tarjetas TO AnalistaTarjetas;
GRANT SELECT ON Banco_CL.marca_tarjeta TO AnalistaTarjetas;
GRANT SELECT ON Banco_CL.nivel_tarjeta TO AnalistaTarjetas;
GRANT SELECT ON Banco_CL.tipo_cuota_de_manejo TO AnalistaTarjetas;
GRANT SELECT ON Banco_CL.eventos_tarjeta TO AnalistaTarjetas;
GRANT SELECT ON Banco_CL.estados_cuota TO AnalistaTarjetas;
GRANT SELECT ON Banco_CL.descuento TO AnalistaTarjetas;

CREATE USER IF NOT EXISTS 'analista_tarjetas'@'%' IDENTIFIED BY 'Analisis321!';
GRANT AnalistaTarjetas TO 'analista_tarjetas'@'%';
SET DEFAULT ROLE AnalistaTarjetas TO 'analista_tarjetas'@'%';


CREATE ROLE IF NOT EXISTS AuditorFinanciero;

GRANT SELECT ON Banco_CL.* TO AuditorFinanciero;

CREATE USER IF NOT EXISTS 'auditor_interno'@'%' IDENTIFIED BY 'Auditor007!';
GRANT AuditorFinanciero TO 'auditor_interno'@'%';
SET DEFAULT ROLE AuditorFinanciero TO 'auditor_interno'@'%';

-- ==================================
-- Aplicar los cambios
-- ==================================
FLUSH PRIVILEGES;
