DROP PROCEDURE CREAR_CUENTA;

CREATE OR REPLACE PROCEDURE CREAR_CUENTA
(
    idAgencia NUMBER,
    idCliente NUMBER,
    montoApertura FLOAT,
    idProducto NUMBER,
    Firma1 VARCHAR2,
    Firma2 VARCHAR2,
    Firma3 VARCHAR2
)
IS
    correlativo INTEGER:=0;
    contA INTEGER:=0;
    contC INTEGER:=0;
    nCuenta VARCHAR2(16);
BEGIN
-- Verificando que la agencia no exista
    SELECT count(ID_CLIENTE)INTO contC FROM CLIENTE WHERE ID_CLIENTE=idCliente;
    SELECT count(ID_AGENCIA)INTO contA FROM AGENCIA WHERE ID_AGENCIA=idAgencia; 
    SELECT count(NO_CUENTA) INTO correlativo FROM CUENTA WHERE ID_PRODUCTO=idProducto;
    correlativo := correlativo+1;
    nCuenta:= idProducto||'-'||LPAD(idAgencia,3,'0')||'-'||LPAD(correlativo,7,'0')||'-'||round(dbms_random.value(0,9),0);
IF(contA=1 and contC=1)THEN
    INSERT INTO CUENTA VALUES (nCuenta,
    idCliente,idAgencia,sysdate,montoApertura,'0.0',sysdate,idProducto,'ACTIVO', Firma1, Firma2, Firma3);
     COMMIT;
    DBMS_OUTPUT.PUT_LINE('CUENTA CREADA SATISFACTORIAMENTE');
ELSE
    DBMS_OUTPUT.PUT_LINE('EL CLIENTE O LA AGENCIA NO EXISTE, VERIFICQUE LOS DATOS');
    ROLLBACK;
END IF;
END CREAR_CUENTA;

EXECUTE CREAR_CUENTA('1','2','1000','1','FIRMA','Q','FIRMA');