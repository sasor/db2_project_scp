CREATE OR REPLACE FUNCTION bit_cita()
RETURNS TRIGGER
AS
$BODY$
DECLARE
   new_f RECORD;
   old_f RECORD;
   pac RECORD;
   med RECORD;
BEGIN
   IF TG_OP = 'INSERT' THEN
      SELECT nombre,apellido_paterno,apellido_materno
      FROM paciente
      WHERE ci = NEW.paciente_id
      INTO pac;

      SELECT nombre,apellido_paterno,apellido_materno
      FROM medico
      WHERE ci = NEW.medico_id
      INTO med;

      new_f := (  NEW.id,
		  NEW.hora,
		  NEW.fecha,
		  NEW.paciente_id,
		  pac.nombre,
		  pac.apellido_paterno,
		  pac.apellido_materno,
		  NEW.medico_id,
		  med.nombre,
		  med.apellido_paterno,
		  med.apellido_materno)::json_cita;

      INSERT INTO bitacora_cita
      (accion, fecha, fields)
      VALUES
      (TG_OP, NOW(), row_to_json(new_f));

      RETURN NEW;
   ELSIF TG_OP = 'DELETE' THEN
      SELECT nombre,apellido_paterno,apellido_materno
      FROM paciente
      WHERE ci = OLD.paciente_id
      INTO pac;

      SELECT nombre,apellido_paterno,apellido_materno
      FROM medico
      WHERE ci = OLD.medico_id
      INTO med;

      old_f := (  OLD.id,
		  OLD.hora,
		  OLD.fecha,
		  OLD.paciente_id,
		  pac.nombre,
		  pac.apellido_paterno,
		  pac.apellido_materno,
		  OLD.medico_id,
		  med.nombre,
		  med.apellido_paterno,
		  med.apellido_materno)::json_cita;

      INSERT INTO bitacora_cita
      (accion, fecha, fields)
      VALUES
      (TG_OP, NOW(), row_to_json(old_f));
      RETURN NULL;
   ELSIF TG_OP = 'UPDATE' THEN
      SELECT nombre,apellido_paterno,apellido_materno
      FROM paciente
      WHERE ci = NEW.paciente_id
      INTO pac;

      SELECT nombre,apellido_paterno,apellido_materno
      FROM medico
      WHERE ci = NEW.medico_id
      INTO med;

      new_f := (  NEW.id,
		  NEW.hora,
		  NEW.fecha,
		  NEW.paciente_id,
		  pac.nombre,
		  pac.apellido_paterno,
		  pac.apellido_materno,
		  NEW.medico_id,
		  med.nombre,
		  med.apellido_paterno,
		  med.apellido_materno)::json_cita;

      SELECT nombre,apellido_paterno,apellido_materno
      FROM paciente
      WHERE ci = OLD.paciente_id
      INTO pac;

      SELECT nombre,apellido_paterno,apellido_materno
      FROM medico
      WHERE ci = OLD.medico_id
      INTO med;

      old_f := (  OLD.id,
		  OLD.hora,
		  OLD.fecha,
		  OLD.paciente_id,
		  pac.nombre,
		  pac.apellido_paterno,
		  pac.apellido_materno,
		  OLD.medico_id,
		  med.nombre,
		  med.apellido_paterno,
		  med.apellido_materno)::json_cita;

      INSERT INTO bitacora_cita
      (accion, fecha, fields)
      VALUES
      ('BEFORE UPDATE', NOW(), row_to_json(old_f));
      INSERT INTO bitacora_cita
      (accion, fecha, fields)
      VALUES
      ('AFTER UPDATE', NOW(), row_to_json(new_f));
      RETURN NEW;
   END IF;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER bit_cita
AFTER INSERT OR UPDATE OR DELETE
ON cita
FOR EACH ROW 
EXECUTE PROCEDURE bit_cita();
