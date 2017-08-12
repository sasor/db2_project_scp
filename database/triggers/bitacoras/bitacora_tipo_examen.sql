CREATE OR REPLACE FUNCTION bitacora_tipo_examen()
RETURNS TRIGGER
AS
$BODY$
BEGIN
   IF TG_OP = 'INSERT' THEN
      INSERT INTO bitacora_tipo_examen
      (accion,fecha,fields)
      VALUES (TG_OP, NOW(), row_to_json(NEW));
      RETURN NEW;
   END IF;

   IF TG_OP = 'DELETE' THEN
      INSERT INTO bitacora_tipo_examen
      (accion,fecha,fields)
      VALUES (TG_OP, NOW(), row_to_json(OLD));
      RETURN NULL;
   END IF;

   IF TG_OP = 'UPDATE' THEN
      INSERT INTO bitacora_tipo_examen
      (accion,fecha,fields)
      VALUES ('BEFORE UPDATE', NOW(), row_to_json(OLD));

      INSERT INTO bitacora_tipo_examen
      (accion,fecha,fields)
      VALUES ('AFTER UPDATE', NOW(), row_to_json(NEW));
      RETURN NEW;
   END IF;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER bitacora_tipo_examen
AFTER INSERT OR UPDATE OR DELETE
ON tipo_examen
FOR EACH ROW
EXECUTE PROCEDURE bitacora_tipo_examen();
