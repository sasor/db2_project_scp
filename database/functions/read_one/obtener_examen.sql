CREATE OR REPLACE FUNCTION obtener_examen
(_id INTEGER)
RETURNS SETOF examen
$BODY$
DECLARE
    existe := BOOLEAN;
BEGIN
    existe := check_if_exists_record('examen','id',_id);
    IF existe IS FALSE THEN
        RAISE EXCEPTION 'examen no existe con este id %',_id;
    END IF;
    RETURN QUERY SELECT * FROM examen WHERE id=_id;
END;
$BODY$
LANGUAGE plpgsql;
