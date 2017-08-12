CREATE OR REPLACE FUNCTION obtener_paciente_internado
(_id INTEGER)
RETURNS SETOF paciente_internado
$BODY$
DECLARE
    existe := BOOLEAN;
BEGIN
    existe := check_if_exists_record('paciente','id',_id);
    IF existe IS FALSE THEN
        RAISE EXCEPTION 'internacion de paciente no existe con este id %',_id;
    END IF;
    RETURN QUERY SELECT * FROM paciente_internado WHERE id=_id;
END;
$BODY$
LANGUAGE plpgsql;
