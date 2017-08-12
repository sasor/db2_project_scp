CREATE OR REPLACE FUNCTION insertar_cama
(_status BOOLEAN)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
BEGIN
   INSERT INTO cama (disponible) VALUES (_status) RETURNING id INTO last_id;
END;
$BODY$
LANGUAGE plpgsql;
