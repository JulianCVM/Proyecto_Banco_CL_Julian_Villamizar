
-- ! Procedimiento 1:
-- ? ============================================================================================
-- ! Registrar una nueva cuota de manejo calculando automáticamente el descuento.
-- ? ============================================================================================

-- DESCRIBE cuotas_manejo;
-- SELECT * FROM cuotas_manejo;
-- SELECT * FROM tipo_cuota_de_manejo;
-- SELECT * FROM descuento;
-- SELECT * FROM descuentos_aplicados;
-- SELECT * FROM nivel_tarjeta;
-- SELECT * FROM tipo_tarjetas;
-- SELECT * FROM marca_tarjeta;
-- SELECT * FROM tarjetas_bancarias;
-- SELECT * FROM cuenta_tarjeta;
-- SELECT * FROM cuenta;



USE banco_cl;


DROP PROCEDURE IF EXISTS cuota_manejo_calc_descuento;

DELIMITER $$

CREATE PROCEDURE cuota_manejo_calc_descuento (
    IN p_tarjeta_id BIGINT,
    IN p_tipo_cuota_manejo_id BIGINT,
    IN p_monto_apertura DECIMAL(15,2),
    IN p_fecha_inicio TIMESTAMP,
    IN p_frecuencia_pago_id BIGINT,
    IN p_fecha_fin DATE,
    IN p_activo BOOLEAN
)
BEGIN
    -- Variables para manejar los datos de la tarjeta a asignarle la cuota de manejo
    DECLARE vttid BIGINT; --tipo tarjeta
    DECLARE vntid BIGINT; --nivel tarjeta
    DECLARE vctid BIGINT; --tipo cliente
    
    -- Variables para el descuento
    DECLARE vdid BIGINT DEFAULT 1; -- Descuento por defecto
    DECLARE vdv DECIMAL(15,2);--valor descuento
    DECLARE vdt VARCHAR(20);--tipo valor
    
    -- Variables para manejar los calculos
    DECLARE vda DECIMAL(15,2) DEFAULT 0.00; --descuento aplicado
    DECLARE vmf DECIMAL(15,2); --monto final
    DECLARE vcmid BIGINT; --cuota manejo id
    
    -- Variables para manejo de errores
    DECLARE verrmsg VARCHAR(255);
    DECLARE exit handler FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 verrmsg = MESSAGE_TEXT;
        SELECT CONCAT('Error: ', verrmsg) as resultado;
    END;

    START TRANSACTION;
    
    -- Se obtiene la informacion de la tarjeta y del cliente del que vamos a asignarle la nueva cuota de manejo
    SELECT 
        tb.tipo_tarjeta_id,
        tb.nivel_tarjeta_id,
        c.tipo_cliente_id
    INTO 
        vttid,
        vntid,
        vctid
    FROM tarjetas_bancarias tb
    JOIN cuenta_tarjeta ct ON tb.id = ct.tarjeta_id
    JOIN cuenta cu ON ct.cuenta_id = cu.id
    JOIN clientes c ON cu.cliente_id = c.id
    WHERE tb.id = p_tarjeta_id
    LIMIT 1;
    
    -- Validamos que exista la tarjeta
    IF vttid IS NULL THEN
        SET verrmsg = CONCAT('Tarjeta con ID ', p_tarjeta_id, ' no encontrada');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = verrmsg;
    END IF;
    
    -- A corde a las reglas de negocio actuales se va a definir que descuento se va a asignar:
    SET vdid = CASE
        -- Clientes VIP (tipo_cliente_id = 4) - Descuento VIP en todos los niveles altos
        WHEN vctid = 4 AND vntid >= 4 THEN 8  -- DESC_VIP
        WHEN vctid = 4 AND vntid >= 2 THEN 4  -- DESC_CONV
        
        -- Tarjetas empresariales (nivel 7) - Descuento empresarial
        WHEN vntid = 7 THEN 10  -- DESC_EMP
        
        -- Tarjetas premium (niveles 4,5,6) - Descuentos especiales
        WHEN vntid >= 4 THEN 8   -- DESC_VIP
        WHEN vntid = 3 THEN 3    -- DESC_CUO_MAN (Exención)
        
        -- Tarjetas Gold (nivel 2) con diferentes tipos
        WHEN vntid = 2 AND vttid = 4 THEN 4  -- Empresarial -> DESC_CONV
        WHEN vntid = 2 AND vttid = 5 THEN 7  -- Nomina -> DESC_NOM
        WHEN vntid = 2 AND vttid = 6 THEN 5  -- Virtual -> CASHBACK
        WHEN vntid = 2 THEN 2    -- Otras Gold -> DESC_DEB_AUT
        
        -- Tarjetas basicas (nivel 1) - Descuento minimo
        ELSE 1  -- DESC_USO
    END;
    
    -- Obtener informacion del descuento
    SELECT valor, tipo_valor 
    INTO vdv, vdt
    FROM descuento 
    WHERE id = vdid AND activo = TRUE;
    
    -- Calcular el descuento aplicado
    IF vdt = 'PORCENTAJE' THEN
        SET vda = p_monto_apertura * (vdv / 100);
    ELSEIF vdt = 'MONTO_FIJO' THEN
        SET vda = LEAST(vdv, p_monto_apertura);
    END IF;
    
    -- Calcular monto final
    SET vmf = p_monto_apertura - vda;
    
    -- Asegurar que el monto final no sea negativo
    IF vmf < 0 THEN
        SET vmf = 0;
        SET vda = p_monto_apertura;
    END IF;
    
    -- Insertar la cuota de manejo
    INSERT INTO cuotas_manejo (tarjeta_id,tipo_cuota_manejo_id,monto_apertura,fecha_inicio,frecuencia_pago_id,fecha_fin,activo) VALUES 
    (p_tarjeta_id,p_tipo_cuota_manejo_id,p_monto_apertura,p_fecha_inicio,p_frecuencia_pago_id,p_fecha_fin,p_activo);
    
    -- Obtener el ID de la cuota creada
    SET vcmid = LAST_INSERT_ID();
    
    -- Insertar el descuento aplicado (solo si hay descuento)
    IF vda > 0 THEN
        INSERT INTO descuentos_aplicados (tarjeta_id,descuento_id,monto_inicial,descuento_aplicado,monto_con_descuento,fecha_aplicado) VALUES 
        (p_tarjeta_id,vdid,p_monto_apertura,vda,vmf,NOW());
    END IF;
    
    COMMIT;
    
    -- Retornar información del proceso
    SELECT 
        vcmid as cuota_id,
        p_tarjeta_id as tarjeta_id,
        p_monto_apertura as monto_original,
        vda as descuento_aplicado,
        vmf as monto_final,
        (SELECT nombre FROM descuento WHERE id = vdid) as tipo_descuento,
        CONCAT(ROUND((vda/p_monto_apertura)*100,2), '%') as porcentaje_descuento,
        'Cuota creada exitosamente' as mensaje;
        
END $$

DELIMITER ;

CALL cuota_manejo_calc_descuento(
    1,                    -- tarjeta clasica
    1,                    -- periodica
    15000.00,            -- monto_apertura
    NOW(),               -- fecha_inicio
    4,                   -- mensual
    '2025-12-31',        -- fecha_fin
    TRUE                 -- activo
);

CALL cuota_manejo_calc_descuento(
    4,                    -- tarjeta platino
    2,                    -- por producto
    25000.00,            -- monto_apertura
    NOW(),               -- fecha_inicio
    4,                   -- mensual
    '2025-12-31',        -- fecha_fin
    TRUE                 -- activo
);


SELECT 
    'Resultado procedimiento' as titulo,
    cm.id as cuota_id,
    tb.numero as tarjeta,
    nt.nombre as nivel_tarjeta,
    tt.nombre as tipo_tarjeta,
    tc.nombre as tipo_cliente,
    cm.monto_apertura,
    da.descuento_aplicado,
    da.monto_con_descuento,
    d.nombre as tipo_descuento,
    CONCAT(d.valor, ' ', d.tipo_valor) as descuento_config
FROM cuotas_manejo cm
JOIN tarjetas_bancarias tb ON cm.tarjeta_id = tb.id
JOIN nivel_tarjeta nt ON tb.nivel_tarjeta_id = nt.id
JOIN tipo_tarjetas tt ON tb.tipo_tarjeta_id = tt.id
JOIN cuenta_tarjeta ct ON tb.id = ct.tarjeta_id
JOIN cuenta cu ON ct.cuenta_id = cu.id
JOIN clientes c ON cu.cliente_id = c.id
JOIN tipo_cliente tc ON c.tipo_cliente_id = tc.id
LEFT JOIN descuentos_aplicados da ON cm.tarjeta_id = da.tarjeta_id 
    AND da.fecha_aplicado >= cm.fecha_inicio
LEFT JOIN descuento d ON da.descuento_id = d.id
ORDER BY cm.fecha_inicio DESC
LIMIT 10;




-- 📋 CUOTAS DE MANEJO
-- 1. crear_cuota_simple
-- Crear una cuota de manejo básica para una tarjeta
-- Parámetros: tarjeta_id, monto


DESCRIBE cuotas_manejo;
SELECT * FROM tipo_cuota_de_manejo;
SELECT * FROM tipo_tarjetas;
SELECT * FROM nivel_tarjeta;
SELECT * FROM tipo_cliente;



DROP PROCEDURE IF EXISTS crear_cuota_simple;

DELIMITER $$


CREATE PROCEDURE crear_cuota_simple(
    IN p_tarjeta_id bigint(20),
    IN p_monto_apertura DECIMAL(15,2)
)

BEGIN

    DECLARE vttid BIGINT; -- tipo tarjeta
    DECLARE vntid BIGINT; -- nivel tarjeta
    DECLARE vtcmid BIGINT; -- valor tipo cuota manejo id
    DECLARE vctid BIGINT; -- tipo cliente
    DECLARE vcid BIGINT; -- cuota id

    DECLARE verrmsg VARCHAR(255);
    DECLARE exit handler FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 verrmsg = MESSAGE_TEXT;
        SELECT CONCAT('Error: ', verrmsg) as resultado;
    END;

    START TRANSACTION;

    SELECT 
        tb.tipo_tarjeta_id,
        tb.nivel_tarjeta_id,
        c.tipo_cliente_id
    INTO 
        vttid,
        vntid,
        vctid
    FROM tarjetas_bancarias tb
    JOIN cuenta_tarjeta ct ON tb.id = ct.tarjeta_id
    JOIN cuenta cu ON ct.cuenta_id = cu.id
    JOIN clientes c ON cu.cliente_id = c.id
    WHERE tb.id = p_tarjeta_id
    LIMIT 1;


SET vtcmid = CASE
        WHEN vctid = 4 AND vntid >= 4 THEN 4
        WHEN vctid = 4 AND vntid >= 2 THEN 3
        
        WHEN vntid = 7 THEN 2
        
        WHEN vntid >= 4 THEN 1
        WHEN vntid = 3 THEN 3
        
        WHEN vntid = 2 AND vttid = 4 THEN 2
        WHEN vntid = 2 AND vttid = 5 THEN 4
        WHEN vntid = 2 AND vttid = 6 THEN 4
        WHEN vntid = 2 THEN 2
        
        ELSE 1  
    END;




    INSERT INTO cuotas_manejo(activo,fecha_inicio,frecuencia_pago_id,monto_apertura,tarjeta_id,tipo_cuota_manejo_id,fecha_fin) VALUES
    (TRUE, NOW(), 4, p_monto_apertura, p_tarjeta_id, vtcmid,DATE_ADD(NOW(), INTERVAL 1 YEAR));

    SET vcid = LAST_INSERT_ID();

    COMMIT;

    SELECT 
        vcid AS cuota_id,
        p_tarjeta_id AS tarjeta_id,
        p_monto_apertura AS monto_apertura,
        (SELECT nombre FROM tipo_cuota_de_manejo WHERE id = vtcmid) AS tipo_cuota,
        (SELECT CONCAT(nt.nombre, ' - ', tt.nombre) 
        FROM tarjetas_bancarias tb 
        JOIN nivel_tarjeta nt ON tb.nivel_tarjeta_id = nt.id
        JOIN tipo_tarjetas tt ON tb.tipo_tarjeta_id = tt.id
        WHERE tb.id = p_tarjeta_id) AS tarjeta_info,
        (SELECT CONCAT(c.primer_nombre, ' ', c.primer_apellido, ' (', tc.nombre, ')')
        FROM tarjetas_bancarias tb
        JOIN cuenta_tarjeta ct ON tb.id = ct.tarjeta_id
        JOIN cuenta cu ON ct.cuenta_id = cu.id
        JOIN clientes c ON cu.cliente_id = c.id
        JOIN tipo_cliente tc ON c.tipo_cliente_id = tc.id
        WHERE tb.id = p_tarjeta_id) AS cliente_info,
        NOW() AS fecha_creacion,
        'Cuota creada exitosamente' AS mensaje;

    
END $$


DELIMITER ;



CALL crear_cuota_simple(1, 15000.00);

CALL crear_cuota_simple(4, 25000.00);

CALL crear_cuota_simple(5, 35000.00);


SELECT 
    cm.id,
    tb.numero AS tarjeta,
    cm.monto_apertura,
    tcm.nombre AS tipo_cuota,
    cm.fecha_inicio,
    CONCAT(c.primer_nombre, ' ', c.primer_apellido) AS cliente
FROM cuotas_manejo cm
JOIN tarjetas_bancarias tb ON cm.tarjeta_id = tb.id
JOIN tipo_cuota_de_manejo tcm ON cm.tipo_cuota_manejo_id = tcm.id
JOIN cuenta_tarjeta ct ON tb.id = ct.tarjeta_id
JOIN cuenta cu ON ct.cuenta_id = cu.id
JOIN clientes c ON cu.cliente_id = c.id
ORDER BY cm.fecha_inicio DESC
LIMIT 5;

SHOW PROCEDURE STATUS WHERE Name = 'crear_cuota_simple';








2. aplicar_descuento_fijo

Aplicar un descuento de monto fijo a una cuota específica
Parámetros: cuota_id, monto_descuento






3. marcar_cuota_pagada

Cambiar estado de una cuota a "PAGADA"
Parámetros: cuota_id

4. exonerar_cuota

Marcar una cuota como exonerada (sin pago)
Parámetros: cuota_id, motivo

5. obtener_cuotas_tarjeta

Mostrar todas las cuotas de una tarjeta específica
Parámetros: tarjeta_id

💳 PAGOS (Básicos)
6. registrar_pago_efectivo

Registrar un pago simple en efectivo
Parámetros: cuenta_id, monto, concepto

7. cancelar_pago

Cambiar estado de un pago a "CANCELADO"
Parámetros: pago_id

8. completar_pago

Cambiar estado de un pago a "COMPLETADO"
Parámetros: pago_id

9. buscar_pago_referencia

Buscar un pago por su referencia
Parámetros: referencia

10. sumar_pagos_cuenta

Sumar todos los pagos de una cuenta en un mes
Parámetros: cuenta_id, mes

🔄 ESTADOS (Súper Simples)
11. activar_tarjeta

Cambiar estado de tarjeta a "ACTIVA"
Parámetros: tarjeta_id

12. bloquear_tarjeta

Cambiar estado de tarjeta a "BLOQUEADA"
Parámetros: tarjeta_id

13. actualizar_saldo_cuenta

Actualizar el saldo disponible de una cuenta
Parámetros: cuenta_id, nuevo_saldo

14. contar_transacciones_cuenta

Contar cuántas transacciones tiene una cuenta
Parámetros: cuenta_id

📊 CONSULTAS (Muy Fáciles)
15. ver_saldo_cliente

Mostrar el saldo total de todas las cuentas de un cliente
Parámetros: cliente_id

16. listar_tarjetas_activas

Mostrar todas las tarjetas con estado ACTIVA
Parámetros: cliente_id (opcional)

17. cuotas_del_mes

Mostrar cuotas generadas en un mes específico
Parámetros: año, mes

🛠️ UTILIDADES (Sencillísimas)
18. generar_referencia_pago

Generar una referencia única para un nuevo pago
Parámetros: prefijo (ej: "PAY")

19. calcular_total_cuota

Calcular el total de una cuota después de descuentos
Parámetros: cuota_id