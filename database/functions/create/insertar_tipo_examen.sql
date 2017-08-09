CREATE OR REPLACE FUNCTION insertar_tipo_examen
(_nom CHARACTER VARYING)
RETURNS INTEGER
AS
$BODY$
DECLARE
   existe BOOLEAN;
   last_id INTEGER;
BEGIN
   PERFORM 1 FROM tipo_examen WHERE nombre = _nom;
   IF NOT FOUND THEN
      INSERT INTO tipo_examen (nombre)
      VALUES (_nom) RETURNING id INTO last_id;
   ELSE
      RAISE EXCEPTION 'tipo examen ya existe';
   END IF;

   RETURN last_id;

END;
$BODY$
LANGUAGE plpgsql;
