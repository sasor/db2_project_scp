CREATE OR REPLACE FUNCTION bitacora_resultado_examen()
RETURNS TRIGGER 
AS
$BODY$
DECLARE
   is_done BOOLEAN;
BEGIN
   IF TG_OP = 'INSERT' THEN
      INSERT INTO bitacora_resultado_examen
      (accion,fecha,fields)
      VALUES (TG_OP, NOW(), row_to_json(NEW));

      -- actualiza el campo resultado_examen a true
      is_done := fix_dependencia_examen('examen', 'id', NEW.examen_id);

      RETURN NEW;
   END IF;

   IF TG_OP = 'DELETE' THEN
      INSERT INTO bitacora_resultado_examen
      (accion,fecha,fields)
      values(TG_OP, NOW(), row_to_json(OLD));
      RETURN NULL;
   END IF;

   IF TG_OP = 'UPDATE' THEN
      INSERT INTO bitacora_resultado_examen
      (accion,fecha,fields)
      VALUES ('BEFORE UPDATE', NOW(), row_to_json(OLD));

      INSERT INTO bitacora_resultado_examen
      (accion,fecha,fields)
      VALUES ('AFTER UPDATE', NOW(), row_to_json(NEW));
      RETURN NEW;
    END IF;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER bitacora_resultado_examen
AFTER INSERT OR UPDATE OR DELETE
ON resultado_examen
FOR EACH ROW
EXECUTE PROCEDURE bitacora_resultado_examen();
