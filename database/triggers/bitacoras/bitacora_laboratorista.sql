CREATE OR REPLACE FUNCTION bitacora_laboratorista()
RETURNS TRIGGER
AS
$BODY$
DECLARE
   new_f RECORD;
   old_f RECORD;
BEGIN
   IF TG_OP = 'INSERT' THEN
      IF NEW.sexo IS TRUE THEN
	 new_f := ( NEW.ci,
		  NEW.laboratorio_id,
		  'male',
		  NEW.nombre,
		  NEW.apellido_paterno,
		  NEW.apellido_materno,
		  NEW.telefono,
		  NEW.direccion)::json_laboratorista;
      ELSE
	 new_f := ( NEW.ci,
		  NEW.laboratorio_id,
		  'female',
		  NEW.nombre,
		  NEW.apellido_paterno,
		  NEW.apellido_materno,
		  NEW.telefono,
		  NEW.direccion)::json_laboratorista;
      END IF;
      INSERT INTO bitacora_laboratorista
      (accion, fecha, fields)
      VALUES
      (TG_OP, NOW(), row_to_json(new_f));
      RETURN NEW;
   ELSIF TG_OP = 'DELETE' THEN
      IF OLD.sexo IS TRUE THEN
	 old_f := ( OLD.ci,
		  OLD.laboratorio_id,
		  'male',
		  OLD.nombre,
		  OLD.apellido_paterno,
		  OLD.apellido_materno,
		  OLD.telefono,
		  OLD.direccion)::json_laboratorista;
      ELSE
	 old_f := ( OLD.ci,
		  OLD.laboratorio_id,
		  'female',
		  OLD.nombre,
		  OLD.apellido_paterno,
		  OLD.apellido_materno,
		  OLD.telefono,
		  OLD.direccion)::json_laboratorista;
      END IF;
      INSERT INTO bitacora_laboratorista
      (accion, fecha, fields)
      VALUES
      (TG_OP, NOW(), row_to_json(old_f));
      RETURN NULL;
   ELSIF TG_OP = 'UPDATE' THEN
      IF NEW.sexo IS TRUE THEN
	 new_f := ( NEW.ci,
		  NEW.laboratorio_id,
		  'male',
		  NEW.nombre,
		  NEW.apellido_paterno,
		  NEW.apellido_materno,
		  NEW.telefono,
		  NEW.direccion)::json_laboratorista;
      ELSE
	 new_f := ( NEW.ci,
		  NEW.laboratorio_id,
		  'female',
		  NEW.nombre,
		  NEW.apellido_paterno,
		  NEW.apellido_materno,
		  NEW.telefono,
		  NEW.direccion)::json_laboratorista;
      END IF;

      IF OLD.sexo IS TRUE THEN
	 old_f := ( OLD.ci,
		  OLD.laboratorio_id,
		  'male',
		  OLD.nombre,
		  OLD.apellido_paterno,
		  OLD.apellido_materno,
		  OLD.telefono,
		  OLD.direccion)::json_laboratorista;
      ELSE
	 old_f := ( OLD.ci,
		  OLD.laboratorio_id,
		  'female',
		  OLD.nombre,
		  OLD.apellido_paterno,
		  OLD.apellido_materno,
		  OLD.telefono,
		  OLD.direccion)::json_laboratorista;
      END IF;
      INSERT INTO bitacora_laboratorista
      (accion, fecha, fields)
      VALUES
      ('BEFORE UPDATE', NOW(), row_to_json(old_f));
      INSERT INTO bitacora_laboratorista
      (accion, fecha, fields)
      VALUES
      ('AFTER UPDATE', NOW(), row_to_json(new_f));
      RETURN NEW;
   END IF;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER bitacora_laboratorista
AFTER INSERT OR UPDATE OR DELETE
ON laboratorista
FOR EACH ROW 
EXECUTE PROCEDURE bitacora_laboratorista();
