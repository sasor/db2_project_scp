CREATE OR REPLACE FUNCTION obtener_paciente_internado()
RETURNS SETOF paciente_internado
AS
$BODY$
DECLARE
   c_p CURSOR FOR SELECT * FROM paciente_internado;
   registro paciente_internado%ROWTYPE;
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
