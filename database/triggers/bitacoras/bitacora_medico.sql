CREATE OR REPLACE FUNCTION bitacora_medico()
RETURNS TRIGGER
AS
$BODY$
DECLARE
    new_f RECORD;
    old_f RECORD;
BEGIN
    IF TG_OP = 'INSERT' THEN
        IF NEW.sexo IS TRUE THEN 
            new_f := (NEW.ci,
                'male',
                NEW.nombre,
                NEW.apellido_paterno,
                NEW.apellido_materno,
                NEW.telefono,
                NEW.especialidad,
                NEW.direccion)::json_medico;
        ELSE
            new_f := (NEW.ci,
                'female',
                NEW.nombre,
                NEW.apellido_paterno,
                NEW.apellido_materno,
                NEW.telefono,
                NEW.especialidad,
                NEW.direccion)::json_medico;
        END IF;
        INSERT INTO bitacora_medico(accion,fecha,fields)
        VALUES(TG_OP, NOW(), row_to_json(new_f));
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        IF OLD.sexo IS TRUE THEN
            old_f := (OLD.ci,
                'male',
                OLD.nombre,
                OLD.apellido_paterno,
                OLD.apellido_materno,
                OLD.telefono,
                OLD.especialidad,
                OLD.direccion)::json_medico;
        ELSE
            old_f := (OLD.ci,
                'female',
                OLD.nombre,
                OLD.apellido_paterno,
                OLD.apellido_materno,
                OLD.telefono,
                OLD.especialidad,
                OLD.direccion)::json_medico;
        END IF;
        INSERT INTO bitacora_medico(accion,fecha,fields)
        VALUES(TG_OP, NOW(), row_to_json(old_f));
        RETURN NULL;
    ELSIF TG_OP = 'UPDATE' THEN 
        IF NEW.sexo IS TRUE THEN 
            new_f := (NEW.ci,
                'male',
                NEW.nombre,
                NEW.apellido_paterno,
                NEW.apellido_materno,
                NEW.telefono,
                NEW.especialidad,
                NEW.direccion)::json_medico;
        ELSE 
            new_f := (NEW.ci,
                'female',
                NEW.nombre,
                NEW.apellido_paterno,
                NEW.apellido_materno,
                NEW.telefono,
                NEW.especialidad,
                NEW.direccion)::json_medico;
        END IF;
        IF OLD.sexo IS TRUE THEN
            old_f := (OLD.ci,
                'male',
                OLD.nombre,
                OLD.apellido_paterno,
                OLD.apellido_materno,
                OLD.telefono,
                OLD.especialidad,
                OLD.direccion)::json_medico;
        ELSE
            old_f := (OLD.ci,
                'female',
                OLD.nombre,
                OLD.apellido_paterno,
                OLD.apellido_materno,
                OLD.telefono,
                OLD.especialidad,
                OLD.direccion)::json_medico;
        END IF;
        INSERT INTO bitacora_medico(accion,fecha,fields)
        VALUES('BEFORE UPDATE', NOW(), row_to_json(old_f));
        INSERT INTO bitacora_medico(accion,fecha,fields)
        VALUES('AFTER UPDATE', NOW(), row_to_json(new_f));
        RETURN NEW;
    END IF;
    END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER bitacora_medico
AFTER INSERT OR UPDATE OR DELETE
ON medico
FOR EACH ROW
EXECUTE PROCEDURE bitacora_medico();
