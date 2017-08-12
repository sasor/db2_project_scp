CREATE OR REPLACE FUNCTION obtener_diagnosticos()
RETURNS SETOF diagnostico
AS
$BODY$
DECLARE
   c_p CURSOR FOR SELECT * FROM diagnostico;
   registro diagnostico%ROWTYPE;
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
