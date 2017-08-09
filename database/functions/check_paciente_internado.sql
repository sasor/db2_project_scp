CREATE OR REPLACE FUNCTION check_paciente_internado
(_pid INTEGER, _inid INTEGER, _enfermeroid INTEGER)
RETURNS BOOLEAN
AS
$BODY$
DECLARE
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('paciente', 'ci', _pid);
   IF NOT is_exists THEN
      RAISE EXCEPTION 'paciente no existe';
   END IF; 

   existe := check_if_exists_record('internacion', 'id', _inid);
   IF NOT is_exists THEN
      RAISE EXCEPTION 'internacion no existe';
   END IF;

   existe := check_if_exists_record('enfermero', 'ci', _enfermeroid);
   IF NOT is_exists THEN
      RAISE EXCEPTION 'enfermero no existe';
   END IF;

   RETURN TRUE;
END;
$BODY$
LANGUAGE plpgsql;
