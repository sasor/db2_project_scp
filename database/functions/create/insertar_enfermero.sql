CREATE OR REPLACE FUNCTION insertar_enfermero
(_ci INTEGER,
_sexo BOOLEAN,
_nombre CHARACTER VARYING,
_ap CHARACTER VARYING,
_am CHARACTER VARYING,
_tel INTEGER,
_dir CHARACTER VARYING)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_ci INTEGER;
   existe BOOLEAN;
BEGIN
   existe := check_if_exists_record('enfermero', 'ci', _ci);
   INSERT INTO enfermero
   (ci,sexo,nombre,apellido_paterno,apellido_materno,telefono,direccion) 
   VALUES (_ci,_sexo,_nombre,_ap,_am,_tel,_dir) RETURNING ci INTO last_ci;
   RETURN last_ci;
END;
$BODY$ 
LANGUAGE plpgsql;
