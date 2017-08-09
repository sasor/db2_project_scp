CREATE OR REPLACE FUNCTION insertar_laboratorio
(_laid INTEGER,_tel INTEGER)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('laboratorista', 'id', _laid);
   IF NOT existe THEN
      RAISE EXCEPTION 'laboratorista no existe';
   END IF;

   INSERT INTO laboratorio
   (labortorista_id,telefono)
   VALUES (_laid,_tel) RETURNING id INTO last_id;

   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
