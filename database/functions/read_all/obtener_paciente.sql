CREATE OR REPLACE FUNCTION obtener_pacientes()
RETURNS SETOF paciente
AS
$BODY$
DECLARE
   c_p CURSOR FOR SELECT * FROM paciente;
   registro paciente%ROWTYPE;
BEGIN
   FOR registro IN c_p LOOP
      RETURN NEXT registro;
      -- RETURN row_to_json(registro);
   END LOOP;
   IF NOT FOUND THEN
      RAISE EXCEPTION 'NO_DATA_FOUND';
   END IF;
END;
$BODY$
LANGUAGE plpgsql;
