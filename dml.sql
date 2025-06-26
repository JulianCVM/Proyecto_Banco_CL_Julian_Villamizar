
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




INSERT INTO interes (activo,codigo,nombre,tipo,valor) VALUES
(TRUE,'INT_AHO','Interes Ahorros','FIJO',0.0250),
(TRUE,'INT_COR','Interes Corriente','VARIABLE',0.0150),
(TRUE,'INT_PRE_PER','Interes Prestamo Personal','FIJO',0.1850),
(TRUE,'INT_PRE_HIP','Interes Hipotecario','VARIABLE',0.0950),
(TRUE,'INT_PRE_AUT','Interes Automotriz','FIJO',0.1350),
(TRUE,'INT_TAR_CRE','Interes Tarjeta Credito','VARIABLE',0.2450),
(TRUE,'INT_MORA','Interes de Mora','MORA',0.0500),
(TRUE,'INT_PF','Interes Plazo Fijo','FIJO',0.0650),
(TRUE,'NO_APLICA','No Aplica Interes','NO_APLICA',0.0000),
(TRUE,'INT_EST','Interes Estudiantil','FIJO',0.0850),
(TRUE,'INT_COM','Interes Comercial','VARIABLE',0.1650),
(TRUE,'INT_LIB','Interes Libre Inversion','FIJO',0.1950),
(TRUE,'INT_ROT','Interes Credito Rotativo','VARIABLE',0.2250),
(TRUE,'INT_PRE_PRE','Interes Prendario','FIJO',0.1450);





INSERT INTO descuento (activo,codigo,descripcion,fecha_fin,fecha_inicio,nombre,tipo_valor,valor) VALUES 
(TRUE,'DESC_USO','Descuento por uso frecuente de productos','2025-12-31',NOW(),'Descuento por Uso','MONTO_FIJO',500.00),
(TRUE,'DESC_DEB_AUT','Descuento por tener debito automatico','2025-12-31',NOW(),'Descuento Debito Automatico','PORCENTAJE',15.00),
(TRUE,'DESC_CUO_MAN','Exencion de cuota de manejo','2025-12-31',NOW(),'Exencion Cuota Manejo','PORCENTAJE',100.00),
(TRUE,'DESC_CONV','Descuento por convenio empresarial','2025-12-31',NOW(),'Descuento Convenio','PORCENTAJE',20.00),
(TRUE,'CASHBACK','Devolucion por compras','2025-12-31',NOW(),'Cashback Compras','PORCENTAJE',2.50),
(TRUE,'DESC_SEG','Descuento en seguros','2025-12-31',NOW(),'Descuento Seguros','PORCENTAJE',25.00),
(TRUE,'DESC_NOM','Descuento por cuenta nomina','2025-12-31',NOW(),'Descuento Nomina','MONTO_FIJO',1000.00),
(TRUE,'DESC_VIP','Descuento cliente VIP','2025-12-31',NOW(),'Descuento VIP','PORCENTAJE',30.00),
(TRUE,'DESC_JUV','Descuento cuenta juvenil','2025-12-31',NOW(),'Descuento Juvenil','PORCENTAJE',50.00),
(TRUE,'DESC_EMP','Descuento empresarial','2025-12-31',NOW(),'Descuento Empresarial','PORCENTAJE',25.00),
(TRUE,'DESC_DIG','Descuento cuenta digital','2025-12-31',NOW(),'Descuento Digital','MONTO_FIJO',750.00),
(TRUE,'DESC_LO','Descuento lealtad','2025-12-31',NOW(),'Descuento Lealtad','PORCENTAJE',10.00);

-- tipo_cliente (1,4)     tipo_nit (1,10)
INSERT INTO clientes (activo,email,fecha_creacion,nit,num_contacto,primer_apellido,primer_nombre,segundo_apellido,segundo_nombre,tipo_cliente_id,tipo_nit_id,tipo_persona) VALUES 
(TRUE,'julian.c@email.com',NOW(),'1095849038','3029390826','Villamizar','Julian','Montañez','Camilo',4,6,'NATURAL'),
(TRUE,'pedro@email.com',NOW(),'1090985647','3029303938','Garcia','Paco','Gonzales','Paconcio',1,1,'JURIDICA'),
(TRUE,'paco@email.com',NOW(),'1094638304','3059382928','Loo','Esteban','Rodriguez','Estebano',2,2,'NATURAL'),
(TRUE,'tulio@email.com',NOW(),'1073849274','30293849587','Rodriguez','Santi','Martinez','Santiaguito',3,3,'NATURAL'),
(TRUE,'laura@email.com',NOW(),'1098472849','30291039548','Martinez','Sonti','Ooi','Jonny',4,4,'JURIDICA'),
(TRUE,'marcelo@email.com',NOW(),'1046372839','31102938954','Ooi','Kakaroto','Anzola','Koku',1,5,'NATURAL'),
(TRUE,'marcela@email.com',NOW(),'1090473526','31102938475','Anzola','Marcelin','Lopez','Vampire',2,6,'NATURAL'),
(TRUE,'adrian@email.com',NOW(),'1090382738','31203948573','Lopez','Marcelino','Qaq','Lucino',3,7,'NATURAL'),
(TRUE,'santiago@email.com',NOW(),'1029384575','30293045918','Qaq','Marcelo','Sanchez','Lolino',4,8,'JURIDICA'),
(TRUE,'josias@email.com',NOW(),'1029029381','3029103921','Sanchez','Juan','Buhajeruk','David',1,9,'NATURAL'),
(TRUE,'maikel@email.com',NOW(),'1020293817','30293039182','Buhajeruk','Yulian','Hernandez','Melpico',2,10,'NATURAL'),
(TRUE,'superkoku@email.com',NOW(),'1090384726','3010293019','Hernandez','Yuli','Montañez','Merina',3,1,'NATURAL'),
(TRUE,'elpapu777@email.com',NOW(),'1092837289','31102938193','Rimunot','Xu-lian','Romero','Ximpeng',4,2,'JURIDICA'),
(TRUE,'samuel@email.com',NOW(),'1023219473','3010209391','Romero','Xi','Torres','Yinping',1,3,'NATURAL'),
(TRUE,'saul@email.com',NOW(),'1098473627','30039201938','Torres','No','Gomez','Se',2,4,'NATURAL'),
(TRUE,'sofia@email.com',NOW(),'1092837192','3110293029','Gomez','Talvez','Fernandez','Capaz',3,5,'NATURAL'),
(TRUE,'laura.c@email.com',NOW(),'1092039485','3020391019','Fernandez','Nombre','Pacsi','SegundoNombre',4,6,'NATURAL'),
(TRUE,'camila@email.com',NOW(),'1032930495','30291039287','Pacsi','erbmoN','Alvarez','erbmoNodnugeS',1,7,'JURIDICA'),
(TRUE,'lorena@email.com',NOW(),'1039283459','3029103129','Alvarez','Patricio','Perez','Estrella',2,8,'NATURAL'),
(TRUE,'david@email.com',NOW(),'1032938472','3029103928','Perez','Patrick','Jimenez','Star',3,9,'NATURAL'),
(TRUE,'juan.david@email.com',NOW(),'1039283746','3029102938','Jimenez','Rick','Mendoza','Rockero',4,10,'NATURAL'),
(TRUE,'pabonjuan@email.com',NOW(),'1019182736','3029457123','Mendoza','Ricardo','Muñoz','Milos',1,1,'NATURAL'),
(TRUE,'kevin@email.com',NOW(),'1039203954','3028173922','Muñoz','Richard','Flores','Darwin',2,2,'NATURAL'),
(TRUE,'thegang@email.com',NOW(),'1090392834','3029909121','Flores','Ricardito','Gomezferrer','Arturito',3,3,'NATURAL'),
(TRUE,'enterprise@email.com',NOW(),'1092938273','3019203928','Gomezferrer','Royer','Caszely','Piraton',4,4,'JURIDICA'),
(TRUE,'nose@email.com',NOW(),'1092832745','3092019398','Caszely','Roger','Magik','Pirate',1,5,'NATURAL'),
(TRUE,'estaleyendoesto@email.com',NOW(),'1903928394','3002910392','Magik','Loyel','Magik','Pilata',2,6,'NATURAL'),
(TRUE,'susregistros@email.com',NOW(),'1032394827','3020293817','Bedman','El propio','Paracetamol','propisio',4,6,'NATURAL'),
(TRUE,'receteamedica@email.com',NOW(),'10932039487','3090201938','en la mañana','Paracetamol','y en la tarde','cada 2 horas',4,8,'JURIDICA'),
(TRUE,'camion@email.com',NOW(),'1023928475','3098547212','Medina','Jose','Zzz','David',1,9,'NATURAL'),
(TRUE,'animal@email.com',NOW(),'1092394827','31192837480','Zzz','Josefo','Castro','Davidfo',2,10,'NATURAL'),
(TRUE,'caballo@email.com',NOW(),'1023928457','3010293847','Castro','Jus','Dominguez','ses',3,1,'NATURAL'),
(TRUE,'alitas@email.com',NOW(),'1090382756','3019283754','Dominguez','Josefina','Parra','La gallina',4,2,'NATURAL'),
(TRUE,'abeja@email.com',NOW(),'102932321','3019283747','Mierda','Joselia','Parra','Ramirez',1,3,'NATURAL'),
(TRUE,'miel@email.com',NOW(),'102932923','3029018238','Parra','Joselina','Parra','Ramirez',2,4,'JURIDICA'),
(TRUE,'panal@email.com',NOW(),'10930293847','3020939812','Morales','Josefina','Morales','Lucila',3,5,'NATURAL'),
(TRUE,'chuki@email.com',NOW(),'10932039481','3029198239','Casas','Maria','Casas','Camilia',1,6,'NATURAL'),
(TRUE,'adrian.el.mejor.trainer@email.com',NOW(),'1090382754','309332874','Ruiz','Adrian','Mondragon','Farid',2,7,'NATURAL'),
(TRUE,'nico.g@email.com',NOW(),'1090392837','302938172','De niro','Darwin','Ruiz','Jose',3,8,'NATURAL'),
(TRUE,'niko@email.com',NOW(),'1098372837','301020932','Cazzucheli','Dlawin','Soto','Jesus',4,9,'NATURAL'),
(TRUE,'denmepuntosporfavor@email.com',NOW(),'1093283746','301010123','Soto','Maikel','Doggenweiler','Donhel',1,10,'JURIDICA'),
(TRUE,'yacasitermino@email.com',NOW(),'10932839487','30292831823','Doggenweiler','Mikel','Castillo','Leonardo',2,1,'NATURAL'),
(TRUE,'holamundo@email.com',NOW(),'1093892837','301020392','Zempoalteca','Michel','Contreras','Lancelot',3,2,'NATURAL'),
(TRUE,'system.out.println@email.com',NOW(),'10932039482','3023049223','Contreras','Michelle','Rivera','Casca',4,3,'NATURAL'),
(TRUE,'pedro.pascal@email.com',NOW(),'1093283748','30405029328','Rivera','Miachel','Montoya','Eren',1,4,'NATURAL'),
(TRUE,'elmaestrosuporemo@email.com',NOW(),'1032930494','3070394238','Montoya','Mikael','Rojas','Tanjiro',2,5,'NATURAL'),
(TRUE,'darth.vader@email.com',NOW(),'1023948573','3029390129','Rojas','Curry','Peralta','Sukuna',3,6,'NATURAL'),
(TRUE,'lu keskywalker@email.com',NOW(),'1032938475','30293102934','Castillo','Estephano','Campoverde','La marmota',4,7,'JURIDICA'),
(TRUE,'sarita@email.com',NOW(),'1023928374','3920392032','Campoverde','Espehen','Peralta','joshep',1,8,'NATURAL'),
(TRUE,'sara@email.com',NOW(),'10932039381','3209123233','Peralta','Patrimonio','Castillo','Nacional',2,9,'NATURAL'),
(TRUE,'sara@email.com',NOW(),'10932039382','3209123233','Peralta','Patrimonio','Castillo','Nacional',2,9,'NATURAL'),
(TRUE,'sara@email.com',NOW(),'10932039383','3209123233','Peralta','Patrimonio','Castillo','Nacional',2,9,'NATURAL'),
(TRUE,'sara@email.com',NOW(),'10932039385','3209123233','Peralta','Patrimonio','Castillo','Nacional',2,9,'NATURAL'),
(TRUE,'sara@email.com',NOW(),'10932039386','3209123233','Peralta','Patrimonio','Castillo','Nacional',2,9,'NATURAL'),
(TRUE,'sara@email.com',NOW(),'10932039387','3209123233','Peralta','Patrimonio','Castillo','Nacional',2,9,'NATURAL'),
(TRUE,'sara@email.com',NOW(),'10932039388','3209123233','Peralta','Patrimonio','Castillo','Nacional',2,9,'NATURAL'),
(TRUE,'sara@email.com',NOW(),'10932039389','3209123233','Peralta','Patrimonio','Castillo','Nacional',2,9,'NATURAL'),
(TRUE,'sara@email.com',NOW(),'10932039310','3209123233','Peralta','Patrimonio','Castillo','Nacional',2,9,'NATURAL'),
(TRUE,'sara@email.com',NOW(),'10932039311','3209123233','Peralta','Patrimonio','Castillo','Nacional',2,9,'NATURAL'),
(TRUE,'sara@email.com',NOW(),'10932039312','3209123233','Peralta','Patrimonio','Castillo','Nacional',2,9,'NATURAL');



DESCRIBE  cuenta;INSERT INTO cuenta (cliente_id,estado_id,fecha_apertura,fecha_cierre,interes_id,moneda_id,numero,saldo_disponible,tipo_cuenta_id,transacciones_realizadas) VALUES 
(1,1,NOW(),NULL,1,1,'1001234567890',2500000.00,1,15),
(1,1,NOW(),NULL,2,1,'2001234567890',850000.00,2,8),
(2,1,NOW(),NULL,1,1,'1002345678901',1750000.00,1,12),
(3,1,NOW(),NULL,9,1,'3003456789012',3200000.00,3,6),
(4,1,NOW(),NULL,1,1,'1004567890123',950000.00,1,9),
(5,1,NOW(),NULL,2,1,'2005678901234',2100000.00,2,14),
(6,1,NOW(),NULL,8,1,'4006789012345',5500000.00,4,3),
(7,1,NOW(),NULL,1,1,'1007890123456',680000.00,1,11),
(8,1,NOW(),NULL,9,1,'3008901234567',2800000.00,3,7),
(9,1,NOW(),NULL,2,1,'2009012345678',1950000.00,2,13),
(10,1,NOW(),NULL,1,1,'1010123456789',4200000.00,1,5),
(11,1,NOW(),NULL,1,1,'1011234567890',1320000.00,1,8),
(12,1,NOW(),NULL,9,1,'3012345678901',3650000.00,3,4),
(13,1,NOW(),NULL,2,1,'2013456789012',780000.00,2,16),
(14,1,NOW(),NULL,8,1,'4014567890123',8900000.00,4,2),
(15,1,NOW(),NULL,1,1,'1015678901234',2150000.00,1,10),
(16,1,NOW(),NULL,5,1,'5016789012345',450000.00,5,25),
(17,1,NOW(),NULL,2,1,'2017890123456',3100000.00,2,9),
(18,1,NOW(),NULL,1,1,'1018901234567',1580000.00,1,14),
(19,1,NOW(),NULL,9,1,'3019012345678',2950000.00,3,6),
(20,1,NOW(),NULL,2,1,'2020123456789',4800000.00,2,11),
(21,1,NOW(),NULL,1,1,'1021234567890',825000.00,1,18),
(22,1,NOW(),NULL,8,1,'4022345678901',12500000.00,4,1),
(23,1,NOW(),NULL,2,1,'2023456789012',1750000.00,2,12),
(24,1,NOW(),NULL,1,1,'1024567890123',3400000.00,1,7),
(25,1,NOW(),NULL,9,1,'3025678901234',2200000.00,3,8),
(26,1,NOW(),NULL,2,1,'2026789012345',5200000.00,2,15),
(27,1,NOW(),NULL,1,1,'1027890123456',975000.00,1,20),
(28,1,NOW(),NULL,5,1,'5028901234567',680000.00,5,22),
(29,1,NOW(),NULL,2,1,'2029012345678',3850000.00,2,10),
(30,1,NOW(),NULL,1,1,'1030123456789',1465000.00,1,13),
(31,1,NOW(),NULL,9,1,'3031234567890',4100000.00,3,5),
(32,1,NOW(),NULL,2,1,'2032345678901',2650000.00,2,17),
(33,1,NOW(),NULL,8,1,'4033456789012',15200000.00,4,3),
(34,1,NOW(),NULL,1,1,'1034567890123',785000.00,1,19),
(35,1,NOW(),NULL,2,1,'2035678901234',3950000.00,2,8),
(36,1,NOW(),NULL,1,1,'1036789012345',2280000.00,1,11),
(37,1,NOW(),NULL,9,1,'3037890123456',1850000.00,3,9),
(38,1,NOW(),NULL,5,1,'5038901234567',525000.00,5,24),
(39,1,NOW(),NULL,2,1,'2039012345678',4650000.00,2,14),
(40,1,NOW(),NULL,1,1,'1040123456789',1125000.00,1,16),
(41,1,NOW(),NULL,8,1,'4041234567890',9800000.00,4,2),
(42,1,NOW(),NULL,2,1,'2042345678901',3150000.00,2,12),
(43,1,NOW(),NULL,1,1,'1043456789012',2750000.00,1,15),
(44,1,NOW(),NULL,9,1,'3044567890123',3850000.00,3,6),
(45,1,NOW(),NULL,2,1,'2045678901234',1950000.00,2,18),
(46,1,NOW(),NULL,1,1,'1046789012345',4250000.00,1,7),
(47,1,NOW(),NULL,5,1,'5047890123456',350000.00,5,26),
(48,1,NOW(),NULL,2,1,'2048901234567',5150000.00,2,10),
(49,1,NOW(),NULL,1,1,'1049012345678',1680000.00,1,21),
(50,1,NOW(),NULL,8,1,'4050123456789',18500000.00,4,1),
(51,1,NOW(),NULL,2,1,'6051234567890',45000000.00,6,25),
(52,1,NOW(),NULL,2,1,'6052345678901',28000000.00,6,18),
(53,1,NOW(),NULL,2,1,'6053456789012',35200000.00,6,22),
(54,1,NOW(),NULL,2,1,'6054567890123',15800000.00,6,16),
(55,1,NOW(),NULL,2,1,'6055678901234',42500000.00,6,28),
(56,1,NOW(),NULL,2,1,'6056789012345',38900000.00,6,31),
(57,1,NOW(),NULL,2,1,'6057890123456',52000000.00,6,24),
(58,1,NOW(),NULL,2,1,'6058901234567',29500000.00,6,19),
(59,1,NOW(),NULL,2,1,'6059012345678',48200000.00,6,26),
(60,1,NOW(),NULL,2,1,'6060123456789',33700000.00,6,21);

