CREATE DATABASE api
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    TEMPLATE template0;

\c api

CREATE TABLE public.usuario
(
    id_usuario serial,
    nombre_usuario character varying(60) NOT NULL,
    email_usuario character varying(254) NOT NULL,
    password_usuario character varying NOT NULL,
    direccion_usuario character varying NOT NULL,
    path_doc text NOT NULL,
    telefono_usuario text,
    CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario)
);

CREATE TABLE public.cliente
(
    id_cliente serial,
    id_usuario integer,
    CONSTRAINT cliente_pkey PRIMARY KEY (id_cliente),
    CONSTRAINT cliente_usuario_fkey FOREIGN KEY (id_usuario)
        REFERENCES public.usuario (id_usuario) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
);

CREATE TABLE public.trabajador
(
    id_trabajador serial,
    id_usuario integer,
    foto text NOT NULL,
    CONSTRAINT trabajador_pkey PRIMARY KEY (id_trabajador),
    CONSTRAINT trabajador_usuario_fkey FOREIGN KEY (id_usuario)
        REFERENCES public.usuario (id_usuario) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
);

CREATE TABLE public.labor
(
    id_labor serial,
    nombre_labor character varying(450) NOT NULL,
    descripcion_labor character varying,
    unidad_labor character varying,
    CONSTRAINT labor_pkey PRIMARY KEY (id_labor)
);

CREATE TABLE public.tarifa
(
    id_tarifa serial,
    tarifa integer NOT NULL,
    id_trabajador integer,
    id_labor integer,
    CONSTRAINT tarifa_pkey PRIMARY KEY (id_tarifa),
    CONSTRAINT tarifa_trabajador_fkey FOREIGN KEY (id_trabajador)
        REFERENCES public.trabajador (id_trabajador) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID,
    CONSTRAINT tarifa_labor_fkey FOREIGN KEY (id_labor)
        REFERENCES public.labor (id_labor) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
);

CREATE TABLE IF NOT EXISTS public.servicio
(
    id_servicio integer NOT NULL DEFAULT 'nextval('servicio_id_servicio_seq'::regclass)',
    costo_servicio integer,
    calificacion_servicio integer,
    unidades_servicio character varying COLLATE pg_catalog."default",
    fecha_servicio date,
    estado_servicio boolean,
    id_oferta integer,
    CONSTRAINT servicio_pkey PRIMARY KEY (id_servicio),
    CONSTRAINT servicio_oferta_fkey FOREIGN KEY (id_oferta)
        REFERENCES public.oferta (id_oferta) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
        NOT VALID
);

CREATE TABLE IF NOT EXISTS public.oferta
(
    id_oferta integer NOT NULL DEFAULT 'nextval('oferta_id_oferta_seq'::regclass)',
    id_trabajador integer,
    id_tarifa integer,
    id_labor integer,
    CONSTRAINT oferta_pkey PRIMARY KEY (id_oferta),
    CONSTRAINT oferta_labor_fkey FOREIGN KEY (id_labor)
        REFERENCES public.labor (id_labor) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT oferta_tarifa_fkey FOREIGN KEY (id_tarifa)
        REFERENCES public.tarifa (id_tarifa) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT oferta_trabajador_fkey FOREIGN KEY (id_trabajador)
        REFERENCES public.trabajador (id_trabajador) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
