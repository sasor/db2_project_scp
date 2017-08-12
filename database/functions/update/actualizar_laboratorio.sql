CREATE OR REPLACE FUNCTION actualizar_laboratorio
(
   _id INTEGER,
   _tel INTEGER
)
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
   UPDATE laboratorio
   SET telefono = _tel
   WHERE id = _id RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
