CREATE OR REPLACE FUNCTION obtener_cita
(_id INTEGER)
RETURNS SETOF cita
$BODY$
DECLARE
    existe := BOOLEAN;
BEGIN
    existe := check_if_exists_record('paciente','id',_id);
    IF existe IS FALSE THEN
        RAISE EXCEPTION 'cita no existe con este id %',_id;
    END IF;
    RETURN QUERY SELECT * FROM cita WHERE id=_id;
END;
$BODY$
LANGUAGE plpgsql;
