CREATE OR REPLACE FUNCTION bitacora_laboratorio()
RETURNS TRIGGER
AS
$BODY$
DECLARE
   -- new_f RECORD;
   -- old_f RECORD;
   -- lab RECORD;
BEGIN
   IF TG_OP = 'INSERT' THEN
      /*SELECT nombre,apellido_paterno,apellido_materno
      FROM laboratorista
      WHERE ci = NEW.laboratorista_id
      INTO lab;*/
      /*new_f := (  NEW.id,
		  NEW.telefono,
		  NEW,laboratorista_id,
		  lab.nombre,
		  lab.apellido_paterno,
		  lab.apellido_materno)::json_laboratorio;*/

      INSERT INTO bitacora_laboratorio
      (accion, fecha, fields)
      VALUES
      (TG_OP, NOW(), row_to_json(NEW));
      RETURN NEW;
   ELSIF TG_OP = 'DELETE' THEN
      /*SELECT nombre,apellido_paterno,apellido_materno
      FROM laboratorista
      WHERE ci = OLD.laboratorista_id
      INTO lab;

      old_f := (  OLD.id,
		  OLD.telefono,
		  OLD,laboratorista_id,
		  lab.nombre,
		  lab.apellido_paterno,
		  lab.apellido_materno)::json_laboratorio;*/

      INSERT INTO bitacora_laboratorio
      (accion, fecha, fields)
      VALUES
      (TG_OP, NOW(), row_to_json(OLD));
      RETURN NULL;
   ELSIF TG_OP = 'UPDATE' THEN
      /*SELECT nombre,apellido_paterno,apellido_materno
      FROM laboratorista
      WHERE ci = NEW.laboratorista_id
      INTO lab;

      new_f := (  NEW.id,
		  NEW.telefono,
		  NEW,laboratorista_id,
		  lab.nombre,
		  lab.apellido_paterno,
		  lab.apellido_materno)::json_laboratorio;

      SELECT nombre,apellido_paterno,apellido_materno
      FROM laboratorista
      WHERE ci = OLD.laboratorista_id
      INTO lab;

      old_f := (  OLD.id,
		  OLD.telefono,
		  OLD,laboratorista_id,
		  lab.nombre,
		  lab.apellido_paterno,
		  lab.apellido_materno)::json_laboratorio;*/

      INSERT INTO bitacora_laboratorio
      (accion, fecha, fields)
      VALUES
      ('BEFORE UPDATE', NOW(), row_to_json(OLD));
      INSERT INTO bitacora_laboratorio
      (accion, fecha, fields)
      VALUES
      ('AFTER UPDATE', NOW(), row_to_json(NEW));
      RETURN NEW;
   END IF;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER bitacora_laboratorio
AFTER INSERT OR UPDATE OR DELETE
ON laboratorio
FOR EACH ROW 
EXECUTE PROCEDURE bitacora_laboratorio();
