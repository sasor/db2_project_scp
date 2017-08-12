CREATE OR REPLACE FUNCTION obtener_laboratorista
(_ci INTEGER)
RETURNS SETOF laboratorista
$BODY$
DECLARE
    existe := BOOLEAN;
BEGIN
    existe := check_if_exists_record('laboratorista','ci',_ci);
    IF existe IS FALSE THEN
        RAISE EXCEPTION 'laboratorista no existe con este ci %',_ci;
    END IF;
    RETURN QUERY SELECT * FROM laboratorista WHERE ci=_ci;
END;
$BODY$
LANGUAGE plpgsql;
