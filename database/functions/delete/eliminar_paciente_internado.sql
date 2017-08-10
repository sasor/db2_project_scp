CREATE OR REPLACE FUNCTION eliminar_paciente_internado
(_pinid INTEGER)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('paciente_internado', 'id', _pinid);
   IF NOT existe THEN
      RAISE EXCEPTION 'paciente_internado no existe';
   END IF;

   DELETE FROM paciente_internado WHERE id = _pinid RETURNING id INTO last_id;

   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
