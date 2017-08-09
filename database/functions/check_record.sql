CREATE OR REPLACE FUNCTION check_if_exists_record(_tbl TEXT, _col TEXT, _cod INTEGER)
RETURNS BOOLEAN
AS
$BODY$
DECLARE
   existe BOOLEAN;
   r INTEGER;
BEGIN
   existe := FALSE;
   EXECUTE format('SELECT 1 FROM %I WHERE %I = %L', _tbl, _col, _cod);
   GET DIAGNOSTICS r = ROW_COUNT;
   IF r > 0 THEN
      existe := TRUE;
   END IF;
   RETURN existe;
END;
$BODY$
LANGUAGE plpgsql;
