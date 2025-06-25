-- insertar los datos (hasta aqui llego mi salud mental)



INSERT INTO tipo_cliente (activo,codigo,descripcion,nombre) VALUES
(TRUE, 'REG', 'Cliente regular, no tiene beneficios especiales.', 'REGULAR'),
(TRUE, 'EST', 'Cliente estandar, tiene beneficios basicos.', 'ESTANDAR'),
(TRUE, 'PREF', 'Cliente preferencial, tiene beneficios preferenciales.', 'PREFERENCIAL'),
(TRUE, 'VIP', 'Cliente regular, tiene beneficios especiales y atencion personalizada.', 'VIP');


INSERT INTO tipo_cuenta (activo,codigo,descripcion,nombre) VALUES
(TRUE,'AHO','Cuenta de ahorros para personas naturales.','AHORRO'),
(TRUE,'COR','Cuenta corriente con sobregiro autorizado.','CORRIENTE'),
(TRUE,'NOM','Cuenta para recepcion de salario.','NOMINA'),
(TRUE,'PF','Cuenta de plazo fijo con rentabilidad garantizada :D.','PLAZO FIJO'),
(TRUE,'JUV','Cuenta para menores de edad y jovenes.','JUVENIL'),
(TRUE,'EMP','Cuenta para empresas y personas juridicas.','EMPRESARIAL'),
(TRUE,'DIV','Cuenta en moneda extranjera.','DIVISA EXTRANJERA'),
(TRUE,'DIG','Cuenta 101% digital sin papeleria.','DIGITAL');