CREATE OR REPLACE FUNCTION actualizar_paciente
(  _ci INTEGER,
   _sexo BOOLEAN,
   _nombre CHARACTER VARYING,
   _ap CHARACTER VARYING,
   _am CHARACTER VARYING,
   _tel INTEGER,
   _fn DATE,
   _ts blood,
   _dir CHARACTER VARYING)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_ci INTEGER;
   exists_record BOOLEAN;
BEGIN
   exists_record := check_if_exists_record('paciente', 'ci', _ci);
   IF NOT exists_record THEN
      INSERT INTO paciente
      (ci,sexo,nombre,apellido_paterno,apellido_materno,telefono,fecha_nacimiento,tipo_sangre,direccion)
      VALUES (_ci,_sexo,_nombre,_ap,_am,_tel,_fn,_ts,_dir) RETURNING ci INTO last_ci;
      RETURN last_ci;
   ELSE
      RAISE EXCEPTION 'paciente ya existe';
   END IF;
END;
$BODY$
LANGUAGE plpgsql;
