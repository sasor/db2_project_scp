CREATE OR REPLACE FUNCTION obtener_diagostico
(_id INTEGER)
RETURNS SETOF diagnostico
$BODY$
DECLARE
    existe := BOOLEAN;
BEGIN
    existe := check_if_exists_record('diagnostico','id',_id);
    IF existe IS FALSE THEN
        RAISE EXCEPTION 'diagnostico no existe con este ci %',_ci;
    END IF;
    RETURN QUERY SELECT * FROM diagnostico WHERE id=_id;
END;
$BODY$
LANGUAGE plpgsql;
