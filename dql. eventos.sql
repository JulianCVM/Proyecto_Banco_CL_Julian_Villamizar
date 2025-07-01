USE banco_cl;

SET GLOBAL event_scheduler = ON;


-- 1 Generar reportes mensuales de cuotas

DELIMITER $$
CREATE EVENT evt_reporte_mensual_cuotas
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-01-01 23:59:00'
DO
BEGIN
    INSERT INTO historial_de_pagos (pago_id, estado_pago_id, descripcion, metodo_pago_id)
    SELECT 1, 1, CONCAT('Reporte mensual generado: ', CURDATE()), 1;
END $$
DELIMITER ;


-- 2 Actualizar estados de cuotas diariamente
DELIMITER $$
CREATE EVENT evt_actualizar_estados_diario
ON SCHEDULE EVERY 1 DAY
STARTS '2025-01-01 01:00:00'
DO
BEGIN
    UPDATE registro_cuota 
    SET estado_cuota_id = 5 
    WHERE fecha_limite_pago < CURDATE() AND estado_cuota_id = 2;
END $$
DELIMITER ;

-- 3 Alertas de pagos pendientes
DELIMITER $$
CREATE EVENT evt_alertas_pagos_pendientes
ON SCHEDULE EVERY 1 WEEK
STARTS '2025-01-01 08:00:00'
DO
BEGIN
    INSERT INTO historial_de_pagos (pago_id, estado_pago_id, descripcion, metodo_pago_id)
    SELECT 1, 1, 'Alerta: Pagos pendientes detectados', 1
    FROM registro_cuota 
    WHERE estado_cuota_id = 2 AND fecha_limite_pago < DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
    LIMIT 1;
END $$
DELIMITER ;


-- 4 Recalcular cuotas cuando cambien descuentos
DELIMITER $$
CREATE EVENT evt_recalcular_cuotas_descuentos
ON SCHEDULE EVERY 1 DAY
STARTS '2025-01-01 02:00:00'
DO
BEGIN
    UPDATE registro_cuota 
    SET monto_a_pagar = monto_facturado * 0.85
    WHERE estado_cuota_id = 2;
END $$
DELIMITER ;

-- 5 Actualizar registros de pagos mensuales
DELIMITER $$
CREATE EVENT evt_actualizar_pagos_mensuales
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-01-01 23:30:00'
DO
BEGIN
    UPDATE cuenta 
    SET transacciones_realizadas = transacciones_realizadas + 1
    WHERE saldo_disponible > 0;
END $$
DELIMITER ;

-- 6 Limpiar registros antiguos semanalmente
DELIMITER $$
CREATE EVENT evt_limpiar_registros_antiguos
ON SCHEDULE EVERY 1 WEEK
STARTS '2025-01-01 03:00:00'
DO
BEGIN
    DELETE FROM historial_de_pagos 
    WHERE fecha_registro < DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
END $$
DELIMITER ;

-- 7 Verificar tarjetas próximas a vencer
DELIMITER $$
CREATE EVENT evt_verificar_vencimiento_tarjetas
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-01-01 10:00:00'
DO
BEGIN
    UPDATE tarjetas_bancarias 
    SET estado_id = 7 
    WHERE fecha_vencimiento <= CURDATE();
END $$
DELIMITER ;

-- 8 Calcular intereses mensuales
DELIMITER $$
CREATE EVENT evt_calcular_intereses_mensual
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-01-01 23:45:00'
DO
BEGIN
    UPDATE cuenta 
    SET saldo_disponible = saldo_disponible * 1.002 
    WHERE tipo_cuenta_id = 1;
END $$
DELIMITER ;

-- 9 Actualizar estados de préstamos
DELIMITER $$
CREATE EVENT evt_actualizar_estados_prestamos
ON SCHEDULE EVERY 1 DAY
STARTS '2025-01-01 01:30:00'
DO
BEGIN
    UPDATE prestamos 
    SET estado_id = 16 
    WHERE saldo_restante = 0;
END $$
DELIMITER ;

-- 10 Generar cuotas mensuales automáticas
DELIMITER $$
CREATE EVENT evt_generar_cuotas_mensuales
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-01-01 00:30:00'
DO
BEGIN
    INSERT INTO registro_cuota (cuota_manejo_id, fecha_ultimo_cobro, monto_facturado, fecha_corte, fecha_limite_pago, estado_cuota_id, monto_a_pagar)
    SELECT id, NOW(), monto_apertura, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 15 DAY), 2, monto_apertura
    FROM cuotas_manejo 
    WHERE activo = TRUE;
END $$
DELIMITER ;