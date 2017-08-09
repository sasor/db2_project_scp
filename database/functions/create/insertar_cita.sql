CREATE OR REPLACE FUNCTION insertar_cita
(_pid INTEGER, _mid INTEGER, _hora TIME, _fecha DATE)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   pass BOOLEAN;
BEGIN
   pass := check_cita(_pid, _mid);
   --IF pass THEN
   --END IF;
   INSERT INTO cita
   (paciente_id, medico_id, hora, fecha)
   VALUES
   (_pid, _mid, _hora, _fecha) RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
