CREATE OR REPLACE FUNCTION obtener_cama
(_id INTEGER)
RETURNS SETOF cama
$BODY$
DECLARE
    existe := BOOLEAN;
BEGIN
    existe := check_if_exists_record('cama','id',_id);
    IF existe IS FALSE THEN
        RAISE EXCEPTION 'cama no existe con este id %',_id;
    END IF;
    RETURN QUERY SELECT * FROM cama WHERE id=_id;
END;
$BODY$
LANGUAGE plpgsql;
