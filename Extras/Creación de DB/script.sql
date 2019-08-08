-- -----------------------------------------------------
-- ------INTEGRANTES--------
-- MELVIN RANDOLFO CANTÉ GUERRA 
-- 5990-14-1106
-- JORGE ALFREDO MONZÓN GUDIEL        
-- 5990-14-426
-- KEVIN AUDIEL PAZ CHAVES                    
-- 5990-14-3306

--- Habilitar salida de servidor
SET SERVEROUTPUT ON
--CREAR UN USUARIO
CREATE USER "USUARIOBD"  PROFILE "DEFAULT" 
    IDENTIFIED BY "USUARIOBD" DEFAULT TABLESPACE "USERS" 
    ACCOUNT UNLOCK;

--ASIGNAR PERMISO PARA CONECTARSE

GRANT "CONNECT" TO "USUARIOBD";

--ASIGNAR PERMISO DE DBA

GRANT "DBA" TO "USUARIOBD";
-- -----------------------------------------------------
--ELIMINAR TABLAS Y SECUENCIAS ANTERIORES
-- -----------------------------------------------------

DROP TABLE PERSONA CASCADE CONSTRAINTS;
DROP TABLE EMPRESA CASCADE CONSTRAINTS;
DROP TABLE CLIENTE CASCADE CONSTRAINTS;
DROP TABLE PRODUCTO CASCADE CONSTRAINTS;
DROP TABLE AGENCIA CASCADE CONSTRAINTS;
DROP TABLE CUENTA CASCADE CONSTRAINTS;
DROP TABLE OPERACION_PLANILLA CASCADE CONSTRAINTS;
DROP TABLE ROL CASCADE CONSTRAINTS;
DROP TABLE EMPLEADO CASCADE CONSTRAINTS;
DROP TABLE CAJA CASCADE CONSTRAINTS;
DROP TABLE CAJERO CASCADE CONSTRAINTS;
DROP TABLE OPERACION CASCADE CONSTRAINTS;
DROP TABLE CHEQUERA CASCADE CONSTRAINTS;
DROP TABLE CHEQUE CASCADE CONSTRAINTS;
DROP TABLE APERTURA_CIERRE CASCADE CONSTRAINTS;
DROP TABLE LIBRETA CASCADE CONSTRAINTS;
DROP TABLE LOGIN CASCADE CONSTRAINTS;
DROP TABLE TIPO_RECARGO CASCADE CONSTRAINTS;
DROP TABLE RECARGO CASCADE CONSTRAINTS;

DROP SEQUENCE seq_login;
DROP SEQUENCE seq_rol;
DROP SEQUENCE seq_empleado;
DROP SEQUENCE seq_cliente;
DROP SEQUENCE seq_producto;
DROP SEQUENCE seq_libreta;
DROP SEQUENCE seq_recargo;
DROP SEQUENCE seq_tipo_recargo;
DROP SEQUENCE seq_chequera;
DROP SEQUENCE seq_cheque;
DROP SEQUENCE seq_operacion_planilla;
DROP SEQUENCE seq_operacion;
DROP SEQUENCE seq_agencia;
DROP SEQUENCE seq_caja;
DROP SEQUENCE seq_cajero;
DROP SEQUENCE seq_apertura_cierre;
DROP SEQUENCE BOLETA;
DROP TRIGGER trig_seq_login;
DROP TRIGGER trig_seq_rol;
DROP TRIGGER trig_seq_empleado;
DROP TRIGGER trig_seq_cliente;
DROP TRIGGER trig_seq_producto;
DROP TRIGGER trig_seq_libreta;
DROP TRIGGER trig_seq_recargo;
DROP TRIGGER trig_seq_tipo_recargo;
DROP TRIGGER trig_seq_chequera;
DROP TRIGGER trig_seq_cheque;
DROP TRIGGER trig_seq_operacion_planilla;
DROP TRIGGER trig_seq_operacion;
DROP TRIGGER trig_seq_agencia;
DROP TRIGGER trig_seq_caja;
DROP TRIGGER trig_seq_cajero;
DROP TRIGGER trig_seq_apertura_cierre;

-- -----------------------------------------------------
-- TABLA PERSONA
-- -----------------------------------------------------
CREATE TABLE PERSONA (
  dpi VARCHAR(13) NOT NULL PRIMARY KEY,
  nit VARCHAR(15) NOT NULL,
  nombre VARCHAR(30) NULL,
  apellido VARCHAR(30) NULL,
  fecha_nacimiento DATE NULL,
  no_telefono VARCHAR(8) NULL,
  direccion VARCHAR(250) NULL
  );

CREATE UNIQUE INDEX nit_persona_unico ON PERSONA (nit);

-- -----------------------------------------------------
-- TABLA EMPRESA
-- -----------------------------------------------------
CREATE TABLE EMPRESA (
  id_patente INT NOT NULL PRIMARY KEY,
  nit VARCHAR(15) NOT NULL,
  nombre VARCHAR(200) NULL,
  direccion VARCHAR(250) NULL
  );

CREATE UNIQUE INDEX nit_empresa_unico ON EMPRESA (nit);

-- -----------------------------------------------------
-- TABLA CLIENTE
-- -----------------------------------------------------
CREATE TABLE CLIENTE (
  id_cliente INT NOT NULL PRIMARY KEY,
  dpi VARCHAR(13) NULL,
  id_patente INT NULL,
  fecha_registro DATE NOT NULL,

  CONSTRAINT fk_cliente_empresa
    FOREIGN KEY (id_patente)
    REFERENCES EMPRESA (id_patente),
  CONSTRAINT fk_cliente_persona
    FOREIGN KEY (dpi)
    REFERENCES PERSONA (dpi)
    );

-- -----------------------------------------------------
-- TABLA PRODUCTO
-- -----------------------------------------------------
CREATE TABLE PRODUCTO (
  id_producto INT NOT NULL PRIMARY KEY,
  tipo VARCHAR(30) NOT NULL,
  tasa_interes FLOAT NOT NULL,
  saldo_minimo FLOAT NOT NULL
  );

-- -----------------------------------------------------
-- TABLA AGENCIA
-- -----------------------------------------------------
CREATE TABLE AGENCIA (
  id_agencia INT NOT NULL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  direccion VARCHAR(200) NOT NULL
  );
CREATE UNIQUE INDEX AGENCIA_UNICA ON AGENCIA (nombre);
-- -----------------------------------------------------
-- TABLA CUENTA
-- -----------------------------------------------------
CREATE TABLE CUENTA (
  no_cuenta VARCHAR(16) NOT NULL PRIMARY KEY,
  id_cliente INT NOT NULL,
  agencia_apertura INT NOT NULL,
  fecha_apertura DATE NOT NULL,
  saldo_disponible FLOAT NOT NULL,
  saldo_reserva FLOAT NULL,
  fecha_ultima_transaccion DATE NULL,
  id_producto INT NOT NULL,
  status VARCHAR(50) NOT NULL,
  firma1 VARCHAR(250) NOT NULL,
  firma2 VARCHAR(250) NULL,
  firma3 VARCHAR(250) NULL,

  CONSTRAINT fk_cuenta_cliente1
    FOREIGN KEY (id_cliente)
    REFERENCES CLIENTE (id_cliente),

  CONSTRAINT fk_cuenta_tipo
    FOREIGN KEY (id_producto)
    REFERENCES PRODUCTO (id_producto),

  CONSTRAINT fk_cuenta_agencia
    FOREIGN KEY (agencia_apertura)
    REFERENCES AGENCIA (id_agencia)
    );

-- -----------------------------------------------------
-- OPERACION PLANILLA
-- -----------------------------------------------------
CREATE TABLE OPERACION_PLANILLA (
  id_operacion_planilla INT NOT NULL PRIMARY KEY,
  no_cuenta_origen VARCHAR(16) NOT NULL,
  fecha_hora_inicio DATE NOT NULL,
  fecha_hora_fin DATE NOT NULL,
  total_pagado FLOAT NOT NULL,
  status VARCHAR(16) NOT NULL,

  CONSTRAINT fk_transaccion_cuenta
    FOREIGN KEY (no_cuenta_origen)
    REFERENCES cuenta (no_cuenta)
);

-- -----------------------------------------------------
-- TABLA ROL
-- -----------------------------------------------------
CREATE TABLE ROL (
  id_rol INT NOT NULL PRIMARY KEY,
  tipo VARCHAR(50) NOT NULL
  );
CREATE UNIQUE INDEX ROL_UNICO ON ROL (tipo);

-- -----------------------------------------------------
-- TABLA EMPLEADO
-- -----------------------------------------------------
CREATE TABLE EMPLEADO (
  id_empleado INT NOT NULL PRIMARY KEY,
  dpi VARCHAR(13) NOT NULL,
  fecha_alta DATE NOT NULL,
  fecha_baja DATE NULL,
  activo VARCHAR(1) NOT NULL,
  usuario VARCHAR(25) NOT NULL,
  password VARCHAR(25) NOT NULL,
  rol INT NOT NULL,

  CONSTRAINT fk_empleado_persona
    FOREIGN KEY (dpi)
    REFERENCES PERSONA (dpi),

  CONSTRAINT fk_empleado_roles
    FOREIGN KEY (rol)
    REFERENCES ROL (id_rol)
    );
CREATE UNIQUE INDEX usuario_unico ON EMPLEADO (usuario);

-- -----------------------------------------------------
-- TABLA CAJA
-- -----------------------------------------------------
CREATE TABLE CAJA (
  id_caja INT NOT NULL PRIMARY KEY,
  id_agencia INT NOT NULL,
  saldo FLOAT NOT NULL,

  CONSTRAINT fk_caja_agencia1
    FOREIGN KEY (id_agencia)
    REFERENCES AGENCIA (id_agencia)
    );

-- -----------------------------------------------------
-- TABLA CAJERO
-- -----------------------------------------------------
CREATE TABLE CAJERO (
  id_cajero INT NOT NULL PRIMARY KEY,
  id_empleado INT NOT NULL,
  id_caja INT NOT NULL,
  fecha_hora DATE NOT NULL,

  CONSTRAINT fk_cajero_persona
    FOREIGN KEY (id_empleado)
    REFERENCES EMPLEADO (id_empleado),

  CONSTRAINT fk_cajero_caja1
    FOREIGN KEY (id_caja)
    REFERENCES CAJA (id_caja)
    );

-- -----------------------------------------------------
-- TABLA OPERACION
-- -----------------------------------------------------
CREATE TABLE OPERACION (
  no_operacion INT NOT NULL PRIMARY KEY,
  id_operacion_planilla INT NULL,
  fecha_hora DATE NOT NULL,
  no_cuenta_origen VARCHAR(16) NULL,
  no_cuenta_destino VARCHAR(16) NULL,
  tipo_operacion VARCHAR(45) NOT NULL,
  tipo_documento VARCHAR(45) NULL,
  no_documento INT NULL,
  status VARCHAR(10) NOT NULL,
  saldo_inicial_origen FLOAT NULL,
  saldo_final_origen FLOAT NULL,
  saldo_inicial_destino FLOAT NULL,
  saldo_final_destino FLOAT NULL,
  monto_total_operado FLOAT NOT NULL,
  id_cajero INT NOT NULL,
  

  CONSTRAINT fk_transaccion_cuenta1
    FOREIGN KEY (no_cuenta_origen)
    REFERENCES CUENTA (no_cuenta),

  CONSTRAINT fk_transaccion_cuenta2
    FOREIGN KEY (no_cuenta_destino)
    REFERENCES CUENTA (no_cuenta),

  CONSTRAINT fk_operacion_planilla
    FOREIGN KEY (id_operacion_planilla)
    REFERENCES operacion_planilla (id_operacion_planilla),

  CONSTRAINT fk_operacion_cajero
    FOREIGN KEY (id_cajero)
    REFERENCES CAJERO (id_cajero)
    );

-- -----------------------------------------------------
-- TABLA CHEQUERA
-- -----------------------------------------------------
CREATE TABLE CHEQUERA (
  no_chequera INT NOT NULL PRIMARY KEY,
  no_cuenta VARCHAR(16) NOT NULL,
  bloqueada VARCHAR(1) NOT NULL,

  CONSTRAINT fk_cuenta_chequera
    FOREIGN KEY (no_cuenta)
    REFERENCES CUENTA (no_cuenta)
    );

-- -----------------------------------------------------
-- TABLA CHEQUE
-- -----------------------------------------------------
CREATE TABLE CHEQUE (
  no_cheque INT NOT NULL PRIMARY KEY,
  no_chequera INT NOT NULL,
  estado VARCHAR(45) NOT NULL,

  CONSTRAINT fk_cheque_chequera
    FOREIGN KEY (no_chequera)
    REFERENCES CHEQUERA (no_chequera)
  );

-- -----------------------------------------------------
-- TABLA APERTURA_CAJA
-- -----------------------------------------------------
CREATE TABLE APERTURA_CIERRE (
  id_apertura_cierre INT NOT NULL PRIMARY KEY,
  tipo VARCHAR(10) NOT NULL,
  fecha_hora DATE NOT NULL,
  saldo FLOAT NOT NULL,
  total_documentos INT NOT NULL,
  id_cajero INT NOT NULL,
  
  CONSTRAINT fk_apertura_cierre_cajero
    FOREIGN KEY (id_cajero)
    REFERENCES cajero (id_cajero)
    );

-- -----------------------------------------------------
-- TABLA LIBRETA
-- -----------------------------------------------------
CREATE TABLE LIBRETA (
  no_libreta INT NOT NULL PRIMARY KEY,
  no_cuenta VARCHAR(16) NOT NULL,
  estado VARCHAR(45) NOT NULL,
  fecha_asignacion DATE NOT NULL,
  fecha_vencimiento DATE NULL,

  CONSTRAINT fk_libreta_cuenta
    FOREIGN KEY (no_cuenta)
    REFERENCES CUENTA (no_cuenta)
    );

-- -----------------------------------------------------
-- TABLA LOGIN
-- -----------------------------------------------------
CREATE TABLE LOGIN (
  log_id INT NOT NULL PRIMARY KEY,
  id_empleado INT NOT NULL,
  fecha_hora DATE NOT NULL,

  CONSTRAINT fk_login_empleado
    FOREIGN KEY (id_empleado)
    REFERENCES EMPLEADO (id_empleado)
    );

-- -----------------------------------------------------
-- TABLA TIPO_RECARGO
-- -----------------------------------------------------
CREATE TABLE TIPO_RECARGO (
  id_tipo INT NOT NULL PRIMARY KEY,
  descripcion VARCHAR(100) NOT NULL
  );

-- -----------------------------------------------------
-- TABLA RECARGO
-- -----------------------------------------------------
CREATE TABLE RECARGO (
  id_recargo INT NOT NULL PRIMARY KEY,
  no_cuenta VARCHAR(16) NOT NULL,
  recargo FLOAT NOT NULL,
  tipo INT NOT NULL,
  debitado VARCHAR(1) NOT NULL,

  CONSTRAINT fk_recargo_cuenta
    FOREIGN KEY (no_cuenta)
    REFERENCES CUENTA (no_cuenta),

  CONSTRAINT fk_recargo_tiporecargo
    FOREIGN KEY (tipo)
    REFERENCES TIPO_RECARGO (id_tipo)
    );

-- -----------------------------------------------------
-- SECUENCIAS
-- -----------------------------------------------------

CREATE SEQUENCE seq_login START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER trig_seq_login
BEFORE INSERT ON LOGIN FOR EACH ROW 
BEGIN SELECT seq_login.NEXTVAL INTO :NEW.log_id FROM DUAL; 
END trig_seq_login;
/

CREATE SEQUENCE seq_rol START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER trig_seq_rol
BEFORE INSERT ON ROL FOR EACH ROW 
BEGIN SELECT seq_rol.NEXTVAL INTO :NEW.id_rol FROM DUAL; 
END trig_seq_rol;
/

CREATE SEQUENCE seq_empleado START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER trig_seq_empleado
BEFORE INSERT ON EMPLEADO FOR EACH ROW 
BEGIN SELECT seq_empleado.NEXTVAL INTO :NEW.id_empleado FROM DUAL; 
END trig_seq_empleado;
/

CREATE SEQUENCE seq_cliente START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER trig_seq_cliente
BEFORE INSERT ON CLIENTE FOR EACH ROW 
BEGIN SELECT seq_cliente.NEXTVAL INTO :NEW.id_cliente FROM DUAL; 
END trig_seq_cliente;
/

CREATE SEQUENCE seq_producto START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER trig_seq_producto
BEFORE INSERT ON PRODUCTO FOR EACH ROW 
BEGIN SELECT seq_producto.NEXTVAL INTO :NEW.id_producto FROM DUAL; 
END trig_seq_producto;
/

CREATE SEQUENCE seq_libreta START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER trig_seq_libreta
BEFORE INSERT ON LIBRETA FOR EACH ROW 
BEGIN SELECT seq_libreta.NEXTVAL INTO :NEW.no_libreta FROM DUAL; 
END trig_seq_libreta;
/

CREATE SEQUENCE seq_recargo START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER trig_seq_recargo
BEFORE INSERT ON RECARGO FOR EACH ROW 
BEGIN SELECT seq_recargo.NEXTVAL INTO :NEW.id_recargo FROM DUAL; 
END trig_seq_recargo;
/

CREATE SEQUENCE seq_tipo_recargo START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER trig_seq_tipo_recargo
BEFORE INSERT ON TIPO_RECARGO FOR EACH ROW 
BEGIN SELECT seq_tipo_recargo.NEXTVAL INTO :NEW.id_tipo FROM DUAL; 
END trig_seq_tipo_recargo;
/

CREATE SEQUENCE seq_chequera START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER trig_seq_chequera
BEFORE INSERT ON CHEQUERA FOR EACH ROW 
BEGIN SELECT seq_chequera.NEXTVAL INTO :NEW.no_chequera FROM DUAL; 
END trig_seq_chequera;
/

CREATE SEQUENCE seq_cheque START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER trig_seq_cheque
BEFORE INSERT ON CHEQUE FOR EACH ROW 
BEGIN SELECT seq_cheque.NEXTVAL INTO :NEW.no_cheque FROM DUAL; 
END trig_seq_cheque;
/

CREATE SEQUENCE seq_operacion_planilla START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER trig_seq_operacion_planilla
BEFORE INSERT ON OPERACION_PLANILLA FOR EACH ROW 
BEGIN SELECT seq_operacion_planilla.NEXTVAL INTO :NEW.id_operacion_planilla FROM DUAL; 
END trig_seq_operacion_planilla;
/

CREATE SEQUENCE seq_operacion START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER trig_seq_operacion
BEFORE INSERT ON OPERACION FOR EACH ROW 
BEGIN SELECT seq_operacion.NEXTVAL INTO :NEW.no_operacion FROM DUAL; 
END trig_seq_operacion;
/

CREATE SEQUENCE seq_agencia START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER trig_seq_agencia
BEFORE INSERT ON AGENCIA FOR EACH ROW 
BEGIN SELECT seq_agencia.NEXTVAL INTO :NEW.id_agencia FROM DUAL; 
END trig_seq_agencia;
/

CREATE SEQUENCE seq_caja START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER trig_seq_caja
BEFORE INSERT ON CAJA FOR EACH ROW 
BEGIN SELECT seq_caja.NEXTVAL INTO :NEW.id_caja FROM DUAL; 
END trig_seq_caja;
/

CREATE SEQUENCE seq_cajero START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER trig_seq_cajero
BEFORE INSERT ON CAJERO FOR EACH ROW 
BEGIN SELECT seq_cajero.NEXTVAL INTO :NEW.id_cajero FROM DUAL; 
END trig_seq_cajero;
/

CREATE SEQUENCE seq_apertura_cierre START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE OR REPLACE TRIGGER trig_seq_apertura_cierre
BEFORE INSERT ON APERTURA_CIERRE FOR EACH ROW 
BEGIN SELECT seq_apertura_cierre.NEXTVAL INTO :NEW.id_apertura_cierre FROM DUAL; 
END seq_apertura_cierre;
/

CREATE SEQUENCE BOLETA START WITH 1 INCREMENT BY 1 NOMAXVALUE;
/