-- funcion 1
-- fn_generar_codigo_unico
-- generar codigo unico para usarse en facturas y demas


DELIMITER $$
DROP FUNCTION IF EXISTS fn_generar_codigo_unico $$
CREATE FUNCTION fn_generar_codigo_unico()
RETURNS VARCHAR(255)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE codigo_complejo VARCHAR(255);
    DECLARE nums_lista TEXT DEFAULT '';
    DECLARE i INT DEFAULT 1;
    DECLARE finCiclo INT DEFAULT 36;
    DECLARE num INT;
    WHILE i <= finCiclo DO
        SET num = FLOOR(RAND() * 9) + 1;
        SET nums_lista = CONCAT(nums_lista, IF(nums_lista = '', '', ''), num);
        SET i = i + 1;
    END WHILE;
    SET codigo_complejo = CONCAT('PAY-', nums_lista);
    RETURN codigo_complejo;
END$$
DELIMITER ;
SELECT fn_generar_codigo_unico();




-- Calcular la cuota de manejo para un cliente según su tipo de tarjeta y monto de apertura.

SELECT * FROM tipo_tarjetas;

DELIMITER $$
DROP FUNCTION IF EXISTS fn_calcular_cuota_manejo_cliente_tarjeta_monto $$
CREATE FUNCTION fn_calcular_cuota_manejo_cliente_tarjeta_monto(
    f_tipo_tarjeta BIGINT, 
    f_monto_apertura DECIMAL(15,2)
)
RETURNS DECIMAL(15,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE valor_porcentaje DECIMAL(5,3);

    SET valor_porcentaje = CASE
        WHEN f_tipo_tarjeta = 1 THEN 0.015
        WHEN f_tipo_tarjeta = 2 THEN 0.010
        WHEN f_tipo_tarjeta = 3 THEN 0.025
        WHEN f_tipo_tarjeta = 4 THEN 0.045
        WHEN f_tipo_tarjeta = 5 THEN 0.020
        WHEN f_tipo_tarjeta = 6 THEN 0.005
        ELSE 0.000
    END;

    RETURN f_monto_apertura * valor_porcentaje;
END$$
DELIMITER ;
SELECT fn_calcular_cuota_manejo_cliente_tarjeta_monto(1,100000000);




-- Estimar el descuento total aplicado sobre la cuota de manejo.

SELECT * FROM descuento;


DELIMITER $$
DROP FUNCTION IF EXISTS fn_descuento_aplicado_cuotas $$
CREATE FUNCTION fn_descuento_aplicado_cuotas(
    f_tipo_tarjeta BIGINT, 
    f_monto_apertura DECIMAL(15,2),
    f_descuento_aplicar BIGINT
)
RETURNS DECIMAL(15,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    
    DECLARE valor_cuota_manejo DECIMAL(15,2);
    DECLARE valor_descuento DECIMAL(15,2);

    SET valor_cuota_manejo = fn_calcular_cuota_manejo_cliente_tarjeta_monto(f_tipo_tarjeta, f_monto_apertura);


    SELECT valor INTO valor_descuento
    FROM descuento
    WHERE id = f_descuento_aplicar
    AND tipo_valor = 'PORCENTAJE';

    RETURN valor_descuento * valor_cuota_manejo;

END$$
DELIMITER ;
SELECT fn_descuento_aplicado_cuotas(1,1000000,2);


-- Calcular el saldo pendiente de pago de un cliente.


-- Estimar el total de pagos realizados por tipo de tarjeta durante un período determinado.


-- Calcular el monto total de las cuotas de manejo para todos los clientes de un mes.


-- Calcular la edad de una cuenta bancaria en días desde su fecha de apertura hasta la fecha actual.


-- Determinar el nivel de riesgo crediticio de un cliente basado en su historial de pagos y mora en préstamos.


-- Calcular el interés acumulado de un préstamo desde su fecha de desembolso hasta una fecha específica.


-- Obtener el promedio de transacciones mensuales realizadas por una cuenta en los últimos 6 meses.


-- Calcular la comisión total por transacciones de una cuenta durante un período determinado.


-- Determinar si una tarjeta está próxima a vencer (en los próximos 90 días) y retornar días restantes.


-- Calcular el porcentaje de utilización de límite de crédito de una tarjeta bancaria.


-- Obtener el monto total adeudado por un cliente sumando todos sus préstamos activos.


-- Calcular la rentabilidad generada por un cliente basada en cuotas de manejo y comisiones pagadas.


-- Determinar el tipo de cliente más frecuente por sucursal o región basado en registros.


-- Calcular los días de mora promedio de las cuotas vencidas de un cliente específico.


-- Obtener el saldo disponible ajustado de una cuenta considerando retenciones y bloqueos.


-- Calcular la tasa efectiva anual de un préstamo considerando todos los costos asociados.


-- Determinar la categoría de gasto de un cliente basada en el volumen de transacciones mensuales.

