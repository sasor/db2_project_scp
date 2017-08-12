CREATE OR REPLACE FUNCTION obtener_recetas_medicas()
RETURNS SETOF receta_medica
AS
$BODY$
DECLARE
   c_p CURSOR FOR SELECT * FROM receta_medica;
   registro receta_medica%ROWTYPE;
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
