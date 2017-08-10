CREATE OR REPLACE FUNCTION bitacora_receta_medica()
RETURNS TRIGGER
AS
$BODY$
DECLARE
   new_f RECORD;
   old_f RECORD;
   med RECORD;
BEGIN
   IF TG_OP = 'INSERT' THEN
      SELECT nombre FROM medicamento WHERE id = NEW.medicamento_id INTO med;

      new_f := (  NEW.id,
		  NEW.diagnostico_id,
		  NEW.medicamento_id,
		  med.nombre,
		  NEW.dosificacion,
		  NEW.hora,
		  NEW.fecha)::json_receta;

      INSERT INTO bitacora_receta_medica
      (accion, fecha, fields)
      VALUES
      (TG_OP, NOW(), row_to_json(new_f));
   ELSIF TG_OP = 'DELETE' THEN
      SELECT nombre FROM medicamento WHERE id = OLD.medicamento_id INTO med;

      old_f := (  OLD.id,
		  OLD.diagnostico_id,
		  OLD.medicamento_id,
		  med.nombre,
		  OLD.dosificacion,
		  OLD.hora,
		  OLD.fecha)::json_receta;

      INSERT INTO bitacora_receta_medica
      (accion, fecha, fields)
      VALUES
      (TG_OP, NOW(), row_to_json(old_f));
   ELSIF TG_OP = 'UPDATE' THEN
      SELECT nombre FROM medicamento WHERE id = OLD.medicamento_id INTO med;
      old_f := (  OLD.id,
		  OLD.diagnostico_id,
		  OLD.medicamento_id,
		  med.nombre,
		  OLD.dosificacion,
		  OLD.hora,
		  OLD.fecha)::json_receta;
      INSERT INTO bitacora_receta_medica
      (accion, fecha, fields)
      VALUES
      ('BEFORE UPDATE', NOW(), row_to_json(old_f));

      SELECT nombre FROM medicamento WHERE id = NEW.medicamento_id INTO med;
      new_f := (  NEW.id,
		  NEW.diagnostico_id,
		  NEW.medicamento_id,
		  med.nombre,
		  NEW.dosificacion,
		  NEW.hora,
		  NEW.fecha)::json_receta;
      INSERT INTO bitacora_receta_medica
      (accion, fecha, fields)
      VALUES
      ('AFTER UPDATE', NOW(), row_to_json(new_f));
   END IF;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER bitacora_receta_medica
AFTER INSERT OR UPDATE OR DELETE
ON receta_medica
FOR EACH ROW 
EXECUTE PROCEDURE bitacora_receta_medica();
