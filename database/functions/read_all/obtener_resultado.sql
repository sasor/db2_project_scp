CREATE OR REPLACE FUNCTION obtener_resultados()
RETURNS SETOF resultado_examen
AS
$BODY$
DECLARE
   c_p CURSOR FOR SELECT * FROM resultado_examen;
   registro resultado_examen%ROWTYPE;
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
