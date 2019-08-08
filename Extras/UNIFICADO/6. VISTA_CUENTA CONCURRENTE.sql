DROP VIEW CUENTA_CONCURRENTE;

CREATE VIEW CUENTA_CONCURRENTE AS

SELECT * FROM (
SELECT
    cuenta.no_cuenta,
    COUNT(operacion.no_operacion) AS count_no_operacion
FROM
    operacion
    INNER JOIN cuenta ON cuenta.no_cuenta = operacion.no_cuenta_origen
    
    
GROUP BY
    cuenta.no_cuenta
ORDER BY
    count_no_operacion DESC
    )
    WHERE rownum <= 5;

SELECT * FROM CUENTA_CONCURRENTE;