CREATE OR REPLACE FUNCTION actualizar_laboratorista
(
    _ci INTEGER,
    _lab_id INTEGER,
    _sex BOOLEAN,
    _nombre VARCHAR,
    _ap VARCHAR,
    _am VARCHAR,
    _tel INTEGER,
    _dir VARCHAR
)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_ci INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('laboratorista', 'ci', _ci);
   IF existe IS FALSE THEN
      RAISE EXCEPTION 'laboratorista no existe con este ci %', _ci;
   END IF;

   UPDATE laboratorista
   SET	 laboratorio_id = _lab_id,
	 sexo = _sex,
	 nombre = _nombre,
	 apellido_paterno = _ap,
	 apellido_materno = _am,
	 telefono = _tel,
	 direccion = _dir
    WHERE ci = _ci RETURNING ci INTO last_ci;
    RETURN last_ci;
END;
$BODY$
LANGUAGE plpgsql;
