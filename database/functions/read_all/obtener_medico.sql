CREATE OR REPLACE FUNCTION obtener_medicos()
RETURNS SETOF medico
AS
$BODY$
DECLARE
   c_p CURSOR FOR SELECT * FROM medico;
   registro medico%ROWTYPE;
BEGIN
   FOR registro IN c_p LOOP
      RETURN NEXT registro;
   END LOOP;
   IF NOT FOUND THEN
      RAISE EXCEPTION 'NO_DATA_FOUND';
   END IF;
END;
$BODY$
LANGUAGE plpgsql;
