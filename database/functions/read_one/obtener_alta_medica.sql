CREATE OR REPLACE FUNCTION obtener_alta_medica
(_id INTEGER)
RETURNS SETOF alta_medica
$BODY$
DECLARE
    existe := BOOLEAN;
BEGIN
    existe := check_if_exists_record('alta_medica','id',_id);
    IF existe IS FALSE THEN
        RAISE EXCEPTION 'alta medica no existe con este id %',_id;
    END IF;
    RETURN QUERY SELECT * FROM alta_medica WHERE id=_id;
END;
$BODY$
LANGUAGE plpgsql;
