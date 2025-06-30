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

SELECT * FROM pago_cuota_manejo WHERE cuota_manejo_id = 1;
SELECT * FROM registro_cuota WHERE cuota_manejo_id = 1 LIMIT 1;
SELECT SUM(monto_abonado)
    FROM registro_cuota
    WHERE cuota_manejo_id = 1;

DELIMITER $$
DROP FUNCTION IF EXISTS fn_calc_saldo_pendiente $$
CREATE FUNCTION fn_calc_saldo_pendiente(
    f_cuota_manejo_id BIGINT
)
RETURNS DECIMAL(15,2)
DETERMINISTIC
READS SQL DATA
BEGIN

    DECLARE valor_pagar DECIMAL(15,2);
    DECLARE valor_pagado DECIMAL(15,2);

    SELECT SUM(monto_pagado) INTO valor_pagado
    FROM pago_cuota_manejo
    WHERE cuota_manejo_id = f_cuota_manejo_id;

    SELECT monto_a_pagar INTO valor_pagar
    FROM registro_cuota
    WHERE cuota_manejo_id = f_cuota_manejo_id LIMIT 1;


    RETURN valor_pagar - valor_pagado;

END $$

DELIMITER ;

SELECT fn_calc_saldo_pendiente(1);





-- Estimar el total de pagos realizados por tipo de tarjeta durante un período determinado.


DELIMITER $$
DROP FUNCTION IF EXISTS fn_total_pagos_tarjeta $$
CREATE FUNCTION fn_total_pagos_tarjeta(
    f_tarjeta_id BIGINT,
    f_fecha_inicio DATE,
    f_fecha_fin DATE
) 
RETURNS DECIMAL(15,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE v_total_cuotas DECIMAL(15,2) DEFAULT 0.00;
    DECLARE v_total_credito DECIMAL(15,2) DEFAULT 0.00;
    DECLARE v_total_final DECIMAL(15,2) DEFAULT 0.00;
    
    SELECT IFNULL(SUM(pcm.monto_pagado), 0.00) INTO v_total_cuotas
        FROM tarjetas_bancarias tb
        JOIN cuotas_manejo cm ON tb.id = cm.tarjeta_id
        JOIN pago_cuota_manejo pcm ON cm.id = pcm.cuota_manejo_id
        JOIN pagos p ON pcm.pago_id = p.id
        WHERE tb.id = f_tarjeta_id
        AND p.estado_pago_id = 2  
        AND (p_fecha_inicio IS NULL OR DATE(p.fecha_pago) >= f_fecha_inicio)
        AND (p_fecha_fin IS NULL OR DATE(p.fecha_pago) <= f_fecha_fin);
    
    SET v_total_final = v_total_cuotas + v_total_credito;
    
    RETURN v_total_final;
END $$
DELIMITER ;

SELECT fn_total_pagos_tarjeta(1, NULL, NULL);

-- Calcular el monto total de las cuotas de manejo para todos los clientes de un mes.

SELECT IFNULL(SUM(rc.monto_facturado), 0.00)
    FROM registro_cuota rc
    WHERE YEAR(rc.fecha_corte) = 2024
    AND MONTH(rc.fecha_corte) = 6;


DELIMITER $$
DROP FUNCTION IF EXISTS fn_total_cuotas_mes $$
CREATE FUNCTION fn_total_cuotas_mes(
    f_anho INT,
    f_mes INT
)
RETURNS DECIMAL(15,2)
READS SQL DATA
DETERMINISTIC
BEGIN

    DECLARE valor_total_cuotas DECIMAL(15,2) DEFAULT 0.00;

    SELECT IFNULL(SUM(rc.monto_facturado), 0.00) INTO valor_total_cuotas
    FROM registro_cuota rc
    WHERE YEAR(rc.fecha_corte) = f_anho
    AND MONTH(rc.fecha_corte) = f_mes;


    RETURN valor_total_cuotas;

END $$

SELECT fn_total_cuotas_mes(2024,6);


-- Calcular la edad de una cuenta bancaria en días desde su fecha de apertura hasta la fecha actual.

DELIMITER $$
DROP FUNCTION IF EXISTS fn_edad_cuenta_dias $$
CREATE FUNCTION fn_edad_cuenta_dias
(
    f_cuenta_id BIGINT
)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN

    DECLARE dias_cuenta INT DEFAULT 0;

    SELECT DATEDIFF(CURDATE(), DATE(fecha_apertura)) INTO dias_cuenta
    FROM cuenta
    WHERE id = f_cuenta_id;

    RETURN dias_cuenta;

END $$

DELIMITER;

SELECT fn_edad_cuenta_dias(1);



-- Determinar el nivel de riesgo crediticio de un cliente basado en su historial de pagos y mora en préstamos.

SELECT * FROM cuotas_prestamo;
SELECT * FROM estados_cuota;

DELIMITER $$
DROP FUNCTION IF EXISTS fn_nivel_riesgo_cliente $$
CREATE FUNCTION fn_nivel_riesgo_cliente(
    f_cliente_id BIGINT
)
RETURNS VARCHAR(20)
READS SQL DATA
DETERMINISTIC
BEGIN

    DECLARE valor_cuotas_mora INT DEFAULT 0;
    DECLARE valor_total_cuotas INT DEFAULT 0;
    DECLARE valor_porcentaje_mora DECIMAL(5,2) DEFAULT 0.00;
    DECLARE valor_nivel_riesgo VARCHAR(20) DEFAULT 'BAJO';

    SELECT
        COUNT(CASE WHEN cp.estado_cuota_id = 6 THEN 1 END),
        COUNT (*)
        INTO valor_cuotas_mora, valor_total_cuotas
    FROM cuotas_prestamo cp
    JOIN prestamos pr ON cp.prestamo_id = pr.id
    JOIN cuenta c ON pr.cuenta_id = c.id
    WHERE c.cliente_id = f_cliente_id;

    IF valor_total_cuotas > 0 THEN
        SET valor_porcentaje_mora = (valor_cuotas_mora/valor_total_cuotas) * 100;

        IF valor_porcentaje_mora >= 30 THEN
            SET valor_nivel_riesgo = 'ALTO';
        ELSEIF valor_porcentaje_mora >= 15 THEN
            SET valor_nivel_riesgo = 'MEDIO';
        ELSE
            SET valor_nivel_riesgo = 'BAJO';
        END IF;
    END IF;

    RETURN valor_nivel_riesgo;

END $$


DELIMITER ;
SELECT * FROM cuotas_prestamo;
SELECT fn_nivel_riesgo_cliente(5);





-- Calcular el interés acumulado de un préstamo desde su fecha de desembolso hasta una fecha específica.

DROP FUNCTION fn_calcular_interes_fecha $$

DELIMITER $$

CREATE FUNCTION fn_calcular_interes_fecha(
    f_prestamo_id BIGINT,
    f_fecha_calculo DATE
)
RETURNS DECIMAL(15,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE valor_monto_prestamo DECIMAL(15,2);
    DECLARE valor_tasa_interes DECIMAL(8,6);
    DECLARE valor_dias_pasados INT;
    DECLARE valor_interes_acumulado DECIMAL(15,2) DEFAULT 0.00;

    SELECT pr.monto_aprobado, i.valor, DATEDIFF(f_fecha_calculo, DATE(pr.fecha_desembolso))
    INTO valor_monto_prestamo, valor_tasa_interes, valor_dias_pasados
    FROM prestamos pr
    JOIN interes i ON pr.interes_id = i.id
    WHERE pr.id = f_prestamo_id
    AND pr.fecha_desembolso IS NOT NULL;

    IF valor_dias_pasados > 0 THEN
        SET valor_interes_acumulado = valor_monto_prestamo * valor_tasa_interes * (valor_dias_pasados/365);
    END IF;

    RETURN valor_interes_acumulado;
END $$

DELIMITER ;

SELECT fn_calcular_interes_fecha(1, '2025-06-30') AS interes_calculado;



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

