CREATE OR REPLACE FUNCTION bitacora_medicamento()
RETURNS TRIGGER
AS
$BODY$
BEGIN
   IF TG_OP = 'INSERT' THEN
        INSERT INTO bitacora_medicamento(accion,fecha,fields)
        VALUES(TG_OP, NOW(), row_to_json(NEW));
        RETURN NEW;
   ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO bitacora_medico(accion,fecha,fields)
        VALUES(TG_OP, NOW(), row_to_json(OLD));
        RETURN NULL;
   ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO bitacora_medico(accion,fecha,fields)
        VALUES('BEFORE UPDATE', NOW(), row_to_json(OLD));
        RETURN NEW;
        INSERT INTO bitacora_medico(accion,fecha,fields)
        VALUES('AFTER UPDATE', NOW(), row_to_json(NEW));
        RETURN NEW;
   END IF;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER bitacora_medicamento
AFTER INSERT OR UPDATE OR DELETE
ON medicamento
FOR EACH ROW
EXECUTE PROCEDURE bitacora_medicamento();
