CREATE OR REPLACE FUNCTION eliminar_cita
(_id INTEGER)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('cita', 'id', _id);
   IF NOT existe THEN
      RAISE EXCEPTION 'cita no existe';
   END IF;

   DELETE FROM cita WHERE id = _id RETURNING id INTO last_id;

   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
