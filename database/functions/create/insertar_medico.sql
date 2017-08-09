CREATE OR REPLACE FUNCTION insert_medico
(  _ci INTEGER,
   _sexo BOOLEAN,
   _nombre CHARACTER VARYING,
   _ap CHARACTER VARYING,
   _am CHARACTER VARYING,
   _tel INTEGER,
   _esp CHARACTER VARYING,
   _dir CHARACTER VARYING)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_ci INTEGER;
BEGIN
   INSERT INTO medico
   (ci,sexo,nombre,apellido_paterno,apellido_materno,telefono,especialidad,direccion)
   VALUES (_ci,_sexo,_nombre,_ap,_am,_tel,_esp,_dir) RETURNING ci INTO last_ci;
   RETURN last_ci;
END;
$BODY$ 
LANGUAGE plpgsql;
