CREATE OR REPLACE FUNCTION obtener_internacion()
RETURNS SETOF internacion
AS
$BODY$
DECLARE
   c_p CURSOR FOR SELECT * FROM internacion;
   registro internacion%ROWTYPE;
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
