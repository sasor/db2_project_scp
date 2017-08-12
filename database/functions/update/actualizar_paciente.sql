CREATE OR REPLACE FUNCTION actualizar_paciente
(  _ci INTEGER,
   _sex BOOLEAN,
   _nombre CHARACTER VARYING,
   _ap CHARACTER VARYING,
   _am CHARACTER VARYING,
   _tel INTEGER,
   _fn DATE,
   _ts blood,
   _dir CHARACTER VARYING
)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_ci INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('paciente', 'ci', _ci);
   IF existe IS FALSE THEN
      RAISE EXCEPTION 'paciente no existe con este ci %', _ci;
   END IF;

   UPDATE paciente
   SET	 sexo = _sex,
	 nombre = _nombre,
	 apellido_paterno = _ap,
	 apellido_materno = _am,
	 telefono = _tel,
	 fecha_nacimiento = _fn,
	 tipo_sangre = _ts,
	 direccion = _dir
   WHERE ci = _ci RETURNING ci INTO last_ci;
   RETURN last_ci;
END;
$BODY$
LANGUAGE plpgsql;
