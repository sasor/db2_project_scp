CREATE OR REPLACE FUNCTION insertar_paciente_internado
(_pid INTEGER, _inid INTEGER, _enfermeroid INTEGER)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   pass BOOLEAN;
BEGIN
   pass := check_paciente_internado(_pid,_inid,_enfermeroid);
   INSERT INTO paciente_internado
   (paciente_id,internacion_id,enfermero_id)
   VALUES (_pid, _inid, _enfermeroid) RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
