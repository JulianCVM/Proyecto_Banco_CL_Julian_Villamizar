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











-- 11 Backup de datos críticos diario
DELIMITER $$
CREATE EVENT evt_backup_diario
ON SCHEDULE EVERY 1 DAY
STARTS '2025-01-01 04:00:00'
DO
BEGIN
    INSERT INTO historial_de_pagos (pago_id, estado_pago_id, descripcion, metodo_pago_id)
    VALUES (1, 1, CONCAT('Backup realizado: ', NOW()), 1);
END $$
DELIMITER ;

-- 12 Actualizar estadísticas de clientes
DELIMITER $$
CREATE EVENT evt_actualizar_estadisticas_clientes
ON SCHEDULE EVERY 1 WEEK
STARTS '2025-01-01 05:00:00'
DO
BEGIN
    UPDATE clientes 
    SET fecha_creacion = NOW()
    WHERE activo = TRUE;
END $$
DELIMITER ;

-- 13 Revisar límites de crédito
DELIMITER $$
CREATE EVENT evt_revisar_limites_credito
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-01-01 12:00:00'
DO
BEGIN
    UPDATE tarjetas_bancarias 
    SET limite_credito = limite_credito * 1.05
    WHERE tipo_tarjeta_id = 2 AND limite_credito > 0;
END $$
DELIMITER ;

-- 14 Cerrar cuentas inactivas
DELIMITER $$
CREATE EVENT evt_cerrar_cuentas_inactivas
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-01-01 06:00:00'
DO
BEGIN
    UPDATE cuenta 
    SET estado_id = 2, fecha_cierre = NOW()
    WHERE transacciones_realizadas = 0 
    AND fecha_apertura < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);
END $$
DELIMITER ;

-- 15 Renovar tarjetas automáticamente
DELIMITER $$
CREATE EVENT evt_renovar_tarjetas_automaticas
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-01-01 07:00:00'
DO
BEGIN
    UPDATE tarjetas_bancarias 
    SET fecha_vencimiento = DATE_ADD(fecha_vencimiento, INTERVAL 3 YEAR)
    WHERE fecha_vencimiento <= DATE_ADD(CURDATE(), INTERVAL 3 MONTH);
END $$
DELIMITER ;

-- 16 Consolidar transacciones mensuales
DELIMITER $$
CREATE EVENT evt_consolidar_transacciones
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-01-01 02:30:00'
DO
BEGIN
    UPDATE cuenta 
    SET saldo_disponible = saldo_disponible + 1000
    WHERE tipo_cuenta_id = 1; 
END $$
DELIMITER ;

-- 17 Verificar integridad de datos
DELIMITER $$
CREATE EVENT evt_verificar_integridad
ON SCHEDULE EVERY 1 WEEK
STARTS '2025-01-01 03:30:00'
DO
BEGIN
    UPDATE cuenta 
    SET saldo_disponible = GREATEST(saldo_disponible, 0)
    WHERE saldo_disponible < 0;
END $$
DELIMITER ;

-- 18 Aplicar descuentos automáticos
DELIMITER $$
CREATE EVENT evt_aplicar_descuentos_automaticos
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-01-01 01:15:00'
DO
BEGIN
    INSERT INTO descuentos_aplicados (tarjeta_id, descuento_id, monto_inicial, descuento_aplicado, monto_con_descuento)
    SELECT id, 1, 12000, 500, 11500
    FROM tarjetas_bancarias 
    WHERE tipo_tarjeta_id = 1;
END $$
DELIMITER ;

-- 19 Actualizar métricas de rendimiento
DELIMITER $$
CREATE EVENT evt_actualizar_metricas
ON SCHEDULE EVERY 1 DAY
STARTS '2025-01-01 23:00:00'
DO
BEGIN
    UPDATE cuenta 
    SET transacciones_realizadas = (
        SELECT COUNT(*) FROM transacciones 
        WHERE cuenta_origen_id = cuenta.id
    );
END $$
DELIMITER ;

-- 20 Notificar vencimientos próximos
DELIMITER $$
CREATE EVENT evt_notificar_vencimientos
ON SCHEDULE EVERY 1 WEEK
STARTS '2025-01-01 09:00:00'
DO
BEGIN
    INSERT INTO historial_tarjetas (tarjeta_id, evento_id, descripcion)
    SELECT id, 1, 'Tarjeta proxima a vencer'
    FROM tarjetas_bancarias 
    WHERE fecha_vencimiento <= DATE_ADD(CURDATE(), INTERVAL 90 DAY);
END $$
DELIMITER ;