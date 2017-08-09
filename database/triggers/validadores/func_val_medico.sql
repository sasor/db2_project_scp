CREATE OR REPLACE FUNCTION val_entries_medico()
RETURNS TRIGGER
AS
$BODY$
BEGIN
   -- IF NEW.ci::TEXT !~ '^[0-9]+$' THEN
     --  RAISE EXCEPTION 'ci debe ser de tipo entero positivo';
   -- END IF;
   -- CI
   IF NEW.ci IS NULL THEN --OR NEW.ci::TEXT !~ E'^\\d{1}$' THEN
      RAISE EXCEPTION 'ci no debe ser null o vacio';
   END IF;
   IF NEW.ci::TEXT !~ E'^\\d{6,7}$' THEN
      RAISE EXCEPTION 'ci debe igual o mayor a 6 digitos y menor a 7 digitos';
   END IF;

   -- nombre
   IF NEW.nombre IS NULL OR Length(NEW.nombre) = 0 THEN
      RAISE EXCEPTION 'nombre no debe ser nulo o vacio';
   END IF;
   IF NEW.nombre ~ '[0-9]+' THEN
      RAISE EXCEPTION 'nombre debe contener solo caracteres';
   END IF;

   -- apellido paterno
   IF NEW.apellido_paterno IS NULL OR Length(NEW.apellido_paterno) = 0 THEN
      RAISE EXCEPTION 'apellido paterno no debe ser nulo o vacio';
   END IF;
   IF NEW.apellido_paterno ~ '[0-9]+' THEN
      RAISE EXCEPTION 'apellido paterno debe contener solo caracteres';
   END IF;

   -- apellido materno
   IF NEW.apellido_materno ~ '[0-9]+' THEN
      RAISE EXCEPTION 'apellido materno debe contener solo caracteres';
   END IF;
   IF NEW.apellido_materno IS NULL OR Length(NEW.apellido_materno) = 0 THEN
      NEW.apellido_materno = 'NaN';
   END IF;

   -- telefono
   IF NEW.telefono::TEXT !~ E'^\\d{8}$' THEN
      RAISE EXCEPTION 'telefono debe ser igual a 8 digitos';
   END IF;

   -- especialidad
   IF NEW.especialidad IS NULL OR Length(NEW.especialidad) = 0 THEN
      RAISE EXCEPTION 'especialidad no debe ser nulo o vacio';
   END IF;
   IF NEW.especialidad::TEXT ~ '[0-9]+' THEN
      RAISE EXCEPTION 'especialidad debe contener solo caracteres';
   END IF;

   -- direccion
   IF NEW.direccion IS NULL OR Length(NEW.direccion) = 0 THEN
      RAISE EXCEPTION 'direccion no debe ser nulo o vacio';
   END IF;

   RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;


CREATE TRIGGER val_entries_medico
BEFORE INSERT OR UPDATE
ON medico
FOR EACH ROW
EXECUTE PROCEDURE  val_entries_medico();
