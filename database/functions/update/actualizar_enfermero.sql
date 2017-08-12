CREATE OR REPLACE FUNCTION actualizar_enfermero
(  _ci INTEGER,
   _sexo BOOLEAN,
   _nombre CHARACTER VARYING,
   _ap CHARACTER VARYING,
   _am CHARACTER VARYING,
   _tel INTEGER,
   _dir CHARACTER VARYING
)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_ci INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('enfermero', 'ci', _ci);
   IF existe IS FALSE THEN
      RAISE EXCEPTION 'enfermero no existe con este ci %', _ci;
   END IF;

   UPDATE enfermero
   SET	 sexo = _sexo,
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
