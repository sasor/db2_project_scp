CREATE OR REPLACE FUNCTION fix_dependencia_examen(_tbl TEXT, _col TEXT, _cod INTEGER)
RETURNS VOID
AS
$BODY$
DECLARE
   es_disponible BOOLEAN;
BEGIN
   EXECUTE format('SELECT resultado_disponible FROM %I WHERE %I = %L', _tbl, _col, _cod) INTO es_disponible;
   IF es_disponible IS TRUE THEN
      UPDATE examen SET resultado_disponible = '0' WHERE id = _cod;
   END IF; 
END;
$BODY$
LANGUAGE plpgsql;
