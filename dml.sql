-- =============================================
-- INSERTS COMPLETOS - SISTEMA BANCARIO
-- =============================================

-- Datos ya proporcionados por el usuario (mantener igual)
INSERT INTO tipo_cliente (activo,codigo,descripcion,nombre) VALUES
(TRUE, 'REG', 'Cliente regular, no tiene beneficios especiales.', 'REGULAR'),
(TRUE, 'EST', 'Cliente estandar, tiene beneficios basicos.', 'ESTANDAR'),
(TRUE, 'PREF', 'Cliente preferencial, tiene beneficios preferenciales.', 'PREFERENCIAL'),
(TRUE, 'VIP', 'Cliente regular, tiene beneficios especiales y atencion personalizada.', 'VIP');

INSERT INTO tipo_cuenta (activo,codigo,descripcion,nombre) VALUES
(TRUE,'AHO','Cuenta de ahorros para personas naturales.','AHORRO'),
(TRUE,'COR','Cuenta corriente con sobregiro autorizado.','CORRIENTE'),
(TRUE,'NOM','Cuenta para recepcion de salario.','NOMINA'),
(TRUE,'PF','Cuenta de plazo fijo con rentabilidad garantizada :D.','PLAZO FIJO'),
(TRUE,'JUV','Cuenta para menores de edad y jovenes.','JUVENIL'),
(TRUE,'EMP','Cuenta para empresas y personas juridicas.','EMPRESARIAL'),
(TRUE,'DIV','Cuenta en moneda extranjera.','DIVISA EXTRANJERA'),
(TRUE,'DIG','Cuenta 101% digital sin papeleria.','DIGITAL');

INSERT INTO tipo_tarjetas (activo,codigo,descripcion,nombre) VALUES
(TRUE,'DEB','Tarjeta de debito','DEBITO'),
(TRUE,'CRE','Tarjeta de credito','CREDITO'),
(TRUE,'PRE','Tarjeta prepago','PREPAGO'),
(TRUE,'EMP','Tarjeta empresarial','EMPRESARIAL'),
(TRUE,'NOM','Tarjeta de nomina','NOMINA'),
(TRUE,'VIR','Tarjeta virtual','VIRTUAL');

INSERT INTO marca_tarjeta (activo,codigo,descripcion,nombre) VALUES
(TRUE,'VIS','Tarjeta de la red Visa International','VISA'),
(TRUE,'MAS','Tarjeta de la red Mastercard','MASTERCARD'),
(TRUE,'AMX','Tarjeta de la red AMERICAN EXPRESOOO','AMERICAN EXPRESS'),
(TRUE,'DIN','Tarjeta de la red Diners Club International','DINERS CLUB'),
(TRUE,'DIS','Tarjeta de la red Discover','DISCOVER'),
(TRUE,'UNI','Tarjeta de la red UNION PLAY CHI-CHI-CHI LE-LE-LE','UNION PAY'),
(TRUE,'SER','Tarjeta de la red Nacion Servibanca','SERVIBANCA'),
(TRUE,'CRB','Tarjeta de la red Credibanco','CREDIBANCO');

INSERT INTO nivel_tarjeta (activo,codigo,descripcion,nombre) VALUES
(TRUE,'CLA','Tarjeta de nivel basico con beneficios estandares','CLASICA'),
(TRUE,'GOL','Tarjeta dorada con beneficios mejorados','GOLD'),
(TRUE,'PLA','Tarjeta platino con beneficios premiun exclusivos','PLATINO'),
(TRUE,'BLA','Tarjeta negra para segmento totalmente exclusivo','BLACK'),
(TRUE,'SIG','Tarjeta signature con servicios de lujooo','SIGNATURE'),
(TRUE,'INF','Tarjeta infinite sin LIMITES!','INFINITE'),
(TRUE,'EMP','Tarjeta especial para empresas','EMPRESARIAL');

INSERT INTO tipo_prestamo (activo,codigo,descripcion,nombre) VALUES
(TRUE,'PER','Prestamo personal de libre destinacion','PERSONAL'),
(TRUE,'HIP','Prestamo para compra de vivienda','HIPOTECARIO'),
(TRUE,'AUT','Prestamo para compra de vehiculos','AUTOMOTRIZ'),
(TRUE,'EST','Prestamo para financiar estudios','ESTUDIANTIL'),
(TRUE,'LCR','Prestamo para lineas de credito rotativas','LINEA DE CREDITO'),
(TRUE,'COM','Prestamo para actividades del comercio/comerciales','COMERCIAL'),
(TRUE,'LIB','Prestamo de libre inversion','LIBRE INVERSION'),
(TRUE,'ROT','Prestamo para creditos rotativos con cupos disponibles','CREDITO ROTATIVO'),
(TRUE,'PRE','Prestamo con garantia prendaria','PRENDARIO');

INSERT INTO tipo_cuota_de_manejo (activo,codigo,descripcion,nombre) VALUES
(TRUE,'PER','Cuota de manejo cobrada periodicamente','PERIODICA'),
(TRUE,'PRO','Cuota basada en el tipo de producto','TIPO PRODUCTO'),
(TRUE,'CLI','Cuota segun perfil del cliente','PERFIL CLIENTE'),
(TRUE,'EXO','Cliente exonerado de cuota de manejo','EXONERADA');

INSERT INTO tipo_nit (activo,codigo,descripcion,nombre) VALUES
(TRUE,'GC','Grandes contribuyentes segun la DIAN','GRAN CONTRIBUYENTE'),
(TRUE,'RC','Regimen comun de IVA','REGIMEN COMUN'),
(TRUE,'RS','Regimen simple de tributacion','REGIMEN SIMPLE'),
(TRUE,'RE','Regimen especial de IVA','REGIMEN ESPECIAL'),
(TRUE,'RSI','Regimen simplificado','REGIMEN SIMPLIFICADO'),
(TRUE,'NRI','No responsable de IVA','NO RESPONSABLE DE IVA'),
(TRUE,'RIV','Responsable de IVA','RESPONSABLE DE IVA'),
(TRUE,'AUT','Agente autorretenedor','AUTORRETENEDOR'),
(TRUE,'EXT','Entidad del exterior','ENTIDAD EXTRANJERA'),
(TRUE,'SC','Sin clasificacion tributaria','SIN CLASIFICAR');

INSERT INTO metodos_de_pago (activo,codigo,descripcion,nombre) VALUES
(TRUE, 'EFE','Pago en efectivo','EFECTIVO'),
(TRUE, 'TRB','Transferencia entre cuentas','TRANSFERENCIA BANCARIA'),
(TRUE, 'DBA','Debito automatico de cuenta','DEBITO AUTOMATICO'),
(TRUE, 'TCR','Pago con tarjeta de credito','TARJETA CREDITO'),
(TRUE, 'TDE','Pago con tarjeta de debito','TARJETA DEBITO'),
(TRUE, 'CHE','Pago con cheque','CHEQUE'),
(TRUE, 'BID','Billetera digital/movil','BILLETERA DIGITAL'),
(TRUE, 'POL','Pago en linea/internet','PAGO EN LINEA'),
(TRUE, 'CON','Consignacion bancaria','CONSIGNACION'),
(TRUE, 'DNO','Descuento por nomina','DESCUENTO NOMINA'),
(TRUE, 'PMO','Pago movil','PAGO MOVIL'),
(TRUE, 'CCO','Debito a cuenta corriente','CUENTA CORRIENTE'),
(TRUE, 'CAH','Debito a cuenta de ahorros','CUENTA AHORRO'),
(TRUE, 'PSE','Pagos seguros en linea','PSE'),
(TRUE, 'OTR','Otro metodo de pago','OTRO');


INSERT INTO monedas (activo,codigo,descripcion,nombre,simbolo) VALUES 
(TRUE,'COP','Moneda oficial de Colombia','Peso Colombiano','$'),
(TRUE,'USD','Moneda de Estados Unidos','Dolar Estadounidense','$'),
(TRUE,'EUR','Moneda oficial de la Eurozona','Euro','€'),
(TRUE,'GBP','Moneda del Reino Unido','Libra Esterlina','£'),
(TRUE,'JPY','Moneda oficial de Japon','Yen Japones','¥'),
(TRUE,'CNY','Moneda oficial de China','Yuan Chino','¥'),
(TRUE,'CHF','Moneda de Suiza','Franco Suizo','Fr'),
(TRUE,'CAD','Moneda de Canada','Dolar Canadiense','$'),
(TRUE,'AUD','Moneda de Australia','Dolar Australiano','$'),
(TRUE,'BRL','Moneda oficial de Brasil','Real Brasileno','R$'),
(TRUE,'MXN','Moneda oficial de Mexico','Peso Mexicano','$'),
(TRUE,'CLP','Moneda oficial de Chile','Peso Chileno','$'),
(TRUE,'PEN','Moneda oficial de Peru','Sol Peruano','S/'),
(TRUE,'ARS','Moneda oficial de Argentina','Peso Argentino','$'),
(TRUE,'VES','Moneda oficial de Venezuela','Bolivar Venezolano','Bs'),
(TRUE,'INR','Moneda oficial de India','Rupia India','₹');



INSERT INTO estados (activo,codigo,contexto,descripcion,nombre) VALUES 
(TRUE,'CTA_ACT','CUENTA','Cuenta activa y operativa','ACTIVA'),
(TRUE,'CTA_CER','CUENTA','Cuenta cerrada definitivamente','CERRADA'),
(TRUE,'CTA_BLO','CUENTA','Cuenta bloqueada temporalmente','BLOQUEADA'),
(TRUE,'TAR_ACT','TARJETA','Tarjeta activa para uso','ACTIVA'),
(TRUE,'TAR_CER','TARJETA','Tarjeta cerrada','CERRADA'),
(TRUE,'TAR_BLO','TARJETA','Tarjeta bloqueada','BLOQUEADA'),
(TRUE,'TAR_VEN','TARJETA','Tarjeta vencida','VENCIDA'),
(TRUE,'PRE_SOL','PRESTAMO','Prestamo solicitado','SOLICITADO'),
(TRUE,'PRE_EVA','PRESTAMO','En proceso de evaluacion','EN EVALUACION'),
(TRUE,'PRE_APR','PRESTAMO','Prestamo aprobado','APROBADO'),
(TRUE,'PRE_DES','PRESTAMO','Prestamo desembolsado','DESEMBOLSADO'),
(TRUE,'PRE_CUR','PRESTAMO','Prestamo en curso de pago','EN CURSO'),
(TRUE,'PRE_MOR','PRESTAMO','Prestamo en mora','EN MORA'),
(TRUE,'PRE_REE','PRESTAMO','Prestamo reestructurado','REESTRUCTURADO'),
(TRUE,'PRE_CAS','PRESTAMO','Prestamo castigado','CASTIGADO'),
(TRUE,'PRE_PAG','PRESTAMO','Prestamo totalmente pagado','PAGADO'),
(TRUE,'PRE_CAN','PRESTAMO','Prestamo cancelado','CANCELADO');

INSERT INTO frecuencias_pago (activo,codigo,descripcion,dias_frecuencia,nombre) VALUES
(TRUE,'DIA','Pago diario',1,'DIARIO'),
(TRUE,'SEM','Pago semanal',7,'SEMANAL'),
(TRUE,'QUI','Pago quincenal',15,'QUINCENAL'),
(TRUE,'MEN','Pago mensual',30,'MENSUAL'),
(TRUE,'BIM','Pago cada dos meses',60,'BIMESTRAL'),
(TRUE,'TRI','Pago trimestral',90,'TRIMESTRAL'),
(TRUE,'CUA','Pago cuatrimestral',120,'CUATRIMESTRAL'),
(TRUE,'SEM_A','Pago semestral',180,'SEMESTRAL'),
(TRUE,'ANU','Pago anual',365,'ANUAL'),
(TRUE,'UNI','Pago unico',0,'UNICO'),
(TRUE,'OTR','Otra frecuencia especifica',0,'OTRO');



INSERT INTO tipos_operacion (activo,codigo,descripcion,nombre,tipo_movimiento) VALUES
(TRUE,'DEP_EFE','Deposito en efectivo','DEPOSITO EFECTIVO','CREDITO'),
(TRUE,'TRA_REC','Transferencia recibida','TRANSFERENCIA RECIBIDA','CREDITO'),
(TRUE,'PAG_NOM','Pago de nomina','PAGO NOMINA','CREDITO'),
(TRUE,'INT_GAN','Intereses ganados','INTERESES GANADOS','CREDITO'),
(TRUE,'DEV_COM','Devolucion de compra','DEVOLUCION COMPRA','CREDITO'),
(TRUE,'ABO_PRE','Abono a prestamo','ABONO PRESTAMO','CREDITO'),
(TRUE,'CASHB','Cashback por compras','CASHBACK','CREDITO'),
(TRUE,'OTR_CRE','Otro credito','OTRO CREDITO','CREDITO'),
(TRUE,'RET_EFE','Retiro en efectivo','RETIRO EFECTIVO','DEBITO'),
(TRUE,'TRA_ENV','Transferencia enviada','TRANSFERENCIA ENVIADA','DEBITO'),
(TRUE,'PAG_SER','Pago de servicios','PAGO SERVICIOS','DEBITO'),
(TRUE,'PAG_TAR','Pago tarjeta credito','PAGO TARJETA CREDITO','DEBITO'),
(TRUE,'COM_TAR','Compra con tarjeta','COMPRA TARJETA','DEBITO'),
(TRUE,'CUO_MAN','Cuota de manejo','CUOTA MANEJO','DEBITO'),
(TRUE,'COMIS','Comision bancaria','COMISION','DEBITO'),
(TRUE,'RET_AUT','Retiro automatico','RETIRO AUTOMATICO','DEBITO'),
(TRUE,'PAG_PRE','Pago de prestamo','PAGO PRESTAMO','DEBITO'),
(TRUE,'OTR_DEB','Otro debito','OTRO DEBITO','DEBITO');



INSERT INTO tipos_transaccion (activo,codigo,descripcion,nombre) VALUES 
(TRUE,'DEP_EFE','Deposito en efectivo','DEPOSITO EFECTIVO'),
(TRUE,'TRA_REC','Transferencia recibida','TRANSFERENCIA RECIBIDA'),
(TRUE,'INT_ACR','Interes acreditado','INTERES ACREDITADO'),
(TRUE,'DEV_COM','Devolucion de compra','DEVOLUCION COMPRA'),
(TRUE,'PAG_NOM','Pago de nomina','PAGO NOMINA'),
(TRUE,'ABO_PRE','Abono a prestamo','ABONO PRESTAMO'),
(TRUE,'BON_PRO','Bono promocional','BONO PROMOCIONAL'),
(TRUE,'RET_EFE','Retiro en efectivo','RETIRO EFECTIVO'),
(TRUE,'TRA_ENV','Transferencia enviada','TRANSFERENCIA ENVIADA'),
(TRUE,'PAG_SER','Pago de servicios','PAGO SERVICIOS'),
(TRUE,'PAG_TAR','Pago tarjeta credito','PAGO TARJETA CREDITO'),
(TRUE,'COM_TAR','Compra con tarjeta','COMPRA TARJETA'),
(TRUE,'CUO_MAN','Cuota de manejo','CUOTA MANEJO'),
(TRUE,'COMIS','Comision','COMISION'),
(TRUE,'PAG_PRE','Pago de prestamo','PAGO PRESTAMO'),
(TRUE,'DEB_AUT','Debito automatico','DEBITO AUTOMATICO'),
(TRUE,'IMPUEST','Impuesto','IMPUESTO'),
(TRUE,'OTRO','Otra transaccion','OTRO');



INSERT INTO metodos_transaccion (activo,codigo,descripcion,nombre) VALUES 
(TRUE,'EFE','Operacion en efectivo','EFECTIVO'),
(TRUE,'TRN','Transferencia bancaria','TRANSFERENCIA'),
(TRUE,'POL','Pago en linea','PAGO EN LINEA'),
(TRUE,'TAR','Operacion con tarjeta','TARJETA'),
(TRUE,'CHE','Pago con cheque','CHEQUE'),
(TRUE,'PSE','Pagos Seguros en Linea','PSE'),
(TRUE,'BID','Billetera digital','BILLETERA DIGITAL'),
(TRUE,'OTR','Otro metodo','OTRO');





INSERT INTO estados_pago (activo,codigo,descripcion,nombre) VALUES 
(TRUE,'PEN','Pago pendiente de procesamiento','PENDIENTE'),
(TRUE,'COM','Pago completado exitosamente','COMPLETADO'),
(TRUE,'REC','Pago rechazado','RECHAZADO'),
(TRUE,'FAL','Pago fallido por error tecnico','FALLIDO'),
(TRUE,'CAN','Pago cancelado por el usuario','CANCELADO'),
(TRUE,'PRO','Pago en proceso','EN PROCESO'),
(TRUE,'REV','Pago revertido','REVERTIDO'),
(TRUE,'PAR','Pago parcial realizado','ABONADO PARCIAL'),
(TRUE,'VEN','Pago vencido','VENCIDO'),
(TRUE,'EXO','Pago exonerado','EXONERADO');




INSERT INTO estados_cuota (activo,codigo,descripcion,nombre) VALUES 
(TRUE,'PEN','Cuota pendiente de pago','PENDIENTE'),
(TRUE,'PAG','Cuota pagada completamente','PAGADA'),
(TRUE,'GEN','Cuota generada','GENERADA'),
(TRUE,'PAG_PAR','Cuota pagada parcialmente','PAGADA_PARCIAL'),
(TRUE,'VEN','Cuota vencida','VENCIDA'),
(TRUE,'MOR','Cuota en mora','EN_MORA'),
(TRUE,'CON','Cuota condonada','CONDONADA'),
(TRUE,'REP','Cuota reprogramada','REPROGRAMADA'),
(TRUE,'ANU','Cuota anulada','ANULADA'),
(TRUE,'EXO','Cuota exonerada','EXONERADA'),
(TRUE,'CAN','Cuota cancelada','CANCELADA'),
(TRUE,'AJS','Cuota ajustada','AJUSTADA'),
(TRUE,'NAP','No aplica','NO_APLICA');




INSERT INTO eventos_tarjeta (activo,codigo,descripcion,nombre) VALUES 
(TRUE,'ACT','Tarjeta activada','ACTIVADA'),
(TRUE,'CER','Tarjeta cerrada','CERRADA'),
(TRUE,'BLO','Tarjeta bloqueada','BLOQUEADA'),
(TRUE,'DES','Tarjeta desbloqueada','DESBLOQUEADA'),
(TRUE,'VEN','Tarjeta vencida','VENCIDA'),
(TRUE,'REN','Tarjeta renovada','RENOVADA'),
(TRUE,'PER','Tarjeta reportada como perdida','PERDIDA'),
(TRUE,'ROB','Tarjeta reportada como robada','ROBADA'),
(TRUE,'REE','Tarjeta reemplazada','REEMPLAZADA');





INSERT INTO tipos_pago (activo,codigo,descripcion,nombre) VALUES 
(TRUE,'CUO_PRE','Pago de cuota de prestamo','CUOTA PRESTAMO'),
(TRUE,'CUO_MAN','Pago de cuota de manejo','CUOTA MANEJO'),
(TRUE,'TAR_CRE','Pago de tarjeta de credito','TARJETA CREDITO'),
(TRUE,'TAR_DEB','Pago con tarjeta debito','TARJETA DEBITO'),
(TRUE,'SERVIC','Pago de servicios','SERVICIO'),
(TRUE,'PRE_TOT','Pago total de prestamo','PRESTAMO TOTAL'),
(TRUE,'TRA_ENT','Transferencia entrante','TRANSFERENCIA ENTRANTE'),
(TRUE,'TRA_SAL','Transferencia saliente','TRANSFERENCIA SALIENTE'),
(TRUE,'RECARG','Recarga de servicios','RECARGA'),
(TRUE,'OTRO','Otro tipo de pago','OTRO');

