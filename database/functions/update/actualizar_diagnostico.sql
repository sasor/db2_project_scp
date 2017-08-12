CREATE OR REPLACE FUNCTION actualizar_diagnostico
(
   _id INTEGER,
   _cid INTEGER,
   _sin VARCHAR,
   _desc VARCHAR
)
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

   UPDATE diagnostico
   SET	 cita_id = _cid,
	 sintoma = _sin,
	 descripcion = _desc
   WHERE id = _id RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
