CREATE OR REPLACE FUNCTION eliminar_internacion
(_inid INTEGER)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   existe BOOLEAN;
   done BOOLEAN;
   cid INTEGER; -- cama_id
   es_disponible BOOLEAN; -- para verificar cama disponible
BEGIN
   existe := check_if_exists_record('internacion', 'id', _inid);
   IF NOT existe THEN
      RAISE EXCEPTION 'internacion no existe';
   END IF;

   --SELECT cama_id FROM internacion WHERE id = _inid INTO cid;
   -- done := fix_dependencias_cama('cama', 'id', cid);
   /*SELECT disponible FROM cama WHERE id = cid INTO es_disponible;
   IF es_disponible IS FALSE THEN
      UPDATE cama SET disponible = '1' WHERE id = cid;
   END IF;*/
   DELETE FROM internacion WHERE id = _inid RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
