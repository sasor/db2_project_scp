CREATE OR REPLACE FUNCTION insertar_internacion
(_did INTEGER, _camaid INTEGER, _fecha DATE, _hora TIME)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
   pass BOOLEAN;
BEGIN
   pass := check_internacion(_did, _camaid);
   INSERT INTO internacion
   (diagnostico_id, cama_id, fecha, hora)
   VALUES (_did, _camaid, _fecha, _hora) RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
