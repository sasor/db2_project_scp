CREATE OR REPLACE FUNCTION check_cita
(_pid INTEGER, _mid INTEGER)
RETURNS BOOLEAN
AS
$BODY$
DECLARE
   is_exists BOOLEAN;
BEGIN
   is_exists := check_if_exists_record('paciente', 'ci', _pid);
   IF NOT is_exists THEN
      RAISE EXCEPTION 'paciente no existe';
   END IF; 

   is_exists := check_if_exists_record('medico', 'ci', _mid);
   IF NOT is_exists THEN
      RAISE EXCEPTION 'medico no existe';
   END IF;

   RETURN TRUE;
END;
$BODY$
LANGUAGE plpgsql;
