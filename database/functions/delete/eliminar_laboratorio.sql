CREATE OR REPLACE FUNCTION eliminar_laboratorio
(_id INTEGER)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('laboratorio', 'id', _id);
   IF NOT existe THEN
      RAISE EXCEPTION 'laboratorio no existe';
   END IF;

   DELETE FROM laboratorio WHERE id = _id RETURNING id INTO last_id;

   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
