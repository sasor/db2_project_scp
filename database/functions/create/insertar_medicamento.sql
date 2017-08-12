CREATE OR REPLACE FUNCTION insertar_medicamento(_nombre CHARACTER VARYING)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
BEGIN
   INSERT INTO medicamento (nombre)
   VALUES (_nombre) RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$ 
LANGUAGE plpgsql;
