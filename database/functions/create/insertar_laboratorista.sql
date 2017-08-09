CREATE OR REPLACE FUNCTION insert_laboratorista
(  _ci INTEGER,
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
   existe BOOLEAN;
   last_id INTEGER;
BEGIN
   existe := check_if_exists_record('laboratorista', 'ci', _ci);

   IF NOT existe THEN
      INSERT INTO laboratorista
      (ci,sexo,nombre,apellido_paterno,apellido_materno,telefono,direccion)
      VALUES (_ci,_sexo,_nombre,_ap,_am,_tel,_dir) RETURNING ci INTO last_ci;
   ELSE
      RAISE EXCEPTION 'laboratorista ya existe';
   END IF;

   RETURN last_ci;
END
$BODY$ 
LANGUAGE plpgsql;
