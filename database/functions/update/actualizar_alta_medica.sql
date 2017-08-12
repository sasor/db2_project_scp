CREATE OR REPLACE FUNCTION actualizar_alta_medica
(
   _id INTEGER,
   _diag INTEGER,
   _stat BOOLEAN
   _hora TIME,
   _fecha DATE
)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
BEGIN
   UPDATE alta_medica
   SET	 diagnostico_id = _diag,
	 status = _stat,
	 hora = _hora,
	 fecha = _fecha
   WHERE id = _id RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
