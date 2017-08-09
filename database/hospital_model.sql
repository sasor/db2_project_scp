CREATE TABLE Persona(
    ci integer NOT null,
    nombre text,
    apelloPaterno text,
    apellidoMaterno text,
    tipoSangre varchar(4),
    sexo char,
    telefomo integer,
    direccion text,
);
CREATE TABLE Doctor(
    ci integer NOT null,
    nombre text,
    apellidoPaterno text,
    apellidoMaterno text,
    sexo char,
    telefono integer,
    direccion text,
    especialidad text,
),
CREATE TABLE Enfermero(
    ci integer NOT null,
    nombre text,
    apellidoPaterno text,
    apellidoMaterno text,
    sexo char,
    telefono integer,
    direccion text,
);
CREATE TABLE Laboratorista(
    ci integer NOT null,
    nombre text,
    apellidoPaterno text,
    apelidoMaterno text,
    telefono integer,
    direccion text,
);
CREATE TABLE Cama(
    id integer NOT null,
    numero interger,
    ocupado boolean,
);
CREATE TABLE Medicamento(
    id integer NOT null,
    nombre text,
    dtosificaion text,
);
CREATE TABLE Laborartorio(
    nit integer NOT null,
    nombre text,
    telefono integer,
    direccion text, 
);
CREATE TABLE tipoExamen(
    id integer NOT null,
    nombre text,
    precio float,
); 
CREATE TABLE Receta(
    id int4 NOT null,
    cantidad int4;
);
CREATE TABLE CitaMedica(
    id integer NOT null,
    fecha timestamp,
    hora time,
    disponible char,
);
CREATE TABLE Consulta(
    id integer NOT null,
    fecha timestamp,
    hora time,
    sintoma text,t
);
CREATE TABLE DetalleConsulta(
    id integer NOT null,
    estado text,
    diagnostico text,
    Orden text,
);
CREATE TABLE DetalleLaboratorio(
    id integer NOT null,
    fecha timestamp,
    hora time,
    detalle text,
);
CREATE TABLE Internacion(
    id integer internacion NOT null,
    alta char,
    fechaIngreso timestamp,
    
);
CREATE TABLE Analisis(
    id integer NOT null,
    fecha timestamp,
);
