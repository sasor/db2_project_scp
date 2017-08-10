CREATE OR REPLACE FUNCTION eliminar_examen
(_id INTEGER)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('examen', 'id', _id);
   IF NOT existe THEN
      RAISE EXCEPTION 'examen no existe';
   END IF;

   DELETE FROM examen WHERE id = _id RETURNING id INTO last_id;

   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
