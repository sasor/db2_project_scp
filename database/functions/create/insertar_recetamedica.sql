CREATE OR REPLACE FUNCTION insertar_receta_medica
(_did INTEGER, _mid INTEGER, _dos TEXT, _hora TIME, _fecha DATE)
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

   existe := check_if_exists_record('medicamento', 'id', _mid);
   IF NOT existe THEN
      RAISE EXCEPTION 'medicamento no existe';
   END IF;

   INSERT INTO receta_medica
   (diagnostico_id,medicamento_id,dosificacion,hora,fecha)
    VALUES
   (_did, _mid, _dos, _hora, _fecha) RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
