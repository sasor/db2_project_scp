CREATE TABLE paciente
(
   ci integer,
   sexo boolean,
   nombre varchar(50),
   apellido_paterno varchar(50),
   apellido_materno varchar(50),
   telefono integer,
   fecha_nacimiento date,
   tipo_sangre blood,
   direccion varchar(150),
   CONSTRAINT pk_paciente PRIMARY KEY (ci)
);

CREATE TABLE bitacora_paciente
(
   id serial,
   accion varchar(20),
   fecha timestamp,
   fields json
);

CREATE TABLE medico
(
   ci integer,
   sexo boolean,
   nombre varchar(50),
   apellido_paterno varchar(50),
   apellido_materno varchar(50),
   telefono integer,
   especialidad varchar(50),
   direccion varchar(150),
   CONSTRAINT pk_medico PRIMARY KEY (ci)
);

CREATE TABLE bitacora_medico
(
   id serial,
   accion varchar(20),
   fecha timestamp,
   fields json
);

CREATE TABLE enfermero
(
   ci integer,
   sexo boolean,
   nombre varchar(50),
   apellido_paterno varchar(50),
   apellido_materno varchar(50),
   telefono integer,
   direccion varchar(150),
   CONSTRAINT pk_enfermero PRIMARY KEY (ci)
);

CREATE TABLE bitacora_enfermero
(
   id serial,
   accion varchar(20),
   fecha timestamp,
   fields json
);

CREATE TABLE laboratorista
(
   ci integer,
   laboratorio_id integer NOT NULL CHECK (laboratorio_id > 0),
   sexo boolean,
   nombre varchar(50),
   apellido_paterno varchar(50),
   apellido_materno varchar(50),
   telefono integer,
   direccion varchar(150),
   CONSTRAINT pk_laboratorista PRIMARY KEY (ci),
   CONSTRAINT fk_laboratorista FOREIGN KEY (laboratorio_id) REFERENCES
laboratorio(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE bitacora_laboratorista
(
   id serial,
   accion varchar(20),
   fecha timestamp,
   fields json
);

CREATE TABLE cama
(
   id serial,
   -- numero smallint NOT NULL CHECK (numero > 0),
   disponible boolean NOT NULL,
   CONSTRAINT pk_cama PRIMARY KEY (id)
);

CREATE TABLE medicamento
(
   id serial,
   nombre varchar(50) NOT NULL,
   CONSTRAINT pk_medicamento PRIMARY KEY (id)
);

CREATE TABLE bitacora_medicamento
(
   id serial,
   accion varchar(20),
   fecha timestamp,
   fields json
);

CREATE TABLE cita
(
   id serial,
   paciente_id integer NOT NULL CHECK (paciente_id > 0),
   medico_id integer NOT NULL CHECK (medico_id > 0),
   hora time NOT NULL,
   fecha date NOT NULL,
   CONSTRAINT pk_cita PRIMARY KEY (id),
   CONSTRAINT fk_cita_paciente FOREIGN KEY (paciente_id) REFERENCES paciente(ci)
ON UPDATE CASCADE ON DELETE CASCADE,
   CONSTRAINT fk_cita_medico FOREIGN KEY (medico_id) REFERENCES medico(ci) ON
UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE bitacora_cita
(
   id serial,
   accion varchar(20),
   fecha timestamp,
   fields json
);

CREATE TABLE diagnostico
(
   id serial,
   cita_id integer NOT NULL UNIQUE CHECK (cita_id > 0),
   sintoma text,
   descripcion text,
   CONSTRAINT pk_diagnostico PRIMARY KEY (id),
   CONSTRAINT fk_diagnostico_cita FOREIGN KEY (cita_id) REFERENCES cita(id) ON
UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE receta_medica
(
   id serial,
   diagnostico_id integer NOT NULL CHECK (diagnostico_id > 0),
   medicamento_id integer NOT NULL CHECK (medicamento_id > 0),
   dosificacion text,
   hora time NOT NULL,
   fecha date NOT NULL,
   CONSTRAINT pk_receta PRIMARY KEY (id),
   CONSTRAINT fk_receta_diagnostico FOREIGN KEY (diagnostico_id) REFERENCES
diagnostico(id) ON UPDATE CASCADE ON DELETE CASCADE,
   CONSTRAINT fk_receta_medicamento FOREIGN KEY (medicamento_id) REFERENCES
medicamento(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE bitacora_receta_medica
(
   id serial,
   accion varchar(20),
   fecha timestamp,
   fields json
);

CREATE TABLE internacion
(
   id serial,
   diagnostico_id integer NOT NULL CHECK (diagnostico_id > 0),
   cama_id integer NOT NULL CHECK (cama_id > 0),
   fecha date NOT NULL,
   hora time NOT NULL,
   CONSTRAINT pk_internacion PRIMARY KEY (id),
   CONSTRAINT fk_internacion FOREIGN KEY (diagnostico_id) REFERENCES
diagnostico(id) ON UPDATE CASCADE ON DELETE CASCADE,
   CONSTRAINT fk_internacion_cama FOREIGN KEY (cama_id) REFERENCES cama(id) ON
UPDATE CASCADE ON DELETE CASCADE
); 

CREATE TABLE paciente_internado
(
   id serial,
   paciente_id integer NOT NULL CHECK (paciente_id > 0),
   internacion_id integer NOT NULL CHECK (internacion_id > 0),
   enfermero_id integer NOT NULL CHECK (enfermero_id > 0),
   CONSTRAINT pk_paciente_internado PRIMARY KEY (id),
   CONSTRAINT fk_paciente_internado_enfermero FOREIGN KEY (enfermero_id)
REFERENCES enfermero(ci) ON UPDATE CASCADE ON DELETE CASCADE,
   CONSTRAINT fk_paciente_internado_paciente FOREIGN KEY (paciente_id)
REFERENCES paciente(ci) ON UPDATE CASCADE ON DELETE CASCADE,
   CONSTRAINT fk_paciente_internado_internacion FOREIGN KEY (internacion_id)
REFERENCES internacion(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE bitacora_paciente_internado
(
   id serial,
   accion varchar(20),
   fecha timestamp,
   fields json
);

/*CREATE TABLE orden_examen
(
   id serial,
   diagnostico_id integer NOT NULL CHECK (diagnostico_id > 0),
   CONSTRAINT pk_orden_examen PRIMARY KEY (id),
   CONSTRAINT fk_orden_examen_diagnostico FOREIGN KEY (diagnostico_id) REFERENCES
diagnostico(id)
);*/

CREATE TABLE alta_medica
(
   id serial,
   diagnostico_id integer NOT NULL CHECK (diagnostico_id > 0),
   status boolean NOT NULL,
   hora time NOT NULL,
   fecha date NOT NULL,
   CONSTRAINT pk_alta_medica PRIMARY KEY (id),
   CONSTRAINT fk_alta_medica_diagnostico FOREIGN KEY (diagnostico_id) REFERENCES
diagnostico(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE laboratorio
(
   id serial,
   -- laboratorista_id integer NOT NULL CHECK (laboratorista_id > 0),
   telefono integer NOT NULL,
   CONSTRAINT pk_laboratorio PRIMARY KEY (id)
   -- CONSTRAINT fk_laboratorio_laboratorista FOREIGN KEY (laboratorista_id)
   -- REFERENCES laboratorista(ci) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE bitacora_laboratorio
(
   id serial,
   accion varchar(20),
   fecha timestamp,
   fields json
);

/*CREATE TABLE receta_medicamento
(
   id serial,
   medicamento_id integer NOT NULL CHECK (medicamento_id > 0),
   receta_id integer NOT NULL CHECK (receta_id > 0),
   cantidad varchar(50) NOT NULL,
   CONSTRAINT pk_receta_medicamento PRIMARY KEY (id),
   CONSTRAINT fk_receta_medicamento_medicamento FOREIGN KEY (medicamento_id)
REFERENCES medicamento(id),
   CONSTRAINT fk_receta_medicamento_receta FOREIGN KEY (receta_id) REFERENCES
receta(id)
);*/

CREATE TABLE tipo_examen
(
   id serial,
   nombre varchar(50) NOT NULL,
   CONSTRAINT pk_tipo_examen PRIMARY KEY (id)
);

CREATE TABLE examen
(
   id serial,
   diagnostico_id integer NOT NULL CHECK (diagnostico_id > 0),
   laboratorio_id integer NOT NULL CHECK (laboratorio_id > 0),
   tipo_examen_id integer NOT NULL CHECK (tipo_examen_id > 0),
   hora time,
   fecha date,
   resultado_disponible boolean NOT NULL DEFAULT FALSE,
   -- orden_examen_id integer NOT NULL CHECK (orden_examen_id > 0),
   CONSTRAINT pk_examen PRIMARY KEY (id),
   CONSTRAINT fk_examen_diagnostico FOREIGN KEY (diagnostico_id) REFERENCES
diagnostico(id) ON UPDATE CASCADE ON DELETE CASCADE,
   CONSTRAINT fk_examen_laboratorio FOREIGN KEY (laboratorio_id) REFERENCES
laboratorio(id) ON UPDATE CASCADE ON DELETE CASCADE,
   CONSTRAINT fk_examen_tipo_examen FOREIGN KEY (tipo_examen_id) REFERENCES
tipo_examen(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE bitacora_examen
(
   id serial,
   accion varchar(20),
   fecha timestamp,
   fields json
);

CREATE TABLE resultado_examen
(
   id serial,
   examen_id integer NOT NULL CHECK (examen_id > 0),
   descripcion varchar(150) NOT NULL,
   CONSTRAINT pk_resultado_examen PRIMARY KEY (id),
   CONSTRAINT fk_resultado_examen_examen FOREIGN KEY (examen_id) REFERENCES
examen(id) ON UPDATE CASCADE ON DELETE CASCADE
);
