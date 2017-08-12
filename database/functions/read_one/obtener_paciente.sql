CREATE OR REPLACE FUNCTION obtener_paciente
(_ci INTEGER)
RETURNS SETOF paciente
$BODY$
DECLARE
    existe := BOOLEAN;
BEGIN
    existe := check_if_exists_record('paciente','ci',_ci);
    IF existe IS FALSE THEN
        RAISE EXCEPTION 'paciente no existe con este ci %',_ci;
    END IF;
    RETURN QUERY SELECT * FROM paciente WHERE ci=_ci;
END;
$BODY$
LANGUAGE plpgsql;
