CREATE OR REPLACE FUNCTION obtener_examenes()
RETURNS SETOF examen
AS
$BODY$
DECLARE
   c_p CURSOR FOR SELECT * FROM examen;
   registro examen%ROWTYPE;
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
