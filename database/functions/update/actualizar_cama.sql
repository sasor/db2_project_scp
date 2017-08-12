CREATE OR REPLACE FUNCTION actualizar_cama
(
   _id INTEGER,
   _disponible BOOLEAN
)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
BEGIN
   UPDATE cama
   SET disponible = _disponible
   WHERE id = _id RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
