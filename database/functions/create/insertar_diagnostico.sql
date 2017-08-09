CREATE OR REPLACE FUNCTION insertar_diagnostico
(_cid INTEGER, _sintoma TEXT, _desc TEXT)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('cita', 'id', _cid);
   IF NOT existe THEN
      RAISE EXCEPTION 'cita no existe';
   END IF;

   INSERT INTO diagnostico
   (cita_id, sintoma, descripcion)
   VALUES (_cid, _sintoma, _desc) RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
