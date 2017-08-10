CREATE OR REPLACE FUNCTION eliminar_medicamento
(_medicamento_id INTEGER)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('medicamento', 'id', _medicamento_id);
   IF NOT existe THEN
      RAISE EXCEPTION 'medicamento no existe';
   END IF;

   DELETE FROM medicamento WHERE id = _medicamento_id RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
