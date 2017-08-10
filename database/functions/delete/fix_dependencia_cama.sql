CREATE OR REPLACE FUNCTION fix_dependencia_cama(_tbl TEXT, _col TEXT, _cod INTEGER)
RETURNS BOOLEAN
AS
$BODY$
DECLARE
   existe BOOLEAN;
   es_disponible BOOLEAN;
   -- r INTEGER;
BEGIN
   /*existe := FALSE;
   EXECUTE format('SELECT 1 FROM %I WHERE %I = %L', _tbl, _col, _cod);
   GET DIAGNOSTICS r = ROW_COUNT;
   IF r > 0 THEN
      existe := TRUE;
   END IF;
   RETURN existe;*/

   existe := FALSE;
   EXECUTE format('SELECT disponible FROM %I WHERE %I = %L', _tbl, _col, _cod) INTO es_disponible;
   IF es_disponible IS FALSE THEN
      UPDATE cama SET disponible = '1' WHERE id = _cod;
      existe := TRUE;
   END IF; 
   RETURN existe;
END;
$BODY$
LANGUAGE plpgsql;
