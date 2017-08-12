CREATE OR REPLACE FUNCTION before_resultado_examen()
RETURNS TRIGGER
AS
$BODY$
DECLARE
   is_done BOOLEAN;
BEGIN
   is_done := fix_dependencia_examen('examen', 'id', OLD.examen_id);
   RETURN OLD;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER before_resultado_examen
BEFORE DELETE
ON resultado_examen
FOR EACH ROW
EXECUTE PROCEDURE before_resultado_examen();
