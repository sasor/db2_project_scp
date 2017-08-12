CREATE OR REPLACE FUNCTION actualizar_examen
(
   _id INTEGER,
   _diag INTEGER,
   _lab INTEGER,
   _tiex INTEGER,
   _hora TIME,
   _fecha DATE,
   _res BOOLEAN
)
RETURNS INTEGER
AS
$BODY$
DECLARE
   last_id INTEGER;
BEGIN
   UPDATE examen
   SET	 diagnostico_id = _diag,
	 laboratorio_id = _lab,
	 tipo_examen_id = _tiex,
	 hora = _hora,
	 fecha = _fecha,
	 resultado_disponible = _res
   WHERE id = _id RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;
