CREATE OR REPLACE FUNCTION actualizar_resultado_examen
(
   _id INTEGER,
   _examen_id BOOLEAN,
   _desc VARCHAR
)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
BEGIN
   UPDATE cama
   SET	 examen_id = _examen_id,
	 descripcion = _desc
   WHERE id = _id RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
