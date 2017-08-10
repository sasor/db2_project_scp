CREATE OR REPLACE FUNCTION eliminar_diagnostico
(_id INTEGER)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('diagnostico', 'id', _id);
   IF NOT existe THEN
      RAISE EXCEPTION 'diagnostico no existe';
   END IF; 

   DELETE FROM diagnostico WHERE id = _id RETURNING id INTO last_id;

   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
