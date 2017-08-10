CREATE OR REPLACE FUNCTION eliminar_laboratorista
(_ci INTEGER)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_ci INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('laboratorista', 'ci', _ci);
   IF NOT existe THEN
      RAISE EXCEPTION 'laboratorista no existe';
   END IF;

   DELETE FROM laboratorista WHERE ci = _ci RETURNING ci INTO last_ci;

   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
