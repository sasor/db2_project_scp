CREATE OR REPLACE FUNCTION obtener_tipo_examenes()
RETURNS SETOF tipo_examen
AS
$BODY$
DECLARE
   c_p CURSOR FOR SELECT * FROM tipo_examen;
   registro tipo_examen%ROWTYPE;
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
