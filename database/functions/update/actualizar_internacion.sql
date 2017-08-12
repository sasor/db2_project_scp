CREATE OR REPLACE FUNCTION actualizar_internacion
(
    _id INTEGER,
    _diag_id INTEGER,
    _cama_id INTEGER,
    _fecha DATE,
    _hora TIME
)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('internacion', 'id', _id);
   IF NOT existe THEN
      RAISE EXCEPTION 'internacion no existe';
   END IF;

   UPDATE internacion
   SET	 diagnostico_id = _diag_id,
	 cama_id = _cama_id,
	 fecha = _fecha,
	 hora = _hora
   WHERE id = _id RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
