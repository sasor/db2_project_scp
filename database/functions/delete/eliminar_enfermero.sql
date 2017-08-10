CREATE OR REPLACE FUNCTION eliminar_enfermero
(_ci INTEGER)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_ci INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('enfermero', 'ci', _ci);
   IF NOT existe THEN
      RAISE EXCEPTION 'enfermero no existe';
   END IF; 

   DELETE FROM enfermero WHERE ci = _ci RETURNING ci INTO last_ci;

   RETURN last_ci;
END;
$BODY$
LANGUAGE plpgsql;
