CREATE OR REPLACE FUNCTION insertar_alta_medica
(_did INTEGER, _stat BOOLEAN, _hora TIME, _fecha DATE)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('diagnostico', 'id', _did);
   IF NOT existe THEN
      RAISE EXCEPTION 'diagnostico no existe';
   END IF;

   INSERT INTO alta_medica
      (diagnostico_id, status, hora, fecha)
    VALUES
      (_did, _stat, _hora, _fecha) RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
