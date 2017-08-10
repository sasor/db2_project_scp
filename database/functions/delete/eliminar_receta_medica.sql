CREATE OR REPLACE FUNCTION eliminar_receta_medica
(_rid INTEGER)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('receta_medica', 'id', _rid);
   IF NOT existe THEN
      RAISE EXCEPTION 'receta_medica no existe';
   END IF; 

   DELETE FROM receta_medica WHERE id = _rid RETURNING id INTO last_id;

   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
