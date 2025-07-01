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

DELOIMITER $$

CREATE TRIGGER 
AFTER UPDATE ON cuotas_manejo
FOR EACH ROW
BEGIN

    IF NEW.monto_apertura !+ OLD.monto_apertura THEN
        UPDATE registro_cuota
        SET monto_facturado = NEW.monto_apertura * 0.01
        WHERE cuota_manejo_id = NEW.id;
    END IF;

END $$

DELIMITER ;