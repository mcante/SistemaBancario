CREATE VIEW LISTA_CLIENTES AS
SELECT
    cliente.id_cliente,
    persona.nit,
    persona.nombre,
    persona.apellido,
    empresa.nit AS nit_emp,
    empresa.nombre AS empresa,
    cuenta.no_cuenta,
    cuenta.saldo_disponible,
    cuenta.saldo_reserva,
    producto.tipo,
    cuenta.status,
    cliente.dpi,
    cliente.id_patente AS id_patente1
FROM
    persona
    FULL OUTER JOIN cliente ON persona.dpi = cliente.dpi
    INNER JOIN cuenta ON cliente.id_cliente = cuenta.id_cliente
    FULL OUTER JOIN producto ON producto.id_producto = cuenta.id_producto
    FULL OUTER JOIN empresa ON empresa.id_patente = cliente.id_patente
ORDER BY
    cliente.id_cliente
;