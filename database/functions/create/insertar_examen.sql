CREATE OR REPLACE FUNCTION insertar_examen
(_did INTEGER, _lid INTEGER, _tid INTEGER, _hora TIME, _fecha DATE, _rel BOOLEAN)
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

   existe := check_if_exists_record('laboratorio', 'id', _lid);
   IF NOT existe THEN
      RAISE EXCEPTION 'laboratorio no existe';
   END IF;

   existe := check_if_exists_record('tipo_examen', 'id', _tid);
   IF NOT existe THEN
      RAISE EXCEPTION 'tipo examen no existe';
   END IF;

   INSERT INTO examen
   (diagnostico_id,laboratorio_id,tipo_examen_id,hora,fecha,resultado_disponible)
   VALUES (_did, _lid, _tid, _hora, _fecha, _rel) RETURNING id INTO last_id;

   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;

