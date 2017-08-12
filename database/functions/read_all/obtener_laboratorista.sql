CREATE OR REPLACE FUNCTION obtener_laboratoristas()
RETURNS SETOF laboratorista
AS
$BODY$
DECLARE
   c_p CURSOR FOR SELECT * FROM laboratorista;
   registro laboratorista%ROWTYPE;
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
