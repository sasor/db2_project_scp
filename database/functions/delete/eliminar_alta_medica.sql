CREATE OR REPLACE FUNCTION eliminar_alta_medica
(_id INTEGER)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('alta_medica', 'id', _id);
   IF NOT existe THEN
      RAISE EXCEPTION 'alta_medica no existe';
   END IF; 

   DELETE FROM alta_medica WHERE id = _id RETURNING id INTO last_id;

   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
