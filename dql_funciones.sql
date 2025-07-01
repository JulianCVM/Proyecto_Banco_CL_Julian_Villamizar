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


SELECT COUNT(*) 
    FROM transacciones t
    WHERE (t.cuenta_origen_id = 2 OR t.cuenta_destino_id = 2)
    AND t.fecha_operacion >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);


DROP FUNCTION IF EXISTS fn_calcular_promedio_mensual_rango_tiempo $$

DELIMITER $$
CREATE FUNCTION fn_calcular_promedio_mensual_rango_tiempo(
    f_cuenta_id BIGINT,
    f_meses_atras INT
)
RETURNS DECIMAL(10,2)
READS SQL DATA
DETERMINISTIC
BEGIN

    DECLARE total_transacciones_realizadas INT DEFAULT 0;
    DECLARE valor_promedio DECIMAL(10,2) DEFAULT 0.00;

    SELECT COUNT(*) INTO total_transacciones_realizadas
    FROM transacciones t
    WHERE (t.cuenta_origen_id = f_cuenta_id OR t.cuenta_destino_id = f_cuenta_id)
    AND t.fecha_operacion >= DATE_SUB(CURDATE(), INTERVAL f_meses_atras MONTH);

    IF f_meses_atras > 0 THEN
        SET valor_promedio = total_transacciones_realizadas/f_meses_atras;
    END IF;

    RETURN valor_promedio;

END $$

DELIMITER ;

SELECT fn_calcular_promedio_mensual_rango_tiempo(1,1);



-- Comisión total por transacciones de una cuenta

SELECT IFNULL(SUM(cobro_operacion), 0.00) FROM transacciones WHERE cuenta_origen_id = 1;

DROP FUNCTION IF EXISTS fn_comision_total_transacciones $$

DELIMITER $$

CREATE FUNCTION fn_comision_total_transacciones (
    f_cuenta_id BIGINT
)
RETURNS DECIMAL(15,2)
READS SQL DATA
DETERMINISTIC
BEGIN

    DECLARE valor_comision_total DECIMAL(15,2);

    SELECT IFNULL(SUM(cobro_operacion), 0.00) INTO valor_comision_total
    FROM transacciones 
    WHERE cuenta_origen_id = f_cuenta_id;
    

    RETURN valor_comision_total;


END $$

DELIMITER ;

SELECT fn_comision_total_transacciones(1);



--  Días para vencimiento de tarjeta

SELECT DATEDIFF(fecha_vencimiento, CURDATE())
FROM tarjetas_bancarias
WHERE id = 1;

DROP FUNCTION IF EXISTS fn_dias_vencimiento_tarjeta $$

DELIMITER $$

CREATE FUNCTION fn_dias_vencimiento_tarjeta(
    f_tarjeta_id BIGINT
)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN

    DECLARE valor_dias_transcurridos INT DEFAULT 0;

    SELECT DATEDIFF(fecha_vencimiento, CURDATE()) INTO valor_dias_transcurridos
    FROM tarjetas_bancarias
    WHERE id = f_tarjeta_id;

    RETURN valor_dias_transcurridos;

END $$

DELIMITER ;
SELECT fn_dias_vencimiento_tarjeta(1);


-- Porcentaje de uso de crédito

SELECT limite_credito FROM tarjetas_bancarias WHERE id = 1;

DROP FUNCTION IF EXISTS fn_porcentaje_creido $$


DELIMITER $$

CREATE FUNCTION fn_porcentaje_creido (
    f_tarjeta_id BIGINT
)   
RETURNS DECIMAL(5,2)
READS SQL DATA
DETERMINISTIC
BEGIN

    DECLARE valor_limite_credito DECIMAL (5,2);

    SELECT limite_credito  INTO valor_limite_credito
    FROM tarjetas_bancarias
    WHERE id = f_tarjeta_id;

    -- El limite actual del credito es del 75%
    IF valor_limite_credito > 0 THEN
        RETURN 75.00;
    END IF;
    
    RETURN 0.00;

END $$

DELIMITER ;
SELECT fn_porcentaje_creido(1)



-- 14 Total monto gastado por cliente de un prestamo

SELECT * FROM prestamos;
SELECT monto_aprobado - saldo_restante
FROM cuenta c 
JOIN prestamos p ON c.id = p.cuenta_id
WHERE c.id = 1
AND p.id = 1;


DROP FUNCTION IF NOT EXISTS fn_prestamo_gasto $$

DELIMITER $$

CREATE FUNCTION fn_prestamo_gasto(
    f_cuenta_id BIGINT,
    f_prestamo_id BIGINT
)
RETURNS DECIMAL(15,2)
READS SQL DATA
DETERMINISTIC
BEGIN

    DECLARE monto_prestamo_gastado DECIMAL(15,2) DEFAULT 0.00;

    SELECT monto_aprobado - saldo_restante INTO monto_prestamo_gastado
    FROM cuenta c 
    JOIN prestamos p ON c.id = p.cuenta_id
    WHERE c.id = f_cuenta_id
    AND p.id = f_prestamo_id;


    RETURN monto_prestamo_gastado;

END $$

DELIMITER ;

SELECT fn_prestamo_gasto(1,1);


-- Rentabilidad básica por cliente

SELECT IFNULL(SUM(monto), 0.00) *0.20
FROM pagos p
JOIN cuenta c ON p.cuenta_id = c.tipo_cuenta_id
WHERE c.cliente_id = 1
AND p.estado_pago_id = 2;


DROP FUNCTION IF NOT EXISTS fn_rentabilidad_cliente $$

DELIMITER $$

CREATE FUNCTION fn_rentabilidad_cliente (
    f_id_cliente BIGINT
)
RETURNS DECIMAL(15,2)
READS SQL DATA
DETERMINISTIC
BEGIN

    DECLARE valor_rentabilidad DECIMAL(15,2) DEFAULT 0.00;

    SELECT IFNULL(SUM(monto), 0.00) INTO valor_rentabilidad
    FROM pagos p
    JOIN cuenta c ON p.cuenta_id = c.tipo_cuenta_id
    WHERE c.cliente_id = f_id_cliente
    AND p.estado_pago_id = 2;

-- a considereacion de que haya una excelente y buenisima rentabilidad del 20%
    RETURN valor_rentabilidad * 0.20;

END $$

DELIMITER ;

SELECT fn_rentabilidad_cliente(1);



-- 16 Tipo de cliente más común

SELECT tc.nombre
FROM clientes c
JOIN tipo_cliente tc
ON c.tipo_cliente_id = tc.id
GROUP BY tc.nombre
ORDER BY COUNT(*) DESC
LIMIT 1;


DROP FUNCTION IF EXISTS fn_cliente_comun $$

DELIMITER $$

CREATE FUNCTION fn_cliente_comun()
RETURNS VARCHAR(255)
READS SQL DATA
DETERMINISTIC
BEGIN

    DECLARE tipoo_cliente_comun VARCHAR(255);

    SELECT tc.nombre INTO tipoo_cliente_comun
    FROM clientes c
    JOIN tipo_cliente tc
    ON c.tipo_cliente_id = tc.id
    GROUP BY tc.nombre
    ORDER BY COUNT(*) DESC
    LIMIT 1;

    RETURN tipoo_cliente_comun;

END $$

DELIMITER ;

SELECT fn_cliente_comun();