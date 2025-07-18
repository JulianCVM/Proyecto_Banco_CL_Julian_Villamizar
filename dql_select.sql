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

SELECT IFNULL(SUM(rc.monto_facturado), 0.00)
    FROM registro_cuota rc
    WHERE YEAR(rc.fecha_corte) = 2024
    AND MONTH(rc.fecha_corte) = 6;
-- 24
SELECT
        COUNT(CASE WHEN cp.estado_cuota_id = 6 THEN 1 END),
        COUNT (*)
    FROM cuotas_prestamo cp
    JOIN prestamos pr ON cp.prestamo_id = pr.id
    JOIN cuenta c ON pr.cuenta_id = c.id
    WHERE c.cliente_id = 1;
-- 25

SELECT pr.monto_aprobado, i.valor, DATEDIFF('2024-01-01', DATE(pr.fecha_desembolso))
    FROM prestamos pr
    JOIN interes i ON pr.interes_id = i.id
    WHERE pr.id = 1
    AND pr.fecha_desembolso IS NOT NULL;
-- 26

SELECT COUNT(*) 
    FROM transacciones t
    WHERE (t.cuenta_origen_id = 2 OR t.cuenta_destino_id = 2)
    AND t.fecha_operacion >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);
-- 27
SELECT IFNULL(SUM(cobro_operacion), 0.00) FROM transacciones WHERE cuenta_origen_id = 1;

-- 28

SELECT DATEDIFF(fecha_vencimiento, CURDATE())
FROM tarjetas_bancarias
WHERE id = 1;
-- 29

    SELECT limite_credito  
    FROM tarjetas_bancarias
    WHERE id = 1;
-- 30

SELECT monto_aprobado - saldo_restante
FROM cuenta c 
JOIN prestamos p ON c.id = p.cuenta_id
WHERE c.id = 1
AND p.id = 1;
-- 31

SELECT IFNULL(SUM(monto), 0.00) *0.20
FROM pagos p
JOIN cuenta c ON p.cuenta_id = c.tipo_cuenta_id
WHERE c.cliente_id = 1
AND p.estado_pago_id = 2;
-- 32

SELECT tc.nombre
FROM clientes c
JOIN tipo_cliente tc
ON c.tipo_cliente_id = tc.id
GROUP BY tc.nombre
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 33
SELECT COUNT(*) 
    FROM cuenta 
    WHERE cliente_id = 1;
-- 34

SELECT TIMESTAMPDIFF(MONTH, fecha_apertura, CURDATE()) 
    FROM cuenta 
    WHERE id = 1;
-- 35

SELECT COUNT(*) 
    FROM prestamos p
    JOIN cuenta c ON p.cuenta_id = c.id
    WHERE c.cliente_id = 1
    AND p.saldo_restante > 0;
-- 36
SELECT * FROM clientes;
-- 37
SELECT * FROM cuenta;
-- 38
SELECT * FROM cuenta_tarjeta;

-- 39
SELECT * FROM cuotas_manejo;
-- 40
SELECT * FROM cuotas_prestamo;
-- 41
SELECT * FROM descuento;
-- 42
SELECT * FROM descuentos_aplicados;
-- 43
SELECT * FROM estados;
-- 44
SELECT * FROM estados_cuota;
-- 45
SELECT * FROM estados_pago;
-- 46
SELECT * FROM eventos_tarjeta;
-- 47
SELECT * FROM extracto_bancario;
-- 48
SELECT * FROM frecuencias_pago;
-- 49
SELECT * FROM historial_de_pagos;
-- 50
SELECT * FROM historial_tarjetas;
-- 51
SELECT * FROM interes;
-- 52
SELECT * FROM marca_tarjeta;
-- 53
SELECT * FROM metodos_de_pago;
-- 54
SELECT * FROM metodos_de_pago_cuenta;
-- 55
SELECT * FROM metodos_transaccion;
-- 56
SELECT * FROM monedas;
-- 57
SELECT * FROM nivel_tarjeta;
-- 58
SELECT * FROM pago_cuota_manejo;
-- 59
SELECT * FROM pagos;
-- 60
SELECT * FROM pagos_prestamo;
-- 61
SELECT * FROM prestamos;
-- 62
SELECT * FROM registro_cuota;
-- 63
SELECT * FROM registro_prestamos;
-- 64
SELECT * FROM tarjetas_bancarias;
-- 65
SELECT * FROM tipo_cliente;
-- 66
SELECT * FROM tipo_cuenta;
-- 67
SELECT * FROM tipo_cuota_de_manejo;
-- 68
SELECT * FROM tipo_nit;
-- 69
SELECT * FROM tipo_prestamo;
-- 70
SELECT * FROM tipo_tarjetas;
-- 71
SELECT * FROM tipos_operacion;
-- 72
SELECT * FROM tipos_pago;
-- 73
SELECT * FROM tipos_transaccion;
-- 74
SELECT * FROM transacciones;
-- 75
SELECT * FROM clientes JOIN cuenta ON clientes.id = cuenta.cliente_id;
-- 76
SELECT * FROM clientes JOIN tipo_cliente ON clientes.tipo_cliente_id = tipo_cliente.id;

-- 77
SELECT * FROM clientes JOIN tipo_nit ON clientes.tipo_nit_id = tipo_nit.id;

-- 78
SELECT * FROM cuenta JOIN tipo_cuenta ON cuenta.tipo_cuenta_id = tipo_cuenta.id;

-- 79
SELECT * FROM cuenta JOIN monedas ON cuenta.moneda_id = monedas.id;

-- 80
SELECT * FROM cuenta JOIN extracto_bancario ON cuenta.id = extracto_bancario.cuenta_id;

-- 81
SELECT * FROM cuenta JOIN transacciones ON cuenta.id = transacciones.cuenta_origen_id;

-- 82
SELECT * FROM cuenta JOIN transacciones ON cuenta.id = transacciones.cuenta_destino_id;

-- 83
SELECT * FROM cuenta JOIN prestamos ON cuenta.id = prestamos.cuenta_id;

-- 84
SELECT * FROM cuenta JOIN pagos ON cuenta.id = pagos.cuenta_id;

-- 85
SELECT * FROM cuenta JOIN cuenta_tarjeta ON cuenta.id = cuenta_tarjeta.cuenta_id;

-- 86
SELECT * FROM tarjetas_bancarias JOIN tipo_tarjetas ON tarjetas_bancarias.tipo_tarjeta_id = tipo_tarjetas.id;

-- 87
SELECT * FROM tarjetas_bancarias JOIN marca_tarjeta ON tarjetas_bancarias.marca_tarjeta_id = marca_tarjeta.id;

-- 88
SELECT * FROM tarjetas_bancarias JOIN cuenta_tarjeta ON cuenta_tarjeta.tarjeta_id = tarjetas_bancarias.id;

-- 89
SELECT * FROM tarjetas_bancarias JOIN nivel_tarjeta ON nivel_tarjeta.id = tarjetas_bancarias.nivel_tarjeta_id;

-- 90 Obtener el listado de todas las tarjetas de los clientes junto con su cuota de manejo.
SELECT * FROM tarjetas_bancarias 
JOIN cuotas_manejo ON tarjetas_bancarias.id = cuotas_manejo.tarjeta_id
JOIN cuenta_tarjeta ON cuenta_tarjeta.tarjeta_id = tarjetas_bancarias.id
JOIN cuenta ON cuenta.id = cuenta_tarjeta.cuenta_id
JOIN clientes ON clientes.id = cuenta.cliente_id;
-- 91 Consultar el historial de pagos de un cliente específico.
SELECT * FROM historial_de_pagos 
JOIN pagos ON pagos.id = historial_de_pagos.pago_id
WHERE pagos.cuenta_id = 1;
-- 92 Obtener el total de cuotas de manejo pagadas durante un mes determinado.
SELECT * FROM cuotas_manejo WHERE fecha_inicio < NOW();
-- 93 Consultar las cuotas de manejo de los clientes con descuento aplicado.
SELECT * FROM cuotas_manejo
JOIN tarjetas_bancarias ON cuotas_manejo.tarjeta_id = tarjetas_bancarias.id
JOIN descuentos_aplicados ON tarjetas_bancarias.id = descuentos_aplicados.tarjeta_id
JOIN cuenta_tarjeta ON cuenta_tarjeta.tarjeta_id = tarjetas_bancarias.id
JOIN cuenta ON cuenta.id = cuenta_tarjeta.cuenta_id
JOIN clientes ON clientes.id = cuenta.cliente_id;
-- 94 Obtener un reporte mensual de las cuotas de manejo de cada tarjeta.
SELECT *
FROM tarjetas_bancarias
JOIN tipo_tarjetas ON tarjetas_bancarias.tipo_tarjeta_id = tipo_tarjetas.id
JOIN marca_tarjeta ON tarjetas_bancarias.marca_tarjeta_id = marca_tarjeta.id
JOIN nivel_tarjeta ON tarjetas_bancarias.nivel_tarjeta_id = nivel_tarjeta.id
JOIN cuotas_manejo ON tarjetas_bancarias.id = cuotas_manejo.tarjeta_id
JOIN registro_cuota ON cuotas_manejo.id = registro_cuota.cuota_manejo_id
JOIN estados_cuota ON registro_cuota.estado_cuota_id = estados_cuota.id
JOIN cuenta_tarjeta ON tarjetas_bancarias.id = cuenta_tarjeta.tarjeta_id
JOIN cuenta ON cuenta_tarjeta.cuenta_id = cuenta.id
JOIN clientes ON cuenta.cliente_id = clientes.id
WHERE YEAR(registro_cuota.fecha_corte) = YEAR(NOW())
AND MONTH(registro_cuota.fecha_corte) = MONTH(NOW())
ORDER BY tipo_tarjetas.nombre, tarjetas_bancarias.numero;
-- 95 Obtener los clientes con pagos pendientes durante los últimos tres meses.
SELECT DISTINCT
    *
FROM clientes 
JOIN tipo_cliente  ON clientes.tipo_cliente_id = tipo_cliente.id
JOIN cuenta  ON clientes.id = cuenta.cliente_id
JOIN cuenta_tarjeta  ON cuenta.id = cuenta_tarjeta.cuenta_id
JOIN tarjetas_bancarias  ON cuenta_tarjeta.tarjeta_id = tarjetas_bancarias.id
JOIN cuotas_manejo  ON tarjetas_bancarias.id = cuotas_manejo.tarjeta_id
JOIN registro_cuota ON cuotas_manejo.id = registro_cuota.cuota_manejo_id
WHERE registro_cuota.fecha_corte >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
AND (registro_cuota.monto_a_pagar - registro_cuota.monto_abonado) > 0  
AND registro_cuota.estado_cuota_id IN (2, 5)
GROUP BY clientes.id, clientes.nit, clientes.primer_nombre, clientes.primer_apellido, clientes.email, clientes.num_contacto, tipo_cliente.nombre;
-- 96 Consultar las cuotas de manejo aplicadas a cada tipo de tarjeta en un período específico.
SELECT 
    *
FROM tipo_tarjetas
JOIN tarjetas_bancarias  ON tipo_tarjetas.id = tarjetas_bancarias.tipo_tarjeta_id
JOIN cuotas_manejo ON tarjetas_bancarias.id = cuotas_manejo.tarjeta_id
JOIN registro_cuota  ON cuotas_manejo.id = registro_cuota.cuota_manejo_id
WHERE registro_cuota.fecha_corte BETWEEN '2024-01-01' AND '2025-12-31'
GROUP BY tipo_tarjetas.id, tipo_tarjetas.codigo, tipo_tarjetas.nombre, tipo_tarjetas.descripcion;
-- 97 Generar un reporte con los descuentos aplicados durante un año.
SELECT 
    *
FROM descuento 
LEFT JOIN descuentos_aplicados  ON descuento.id = descuentos_aplicados.descuento_id
    AND YEAR(descuentos_aplicados.fecha_aplicado) = 2024 
LEFT JOIN tarjetas_bancarias  ON descuentos_aplicados.tarjeta_id = tarjetas_bancarias.id
LEFT JOIN tipo_tarjetas  ON tarjetas_bancarias.tipo_tarjeta_id = tipo_tarjetas.id
WHERE descuento.activo = TRUE
GROUP BY descuento.id, descuento.codigo, descuento.nombre, descuento.descripcion, descuento.tipo_valor, descuento.valor;
-- 98 Consultar las tarjetas con el mayor y menor monto de apertura.
SELECT 
    *
FROM cuotas_manejo 
JOIN tarjetas_bancarias ON cuotas_manejo.tarjeta_id = tarjetas_bancarias.id
JOIN tipo_tarjetas  ON tarjetas_bancarias.tipo_tarjeta_id = tipo_tarjetas.id
JOIN marca_tarjeta  ON tarjetas_bancarias.marca_tarjeta_id = marca_tarjeta.id
JOIN nivel_tarjeta  ON tarjetas_bancarias.nivel_tarjeta_id = nivel_tarjeta.id
JOIN estados  ON tarjetas_bancarias.estado_id = estados.id
JOIN cuenta_tarjeta  ON tarjetas_bancarias.id = cuenta_tarjeta.tarjeta_id
JOIN cuenta  ON cuenta_tarjeta.cuenta_id = cuenta.id
JOIN clientes  ON cuenta.cliente_id = clientes.id
ORDER BY cuotas_manejo.monto_apertura;
-- 99 Generar un reporte que muestre el total de pagos realizados por tipo de tarjeta.
SELECT 
    tipo_tarjetas.codigo AS codigo_tipo,
    tipo_tarjetas.nombre AS tipo_tarjeta,
    tipo_tarjetas.descripcion,
    COUNT(DISTINCT pago_cuota_manejo.id) AS total_pagos_cuotas_manejo,
    COUNT(DISTINCT CASE WHEN pagos.tipo_pago_id = 3 THEN pagos.id END) AS total_pagos_credito,
    (COUNT(DISTINCT pago_cuota_manejo.id) + COUNT(DISTINCT CASE WHEN pagos.tipo_pago_id = 3 THEN pagos.id END)) AS total_pagos_general,
    (COALESCE(SUM(pago_cuota_manejo.monto_pagado), 0) + 
    COALESCE(SUM(CASE WHEN pagos.tipo_pago_id = 3 THEN pagos.monto END), 0)) AS monto_total_general,
    COUNT(DISTINCT clientes.id) AS clientes_que_pagaron,
    MIN(pago_cuota_manejo.fecha_pago) AS primer_pago_registrado,
    MAX(pago_cuota_manejo.fecha_pago) AS ultimo_pago_registrado
FROM tipo_tarjetas 
LEFT JOIN tarjetas_bancarias  ON tipo_tarjetas.id = tarjetas_bancarias.tipo_tarjeta_id
LEFT JOIN cuotas_manejo  ON tarjetas_bancarias.id = cuotas_manejo.tarjeta_id
LEFT JOIN pago_cuota_manejo  ON cuotas_manejo.id = pago_cuota_manejo.cuota_manejo_id
LEFT JOIN cuenta_tarjeta  ON tarjetas_bancarias.id = cuenta_tarjeta.tarjeta_id
LEFT JOIN cuenta  ON cuenta_tarjeta.cuenta_id = cuenta.id
LEFT JOIN pagos  ON cuenta.id = pagos.cuenta_id AND pagos.estado_pago_id = 2
LEFT JOIN clientes  ON cuenta.cliente_id = clientes.id
WHERE tipo_tarjetas.activo = TRUE
GROUP BY tipo_tarjetas.id, tipo_tarjetas.codigo, tipo_tarjetas.nombre, tipo_tarjetas.descripcion;


-- 100
SELECT * FROM estados JOIN registro_prestamos ON estados.id = registro_prestamos.ultimo_estado_id;