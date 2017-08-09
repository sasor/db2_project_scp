CREATE OR REPLACE FUNCTION insertar_resultado_examen
(_examenid INTEGER, _desc TEXT)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('examen', 'id', _examenid);
   IF NOT existe THEN
      RAISE EXCEPTION 'examen no existe';
   END IF;

   INSERT INTO resultado_examen
   (examen_id, descripcion)
   VALUES (_examenid, _desc) RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;

