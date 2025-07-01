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