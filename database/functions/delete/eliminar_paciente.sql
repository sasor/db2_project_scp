CREATE OR REPLACE FUNCTION eliminar_paciente
(_ci INTEGER)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_ci INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('paciente', 'ci', _ci);
   IF NOT existe THEN
      RAISE EXCEPTION 'paciente no existe';
   END IF;

   DELETE FROM paciente WHERE ci = _ci RETURNING ci INTO last_ci;

   RETURN last_ci;
END;
$BODY$
LANGUAGE plpgsql;
