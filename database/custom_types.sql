CREATE TYPE blood AS ENUM
(
   'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
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

CREATE TYPE estapa AS ENUM
(
   'grave', 'critico', 'estable'
);
