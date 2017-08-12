CREATE OR REPLACE FUNCTION actualizar_receta_medica
(
   _id INTEGER, 
   _diag_id INTEGER,
   _mid INTEGER,
   _dosif TEXT,
   _hora TIME,
   _fecha DATE
)
RETURNS INTEGER 
AS
$BODY$
DECLARE 
    last_id INTEGER;
BEGIN
   UPDATE receta_medica
   SET	 diagnostico_id = _diag_id,
	 medicamento_id = _mid,
	 dosificacion = _dosif,
	 hora = _hora,
	 fecha = _fecha
   WHERE id = _id RETURNING id INTO last_id;
   RETURN last_id;
END;
$BODY$
LANGUAGE plpgsql;

