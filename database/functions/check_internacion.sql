CREATE OR REPLACE FUNCTION check_internacion
(_did INTEGER, _camaid INTEGER)
RETURNS BOOLEAN
AS
$BODY$
DECLARE
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('diagnostico', 'id', _did);
   IF NOT existe THEN
      RAISE EXCEPTION 'diagnostico no existe';
   END IF;

   existe := check_if_exists_record('cama', 'id', _camaid);
   IF NOT existe THEN
      RAISE EXCEPTION 'cama no existe';
   END IF;

   PERFORM 1 FROM cama WHERE id = _camaid AND status = 't';
   IF NOT FOUND THEN
      RAISE EXCEPTION 'cama no disponible';
   END IF;

   RETURN TRUE;
END;
$BODY$
LANGUAGE plpgsql;
