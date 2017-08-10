CREATE OR REPLACE FUNCTION eliminar_medico
(_ci INTEGER)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_ci INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('medico', 'ci', _ci);
   IF NOT existe THEN
      RAISE EXCEPTION 'medico no existe';
   END IF;

   DELETE FROM medico WHERE ci = _ci RETURNING ci INTO last_ci;

   RETURN last_ci;
END;
$BODY$
LANGUAGE plpgsql;
