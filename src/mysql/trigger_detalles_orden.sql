CREATE DEFINER=`usermysql`@`localhost` TRIGGER `detalles_orden_AFTER_INSERT` AFTER INSERT ON `detalles_orden` FOR EACH ROW BEGIN
	UPDATE orden set
    fecha_actualizacion = now(),
    total = (SELECT sum(prod.precio * det.cantidad) total FROM detalles_orden det
			INNER JOIN productos prod ON prod.id = det.idproducto
			WHERE det.idorden = NEW.idorden)
	WHERE orden.id = NEW.idorden;
END


CREATE DEFINER=`usermysql`@`localhost` TRIGGER `detalles_orden_AFTER_UPDATE` AFTER UPDATE ON `detalles_orden` FOR EACH ROW BEGIN
	UPDATE orden set
    fecha_actualizacion = now(),
    total = (SELECT sum(prod.precio * det.cantidad) total FROM detalles_orden det
			INNER JOIN productos prod ON prod.id = det.idproducto
			WHERE det.idorden = NEW.idorden)
	WHERE orden.id = NEW.idorden;
END


CREATE DEFINER=`usermysql`@`localhost` TRIGGER `detalles_orden_AFTER_DELETE` AFTER DELETE ON `detalles_orden` FOR EACH ROW BEGIN
	/*DECLARE v_total int;  -- declarar variable y asignarle un valor
    SET v_total = 234;*/
	UPDATE orden set
    fecha_actualizacion = now(),
    total = IFNULL((SELECT sum(prod.precio * det.cantidad) total FROM detalles_orden det
			inner join productos prod on prod.id = det.idproducto
			where det.idorden = old.idorden), 0)
	where orden.id = old.idorden;
END