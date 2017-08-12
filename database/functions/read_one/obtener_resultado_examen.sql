CREATE OR REPLACE FUNCTION obtener_resultado_examen
(_id INTEGER)
RETURNS SETOF resultado_examen
$BODY$
DECLARE
    existe := BOOLEAN;
BEGIN
    existe := check_if_exists_record('resultado_examen','id',_id);
    IF existe IS FALSE THEN
        RAISE EXCEPTION 'resultado de examen no existe con este id %',_id;
    END IF;
    RETURN QUERY SELECT * FROM resultado_examen WHERE id=_id;
END;
$BODY$
LANGUAGE plpgsql;
