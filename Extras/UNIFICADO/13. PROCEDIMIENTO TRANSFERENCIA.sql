DROP PROCEDURE TRANSFERENCIA;

CREATE OR REPLACE PROCEDURE TRANSFERENCIA
(
   ctaOrigen VARCHAR2,
   ctaDestino VARCHAR2,
   monto FLOAT
)
IS
existeOrigen INTEGER := 0;
existeDestino INTEGER := 0;
saldoOrigen FLOAT :=0;
saldoDestino FLOAT :=0;
tipoCuenta INTEGER :=0;
diferencia FLOAT :=0;
nuevoSaldo FLOAT :=0;
estadoOrigen varchar(50) :='INACTIVA';
estadoDestino varchar(50) :='INACTIVA';
ex_custom EXCEPTION;
BEGIN
    --Verificar si la cuenta origen exsite
    SELECT COUNT(NO_CUENTA) INTO existeOrigen FROM CUENTA WHERE NO_CUENTA=ctaOrigen;
    --Verificar si la cuenta destino exsite    
    SELECT COUNT(NO_CUENTA) INTO existeDestino FROM CUENTA WHERE NO_CUENTA=ctaDestino;
    
    
    --Si origen y destino son igual a 1 entonces existen
    IF (existeOrigen=1 and existeDestino=1) THEN
        SELECT STATUS INTO estadoOrigen FROM CUENTA WHERE NO_CUENTA=ctaOrigen; --Estado cuenta origen
        SELECT STATUS INTO estadoDestino FROM CUENTA WHERE NO_CUENTA=ctaDestino; --Estado cuenta destino
        
        IF ((estadoOrigen='ACTIVO') AND (estadoDestino='ACTIVO')) THEN
            SELECT SALDO_DISPONIBLE INTO saldoOrigen FROM CUENTA WHERE NO_CUENTA=ctaOrigen; --Saldo cuenta origen
            SELECT SALDO_DISPONIBLE INTO saldoDestino FROM CUENTA WHERE NO_CUENTA=ctaDestino; --Saldo cuenta destino
            diferencia :=saldoOrigen - monto;
            nuevoSaldo :=saldoDestino + monto;
                    
            SELECT ID_PRODUCTO INTO tipoCuenta FROM CUENTA WHERE NO_CUENTA=ctaOrigen; --Tipo de cuenta ahorro o monetaria
            
            --El saldo actual tiene que ser mayor al monto a transferir
            IF (saldoOrigen>=monto)THEN
                IF (tipoCuenta=1) THEN --Si la cuenta origen es de ahorro no puede quedar menos de 100. Ahorro=201
                    IF (diferencia >= 100) THEN --Si la cuenta origen es de ahorro no puede quedar menos de 100. Ahorro=201
                        UPDATE CUENTA SET SALDO_DISPONIBLE=SALDO_DISPONIBLE-monto WHERE NO_CUENTA=ctaOrigen;
                        UPDATE CUENTA SET SALDO_DISPONIBLE=SALDO_DISPONIBLE+monto WHERE NO_CUENTA=ctaDestino;
                        
                        --ORIGEN A DESTINO
                        INSERT INTO OPERACION (FECHA_HORA, NO_CUENTA_ORIGEN, NO_CUENTA_DESTINO, TIPO_OPERACION, TIPO_DOCUMENTO, STATUS, SALDO_INICIAL_ORIGEN, SALDO_FINAL_ORIGEN, SALDO_INICIAL_DESTINO, SALDO_FINAL_DESTINO, MONTO_TOTAL_OPERADO, ID_CAJERO) 
                        VALUES (SYSDATE, ctaOrigen, ctaDestino, 'TRANSFERENCIA ELECTRÓNICA', 'TRASFERENCIA', 'CORRECTO', saldoOrigen, diferencia, saldoDestino, nuevoSaldo, monto, '1');
                        
                        --DESTINO A ORIGEN
                        INSERT INTO OPERACION (FECHA_HORA, NO_CUENTA_ORIGEN, TIPO_OPERACION, TIPO_DOCUMENTO, STATUS, SALDO_INICIAL_ORIGEN, SALDO_FINAL_ORIGEN, MONTO_TOTAL_OPERADO, ID_CAJERO) 
                        VALUES (SYSDATE, ctaDestino, 'TRANSFERENCIA ELECTRÓNICA', 'TRASFERENCIA', 'CORRECTO', saldoDestino, nuevoSaldo, monto, '1');
                 
                        COMMIT;
                        DBMS_OUTPUT.PUT_LINE('SALDO ACTUAL Q' ||saldoOrigen||' monto a transferir: Q'||monto || ' Cuenta ahorro ' || tipoCuenta || ' nuevo salgo: ' || diferencia);
                    ELSE
                        DBMS_OUTPUT.PUT_LINE('EL SALDO ACTUAL Q' ||saldoOrigen||' ES INSUFICIENTE POR EL TIPO DE CUENTA - AHORRO, EL SALDO MINIMO PARA LA CUENTA ES Q100');
                        RAISE ex_custom;
                    END IF;
                ELSIF (tipoCuenta=2) THEN
                    IF (diferencia >= 0) THEN --Si la cuenta origen es de MONETARIA no puede quedar menos de 0. Ahorro=202
                        UPDATE CUENTA SET SALDO_DISPONIBLE=SALDO_DISPONIBLE-monto WHERE NO_CUENTA=ctaOrigen;
                        UPDATE CUENTA SET SALDO_DISPONIBLE=SALDO_DISPONIBLE+monto WHERE NO_CUENTA=ctaDestino;
                        
                         --ORIGEN A DESTINO
                        INSERT INTO OPERACION (FECHA_HORA, NO_CUENTA_ORIGEN, NO_CUENTA_DESTINO, TIPO_OPERACION, TIPO_DOCUMENTO, STATUS, SALDO_INICIAL_ORIGEN, SALDO_FINAL_ORIGEN, SALDO_INICIAL_DESTINO, SALDO_FINAL_DESTINO, MONTO_TOTAL_OPERADO, ID_CAJERO) 
                        VALUES (SYSDATE, ctaOrigen, ctaDestino, 'TRANSFERENCIA ELECTRONICA', 'DEBITO_T', 'CORRECTO', saldoOrigen, diferencia, saldoDestino, nuevoSaldo, monto, '1');
                        
                        --DESTINO A ORIGEN
                        INSERT INTO OPERACION (FECHA_HORA, NO_CUENTA_ORIGEN, TIPO_OPERACION, TIPO_DOCUMENTO, STATUS, SALDO_INICIAL_ORIGEN, SALDO_FINAL_ORIGEN, MONTO_TOTAL_OPERADO, ID_CAJERO) 
                        VALUES (SYSDATE, ctaDestino, 'TRANSFERENCIA ELECTRONICA', 'CREDITO_t', 'CORRECTO', saldoDestino, nuevoSaldo, monto, '1');
                        
                        COMMIT;
                        DBMS_OUTPUT.PUT_LINE('SALDO ACTUAL Q' ||saldoOrigen||' monto a transferir: Q'||monto || ' Cuenta MONETARIA ' || tipoCuenta || ' nuevo salgo: ' || diferencia);
                    ELSE
                        DBMS_OUTPUT.PUT_LINE('EL SALDO ACTUAL Q' ||saldoOrigen||' ES INSUFICIENTE POR EL TIPO DE CUENTA - MONETARIA, EL SALDO MINIMO PARA LA CUENTA NO PUEDE SER MENOR A Q0.00');
                        RAISE ex_custom;
                    END IF;
                END IF;
            ELSE
                DBMS_OUTPUT.PUT_LINE('SALDO ACTUAL INSUFICIENTE Q' ||saldoOrigen||' PARA TRANSFERIR: Q'||monto);
                RAISE ex_custom;
            END IF;
    
        ELSE
            DBMS_OUTPUT.PUT_LINE('Verificar que las cuentas se encuentren activas -- ' ||ctaOrigen||' => '||estadoOrigen || ',  ' ||ctaDestino ||' => '||estadoDestino);
            RAISE ex_custom;

        END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Verificar que las cuentas existan');
            RAISE ex_custom;
    END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('NO SE ENCONTRARON DATOS, POR FAVOR VALIDE LOS DATOS');
WHEN ex_custom THEN
    INSERT INTO OPERACION (FECHA_HORA, NO_CUENTA_ORIGEN, NO_CUENTA_DESTINO, TIPO_OPERACION, TIPO_DOCUMENTO, STATUS, SALDO_INICIAL_ORIGEN, SALDO_FINAL_ORIGEN, SALDO_INICIAL_DESTINO, SALDO_FINAL_DESTINO, MONTO_TOTAL_OPERADO, ID_CAJERO) 
     VALUES (SYSDATE, ctaOrigen, ctaDestino, 'TRANSFERENCIA ELECTRONICA','DEBITO_T', 'FALLIDO', saldoOrigen, saldoOrigen, saldoDestino, saldoDestino, monto, '1');
     dbms_output.put_line('Error en la transaccion: '||SQLERRM);
     dbms_output.put_line('Se deshacen las modificaciones');
END TRANSFERENCIA;





--PRUEBAS

SELECT * FROM CUENTA; --DATOS ACTUALES DE LAS CUENTAS 1 Y 2

--MONETARIA
EXECUTE TRANSFERENCIA('2-001-0000001-9', '1-002-0000001-8', 50);
SELECT * FROM CUENTA; --DATOS ACTUALES DE LAS CUENTAS 1 Y 2

--AHORRO
EXECUTE TRANSFERENCIA('1-002-0000001-8', '2-001-0000001-9', 50);
SELECT * FROM CUENTA; --DATOS ACTUALES DE LAS CUENTAS 1 Y 2

--ERROR DE CUENTAS QUE NO EXISTEN
EXECUTE TRANSFERENCIA('2-001-00000011-9', '1-002-0000001-8', 50);