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
