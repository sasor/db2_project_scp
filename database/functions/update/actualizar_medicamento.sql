CREATE OR REPLACE FUNCTION actualizar_medicamento
(
   _id INTEGER,
   _nombre VARCHAR
)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('medicamento', 'id', _id);
   IF existe IS FALSE THEN
      RAISE EXCEPTION 'medicamento no existe con este id %', _id;
   END IF;

   UPDATE medicamento
   SET nombre = _nombre
   WHERE id = _id RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
