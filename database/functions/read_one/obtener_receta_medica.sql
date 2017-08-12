CREATE OR REPLACE FUNCTION obtener_receta_medica
(_id INTEGER)
RETURNS SETOF receta_medica
$BODY$
DECLARE
    existe := BOOLEAN;
BEGIN
    existe := check_if_exists_record('receta_medica','id',_id);
    IF existe IS FALSE THEN
        RAISE EXCEPTION 'receta medica no existe con este id %',_id;
    END IF;
    RETURN QUERY SELECT * FROM receta_medica WHERE id=_id;
END;
$BODY$
LANGUAGE plpgsql;
