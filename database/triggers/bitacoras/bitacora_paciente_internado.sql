CREATE OR REPLACE FUNCTION bitacora_paciente_internado()
RETURNS TRIGGER
AS
$BODY$
DECLARE
   new_f RECORD;
   old_f RECORD;
   pac RECORD; -- paciente
   enf RECORD; -- enfermero
   inter RECORD; -- internacion
BEGIN
   IF TG_OP = 'INSERT' THEN
      SELECT nombre,apellido_paterno,apellido_materno
      FROM paciente
      WHERE ci = NEW.paciente_id
      INTO pac;

      SELECT nombre,apellido_paterno,apellido_materno
      FROM medico
      WHERE ci = NEW.enfermero_id
      INTO enf;

      SELECT cama_id FROM internacion WHERE id = NEW.internacion_id INTO inter;

      new_f := (  NEW.id,
		  NEW.internacion_id,
		  inter.cama_id,
		  NEW.paciente_id,
		  pac.nombre,
		  pac.apellido_paterno,
		  pac.apellido_materno,
		  NEW.enfermero_id,
		  enf.nombre,
		  enf.apellido_paterno,
		  enf.apellido_materno)::json_internado;

      INSERT INTO bitacora_paciente_internado
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
      WHERE ci = OLD.enfermero_id
      INTO enf;

      SELECT cama_id FROM internacion WHERE id = OLD.internacion_id INTO inter;

      old_f := (  OLD.id,
		  OLD.internacion_id,
		  inter.cama_id,
		  OLD.paciente_id,
		  pac.nombre,
		  pac.apellido_paterno,
		  pac.apellido_materno,
		  OLD.enfermero_id,
		  enf.nombre,
		  enf.apellido_paterno,
		  enf.apellido_materno)::json_internado;

      INSERT INTO bitacora_paciente_internado
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
      WHERE ci = NEW.enfermero_id
      INTO enf;

      SELECT cama_id FROM internacion WHERE id = NEW.internacion_id INTO inter;

      new_f := (  NEW.id,
		  NEW.internacion_id,
		  inter.cama_id,
		  NEW.paciente_id,
		  pac.nombre,
		  pac.apellido_paterno,
		  pac.apellido_materno,
		  NEW.enfermero_id,
		  enf.nombre,
		  enf.apellido_paterno,
		  enf.apellido_materno)::json_internado;

      SELECT nombre,apellido_paterno,apellido_materno
      FROM paciente
      WHERE ci = OLD.paciente_id
      INTO pac;

      SELECT nombre,apellido_paterno,apellido_materno
      FROM medico
      WHERE ci = OLD.enfermero_id
      INTO enf;

      SELECT cama_id FROM internacion WHERE id = OLD.internacion_id INTO inter;

      old_f := (  OLD.id,
		  OLD.internacion_id,
		  inter.cama_id,
		  OLD.paciente_id,
		  pac.nombre,
		  pac.apellido_paterno,
		  pac.apellido_materno,
		  OLD.enfermero_id,
		  enf.nombre,
		  enf.apellido_paterno,
		  enf.apellido_materno)::json_internado;

      INSERT INTO bitacora_paciente_internado
      (accion, fecha, fields)
      VALUES
      ('BEFORE UPDATE', NOW(), row_to_json(old_f));
      INSERT INTO bitacora_paciente_internado
      (accion, fecha, fields)
      VALUES
      ('AFTER UPDATE', NOW(), row_to_json(new_f));
      RETURN NEW;
   END IF;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER bitacora_paciente_internado
AFTER INSERT OR UPDATE OR DELETE
ON paciente_internado
FOR EACH ROW 
EXECUTE PROCEDURE bitacora_paciente_internado();
