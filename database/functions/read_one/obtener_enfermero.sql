CREATE OR REPLACE FUNCTION obtener_enfermero
(_ci INTEGER)
RETURNS SETOF enfermero
$BODY$
DECLARE
    existe := BOOLEAN;
BEGIN
    existe := check_if_exists_record('paciente','ci',_ci);
    IF existe IS FALSE THEN
        RAISE EXCEPTION 'enfermero no existe con este ci %',_ci;
    END IF;
    RETURN QUERY SELECT * FROM enfermero WHERE ci=_ci;
END;
$BODY$
LANGUAGE plpgsql;
