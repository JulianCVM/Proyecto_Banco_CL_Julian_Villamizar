-- LISTADO DE SELECTS:


-- 1
SELECT 
        tb.tipo_tarjeta_id,
        tb.nivel_tarjeta_id,
        c.tipo_cliente_id
    FROM tarjetas_bancarias tb
    JOIN cuenta_tarjeta ct ON tb.id = ct.tarjeta_id
    JOIN cuenta cu ON ct.cuenta_id = cu.id
    JOIN clientes c ON cu.cliente_id = c.id
    WHERE tb.id = 1
    LIMIT 1;



-- 2

SELECT valor, tipo_valor 
    FROM descuento 
    WHERE id = 1 AND activo = TRUE;


-- 3
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

-- 4
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


-- 5
SELECT tarjeta_id, monto_apertura, 1
    FROM cuotas_manejo
    WHERE id = 1
    AND activo = TRUE;


-- 6
SELECT 1 FROM descuentos_aplicados 
            WHERE tarjeta_id = 1
            AND DATE(fecha_aplicado) = CURDATE()


-- 7
SELECT 
    da.id,
    tb.numero AS tarjeta,
    da.monto_inicial,
    da.descuento_aplicado,
    da.monto_con_descuento,
    da.fecha_aplicado,
    CONCAT(c.primer_nombre, ' ', c.primer_apellido) AS cliente
FROM descuentos_aplicados da
JOIN tarjetas_bancarias tb ON da.tarjeta_id = tb.id
JOIN cuenta_tarjeta ct ON tb.id = ct.tarjeta_id
JOIN cuenta cu ON ct.cuenta_id = cu.id
JOIN clientes c ON cu.cliente_id = c.id
WHERE da.descuento_id = 1 -- Solo descuentos por uso (fijos)
ORDER BY da.fecha_aplicado DESC
LIMIT 5;



-- 8

SELECT *
        FROM cuotas_manejo
        WHERE tarjeta_id = 1;


-- 9

SELECT COALESCE(SUM(monto),0)
    FROM pagos
    WHERE cuenta_id = 1;



-- 10
SELECT COUNT(cuenta_origen_id) AS cantidad_transacciones 
    FROM transacciones 
    WHERE cuenta_origen_id = 1;


-- 11
SELECT saldo_disponible, id AS cuenta_id
FROM cuenta
WHERE cliente_id = 1;


-- 12
SELECT *
FROM tarjetas_bancarias
LEFT JOIN cuenta_tarjeta ON tarjetas_bancarias.id = cuenta_tarjeta.tarjeta_id
LEFT JOIN cuenta ON cuenta_tarjeta.cuenta_id = cuenta.id
WHERE tarjetas_bancarias.estado_id = 4
    AND (cuenta.cliente_id = 1);


-- 13
SELECT * FROM cuotas_manejo WHERE YEAR('2024-01-01') >= 2024 AND MONTH('2024-12-01') >= 5;



-- 14
SELECT
        COALESCE(
            CAST(SUBSTRING(referencia, LENGTH('PAY')+1) + 0 AS UNSIGNED),
            0
        )
    FROM pagos
    WHERE LEFT(referencia, LENGTH('PAY')) = 'PAY'
    ORDER BY id DESC
    LIMIT 1;


-- 15
SELECT COALESCE(SUM(monto_pagado),0)
    FROM pago_cuota_manejo
    WHERE cuota_manejo_id = 1;


-- 16
    SELECT 1, 1, CONCAT('Reporte mensual generado: ', CURDATE()), 1;


-- 17

SELECT valor 
    FROM descuento
    WHERE tipo_valor = 'PORCENTAJE';


-- 18
SELECT * FROM pago_cuota_manejo WHERE cuota_manejo_id = 1;




-- 19

SELECT * FROM registro_cuota WHERE cuota_manejo_id = 1 LIMIT 1;


-- 20

SELECT SUM(monto_abonado)
    FROM registro_cuota
    WHERE cuota_manejo_id = 1;
-- 21

SELECT monto_a_pagar 
    FROM registro_cuota
    WHERE cuota_manejo_id = 1 LIMIT 1;
-- 22

SELECT IFNULL(SUM(pcm.monto_pagado), 0.00)
        FROM tarjetas_bancarias tb
        JOIN cuotas_manejo cm ON tb.id = cm.tarjeta_id
        JOIN pago_cuota_manejo pcm ON cm.id = pcm.cuota_manejo_id
        JOIN pagos p ON pcm.pago_id = p.id
        WHERE tb.id = 1
        AND p.estado_pago_id = 2  
        AND (DATE(p.fecha_pago) >= '2024-01-01')
        AND (DATE(p.fecha_pago) <= '2027-01-01');
-- 23
-- 24
-- 25
-- 26
-- 27
-- 28
-- 29
-- 30
-- 31
-- 32
-- 33
-- 34
-- 35
-- 36
-- 37
-- 38
-- 39
-- 40
-- 41
-- 42
-- 43
-- 44
-- 45
-- 46
-- 47
-- 48
-- 49
-- 50
-- 50
-- 51
-- 52
-- 53
-- 54
-- 55
-- 56
-- 57
-- 58
-- 59
-- 60
-- 61
-- 62
-- 63
-- 64
-- 65
-- 66
-- 67
-- 68
-- 69
-- 70
-- 70
-- 71
-- 72
-- 73
-- 74
-- 75
-- 76
-- 77
-- 78
-- 79
-- 80
-- 81
-- 82
-- 83
-- 84
-- 85
-- 86
-- 87
-- 88
-- 89
-- 90
-- 91
-- 92
-- 93
-- 94
-- 95
-- 96
-- 97
-- 98
-- 99
