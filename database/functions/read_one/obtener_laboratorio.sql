CREATE OR REPLACE FUNCTION obtener_laboratorio
(_id INTEGER)
RETURNS SETOF laboratorio
$BODY$
DECLARE
    existe := BOOLEAN;
BEGIN
    existe := check_if_exists_record('laboratorio','id',_id);
    IF existe IS FALSE THEN
        RAISE EXCEPTION 'laboratorio no existe con este id %',_id;
    END IF;
    RETURN QUERY SELECT * FROM laboratorio WHERE id=_id;
END;
$BODY$
LANGUAGE plpgsql;
