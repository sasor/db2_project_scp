CREATE OR REPLACE FUNCTION bitacora_cama()
RETURNS TRIGGER 
AS
$BODY$
-- id serial status boolean
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO bitacora_cama
        (accion,fecha,fields)
        VALUES(TG_OP,NOW(),row_to_json(NEW));
        RETURN NEW;
    END IF;

    IF TG_OP = 'DELETE' THEN
        INSERT INTO bitacora_cama
        (accion,fecha,fields)
        VALUES(TG_OP,NOW(),row_to_json(OLD));
        RETURN OLD;
    END IF;
    
    IF TG_OP = 'UPDATE' THEN
        INSERT INTO bitacora_cama
        (accion,fecha,fields)
        VALUES('BEFORE UPDATE',NOW(),row_to_json(NEW));
        INSERT INTO bitacora_cama
        (accion,fecha,fields)
        VALUES('AFTER UPDATE',NOW(),row_to_json(OLD));
        RETURN NEW;
    END IF;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER bitacora_cama
AFTER INSERT OR UPDATE OR DELETE
ON cama
FOR EACH ROW
EXECUTE PROCEDURE bitacora_cama();
