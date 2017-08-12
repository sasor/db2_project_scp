CREATE OR REPLACE FUNCTION obtener_tipo_examen
(_id INTEGER)
RETURNS SETOF tipo_examen
AS
$BODY$
DECLARE
    existe := BOOLEAN;
BEGIN
    existe := check_if_exists_record('tipo_examen','id',_id);
    IF existe IS FALSE THEN
        RAISE EXCEPTION 'tipo de examen no existe con este id %',_id;
    END IF;
    RETURN QUERY SELECT * FROM tipo_examen WHERE id=_id;
END;
$BODY$
LANGUAGE plpgsql;
