CREATE OR REPLACE FUNCTION actualizar_medico
(
    _ci INTEGER, 
    _sex BOOLEAN,
    _nombre VARCHAR,
    _ap VARCHAR,
    _am VARCHAR,
    _tel INTEGER,
    _esp VARCHAR,
    _dir VARCHAR
)
RETURNS INTEGER 
AS
$BODY$
DECLARE
   last_ci INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('medico', 'ci', _ci);
   IF existe IS FALSE THEN
      RAISE EXCEPTION 'medico no existe con este ci %', _ci;
   END IF;
    UPDATE medico 
    SET	 sexo = _sex,
	 nombre = _nombre,
	 apellido_paterno = _ap,
	 apellido_materno = _am,
	 telefono = _tel,
	 especialidad = _esp,
	 direccion = _dir
    WHERE ci = _ci RETURNING ci INTO last_ci;
    RETURN last_ci;
END;
$BODY$
LANGUAGE plpgsql;
