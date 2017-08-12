CREATE OR REPLACE FUNCTION obtener_medico
(_ci INTEGER)
RETURNS SETOF medico
$BODY$
DECLARE
    existe := BOOLEAN;
BEGIN
    existe := check_if_exists_record('medico','ci',_ci);
    IF existe IS FALSE THEN
        RAISE EXCEPTION 'medico no existe con este ci %',_ci;
    END IF;
    RETURN QUERY SELECT * FROM medico WHERE ci=_ci;
END;
$BODY$
LENGUAGE plpgsql;
