DROP VIEW LOGUEO;
CREATE VIEW LOGUEO AS

SELECT
    persona.nombre,
    persona.apellido,
    empleado.activo,
    empleado.usuario,
    empleado.password,
    rol.tipo
FROM
    empleado
    INNER JOIN persona ON persona.dpi = empleado.dpi
    INNER JOIN rol ON rol.id_rol = empleado.rol
;

SELECT * FROM LOGUEO;