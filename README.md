# 🏦 Sistema de Cuotas de Manejo - Banco CL

## 📋 Descripción del Proyecto

Este proyecto implementa una base de datos completa para gestionar el sistema de cuotas de manejo de tarjetas bancarias del **Banco CL**. El sistema permite administrar diferentes tipos de tarjetas (Débito, Crédito, Prepago, Empresarial, Nómina, Virtual) con sus respectivos descuentos y cuotas de manejo.

### Funcionalidades Principales:
- ✅ Gestión de clientes y sus tarjetas bancarias
- ✅ Cálculo automático de cuotas de manejo con descuentos
- ✅ Registro y seguimiento de pagos
- ✅ Generación de reportes financieros
- ✅ Control de acceso por roles de usuario
- ✅ Automatización mediante triggers y eventos

---

## 🛠️ Requisitos del Sistema

- **MySQL Server 8.0** o superior
- **MySQL Workbench** (recomendado para ejecutar scripts)
- **Privilegios administrativos** para crear bases de datos y usuarios

---

## 🚀 Instalación y Configuración

### Paso 1: Crear la Base de Datos
```sql
-- Ejecutar el archivo DDL
mysql -u root -p < ddl.sql
```

### Paso 2: Cargar Datos Iniciales
```sql
-- Ejecutar el archivo DML
mysql -u root -p Banco_CL < dml.sql
```

### Paso 3: Ejecutar Componentes Adicionales
```sql
-- En MySQL Workbench, ejecutar en orden:
1. dql_funciones.sql      -- Funciones personalizadas
2. dql_procedimientos.sql -- Procedimientos almacenados
3. dql_triggers.sql       -- Triggers automáticos
4. dql_eventos.sql        -- Eventos programados
```

### Paso 4: Configurar Roles de Usuario
```sql
-- Ejecutar el script de roles y permisos incluido en ddl.sql
-- Los usuarios ya están creados con sus respectivas contraseñas
```

---

## 🗃️ Estructura de la Base de Datos

### Tablas Principales:
| Tabla | Propósito |
|-------|-----------|
| `clientes` | Información personal de los clientes |
| `cuenta` | Cuentas bancarias de los clientes |
| `tarjetas_bancarias` | Tarjetas emitidas por el banco |
| `cuotas_manejo` | Configuración de cuotas por tarjeta |
| `registro_cuota` | Facturación mensual de cuotas |
| `pagos` | Registro de pagos realizados |
| `prestamos` | Préstamos otorgados a clientes |
| `descuento` | Tipos de descuentos disponibles |

### Tablas de Catálogo:
- `tipo_cliente`, `tipo_cuenta`, `tipo_tarjetas`
- `marca_tarjeta`, `nivel_tarjeta`, `estados`
- `metodos_de_pago`, `monedas`, `frecuencias_pago`

---

## 📊 Ejemplos de Consultas

### Consultas Básicas:
```sql
-- Ver todas las tarjetas de un cliente
SELECT tb.numero, tt.nombre, tb.limite_credito 
FROM tarjetas_bancarias tb
JOIN tipo_tarjetas tt ON tb.tipo_tarjeta_id = tt.id
JOIN cuenta_tarjeta ct ON tb.id = ct.tarjeta_id
JOIN cuenta c ON ct.cuenta_id = c.id
WHERE c.cliente_id = 1;

-- Cuotas pendientes por cliente
SELECT cl.primer_nombre, SUM(rc.monto_a_pagar - rc.monto_abonado) as total_pendiente
FROM clientes cl
JOIN cuenta c ON cl.id = c.cliente_id
JOIN cuenta_tarjeta ct ON c.id = ct.cuenta_id
JOIN tarjetas_bancarias tb ON ct.tarjeta_id = tb.id
JOIN cuotas_manejo cm ON tb.id = cm.tarjeta_id
JOIN registro_cuota rc ON cm.id = rc.cuota_manejo_id
WHERE rc.estado_cuota_id = 2  -- PENDIENTE
GROUP BY cl.id, cl.primer_nombre;
```

### Consultas Avanzadas:
```sql
-- Reporte de rentabilidad por tipo de tarjeta
SELECT tt.nombre, COUNT(*) as total_tarjetas, 
       SUM(pcm.monto_pagado) as ingresos_totales
FROM tipo_tarjetas tt
JOIN tarjetas_bancarias tb ON tt.id = tb.tipo_tarjeta_id
JOIN cuotas_manejo cm ON tb.id = cm.tarjeta_id
JOIN pago_cuota_manejo pcm ON cm.id = pcm.cuota_manejo_id
GROUP BY tt.id, tt.nombre
ORDER BY ingresos_totales DESC;
```

---

## ⚙️ Procedimientos, Funciones, Triggers y Eventos

### 🔧 Funciones Disponibles:
- `fn_calcular_cuota_manejo()` - Calcula cuota según tipo de tarjeta
- `fn_saldo_pendiente_cliente()` - Obtiene saldo total adeudado
- `fn_rentabilidad_cliente()` - Calcula ingresos por cliente
- `fn_es_vip()` - Verifica si un cliente es VIP

**Ejemplo de uso:**
```sql
SELECT fn_calcular_cuota_manejo(1, 50000.00) as cuota_calculada;
```

### 📋 Procedimientos Almacenados:
- `sp_registrar_pago_cuota()` - Registra pago de cuota de manejo
- `sp_generar_cuotas_mensuales()` - Genera facturación mensual
- `sp_actualizar_estados_vencidos()` - Actualiza cuotas vencidas

### 🎯 Triggers Automáticos:
- `trg_actualizar_saldo_transaccion` - Actualiza saldo al hacer transacciones
- `trg_generar_cuota_nueva_tarjeta` - Crea cuota al emitir tarjeta nueva
- `trg_historial_pago` - Registra historial de pagos automáticamente

### ⏰ Eventos Programados:
- `evt_actualizar_estados_diario` - Actualiza estados vencidos diariamente
- `evt_generar_cuotas_mensuales` - Genera facturación automática mensual
- `evt_reporte_mensual_cuotas` - Crea reportes automáticos

---

## 👥 Roles de Usuario y Permisos

| Rol | Usuario | Contraseña | Permisos |
|-----|---------|------------|----------|
| **Administrador** | `admin_sistema` | `Admin2024!@` | Acceso completo al sistema |
| **Operador de Pagos** | `operador_juan` | `OpPagos2024!` | Gestión de pagos únicamente |
| **Gerente** | `gerente_maria` | `Gerente2024!` | Reportes y análisis financiero |
| **Consultor** | `consultor_pedro` | `Consultor2024!` | Solo consulta de tarjetas |
| **Auditor** | `auditor_ana` | `Auditor2024!` | Solo lectura de reportes |

### Crear Usuarios Adicionales:
```sql
-- Ejemplo para crear un nuevo operador
CREATE USER 'nuevo_operador'@'%' IDENTIFIED BY 'Password2024!';
GRANT 'operador_pagos'@'%' TO 'nuevo_operador'@'%';
SET DEFAULT ROLE 'operador_pagos'@'%' TO 'nuevo_operador'@'%';
```

---

## 📁 Estructura de Archivos

```
📦 banco-cl-database/
├── 📄 ddl.sql                 # Creación de tablas y estructura
├── 📄 dml.sql                 # Datos de prueba
├── 📄 dql_select.sql          # Consultas SELECT
├── 📄 dql_procedimientos.sql  # Procedimientos almacenados
├── 📄 dql_funciones.sql       # Funciones personalizadas
├── 📄 dql_triggers.sql        # Triggers automáticos
├── 📄 dql_eventos.sql         # Eventos programados
├── 📄 README.md               # Este archivo
└── 📄 Diagrama.jpg            # Modelo de datos
```

---

## 🎯 Casos de Uso Comunes

### Para Operadores de Pago:
```sql
-- Registrar pago de cuota
CALL sp_registrar_pago_cuota(1, 25000.00, 'Pago cuota enero', 2);

-- Ver pagos pendientes
SELECT * FROM vista_operador_pagos WHERE estado_pago = 'PENDIENTE';
```

### Para Gerentes:
```sql
-- Dashboard ejecutivo
SELECT * FROM vista_gerente_dashboard WHERE año = 2024;

-- Análisis de rentabilidad
SELECT fn_rentabilidad_cliente(10, '2024-01-01', '2024-12-31');
```

### Para Consultores:
```sql
-- Información completa de tarjeta
SELECT * FROM vista_consultor_tarjetas WHERE numero_tarjeta = '4532123456789012';

-- Calcular cuota para cliente
SELECT fn_calcular_cuota_manejo(5, 30000.00);
```

---

## 📞 Soporte y Contacto

- **Proyecto:** Sistema de Cuotas de Manejo - Banco CL
- **Versión:** 1.0
- **Fecha:** 2024

### Notas Importantes:
- ⚠️ **Seguridad:** Cambiar contraseñas por defecto en producción
- 🔄 **Eventos:** Los eventos están programados para ejecutarse automáticamente
- 💾 **Respaldos:** Crear respaldos regulares de la base de datos
- 📊 **Monitoreo:** Revisar logs de eventos y triggers periódicamente

---

## 📝 Licencia

Este proyecto es desarrollado con fines educativos para el curso de bases de datos.

---

**¡Listo para usar! 🚀**