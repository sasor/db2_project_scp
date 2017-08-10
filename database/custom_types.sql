CREATE TYPE blood AS ENUM
(
   'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
);

CREATE TYPE estapa AS ENUM
(
   'grave', 'critico', 'estable'
);

CREATE TYPE json_paciente
AS
(
   ci int,
   sexo text,
   nombre text,
   apellido_paterno text,
   apellido_materno text,
   telefono text,
   fecha_nacimiento text,
   tipo_sangre text,
   direccion text
);

CREATE TYPE json_cita
AS
(
   cita_id int,
   cita_hora TIME,
   cita_fecha DATE,
   paciente_ci int,
   paciente_nombre text,
   paciente_apellido_paterno text,
   paciente_apellido_materno text,
   medico_ci int,
   medico_nombre text,
   medico_apellido_paterno text,
   medico_apellido_materno text
);

CREATE TYPE json_medico
AS
(
   ci int,
   sexo text,
   nombre text,
   apellido_paterno text,
   apellido_materno text,
   telefono text,
   especialidad text,
   direccion text
);

CREATE TYPE json_enfermero
AS
(
   ci int,
   sexo text,
   nombre text,
   apellido_paterno text,
   apellido_materno text,
   telefono text,
   direccion text
);

CREATE TYPE json_laboratorista
AS
(
   ci int,
   laboratorio_id int,
   sexo text,
   nombre text,
   apellido_paterno text,
   apellido_materno text,
   telefono text,
   direccion text
);

/*CREATE TYPE json_laboratorio
AS
(
   laboratorio_id int,
   laboratorio_telefono text,
   laboratorista_ci int,
   laboratorista_nombre text,
   laboratorista_apellido_paterno text,
   laboratorista_apellido_materno text
);*/

CREATE TYPE json_receta
AS
(
   receta_id int,
   diagnostico_id int,
   medicamento_id int,
   medicamento_nombre text,
   dosificacion text,
   hora text,
   fecha text
);

CREATE TYPE json_internado
AS
(
   pac_internado_id int,
   internacion_id int,
   cama_id int,
   paciente_id int,
   paciente_nombre text,
   paciente_apellido_paterno text,
   paciente_apellido_materno text,
   enfermero_id int,
   enfermero_nombre text,
   enfermero_apellido_paterno text,
   enfermero_apellido_materno text
);
