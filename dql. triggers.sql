USE banco_cl;



--  1 Actualizar estado de cuota al insertar pago
DROP TRIGGER IF EXISTS trg_actualizar_estado_cuota_pago $$

DELIMITER $$

CREATE TRIGGER trg_actualizar_estado_cuota_pago
AFTER INSERT ON pago_cuota_manejo
FOR EACH ROW
BEGIN
    UPDATE registro_cuota
    SET estado_cuota_id = 3, 
    monto_abonado = monto_abonado + NEW.monto_pagado
    WHERE cuota_manejo_id = NEW.cuota_manejo_id;

END $$

DELIMITER ;

SELECT * FROM registro_cuota WHERE cuota_manejo_id = 1;
SELECT * FROM pago_cuota_manejo WHERE cuota_manejo_id = 1;

INSERT INTO pago_cuota_manejo (cuota_manejo_id,fecha_pago,metodo_pago_id,monto_pagado,pago_id) VALUES 
(1,NOW()-INTERVAL 28 DAY,3,15000.00,4);



-- 2 Recalcular cuota al cambiar monto apertura

DROP TRIGGER IF EXISTS trg_recalcular_cuota_monto $$

DELIMITER $$

CREATE TRIGGER trg_recalcular_cuota_monto
AFTER UPDATE ON cuotas_manejo
FOR EACH ROW
BEGIN

    IF NEW.monto_apertura != OLD.monto_apertura THEN
        UPDATE registro_cuota
        SET monto_facturado = NEW.monto_apertura * 0.01
        WHERE cuota_manejo_id = NEW.id;
    END IF;

END $$

DELIMITER ;

SELECT * FROM registro_cuota;
SELECT * FROM cuotas_manejo;

UPDATE cuotas_manejo
SET monto_apertura = 12000.00
WHERE id = 1;



--  3 Asignar descuento al crear tarjeta

DROP TRIGGER IF EXISTS trg_asignar_descuento_tarjeta $$

DELIMITER $$

CREATE TRIGGER trg_asignar_descuento_tarjeta
AFTER INSERT ON tarjetas_bancarias
FOR EACH ROW
BEGIN
    INSERT INTO descuentos_aplicados (tarjeta_id, descuento_id, monto_inicial, descuento_aplicado, monto_con_descuento)
    VALUES (NEW.id, 1, 12000.00, 500.00, 11500.00);
END $$
DELIMITER ;

INSERT INTO tarjetas_bancarias (codigo_seguridad,estado_id,fecha_emision,fecha_vencimiento,limite_credito,marca_tarjeta_id,nivel_tarjeta_id,numero,tipo_tarjeta_id) VALUES 
('333',4,NOW(),'2027-12-31',0,1,1,'4532123456789091',1);
SELECT * FROM descuentos_aplicados WHERE tarjeta_id = 53;

SELECT * FROM tarjetas_bancarias WHERE id = 53; 



-- 4 Eliminar cuotas al eliminar tarjeta

DROP TRIGGER IF EXISTS trg_eliminar_cuotas_tarjeta $$


DELIMITER $$

CREATE TRIGGER trg_eliminar_cuotas_tarjeta
BEFORE DELETE ON tarjetas_bancarias
FOR EACH ROW
BEGIN
    DELETE FROM cuotas_manejo WHERE tarjeta_id = OLD.id;
END $$
DELIMITER ;

DELETE FROM tarjetas_bancarias WHERE id = 55;
INSERT INTO cuotas_manejo (activo,fecha_fin,fecha_inicio,frecuencia_pago_id,monto_apertura,tarjeta_id,tipo_cuota_manejo_id) VALUES 
(TRUE,'2025-12-31',NOW(),4,12000.00,55,1);
SELECT * FROM cuotas_manejo WHERE tarjeta_id = 55;



-- 5 Actualizar saldo cuenta al insertar transacción
DROP TRIGGER IF EXISTS trg_actualizar_saldo_transaccion $$


DELIMITER $$

CREATE TRIGGER trg_actualizar_saldo_transaccion
AFTER INSERT ON transacciones
FOR EACH ROW
BEGIN
    UPDATE cuenta
            SET saldo_disponible = saldo_disponible - NEW.monto,
            transacciones_realizadas = transacciones_realizadas + 1
        WHERE id = NEW.cuenta_origen_id;
END $$
DELIMITER ;

DESCRIBE  cuenta;
INSERT INTO transacciones (cuenta_destino_id,cuenta_origen_id,cobro_operacion,descripcion,fecha_operacion,monto,referencia,tipo_transaccion_id) VALUES 
(2,1,5000.00,'Transferencia entre cuentas de yo',NOW()-INTERVAL 15 DAY,500000.00,'TRF333',9);

SELECT * FROM transacciones WHERE cuenta_origen_id = 1;
SELECT * FROM cuenta WHERE id = 1;


-- 6 Registrar historial al cambiar estado tarjeta

DROP TRIGGER IF EXISTS trg_historial_estado_tarjeta $$


DELIMITER $$

CREATE TRIGGER trg_historial_estado_tarjeta
AFTER UPDATE ON tarjetas_bancarias
FOR EACH ROW
BEGIN
    IF NEW.estado_id != OLD.estado_id THEN
        INSERT INTO historial_tarjetas (tarjeta_id, evento_id, descripcion)
        VALUES (NEW.id, 1, CONCAT('Estado cambiado de ', OLD.estado_id, ' a ', NEW.estado_id));
    END IF;
END $$
DELIMITER ;


SELECT * FROM tarjetas_bancarias;
UPDATE tarjetas_bancarias SET estado_id = 4 WHERE id = 1;
SELECT * FROM historial_tarjetas;


-- 7 Validar límite crédito al crear tarjeta

DROP TRIGGER IF EXISTS trg_validar_limite_credito $$


DELIMITER $$

CREATE TRIGGER trg_validar_limite_credito
BEFORE INSERT ON tarjetas_bancarias
FOR EACH ROW
BEGIN
    IF NEW.limite_credito > 50000000 THEN
        SET NEW.limite_credito = 50000000;
    END IF;
END $$
DELIMITER ;

SELECT * FROM tarjetas_bancarias;

INSERT INTO tarjetas_bancarias (codigo_seguridad,estado_id,fecha_emision,fecha_vencimiento,limite_credito,marca_tarjeta_id,nivel_tarjeta_id,numero,tipo_tarjeta_id) VALUES 
('333',4,NOW(),'2027-12-31',60000000,1,1,'111111112',1);



-- 8 Actualizar contador de transacciones
-- este trigger era de prueba pa ver si se duplicaba una operacion se sobre escribia o se acumulaban
DROP TRIGGER IF EXISTS trg_contar_transacciones $$


DELIMITER $$

CREATE TRIGGER trg_contar_transacciones
AFTER INSERT ON transacciones
FOR EACH ROW
BEGIN
    UPDATE cuenta 
    SET transacciones_realizadas = transacciones_realizadas + 1
    WHERE id = NEW.cuenta_origen_id;
END $$
DELIMITER ;


SELECT * FROM cuenta;
INSERT INTO transacciones (cuenta_destino_id,cuenta_origen_id,cobro_operacion,descripcion,fecha_operacion,monto,referencia,tipo_transaccion_id) VALUES 
(2,1,5000.00,'Transferencia entre cuentas de yo',NOW()-INTERVAL 15 DAY,500000.00,'TRF334',9);

SELECT * FROM cuenta WHERE id = 1;

-- se acumulan y ahora suma el doble



-- 9 Calcular mora automática en cuotas


DROP TRIGGER IF EXISTS trg_calcular_mora_cuota $$


DELIMITER $$


CREATE TRIGGER trg_calcular_mora_cuota
BEFORE UPDATE ON cuotas_prestamo
FOR EACH ROW
BEGIN
    IF NEW.fecha_vencimiento < CURDATE() AND NEW.fecha_pago IS NULL THEN
        SET NEW.estado_cuota_id = 6;
    END IF;
END$$

DELIMITER ;

SELECT * FROM cuotas_prestamo;
UPDATE cuotas_prestamo SET monto_pagado = 1 WHERE id = 4;


--  10 Registrar pago en historial

DROP TRIGGER IF EXISTS trg_historial_pago $$


DELIMITER $$


CREATE TRIGGER trg_historial_pago
AFTER INSERT ON pagos
FOR EACH ROW
BEGIN
    INSERT INTO historial_de_pagos (pago_id, estado_pago_id, descripcion, metodo_pago_id)
    VALUES (NEW.id, NEW.estado_pago_id, 'Pago registrado automáticamente', 1);
END$$

DELIMITER ;

INSERT INTO pagos (cuenta_id,descripcion,estado_pago_id,fecha_pago,metodo_transaccion_id,monto,referencia,tipo_pago_id) VALUES 
(1,'Pago cuota prestamo personal mes 1',2,NOW()-INTERVAL 30 DAY,4,245000.00,'PAY444',1);



-- 11Actualizar saldo restante préstamo

DROP TRIGGER IF EXISTS trg_actualizar_saldo_prestamo $$


DELIMITER $$


CREATE TRIGGER trg_actualizar_saldo_prestamo
AFTER INSERT ON pagos_prestamo
FOR EACH ROW
BEGIN
    UPDATE prestamos
    SET saldo_restante = saldo_restante - NEW.monto_pagado
    WHERE id = (SELECT prestamo_id FROM cuotas_prestamo WHERE id = NEW.cuota_prestamo_id);
END$$

DELIMITER ;

INSERT INTO pagos_prestamo (cuota_prestamo_id,pago_id,monto_pagado,fecha_pago,metodo_pago_id,descripcion) VALUES 
(1,1,10.00,NOW()-INTERVAL 30 DAY,2,'Pago cuota 1 prestamo personal Julian');


-- 12 Bloquear eliminación de cliente con deudas

DROP TRIGGER IF EXISTS trg_validar_eliminar_cliente $$


DELIMITER $$


CREATE TRIGGER trg_validar_eliminar_cliente
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
    DECLARE valor_deudas INT DEFAULT 0;


    SELECT COUNT(*) 
    INTO valor_deudas 
    FROM prestamos p 
    JOIN cuenta c 
    ON p.cuenta_id = c.id 
    WHERE c.cliente_id = OLD.id 
    AND p.saldo_restante > 0;
    
    IF valor_deudas > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar cliente con deudas';
    END IF;
END$$

DELIMITER ;

SELECT * FROM clientes;


-- 13 Actualizar estado cuenta al cerrar

DROP TRIGGER IF EXISTS trg_cerrar_cuenta $$


DELIMITER $$


CREATE TRIGGER trg_cerrar_cuenta
BEFORE UPDATE ON cuenta
FOR EACH ROW
BEGIN
    IF NEW.fecha_cierre IS NOT NULL AND OLD.fecha_cierre IS NULL THEN
        SET NEW.estado_id = 2;
    END IF;
END$$

DELIMITER ;



-- 14 Generar cuota manejo nueva tarjeta

DROP TRIGGER IF EXISTS trg_generar_cuota_nueva_tarjeta $$


DELIMITER $$


CREATE TRIGGER trg_generar_cuota_nueva_tarjeta
AFTER INSERT ON tarjetas_bancarias
FOR EACH ROW
BEGIN
    INSERT INTO cuotas_manejo (tarjeta_id, tipo_cuota_manejo_id, monto_apertura, frecuencia_pago_id, fecha_fin)
    VALUES (NEW.id, 1, 12000.00, 4, DATE_ADD(CURDATE(), INTERVAL 1 YEAR));
END$$

DELIMITER ;



-- 15 Validar fecha vencimiento tarjeta

DROP TRIGGER IF EXISTS trg_validar_vencimiento_tarjeta $$


DELIMITER $$


CREATE TRIGGER trg_validar_vencimiento_tarjeta
BEFORE INSERT ON tarjetas_bancarias
FOR EACH ROW
BEGIN
    IF NEW.fecha_vencimiento <= CURDATE() THEN
        SET NEW.fecha_vencimiento = DATE_ADD(CURDATE(), INTERVAL 3 YEAR);
    END IF;
END$$

DELIMITER ;



-- 16 Actualizar registro préstamo al pagar
DROP TRIGGER IF EXISTS trg_actualizar_registro_prestamo $$

DELIMITER $$
CREATE TRIGGER trg_actualizar_registro_prestamo
AFTER INSERT ON pagos_prestamo
FOR EACH ROW
BEGIN
    INSERT INTO registro_prestamos (prestamo_id, ultimo_pago, fecha_ultimo_pago, ultimo_estado_id, monto_restante, tiempo_restante_meses)
    SELECT p.id, NEW.monto_pagado, NOW(), p.estado_id, p.saldo_restante, p.plazo_meses
    FROM prestamos p 
    JOIN cuotas_prestamo cp ON p.id = cp.prestamo_id
    WHERE cp.id = NEW.cuota_prestamo_id;
END $$
DELIMITER ;

-- 17 Activar tarjeta automáticamente
DROP TRIGGER IF EXISTS trg_activar_tarjeta_automatica $$

DELIMITER $$
CREATE TRIGGER trg_activar_tarjeta_automatica
BEFORE INSERT ON tarjetas_bancarias
FOR EACH ROW
BEGIN
    SET NEW.estado_id = 4;
END $$
DELIMITER ;

-- 18 Validar monto mínimo transacción
DROP TRIGGER IF EXISTS trg_validar_monto_minimo $$

DELIMITER $$
CREATE TRIGGER trg_validar_monto_minimo
BEFORE INSERT ON transacciones
FOR EACH ROW
BEGIN
    IF NEW.monto < 1000 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Monto mínimo es $1,000';
    END IF;
END $$
DELIMITER ;

-- 19 Generar extracto al hacer transacción
DROP TRIGGER IF EXISTS trg_generar_extracto $$

DELIMITER $$
CREATE TRIGGER trg_generar_extracto
AFTER INSERT ON transacciones
FOR EACH ROW
BEGIN
    INSERT INTO extracto_bancario (cuenta_id, fecha_inicial_extracto, fecha_final_extracto, monto, saldo_post_operacion, tipo_operacion_id, referencia, descripcion, metodo_transaccion_id)
    SELECT NEW.cuenta_origen_id, CURDATE(), CURDATE(), NEW.monto, 
        (SELECT saldo_disponible FROM cuenta WHERE id = NEW.cuenta_origen_id),
        9, NEW.referencia, NEW.descripcion, 1;
END $$
DELIMITER ;

-- 20 Actualizar cliente activo al crear cuenta
DROP TRIGGER IF EXISTS trg_activar_cliente $$
DELIMITER $$
CREATE TRIGGER trg_activar_cliente
AFTER INSERT ON cuenta
FOR EACH ROW
BEGIN
    UPDATE clientes 
    SET activo = TRUE 
    WHERE id = NEW.cliente_id;
END $$
DELIMITER ;
