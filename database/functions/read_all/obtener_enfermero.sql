CREATE OR REPLACE FUNCTION obtener_enfermeros()
RETURNS SETOF enfermero
AS
$BODY$
DECLARE
   c_p CURSOR FOR SELECT * FROM enfermero;
   registro enfermero%ROWTYPE;
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
