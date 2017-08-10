CREATE OR REPLACE FUNCTION bitacora_examen()
RETURNS TRIGGER
AS
$BODY$
DECLARE
   new_f  RECORD;
   old_f  RECORD;
   diag RECORD; -- diagnostico
   tipo RECORD; -- tipo_examen
   da_ci RECORD;
   pac RECORD; -- paciente
   med RECORD; -- medico
BEGIN
   IF TG_OP IS 'INSERT' THEN
      SELECT nombre
      FROM tipo_examen
      WHERE id = NEW.tipo_examen_id INTO tipo; -- data tipo_examen

      SELECT cita_id,descripcion
      FROM diagnostico
      WHERE id = NEW.diagnostico_id INTO diag; -- data diagnostico

      SELECT paciente_id,medico_id
      FROM cita
      WHERE id = diag.cita_id::integer INTO da_ci; -- data cita

      SELECT nombre,apellido_paterno,apellido_materno
      FROM paciente
      WHERE ci = da_ci.paciente_id INTO pac;
      SELECT nombre,apellido_paterno,apellido_materno
      FROM medico
      WHERE ci = da_ci.medico_id INTO med;

      new_f := (
	 NEW.id,
	 NEW.laboratorio_id,
	 NEW.hora,
	 NEW.fecha, 
	 NEW.resultado_examen,
	 NEW.diagnostico_id,
	 diag.descripcion,
	 NEW.tipo_examen_id,
	 tipo.nombre,
	 da_ci.medico_id,
	 med.nombre,
	 med.apellido_paterno,
	 med.apellido_materno,
	 da_ci.paciente_id,
	 pac.nombre,
	 pac.apellido_paterno,
	 pac.apellido_materno)::json_examen; 
      INSERT INTO bitacora_examen
      (accion, fecha, fields)
      VALUES (TG_OP, NOW(), row_to_json(new_f));
      RETURN NEW;

   ELSIF TG_OP = 'DELETE' THEN
      SELECT nombre
      FROM tipo_examen
      WHERE id = OLD.tipo_examen_id INTO tipo; -- data tipo_examen

      SELECT cita_id,descripcion
      FROM diagnostico
      WHERE id = OLD.diagnostico_id INTO diag; -- data diagnostico

      SELECT paciente_id,medico_id
      FROM cita
      WHERE id = diag.cita_id::integer INTO da_ci; -- data cita

      SELECT nombre,apellido_paterno,apellido_materno
      FROM paciente
      WHERE ci = da_ci.paciente_id INTO pac;
      SELECT nombre,apellido_paterno,apellido_materno
      FROM medico
      WHERE ci = da_ci.medico_id INTO med;

      old_f := (
	 OLD.id,
	 OLD.laboratorio_id,
	 OLD.hora,
	 OLD.fecha, 
	 OLD.resultado_examen,
	 OLD.diagnostico_id,
	 diag.descripcion,
	 OLD.tipo_examen_id,
	 tipo.nombre,
	 da_ci.medico_id,
	 med.nombre,
	 med.apellido_paterno,
	 med.apellido_materno,
	 da_ci.paciente_id,
	 pac.nombre,
	 pac.apellido_paterno,
	 pac.apellido_materno)::json_examen; 
      INSERT INTO bitacora_examen
      (accion, fecha, fields)
      VALUES (TG_OP, NOW(), row_to_json(old_f));
      RETURN NULL;
   ELSIF TG_OP = 'UPDATE' THEN
      SELECT nombre
      FROM tipo_examen
      WHERE id = OLD.tipo_examen_id INTO tipo; -- data tipo_examen

      SELECT cita_id,descripcion
      FROM diagnostico
      WHERE id = OLD.diagnostico_id INTO diag; -- data diagnostico

      SELECT paciente_id,medico_id
      FROM cita
      WHERE id = diag.cita_id::integer INTO da_ci; -- data cita

      SELECT nombre,apellido_paterno,apellido_materno
      FROM paciente
      WHERE ci = da_ci.paciente_id INTO pac;
      SELECT nombre,apellido_paterno,apellido_materno
      FROM medico
      WHERE ci = da_ci.medico_id INTO med;

      old_f := (
	 OLD.id,
	 OLD.laboratorio_id,
	 OLD.hora,
	 OLD.fecha, 
	 OLD.resultado_examen,
	 OLD.diagnostico_id,
	 diag.descripcion,
	 OLD.tipo_examen_id,
	 tipo.nombre,
	 da_ci.medico_id,
	 med.nombre,
	 med.apellido_paterno,
	 med.apellido_materno,
	 da_ci.paciente_id,
	 pac.nombre,
	 pac.apellido_paterno,
	 pac.apellido_materno)::json_examen; 
      INSERT INTO bitacora_examen
      (accion, fecha, fields)
      VALUES ('BEFORE UPDATE', NOW(), row_to_json(old_f));

      SELECT nombre
      FROM tipo_examen
      WHERE id = NEW.tipo_examen_id INTO tipo; -- data tipo_examen

      SELECT cita_id,descripcion
      FROM diagnostico
      WHERE id = NEW.diagnostico_id INTO diag; -- data diagnostico

      SELECT paciente_id,medico_id
      FROM cita
      WHERE id = diag.cita_id::integer INTO da_ci; -- data cita

      SELECT nombre,apellido_paterno,apellido_materno
      FROM paciente
      WHERE ci = da_ci.paciente_id INTO pac;
      SELECT nombre,apellido_paterno,apellido_materno
      FROM medico
      WHERE ci = da_ci.medico_id INTO med;

      new_f := (
	 NEW.id,
	 NEW.laboratorio_id,
	 NEW.hora,
	 NEW.fecha, 
	 NEW.resultado_examen,
	 NEW.diagnostico_id,
	 diag.descripcion,
	 NEW.tipo_examen_id,
	 tipo.nombre,
	 da_ci.medico_id,
	 med.nombre,
	 med.apellido_paterno,
	 med.apellido_materno,
	 da_ci.paciente_id,
	 pac.nombre,
	 pac.apellido_paterno,
	 pac.apellido_materno)::json_examen; 
      INSERT INTO bitacora_examen
      (accion, fecha, fields)
      VALUES ('AFTER UPDATE', NOW(), row_to_json(new_f));
      RETURN NEW;
   END IF;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER bitacora_examen
BEFORE INSERT OR UPDATE OR DELETE
ON examen
FOR EACH ROW
EXECUTE PROCEDURE bitacora_examen()
