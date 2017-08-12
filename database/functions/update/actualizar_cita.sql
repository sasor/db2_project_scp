CREATE OR REPLACE FUNCTION actualizar_cita
(
   _id INTEGER,
   _pid INTEGER,
   _mid INTEGER,
   _hora TIME,
   _fecha DATE
)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   pass BOOLEAN;
BEGIN
   pass := check_cita(_pid, _mid);
   UPDATE cita
   SET	 paciente_id = _pid,
	 medico_id = _mid,
	 hora = _hora,
	 fecha = _fecha
   WHERE id = _id RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
