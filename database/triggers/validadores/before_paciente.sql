CREATE OR REPLACE FUNCTION before_paciente()
RETURNS TRIGGER
AS
$BODY$
BEGIN

END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER before_paciente
BEFORE DELETE
ON paciente
FOR EACH ROW
EXECUTE PROCEDURE  before_paciente();
