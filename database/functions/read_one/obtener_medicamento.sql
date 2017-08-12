CREATE OR REPLACE FUNCTION obtener_medicamento
(_id INTEGER)
RETURNS SETOF medicamento
$BODY$
DECLARE
    existe := BOOLEAN;
BEGIN
    existe := check_if_exists_record('medicamento','ci',_ci);
    IF existe IS FALSE THEN
        RAISE EXCEPTION 'medicamento no existe con este ci %',_ci;
    END IF;
    RETURN QUERY SELECT * FROM medicamento WHERE id=_id;
END;
$BODY$
LANGUAGE plpgsql;
