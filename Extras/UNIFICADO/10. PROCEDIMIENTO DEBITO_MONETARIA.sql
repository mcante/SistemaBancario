CREATE OR REPLACE PROCEDURE DEBITO_MONETARIA
(MONTO IN FLOAT,   CTA_OR IN VARCHAR2,IN_NO_CHEQUE IN NUMBER)
IS 
V_VALIDA_CUENTA NUMBER;
V_SALDO_CUENTA CUENTA.SALDO_DISPONIBLE%TYPE;
V_BLOQUEADA CUENTA.STATUS%TYPE;
V_DIFERENCIA CUENTA.SALDO_DISPONIBLE%TYPE;
V_TIPO_CUENTA CUENTA.ID_PRODUCTO%TYPE;
V_NO_CHEQUE NUMBER;
V_STAT_CHEQUE CHEQUE.ESTADO%TYPE;
V_CHEQUERA1 NUMBER;
V_CHEQUERA2 NUMBER;
V_SALDO_RESERVA CUENTA.SALDO_RESERVA%TYPE;
BEGIN
IF (MONTO>0) THEN
--VALIDACION SI CUENTA EXISTE Y NO ESTA BLOQUEADA
	SELECT COUNT(NO_CUENTA) INTO V_VALIDA_CUENTA FROM CUENTA WHERE NO_CUENTA=CTA_OR;
	SELECT STATUS INTO V_BLOQUEADA FROM CUENTA WHERE NO_CUENTA=CTA_OR;
	IF(V_VALIDA_CUENTA=1 and V_BLOQUEADA='ACTIVO') THEN
	--VALIDACION SI ES CUENTA MONETARIA
	SELECT ID_PRODUCTO INTO V_TIPO_CUENTA FROM CUENTA WHERE NO_CUENTA=CTA_OR; --TIPO DE CUENTA ORIGEN
	IF(V_TIPO_CUENTA=2) THEN
		--VALIDACION DE SALDO
		SELECT SALDO_DISPONIBLE INTO V_SALDO_CUENTA FROM CUENTA WHERE NO_CUENTA=CTA_OR;
		V_DIFERENCIA:=V_SALDO_CUENTA-MONTO;
		IF(V_DIFERENCIA>=0)THEN				
				SELECT NO_CHEQUERA INTO V_CHEQUERA1 FROM CHEQUERA WHERE NO_CUENTA=CTA_OR; 
				SELECT NO_CHEQUERA INTO V_CHEQUERA2 FROM CHEQUE WHERE NO_CHEQUE=IN_NO_CHEQUE;
				IF(V_CHEQUERA2=V_CHEQUERA1) THEN
					SELECT COUNT(NO_CHEQUE) INTO V_NO_CHEQUE FROM CHEQUE WHERE NO_CHEQUE=IN_NO_CHEQUE;
					SELECT ESTADO INTO V_STAT_CHEQUE FROM CHEQUE WHERE NO_CHEQUE=IN_NO_CHEQUE;
					IF (V_NO_CHEQUE=1 AND V_STAT_CHEQUE='ACTIVO') THEN
					UPDATE CUENTA SET SALDO_DISPONIBLE=V_SALDO_CUENTA-MONTO, FECHA_ULTIMA_TRANSACCION=SYSDATE WHERE NO_CUENTA=CTA_OR;
					UPDATE CHEQUE SET ESTADO='COBRADO' WHERE NO_CHEQUE=IN_NO_CHEQUE;
					INSERT INTO OPERACION (FECHA_HORA, NO_CUENTA_ORIGEN,TIPO_OPERACION, TIPO_DOCUMENTO, NO_DOCUMENTO, STATUS, SALDO_INICIAL_ORIGEN,SALDO_FINAL_ORIGEN,MONTO_TOTAL_OPERADO,ID_CAJERO)
					VALUES (SYSDATE,CTA_OR,'RETIRO CON CHEQUE','CHEQUE',IN_NO_CHEQUE,'CORRECTO',V_SALDO_CUENTA,V_DIFERENCIA,MONTO,1);
					COMMIT;
					DBMS_OUTPUT.put_line('RETIRO REALIZADO CORRECTAMENTE');
					ElSE
					ROLLBACK;
					DBMS_OUTPUT.put_line('EL CHEQUE NO EXISTE O NO SE ENCUENTRA ACTIVO.');
					END IF;
				ELSE
					DBMS_OUTPUT.put_line('LA CHEQUERA DE LA CUENTA DEBE COINCIDIR CON');
					DBMS_OUTPUT.put_line('LA CHEQUERA A LA QUE PERTENECE EL CHEQUE.');
				END IF;
		ElSE
			UPDATE CHEQUE SET ESTADO='RECHAZADO' WHERE NO_CHEQUE=IN_NO_CHEQUE;
			SELECT SALDO_RESERVA INTO V_SALDO_RESERVA FROM CUENTA WHERE NO_CUENTA=CTA_OR;
			UPDATE CUENTA SET SALDO_RESERVA=V_SALDO_RESERVA+50, FECHA_ULTIMA_TRANSACCION=SYSDATE WHERE NO_CUENTA=CTA_OR;
			INSERT INTO RECARGO (NO_CUENTA,RECARGO,TIPO,DEBITADO) VALUES (CTA_OR,50,1,'N');
			INSERT INTO OPERACION (FECHA_HORA, NO_CUENTA_ORIGEN,TIPO_OPERACION, TIPO_DOCUMENTO, NO_DOCUMENTO, STATUS, SALDO_INICIAL_ORIGEN,SALDO_FINAL_ORIGEN,MONTO_TOTAL_OPERADO,ID_CAJERO)
            VALUES (SYSDATE,CTA_OR,'RETIRO CON CHEQUE','CHEQUE',IN_NO_CHEQUE,'FALLIDO',V_SALDO_CUENTA,V_SALDO_CUENTA,MONTO,1);
			DBMS_OUTPUT.PUT_LINE('EL SALDO ACTUAL DE LA CUENTA MONETARIA ES DE: Q.'||V_SALDO_CUENTA);
            DBMS_OUTPUT.PUT_LINE('EL SALDO MINIMO RESTANTE NO PUEDE SER MENOR A Q0.00');
		END IF;
	ElSE
	DBMS_OUTPUT.put_line('LA CUENTA DEBE SER MONETARIA, FAVOR VALIDAR LOS DATOS');
	END IF;
	ElSE
	DBMS_OUTPUT.put_line('LA CUENTA NO EXISTE O NO ESTA ACTIVA');
	END IF;
ElSE
DBMS_OUTPUT.PUT_LINE('EL MONTO A RETIRAR NO PUEDE SER CERO');
END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('NO SE ENCONTRARON DATOS, POR FAVOR VALIDE LOS DATOS');
END DEBITO_MONETARIA ;
--PRUEBAS
EXECUTE DEBITO_MONETARIA(0,'1-002-0000001-8',100);
EXECUTE DEBITO_MONETARIA(100,'1-002-0000001-8',100);
EXECUTE DEBITO_MONETARIA(100,'3-002-0000002-9',100);
EXECUTE DEBITO_MONETARIA(100,'2-001-0000001-9',100);
EXECUTE DEBITO_MONETARIA(100,'2-001-0000001-9',80);
EXECUTE DEBITO_MONETARIA(100,'2-001-0000001-9',5);