CREATE OR REPLACE FUNCTION eliminar_cama
(_cid INTEGER)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('cama', 'id', _cid);
   IF NOT existe THEN
      RAISE EXCEPTION 'cama no existe';
   END IF; 

   DELETE FROM cama WHERE id = _cid RETURNING id INTO last_id;

   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
