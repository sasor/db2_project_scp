CREATE OR REPLACE FUNCTION before_internacion()
RETURNS TRIGGER
AS
$BODY$
DECLARE
   is_done BOOLEAN;
BEGIN
   is_done := fix_dependencia_cama('cama', 'id', OLD.cama_id);
   RETURN OLD;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER before_paciente
BEFORE DELETE
ON internacion
FOR EACH ROW
EXECUTE PROCEDURE  before_internacion();
