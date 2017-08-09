CREATE OR REPLACE FUNCTION 
insert_enfermero(_ci INTEGER,
	       _sexo BOOLEAN,
	       _nombre CHARACTER VARYING,
	       _ap CHARACTER VARYING,
	       _am CHARACTER VARYING,
	       _tel CHARACTER VARYING,
	       _dir CHARACTER VARYING)
RETURNS BOOLEAN
AS
$BODY$
DECLARE
   valid BOOLEAN;
BEGIN
   valid := FALSE;
   IF NOT EXISTS (SELECT 1 FROM enfermero WHERE ci = _ci) THEN
      INSERT INTO enfermero
      (ci,sexo,nombre,apellido_paterno,apellido_materno,telefono,direccion) 
      VALUES (_ci,_sexo,_nombre,_ap,_am,_tel,_dir);
      valid := TRUE;
   END IF; 
   RETURN valid;
END
$BODY$ 
LANGUAGE plpgsql;
