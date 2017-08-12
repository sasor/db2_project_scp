CREATE OR REPLACE FUNCTION obtener_internacion
(_id INTEGER)
RETURNS SETOF internacion
$BODY$
DECLARE
    existe := BOOLEAN;
BEGIN
    existe := check_if_exists_record('internacion','id',_id);
    IF existe IS FALSE THEN
        RAISE EXCEPTION 'internacion no existe con este id %',_id;
    END IF;
    RETURN QUERY SELECT * FROM internacion WHERE id=_id;
END;
$BODY$
LANGUAGE plpgsql;
