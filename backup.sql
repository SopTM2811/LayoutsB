--
-- PostgreSQL database dump
--

\restrict byQ8C09mLadZQWPzLofNdqTPCe8lgQqyDxMkfZPuaI03zaIrUnvkRQAD8ybUOvJ

-- Dumped from database version 16.11
-- Dumped by pg_dump version 16.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cat_beneficiario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cat_beneficiario (
    id_beneficiario integer NOT NULL,
    nombre character varying(150) NOT NULL,
    alias_nom character varying(150),
    rfc character varying(13),
    curp character varying(18),
    correo character varying(150),
    celular character varying(10),
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: cat_beneficiario_id_beneficiario_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cat_beneficiario_id_beneficiario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cat_beneficiario_id_beneficiario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cat_beneficiario_id_beneficiario_seq OWNED BY public.cat_beneficiario.id_beneficiario;


--
-- Name: cat_cuenta_beneficiario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cat_cuenta_beneficiario (
    id_cuenta_beneficiario integer NOT NULL,
    id_beneficiario integer NOT NULL,
    numero_cuenta character varying(18) NOT NULL,
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: cat_cuenta_beneficiario_id_cuenta_beneficiario_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cat_cuenta_beneficiario_id_cuenta_beneficiario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cat_cuenta_beneficiario_id_cuenta_beneficiario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cat_cuenta_beneficiario_id_cuenta_beneficiario_seq OWNED BY public.cat_cuenta_beneficiario.id_cuenta_beneficiario;


--
-- Name: cat_institucion_bancaria; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cat_institucion_bancaria (
    id_institucion integer NOT NULL,
    nombre_institucion character varying(50) NOT NULL,
    clave_banxico character varying(3) NOT NULL,
    clave_transfer character varying(10),
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: cat_institucion_bancaria_id_institucion_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cat_institucion_bancaria_id_institucion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cat_institucion_bancaria_id_institucion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cat_institucion_bancaria_id_institucion_seq OWNED BY public.cat_institucion_bancaria.id_institucion;


--
-- Name: cat_institucion_stp; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cat_institucion_stp (
    id_stp integer NOT NULL,
    prefijo_clabe character varying(3) NOT NULL,
    institucion character varying(100) NOT NULL,
    participante character varying(10) NOT NULL,
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: cat_institucion_stp_id_stp_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cat_institucion_stp_id_stp_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cat_institucion_stp_id_stp_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cat_institucion_stp_id_stp_seq OWNED BY public.cat_institucion_stp.id_stp;


--
-- Name: cat_layout; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cat_layout (
    id_layout integer NOT NULL,
    codigo character varying(50) NOT NULL,
    id_origen integer NOT NULL,
    id_opcion integer,
    tipo_archivo character varying(10) NOT NULL,
    separador character varying(5),
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    tipo_layout character varying(20) DEFAULT 'FIXED'::character varying,
    ruta_plantilla character varying(255)
);


--
-- Name: cat_layout_campo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cat_layout_campo (
    id_layout_campo integer NOT NULL,
    id_layout integer NOT NULL,
    nombre_logico character varying(50) NOT NULL,
    etiqueta_ui character varying(100) NOT NULL,
    posicion_inicio integer,
    longitud integer,
    obligatorio boolean DEFAULT false,
    editable boolean DEFAULT true,
    valor_fijo character varying(100),
    formato character varying(100),
    padding character varying(10),
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    tipo_campo character varying(20) DEFAULT 'DETALLE'::character varying,
    hoja_excel character varying(50),
    celda_excel character varying(10),
    fila_inicio integer
);


--
-- Name: cat_layout_campo_id_layout_campo_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cat_layout_campo_id_layout_campo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cat_layout_campo_id_layout_campo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cat_layout_campo_id_layout_campo_seq OWNED BY public.cat_layout_campo.id_layout_campo;


--
-- Name: cat_layout_id_layout_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cat_layout_id_layout_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cat_layout_id_layout_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cat_layout_id_layout_seq OWNED BY public.cat_layout.id_layout;


--
-- Name: cat_origen_opcion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cat_origen_opcion (
    id_opcion integer NOT NULL,
    id_origen integer NOT NULL,
    codigo character varying(30) NOT NULL,
    descripcion character varying(150),
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: cat_origen_opcion_id_opcion_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cat_origen_opcion_id_opcion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cat_origen_opcion_id_opcion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cat_origen_opcion_id_opcion_seq OWNED BY public.cat_origen_opcion.id_opcion;


--
-- Name: cat_origen_operativo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cat_origen_operativo (
    id_origen integer NOT NULL,
    codigo character varying(30) NOT NULL,
    descripcion character varying(150),
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: cat_origen_operativo_id_origen_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cat_origen_operativo_id_origen_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cat_origen_operativo_id_origen_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cat_origen_operativo_id_origen_seq OWNED BY public.cat_origen_operativo.id_origen;


--
-- Name: cat_plaza_banxico; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cat_plaza_banxico (
    id_plaza integer NOT NULL,
    numero character varying(5) NOT NULL,
    ciudad character varying(100),
    activo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: cat_plaza_banxico_id_plaza_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cat_plaza_banxico_id_plaza_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cat_plaza_banxico_id_plaza_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cat_plaza_banxico_id_plaza_seq OWNED BY public.cat_plaza_banxico.id_plaza;


--
-- Name: cat_beneficiario id_beneficiario; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_beneficiario ALTER COLUMN id_beneficiario SET DEFAULT nextval('public.cat_beneficiario_id_beneficiario_seq'::regclass);


--
-- Name: cat_cuenta_beneficiario id_cuenta_beneficiario; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_cuenta_beneficiario ALTER COLUMN id_cuenta_beneficiario SET DEFAULT nextval('public.cat_cuenta_beneficiario_id_cuenta_beneficiario_seq'::regclass);


--
-- Name: cat_institucion_stp id_stp; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_institucion_stp ALTER COLUMN id_stp SET DEFAULT nextval('public.cat_institucion_stp_id_stp_seq'::regclass);


--
-- Name: cat_layout id_layout; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_layout ALTER COLUMN id_layout SET DEFAULT nextval('public.cat_layout_id_layout_seq'::regclass);


--
-- Name: cat_layout_campo id_layout_campo; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_layout_campo ALTER COLUMN id_layout_campo SET DEFAULT nextval('public.cat_layout_campo_id_layout_campo_seq'::regclass);


--
-- Name: cat_origen_opcion id_opcion; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_origen_opcion ALTER COLUMN id_opcion SET DEFAULT nextval('public.cat_origen_opcion_id_opcion_seq'::regclass);


--
-- Name: cat_origen_operativo id_origen; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_origen_operativo ALTER COLUMN id_origen SET DEFAULT nextval('public.cat_origen_operativo_id_origen_seq'::regclass);


--
-- Name: cat_plaza_banxico id_plaza; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_plaza_banxico ALTER COLUMN id_plaza SET DEFAULT nextval('public.cat_plaza_banxico_id_plaza_seq'::regclass);


--
-- Data for Name: cat_beneficiario; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cat_beneficiario (id_beneficiario, nombre, alias_nom, rfc, curp, correo, celular, activo, created_at) FROM stdin;
\.


--
-- Data for Name: cat_cuenta_beneficiario; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cat_cuenta_beneficiario (id_cuenta_beneficiario, id_beneficiario, numero_cuenta, activo, created_at) FROM stdin;
\.


--
-- Data for Name: cat_institucion_bancaria; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cat_institucion_bancaria (id_institucion, nombre_institucion, clave_banxico, clave_transfer, activo, created_at) FROM stdin;
37006	BANCOMEXT	006	BCEXT	t	2026-02-10 13:36:36.143626
37009	BANOBRAS	009	BOBRA	t	2026-02-10 13:36:36.143626
37019	BANJERCITO	019	BEJER	t	2026-02-10 13:36:36.143626
37135	NACIONAL FINANCIERA	135	NAFIN	t	2026-02-10 13:36:36.143626
37166	BANSEFI	166	BANSE	t	2026-02-10 13:36:36.143626
37168	HIPOTECARIA FEDERAL	168	HIFED	t	2026-02-10 13:36:36.143626
40002	BANAMEX	002	BANAM	t	2026-02-10 13:36:36.143626
40012	BBVA BANCOMER	012	BACOM	t	2026-02-10 13:36:36.143626
40014	BANCO SANTANDER	014	BANME	t	2026-02-10 13:36:36.143626
40021	HSBC	021	BITAL	t	2026-02-10 13:36:36.143626
40030	BAJIO	030	BAJIO	t	2026-02-10 13:36:36.143626
40032	IXE	032	BAIXE	t	2026-02-10 13:36:36.143626
40036	INBURSA	036	BINBU	t	2026-02-10 13:36:36.143626
40037	INTERACCIONES	037	BINTE	t	2026-02-10 13:36:36.143626
40042	MIFEL	042	MIFEL	t	2026-02-10 13:36:36.143626
40044	SCOTIA BANK INVERLAT	044	COMER	t	2026-02-10 13:36:36.143626
40058	BANREGIO	058	BANRE	t	2026-02-10 13:36:36.143626
40059	INVEX	059	BINVE	t	2026-02-10 13:36:36.143626
40060	BANSI	060	BANSI	t	2026-02-10 13:36:36.143626
40062	AFIRME	062	BAFIR	t	2026-02-10 13:36:36.143626
40072	BANORTE	072	BBANO	t	2026-02-10 13:36:36.143626
40102	ROYAL BANK OF SCOTLAND	102	ABNBA	t	2026-02-10 13:36:36.143626
40103	AMERICAN EXPRESS	103	AMEX	t	2026-02-10 13:36:36.143626
40106	BANK OF AMERICA	106	BAMSA	t	2026-02-10 13:36:36.143626
40108	TOKYO	108	TOKYO	t	2026-02-10 13:36:36.143626
40110	JP MORGAN	110	CHASE	t	2026-02-10 13:36:36.143626
40112	BANCO MONEX	112	CMCA	t	2026-02-10 13:36:36.143626
40113	VE POR MAS	113	DRESD	t	2026-02-10 13:36:36.143626
40116	ING	116	INGBA	t	2026-02-10 13:36:36.143626
40124	DEUTCHE	124	DEUTB	t	2026-02-10 13:36:36.143626
40126	CREDIT SUISSE	126	CRESU	t	2026-02-10 13:36:36.143626
40127	AZTECA	127	BAZTE	t	2026-02-10 13:36:36.143626
40128	BANCO AUTOFIN	128	BAUTO	t	2026-02-10 13:36:36.143626
40129	BARCLAYS BANK	129	BARCL	t	2026-02-10 13:36:36.143626
40130	BANCO COMPARTAMOS	130	BCOMP	t	2026-02-10 13:36:36.143626
40131	BANCO DE AHORRO FAMSA	131	FAMSA	t	2026-02-10 13:36:36.143626
40132	BANCO MULTIVA	132	MULTI	t	2026-02-10 13:36:36.143626
40133	PRUDENTIAL BANK	133	PRUDE	t	2026-02-10 13:36:36.143626
40134	BANCO WAL MART	134	BWALL	t	2026-02-10 13:36:36.143626
40136	BANCO REGIONAL SA	136	REGIO	t	2026-02-10 13:36:36.143626
40137	BANCOPPEL	137	COPEL	t	2026-02-10 13:36:36.143626
40138	BANCO AMIGO	138	AMIGO	t	2026-02-10 13:36:36.143626
40139	UBS BANK MEXICO	139	UBSBA	t	2026-02-10 13:36:36.143626
40140	BANCO FACIL	140	FACIL	t	2026-02-10 13:36:36.143626
40141	VOLKSWAGEN BANK	141	VOLKS	t	2026-02-10 13:36:36.143626
40143	BANCO CONSULTORIA	143	CONSU	t	2026-02-10 13:36:36.143626
2001	BANXICO	001	BANCO	t	2026-02-10 13:36:36.143626
\.


--
-- Data for Name: cat_institucion_stp; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cat_institucion_stp (id_stp, prefijo_clabe, institucion, participante, activo, created_at) FROM stdin;
1	133	ACTINVER	40133	t	2026-02-10 15:44:28.962052
2	062	AFIRME	40062	t	2026-02-10 15:44:28.962052
3	721	ALBO	90721	t	2026-02-10 15:44:28.962052
4	706	ARCUS FI	90706	t	2026-02-10 15:44:28.962052
5	659	ASP INTEGRA OPC	90659	t	2026-02-10 15:44:28.962052
6	128	AUTOFIN	40128	t	2026-02-10 15:44:28.962052
7	127	AZTECA	40127	t	2026-02-10 15:44:28.962052
8	166	BaBien	37166	t	2026-02-10 15:44:28.962052
9	030	BAJIO	40030	t	2026-02-10 15:44:28.962052
10	002	BANAMEX	40002	t	2026-02-10 15:44:28.962052
11	154	BANCO COVALTO	40154	t	2026-02-10 15:44:28.962052
12	160	BANCO S3	40160	t	2026-02-10 15:44:28.962052
13	006	BANCOMEXT	37006	t	2026-02-10 15:44:28.962052
14	137	BANCOPPEL	40137	t	2026-02-10 15:44:28.962052
15	152	BANCREA	40152	t	2026-02-10 15:44:28.962052
16	019	BANJERCITO	37019	t	2026-02-10 15:44:28.962052
17	106	BANK OF AMERICA	40106	t	2026-02-10 15:44:28.962052
18	159	BANK OF CHINA	40159	t	2026-02-10 15:44:28.962052
19	147	BANKAOOL	40147	t	2026-02-10 15:44:28.962052
20	009	BANOBRAS	37009	t	2026-02-10 15:44:28.962052
21	072	BANORTE	40072	t	2026-02-10 15:44:28.962052
22	058	BANREGIO	40058	t	2026-02-10 15:44:28.962052
23	060	BANSI	40060	t	2026-02-10 15:44:28.962052
24	001	BANXICO	2001	t	2026-02-10 15:44:28.962052
25	129	BARCLAYS	40129	t	2026-02-10 15:44:28.962052
26	145	BBASE	40145	t	2026-02-10 15:44:28.962052
27	012	BBVA MEXICO	40012	t	2026-02-10 15:44:28.962052
28	112	BMONEX	40112	t	2026-02-10 15:44:28.962052
29	677	CAJA POP MEXICA	90677	t	2026-02-10 15:44:28.962052
30	683	CAJA TELEFONIST	90683	t	2026-02-10 15:44:28.962052
31	715	Cartera Digital	90715	t	2026-02-10 15:44:28.962052
32	630	CB INTERCAM	90630	t	2026-02-10 15:44:28.962052
33	631	CI BOLSA	90631	t	2026-02-10 15:44:28.962052
34	143	CIBANCO	40143	t	2026-02-10 15:44:28.962052
35	124	CITI MEXICO	40124	t	2026-02-10 15:44:28.962052
36	901	CLS	90901	t	2026-02-10 15:44:28.962052
37	903	CoDi Valida	90903	t	2026-02-10 15:44:28.962052
38	130	COMPARTAMOS	40130	t	2026-02-10 15:44:28.962052
39	140	CONSUBANCO	40140	t	2026-02-10 15:44:28.962052
40	652	CREDICAPITAL	90652	t	2026-02-10 15:44:28.962052
41	688	CREDICLUB	90688	t	2026-02-10 15:44:28.962052
42	680	CRISTOBAL COLON	90680	t	2026-02-10 15:44:28.962052
43	723	CUENCA	90723	t	2026-02-10 15:44:28.962052
44	151	DONDE	40151	t	2026-02-10 15:44:28.962052
45	616	FINAMEX	90616	t	2026-02-10 15:44:28.962052
46	734	FINCO PAY	90734	t	2026-02-10 15:44:28.962052
47	634	FINCOMUN	90634	t	2026-02-10 15:44:28.962052
48	689	FOMPED	90689	t	2026-02-10 15:44:28.962052
49	699	FONDEADORA	90699	t	2026-02-10 15:44:28.962052
50	685	FONDO (FIRA)	90685	t	2026-02-10 15:44:28.962052
51	601	GBM	90601	t	2026-02-10 15:44:28.962052
52	167	HEY BANCO	40167	t	2026-02-10 15:44:28.962052
53	168	HIPOTECARIA FED	37168	t	2026-02-10 15:44:28.962052
54	021	HSBC	40021	t	2026-02-10 15:44:28.962052
55	155	ICBC	40155	t	2026-02-10 15:44:28.962052
56	036	INBURSA	40036	t	2026-02-10 15:44:28.962052
57	902	INDEVAL	90902	t	2026-02-10 15:44:28.962052
58	150	INMOBILIARIO	40150	t	2026-02-10 15:44:28.962052
59	136	INTERCAM BANCO	40136	t	2026-02-10 15:44:28.962052
60	059	INVEX	40059	t	2026-02-10 15:44:28.962052
61	110	JP MORGAN	40110	t	2026-02-10 15:44:28.962052
62	661	KLAR	90661	t	2026-02-10 15:44:28.962052
63	653	KUSPIT*	90653	t	2026-02-10 15:44:28.962052
64	670	LIBERTAD	90670	t	2026-02-10 15:44:28.962052
65	602	MASARI	90602	t	2026-02-10 15:44:28.962052
66	722	Mercado Pago W	90722	t	2026-02-10 15:44:28.962052
67	042	MIFEL	40042	t	2026-02-10 15:44:28.962052
68	158	MIZUHO BANK	40158	t	2026-02-10 15:44:28.962052
69	600	MONEXCB	90600	t	2026-02-10 15:44:28.962052
70	108	MUFG	40108	t	2026-02-10 15:44:28.962052
71	132	MULTIVA BANCO	40132	t	2026-02-10 15:44:28.962052
72	135	NAFIN	37135	t	2026-02-10 15:44:28.962052
73	638	NU MEXICO	90638	t	2026-02-10 15:44:28.962052
74	710	NVIO	90710	t	2026-02-10 15:44:28.962052
75	148	PAGATODO	40148	t	2026-02-10 15:44:28.962052
76	732	Peibo	90732	t	2026-02-10 15:44:28.962052
77	620	PROFUTURO	90620	t	2026-02-10 15:44:28.962052
78	156	SABADELL	40156	t	2026-02-10 15:44:28.962052
79	014	SANTANDER	40014	t	2026-02-10 15:44:28.962052
80	044	SCOTIABANK	40044	t	2026-02-10 15:44:28.962052
81	157	SHINHAN	40157	t	2026-02-10 15:44:28.962052
82	728	SPIN BY OXXO	90728	t	2026-02-10 15:44:28.962052
83	646	STP	90646	t	2026-02-10 15:44:28.962052
84	703	TESORED	90703	t	2026-02-10 15:44:28.962052
85	684	TRANSFER	90684	t	2026-02-10 15:44:28.962052
86	138	UALA	40138	t	2026-02-10 15:44:28.962052
87	656	UNAGRA	90656	t	2026-02-10 15:44:28.962052
88	617	VALMEX	90617	t	2026-02-10 15:44:28.962052
89	605	VALUE	90605	t	2026-02-10 15:44:28.962052
90	113	VE POR MAS	40113	t	2026-02-10 15:44:28.962052
91	608	VECTOR	90608	t	2026-02-10 15:44:28.962052
92	141	VOLKSWAGEN	40141	t	2026-02-10 15:44:28.962052
\.


--
-- Data for Name: cat_layout; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cat_layout (id_layout, codigo, id_origen, id_opcion, tipo_archivo, separador, activo, created_at, tipo_layout, ruta_plantilla) FROM stdin;
1	SANTANDER ADOLESTIC	7	9	TXT	FIXED	t	2026-02-10 16:24:26.732901	FIXED	\N
2	SANTADER KIUGDU	7	10	TXT	FIXED	t	2026-02-21 15:40:45.194786	FIXED	\N
3	SANTADER SMAUG	7	11	TXT	FIXED	t	2026-02-21 15:41:16.078272	FIXED	\N
4	SANTADER YHOSHI	7	12	TXT	FIXED	t	2026-02-21 15:42:17.144564	FIXED	\N
5	MIFEL ADOLESTIC LAYOUT SPEI	6	7	TXT	|	t	2026-02-21 19:13:44.034148	DELIMITADO	\N
6	MIFEL IRONISLAND LAYOUT SPEI	7	8	TXT	|	t	2026-02-21 19:13:44.034148	DELIMITADO	\N
8	DEPLESS LAYOUT DISPERSION	1	1	XLSL	\N	t	2026-02-26 13:39:53.978515	PLANTILLA_EXCEL	app/plantillas_layouts/ASP/DEPLESS LAYOUT_DISPERSION.xlsx
10	KOUSTOGERAKO LAYOUT DISPERSION	1	3	XLSL	\N	t	2026-02-27 09:16:25.39756	PLANTILLA_EXCEL	app/plantillas_layouts/ASP/KOUSTOGERAKO LAYOUT_DISPERSION.xlsx
11	SCODELARIO LAYOUT DISPERSION	1	4	XLSL	\N	t	2026-02-27 09:18:04.810792	PLANTILLA_EXCEL	app/plantillas_layouts/ASP/SCODELARIO LAYOUT_DISPERSION.xlsx
15	BANREGIO LAYOUT	3	15	XLSL	\N	t	2026-02-27 16:47:18.789885	PLANTILLA_EXCEL	app/plantillas_layouts/BANREGIO/transferenciasMasivas.xlsx
12	TNN LAYOUT	4	5	XLSX	\N	t	2026-02-27 16:31:04.563015	PLANTILLA_EXCEL	app/plantillas_layouts/ESPIRAL/TNN FormatoDispersionMasivaCards.xlsx
13	TRANSFERENCIAS FORMATO DISPERSION MASIVA	4	6	XLSX	\N	t	2026-02-27 16:31:04.563015	PLANTILLA_EXCEL	app/plantillas_layouts/ESPIRAL/TRANSFERENCIAS_FormatoDisMasiva20Oct2025.xlsx
7	KUSPIT LAYOUT	5	13	CSV	,	t	2026-02-24 19:16:49.554019	DELIMITADO	app/plantillas_layouts/KUSPIT/Lay Out Banpay.csv
14	STP LAYOUT	8	14	TXT	\t	t	2026-02-27 16:44:27.766177	DELIMITADO	\N
9	KANTANO LAYOUT DISPERSION	1	2	XLSL	\N	t	2026-02-27 08:51:27.796676	PLANTILLA_EXCEL	app/plantillas_layouts/ASP/KANTANO LAYOUT_DISPERSION.xlsx
\.


--
-- Data for Name: cat_layout_campo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cat_layout_campo (id_layout_campo, id_layout, nombre_logico, etiqueta_ui, posicion_inicio, longitud, obligatorio, editable, valor_fijo, formato, padding, activo, created_at, tipo_campo, hoja_excel, celda_excel, fila_inicio) FROM stdin;
296	7	beneficiario	Nombre Beneficiario	9	\N	t	t	\N	ALFANUM	\N	t	2026-03-07 21:58:40.198235	DETALLE_UI	\N	\N	\N
297	7	clave_banco	Clave Banco	10	\N	t	f	\N	NUMERIC	\N	t	2026-03-07 21:58:40.198235	DETALLE_UI	\N	\N	\N
298	7	clabe	CLABE	11	\N	t	t	\N	NUMERIC	\N	t	2026-03-07 21:58:40.198235	DETALLE_UI	\N	\N	\N
300	7	importe	Importe	13	\N	t	t	\N	DECIMAL_2	\N	t	2026-03-07 21:58:40.198235	DETALLE_UI	\N	\N	\N
301	7	correo	Correo Beneficiario	14	\N	f	t	\N	ALFANUM	\N	t	2026-03-07 21:58:40.198235	DETALLE_UI	\N	\N	\N
302	7	referencia	Referencia	15	\N	f	t	\N	ALFANUM	\N	t	2026-03-07 21:58:40.198235	DETALLE_UI	\N	\N	\N
304	7	grupo	Grupo	17	\N	f	t	\N	ALFANUM	\N	t	2026-03-07 21:58:40.198235	DETALLE_UI	\N	\N	\N
305	7	id_referencia_cliente	Id Referencia Cliente	18	\N	f	t	\N	ALFANUM	\N	t	2026-03-07 21:58:40.198235	DETALLE_UI	\N	\N	\N
307	7	celular	Celular	20	\N	f	t	\N	NUMERIC	\N	t	2026-03-07 21:58:40.198235	DETALLE_UI	\N	\N	\N
41	3	espacios2	ESPACIOS	146	90	f	f	\N	FIXED	 	t	2026-02-21 16:11:39.465492	DETALLE_TXT	\N	\N	\N
56	4	espacios2	ESPACIOS	146	90	f	f	\N	FIXED	 	t	2026-02-21 16:11:48.388402	DETALLE_TXT	\N	\N	\N
290	7	fecha_elab	Fecha Elaboracion	3	\N	f	f	\N	ALFANUM	\N	t	2026-03-07 21:58:40.198235	HEADER	\N	\N	\N
291	7	fecha_pago	Fecha Pago	4	\N	f	f	\N	ALFANUM	\N	t	2026-03-07 21:58:40.198235	HEADER	\N	\N	\N
34	3	clabe	CUENTA DE ABONO	17	20	t	f	\N	NUMERIC	0	t	2026-02-21 16:11:39.465492	DETALLE_UI	\N	\N	\N
293	7	cliente_nombre	Cliente Nombre	6	\N	f	f	\N	ALFANUM	\N	t	2026-03-07 21:58:40.198235	HEADER	\N	\N	\N
299	7	tipo_cuenta	Tipo Cuenta	12	\N	t	f	\N	NUMERIC	\N	t	2026-03-07 21:58:40.198235	DETALLE_UI	\N	\N	\N
308	14	institucion_contraparte	INSTITUCION_CONTRAPARTE	1	\N	t	t	\N	NUMERIC	\N	t	2026-03-09 09:08:06.244966	DETALLE_UI	\N	\N	\N
288	7	esuelv	esuelv	1	\N	f	f	\N	ALFANUM	\N	t	2026-03-07 21:58:40.198235	HEADER	\N	\N	\N
36	3	beneficiario	BENEFICIARIO	42	40	t	t	\N	ALFANUM	 	t	2026-02-21 16:11:39.465492	DETALLE_UI	\N	\N	\N
289	7	nombre_programa	Nombre Programa	2	\N	t	f	\N	ALFANUM	\N	t	2026-03-07 21:58:40.198235	HEADER	\N	\N	\N
37	3	sucursal	SUCURSAL	82	4	t	f	0002	NUMERIC	0	t	2026-02-21 16:11:39.465492	DETALLE_UI	\N	\N	\N
38	3	importe	IMPORTE	86	15	t	t	\N	DECIMAL_2	0	t	2026-02-21 16:11:39.465492	DETALLE_UI	\N	\N	\N
39	3	plaza_banxico	PLAZA BANXICO	101	5	t	f	01001	NUMERIC	0	t	2026-02-21 16:11:39.465492	DETALLE_UI	\N	\N	\N
40	3	concepto	CONCEPTO	106	40	t	t	\N	ALFANUM	 	t	2026-02-21 16:11:39.465492	DETALLE_UI	\N	\N	\N
42	3	rfc	RFC	237	13	f	t	\N	ALFANUM	 	t	2026-02-21 16:11:39.465492	DETALLE_UI	\N	\N	\N
43	3	iva	IVA	250	14	f	t	\N	DECIMAL_2_CON_PUNTO	0	t	2026-02-21 16:11:39.465492	DETALLE_UI	\N	\N	\N
30	2	estado_cuenta	EDO CUENTA	236	1	t	t	N	FIXED	 	t	2026-02-21 16:10:55.811318	DETALLE_UI	\N	\N	\N
5	1	beneficiario	BENEFICIARIO	42	40	t	t	\N	ALFANUM	 	t	2026-02-18 13:23:27.872072	DETALLE_UI	\N	\N	\N
6	1	sucursal	SUCURSAL	82	4	t	f	0002	NUMERIC	0	t	2026-02-18 13:23:27.872072	DETALLE_UI	\N	\N	\N
7	1	importe	IMPORTE	86	15	t	t	\N	DECIMAL_2	0	t	2026-02-18 13:23:27.872072	DETALLE_UI	\N	\N	\N
8	1	plaza_banxico	PLAZA BANXICO	101	5	t	f	01001	NUMERIC	0	t	2026-02-18 13:23:27.872072	DETALLE_UI	\N	\N	\N
9	1	concepto	CONCEPTO	106	40	t	t	\N	ALFANUM	 	t	2026-02-18 13:23:27.872072	DETALLE_UI	\N	\N	\N
26	2	espacios2	ESPACIOS	146	90	f	f	\N	FIXED	 	t	2026-02-21 16:10:55.811318	DETALLE_TXT	\N	\N	\N
27	2	rfc	RFC	237	13	f	t	\N	ALFANUM	 	t	2026-02-21 16:10:55.811318	DETALLE_UI	\N	\N	\N
28	2	iva	IVA	250	14	f	t	\N	DECIMAL_2_CON_PUNTO	0	t	2026-02-21 16:10:55.811318	DETALLE_UI	\N	\N	\N
29	2	referencia_ordenante	REFERENCIA	264	7	t	f	1	FIXED	 	t	2026-02-21 16:10:55.811318	DETALLE_UI	\N	\N	\N
4	1	banco_receptor	BANCO RECEPTOR	37	5	t	t	\N	ALFANUM	0	t	2026-02-18 13:23:27.872072	DETALLE_UI	\N	\N	\N
31	2	forma_aplicacion	FORMA	271	1	t	t	1	FIXED	 	t	2026-02-21 16:10:55.811318	DETALLE_UI	\N	\N	\N
33	3	espacios1	ESPACIOS	12	5	f	f	\N	FIXED	 	t	2026-02-21 16:11:39.465492	DETALLE_TXT	\N	\N	\N
45	3	estado_cuenta	EDO CUENTA	236	1	t	t	N	FIXED	 	t	2026-02-21 16:11:39.465492	DETALLE_UI	\N	\N	\N
295	7	clave_beneficiario	Clave Beneficiario	8	\N	f	f	SIN DEFINIR	NUMERIC	\N	t	2026-03-07 21:58:40.198235	DETALLE_UI	\N	\N	\N
1	1	cuenta_carg	CUENTA DE CARGO	1	11	t	t	\N	NUMERIC	0	t	2026-02-18 13:23:27.872072	DETALLE_UI	\N	\N	\N
70	6	literal	LITERAL	3	20	t	f	Transfers	FIXED	 	t	2026-02-21 19:28:30.696409	HEADER_TXT	\N	\N	\N
294	7	ingreso_importe	Ingreso Importe	7	\N	f	f	\N	DECIMAL_2	\N	t	2026-03-07 21:58:40.198235	HEADER_TXT	\N	\N	\N
35	3	banco_receptor	BANCO RECEPTOR	37	5	t	t	\N	ALFANUM	0	t	2026-02-21 16:11:39.465492	DETALLE_UI	\N	\N	\N
68	6	total_registros	TOTAL REGISTROS	1	10	t	f	\N	NUMERIC	0	t	2026-02-21 19:28:30.696409	HEADER_TXT	\N	\N	\N
306	7	rfc	RFC/CURP	19	\N	f	t	\N	ALFANUM	\N	t	2026-03-07 21:58:40.198235	DETALLE_UI	\N	\N	\N
2	1	espacios1	ESPACIOS	12	5	f	f	\N	FIXED	 	t	2026-02-18 13:23:27.872072	DETALLE_TXT	\N	\N	\N
303	7	concepto	Concepto	16	\N	f	t	\N	ALFANUM	\N	t	2026-03-07 21:58:40.198235	DETALLE_UI	\N	\N	\N
24	2	plaza_banxico	PLAZA BANXICO	101	5	t	f	01001	NUMERIC	0	t	2026-02-21 16:10:55.811318	DETALLE_UI	\N	\N	\N
25	2	concepto	CONCEPTO	106	40	t	t	\N	ALFANUM	 	t	2026-02-21 16:10:55.811318	DETALLE_UI	\N	\N	\N
67	5	codigo_empresa	DESCRIPCION	5	10	t	t	\N	ALFANUM	 	t	2026-02-21 19:28:30.696409	HEADER	\N	\N	\N
66	5	cuenta_cargo	CUENTA CARGO	4	11	t	t	\N	NUMERIC	0	t	2026-02-21 19:28:30.696409	HEADER	\N	\N	\N
292	7	clave_cliente	Clave Cliente Fondeo	5	\N	f	f	\N	NUMERIC	\N	t	2026-03-07 21:58:40.198235	HEADER	\N	\N	\N
3	1	clabe	CUENTA DE ABONO	17	20	t	f	\N	NUMERIC	0	t	2026-02-18 13:23:27.872072	DETALLE_UI	\N	\N	\N
69	6	total_importe	TOTAL IMPORTE	2	15	t	f	\N	DECIMAL_2	0	t	2026-02-21 19:28:30.696409	HEADER_TXT	\N	\N	\N
44	3	referencia_ordenante	REFERENCIA	264	7	t	f	1	FIXED	 	t	2026-02-21 16:11:39.465492	DETALLE_UI	\N	\N	\N
63	5	total_registros	TOTAL REGISTROS	1	10	t	f	\N	NUMERIC	0	t	2026-02-21 19:28:30.696409	HEADER_TXT	\N	\N	\N
64	5	total_importe	TOTAL IMPORTE	2	15	t	f	\N	DECIMAL_2	0	t	2026-02-21 19:28:30.696409	HEADER_TXT	\N	\N	\N
65	5	literal	LITERAL	3	20	t	f	Transfers	FIXED	 	t	2026-02-21 19:28:30.696409	HEADER_TXT	\N	\N	\N
10	1	espacios2	ESPACIOS	146	90	f	f	\N	FIXED	 	t	2026-02-18 13:23:27.872072	DETALLE_TXT	\N	\N	\N
12	1	rfc	RFC	237	13	f	t	\N	ALFANUM	 	t	2026-02-18 13:23:27.872072	DETALLE_UI	\N	\N	\N
13	1	iva	IVA	250	14	f	t	\N	DECIMAL_2_CON_PUNTO	0	t	2026-02-18 13:23:27.872072	DETALLE_UI	\N	\N	\N
14	1	referencia_ordenante	REFERENCIA	264	7	t	f	1	FIXED	 	t	2026-02-18 13:23:27.872072	DETALLE_UI	\N	\N	\N
15	1	forma_aplicacion	FORMA	271	1	t	t	1	FIXED	 	t	2026-02-18 13:23:27.872072	DETALLE_UI	\N	\N	\N
18	2	espacios1	ESPACIOS	12	5	f	f	\N	FIXED	 	t	2026-02-21 16:10:55.811318	DETALLE_TXT	\N	\N	\N
21	2	beneficiario	BENEFICIARIO	42	40	t	t	\N	ALFANUM	 	t	2026-02-21 16:10:55.811318	DETALLE_UI	\N	\N	\N
22	2	sucursal	SUCURSAL	82	4	t	f	0002	NUMERIC	0	t	2026-02-21 16:10:55.811318	DETALLE_UI	\N	\N	\N
23	2	importe	IMPORTE	86	15	t	t	\N	DECIMAL_2	0	t	2026-02-21 16:10:55.811318	DETALLE_UI	\N	\N	\N
86	6	consecutivo	CONSECUTIVO	6	5	t	f	\N	NUMERIC	0	t	2026-02-21 19:35:13.718736	DETALLE_TXT	\N	\N	\N
87	6	tipo_transferencia	TIPO	7	2	t	f	20	FIXED	0	t	2026-02-21 19:35:13.718736	DETALLE_TXT	\N	\N	\N
88	6	campo_vacio	VACIO	8	1	f	f	\N	FIXED	 	t	2026-02-21 19:35:13.718736	DETALLE_TXT	\N	\N	\N
89	6	clabe	CLABE	9	18	t	t	\N	NUMERIC	0	t	2026-02-21 19:35:13.718736	DETALLE_UI	\N	\N	\N
90	6	importe	IMPORTE	10	15	t	t	\N	DECIMAL_2	0	t	2026-02-21 19:35:13.718736	DETALLE_UI	\N	\N	\N
91	6	moneda	MONEDA	11	3	t	f	MXP	FIXED	 	t	2026-02-21 19:35:13.718736	DETALLE_UI	\N	\N	\N
92	6	concepto	CONCEPTO	12	40	t	t	\N	ALFANUM	 	t	2026-02-21 19:35:13.718736	DETALLE_UI	\N	\N	\N
94	6	correo	CORREO	14	100	f	t	\N	ALFANUM	 	t	2026-02-21 19:35:13.718736	DETALLE_UI	\N	\N	\N
95	6	celular	CELULAR	15	10	f	t	\N	NUMERIC	0	t	2026-02-21 19:35:13.718736	DETALLE_UI	\N	\N	\N
96	6	rfc	RFC	16	13	f	t	\N	ALFANUM	 	t	2026-02-21 19:35:13.718736	DETALLE_UI	\N	\N	\N
97	6	iva	IVA	17	15	f	t	\N	DECIMAL_2	0	t	2026-02-21 19:35:13.718736	DETALLE_UI	\N	\N	\N
98	6	referencia	REFERENCIA	18	7	f	t	\N	NUMERIC	0	t	2026-02-21 19:35:13.718736	DETALLE_UI	\N	\N	\N
71	6	cuenta_cargo	CUENTA CARGO	4	11	t	t	\N	NUMERIC	0	t	2026-02-21 19:28:30.696409	HEADER	\N	\N	\N
72	6	codigo_empresa	DESCRIPCION	5	10	t	t	\N	ALFANUM	 	t	2026-02-21 19:28:30.696409	HEADER	\N	\N	\N
93	6	descripcion	DESCRIPCION	13	40	t	t	\N	ALFANUM	 	t	2026-02-21 19:35:13.718736	DETALLE_TXT	\N	\N	\N
309	14	clave_rastreo	CLAVE_RASTREO	2	\N	f	t	\N	ALFANUM	\N	t	2026-03-09 09:08:06.244966	DETALLE_UI	\N	\N	\N
312	14	tipo_pago	TIPO_PAGO	5	\N	f	f	1	NUMERIC	\N	t	2026-03-09 09:08:06.244966	DETALLE_UI	\N	\N	\N
313	14	tipo_cuenta	TIPO_CUENTA_BENEFICIARIO	6	\N	f	f	40	NUMERIC	\N	t	2026-03-09 09:08:06.244966	DETALLE_UI	\N	\N	\N
310	14	beneficiario	NOMBRE_BENEFICIARIO	3	\N	f	t	\N	ALFANUM	\N	t	2026-03-09 09:08:06.244966	DETALLE_UI	\N	\N	\N
48	4	espacios1	ESPACIOS	12	5	f	f	\N	FIXED	 	t	2026-02-21 16:11:48.388402	DETALLE_TXT	\N	\N	\N
46	3	forma_aplicacion	FORMA	271	1	t	t	1	FIXED	 	t	2026-02-21 16:11:39.465492	DETALLE_UI	\N	\N	\N
20	2	banco_receptor	BANCO RECEPTOR	37	5	t	t	\N	ALFANUM	0	t	2026-02-21 16:10:55.811318	DETALLE_UI	\N	\N	\N
73	5	consecutivo	CONSECUTIVO	6	5	t	f	\N	NUMERIC	0	t	2026-02-21 19:34:23.480032	DETALLE_TXT	\N	\N	\N
74	5	tipo_transferencia	TIPO	7	2	t	f	20	FIXED	0	t	2026-02-21 19:34:23.480032	DETALLE_TXT	\N	\N	\N
75	5	campo_vacio	VACIO	8	1	f	f	\N	FIXED	 	t	2026-02-21 19:34:23.480032	DETALLE_TXT	\N	\N	\N
49	4	clabe	CUENTA DE ABONO	17	20	t	f	\N	NUMERIC	0	t	2026-02-21 16:11:48.388402	DETALLE_UI	\N	\N	\N
11	1	estado_cuenta	EDO CUENTA	236	1	t	t	N	FIXED	 	t	2026-02-18 13:23:27.872072	DETALLE_UI	\N	\N	\N
101	8	clabe	CLABE O TARJETA	2	18	t	t	\N	NUMERIC	\N	t	2026-02-26 14:21:46.200706	DETALLE_UI	Hoja1	B	2
76	5	clabe	CLABE	9	18	t	t	\N	NUMERIC	0	t	2026-02-21 19:34:23.480032	DETALLE_UI	\N	\N	\N
77	5	importe	IMPORTE	10	15	t	t	\N	DECIMAL_2	0	t	2026-02-21 19:34:23.480032	DETALLE_UI	\N	\N	\N
78	5	moneda	MONEDA	11	3	t	f	MXP	FIXED	 	t	2026-02-21 19:34:23.480032	DETALLE_UI	\N	\N	\N
79	5	concepto	CONCEPTO	12	40	t	t	\N	ALFANUM	 	t	2026-02-21 19:34:23.480032	DETALLE_UI	\N	\N	\N
81	5	correo	CORREO	14	100	f	t	\N	ALFANUM	 	t	2026-02-21 19:34:23.480032	DETALLE_UI	\N	\N	\N
82	5	celular	CELULAR	15	10	f	t	\N	NUMERIC	0	t	2026-02-21 19:34:23.480032	DETALLE_UI	\N	\N	\N
83	5	rfc	RFC	16	13	f	t	\N	ALFANUM	 	t	2026-02-21 19:34:23.480032	DETALLE_UI	\N	\N	\N
84	5	iva	IVA	17	15	f	t	\N	DECIMAL_2	0	t	2026-02-21 19:34:23.480032	DETALLE_UI	\N	\N	\N
85	5	referencia	REFERENCIA	18	7	f	t	\N	NUMERIC	0	t	2026-02-21 19:34:23.480032	DETALLE_UI	\N	\N	\N
100	8	beneficiario	BENEFICIARIO	1	\N	t	t	\N	ALFANUM	\N	t	2026-02-26 14:21:46.200706	DETALLE_UI	Hoja1	A	2
103	8	concepto	CONCEPTO	4	\N	t	t	\N	ALFANUM	\N	t	2026-02-26 14:21:46.200706	DETALLE_UI	Hoja1	D	2
104	8	referencia	REFERENCIA	5	7	t	t	\N	NUMERIC	\N	t	2026-02-26 14:21:46.200706	DETALLE_UI	Hoja1	E	2
105	8	monto_maximo	MONTO MAXIMO	6	\N	t	t	\N	DECIMAL_2	\N	t	2026-02-26 14:21:46.200706	DETALLE_UI	Hoja1	F	2
102	8	importe	MONTO	3	\N	t	t	\N	DECIMAL_2	\N	t	2026-02-26 14:21:46.200706	DETALLE_UI	Hoja1	C	2
19	2	clabe	CUENTA DE ABONO	17	20	t	f	\N	NUMERIC	0	t	2026-02-21 16:10:55.811318	DETALLE_UI	\N	\N	\N
311	14	rfc	RFC_CURP_BENEFICIARIO	4	\N	f	t	0	ALFANUM	\N	t	2026-03-09 09:08:06.244966	DETALLE_UI	\N	\N	\N
80	5	descripcion	DESCRIPCION	13	40	t	t	\N	ALFANUM	 	t	2026-02-21 19:34:23.480032	DETALLE_TXT	\N	\N	\N
106	8	cuenta_origen	CUENTA ORIGEN	7	\N	t	t	\N	NUMERIC	\N	t	2026-02-26 14:21:46.200706	DETALLE_UI	Hoja1	G	2
51	4	beneficiario	BENEFICIARIO	42	40	t	t	\N	ALFANUM	 	t	2026-02-21 16:11:48.388402	DETALLE_UI	\N	\N	\N
52	4	sucursal	SUCURSAL	82	4	t	f	0002	NUMERIC	0	t	2026-02-21 16:11:48.388402	DETALLE_UI	\N	\N	\N
314	14	importe	MONTO	7	\N	f	t	\N	DECIMAL_2	\N	t	2026-03-09 09:08:06.244966	DETALLE_UI	\N	\N	\N
315	14	clabe	CUENTA_BENEFICIARIO	8	\N	f	t	\N	NUMERIC	\N	t	2026-03-09 09:08:06.244966	DETALLE_UI	\N	\N	\N
317	14	referencia	REFERENCIA_NUMERICA	10	\N	f	f	0	NUMERIC	\N	t	2026-03-09 09:08:06.244966	DETALLE_UI	\N	\N	\N
318	14	institucion_operante	INSTITUCION_OPERANTE	11	\N	f	f	90646	NUMERIC	\N	t	2026-03-09 09:08:06.244966	DETALLE_UI	\N	\N	\N
146	13	tipo_tarjeta	TIPO_TARJETA	8	\N	f	t	\N	ALFANUM	\N	t	2026-03-03 13:07:34.761873	DETALLE_UI	dispersion	H	2
60	4	estado_cuenta	EDO CUENTA	236	1	t	t	N	FIXED	 	t	2026-02-21 16:11:48.388402	DETALLE_UI	\N	\N	\N
129	15	tipo	TIPO	2	\N	t	f	S	ALFANUM	\N	t	2026-02-27 17:10:15.047286	DETALLE_UI	22097300 	B	2
130	15	clabe	CUENTA DESTINO	3	\N	t	f	\N	NUMERIC	\N	t	2026-02-27 17:10:15.047286	DETALLE_UI	22097300 	C	2
131	15	importe	IMPORTE	4	\N	t	t	\N	DECIMAL_2	\N	t	2026-02-27 17:10:15.047286	DETALLE_UI	22097300 	D	2
132	15	iva	IVA	5	\N	t	f	0	DECIMAL_2	\N	t	2026-02-27 17:10:15.047286	DETALLE_UI	22097300 	E	2
133	15	concepto	DESCRIPCIÓN	6	\N	t	t	\N	ALFANUM	\N	t	2026-02-27 17:10:15.047286	DETALLE_UI	22097300 	F	2
134	15	ref_numerica	REF NUMERICA	7	\N	t	f	0	NUMERIC	\N	t	2026-02-27 17:10:15.047286	DETALLE_UI	22097300 	G	2
135	12	clabe	TARJETA	1	\N	t	t	\N	NUMERIC	\N	t	2026-03-01 22:05:59.570122	DETALLE_UI	dispersion	A	2
319	14	empresa	EMPRESA	12	\N	f	f	\N	ALFANUM	\N	t	2026-03-09 09:08:06.244966	DETALLE_UI	\N	\N	\N
17	2	cuenta_carg	CUENTA DE CARGO	1	11	t	t	\N	NUMERIC	0	t	2026-02-21 16:10:55.811318	DETALLE_UI	\N	\N	\N
143	13	importe	MONTO	5	\N	t	t	\N	DECIMAL_2	\N	t	2026-03-03 13:07:34.761873	DETALLE_UI	dispersion	E	2
144	13	concepto	CONCEPTO_PAGO	6	\N	t	t	\N	ALFANUM	\N	t	2026-03-03 13:07:34.761873	DETALLE_UI	dispersion	F	2
145	13	concepto2	CONCEPTO_PAGO2	7	\N	f	t	\N	ALFANUM	\N	t	2026-03-03 13:07:34.761873	DETALLE_UI	dispersion	G	2
147	13	codigo_banco	CODIGO_BANCO	9	\N	f	f	\N	ALFANUM	\N	t	2026-03-03 13:07:34.761873	DETALLE_UI	dispersion	I	2
139	13	clabe	CUENTA_BENEFICIARIO	1	\N	t	f	\N	NUMERIC	\N	t	2026-03-03 13:07:34.761873	DETALLE_UI	dispersion	A	2
140	13	banco_nombre	BANCO	2	\N	t	t	\N	ALFANUM	\N	t	2026-03-03 13:07:34.761873	DETALLE_UI	dispersion	B	2
141	13	beneficiario	NOMBRE_BENEFICIARIO	3	\N	t	f	\N	ALFANUM	\N	t	2026-03-03 13:07:34.761873	DETALLE_UI	dispersion	C	2
142	13	rfc	RFC_CURP_BENEFICIARIO	4	\N	f	t	\N	ALFANUM	\N	t	2026-03-03 13:07:34.761873	DETALLE_UI	dispersion	D	2
137	12	importe	MONTO	3	\N	t	t	\N	DECIMAL_2	\N	t	2026-03-01 22:12:15.750257	DETALLE_UI	dispersion	C	2
53	4	importe	IMPORTE	86	15	t	t	\N	DECIMAL_2	0	t	2026-02-21 16:11:48.388402	DETALLE_UI	\N	\N	\N
54	4	plaza_banxico	PLAZA BANXICO	101	5	t	f	01001	NUMERIC	0	t	2026-02-21 16:11:48.388402	DETALLE_UI	\N	\N	\N
55	4	concepto	CONCEPTO	106	40	t	t	\N	ALFANUM	 	t	2026-02-21 16:11:48.388402	DETALLE_UI	\N	\N	\N
57	4	rfc	RFC	237	13	f	t	\N	ALFANUM	 	t	2026-02-21 16:11:48.388402	DETALLE_UI	\N	\N	\N
58	4	iva	IVA	250	14	f	t	\N	DECIMAL_2_CON_PUNTO	0	t	2026-02-21 16:11:48.388402	DETALLE_UI	\N	\N	\N
59	4	referencia_ordenante	REFERENCIA	264	7	t	f	1	FIXED	 	t	2026-02-21 16:11:48.388402	DETALLE_UI	\N	\N	\N
61	4	forma_aplicacion	FORMA	271	1	t	t	1	FIXED	 	t	2026-02-21 16:11:48.388402	DETALLE_UI	\N	\N	\N
107	9	beneficiario	BENEFICIARIO	1	\N	t	t	\N	ALFANUM	\N	t	2026-02-27 14:38:24.310437	DETALLE_UI	Hoja1	A	2
108	9	clabe	CLABE O TARJETA	2	\N	t	t	\N	NUMERIC	\N	t	2026-02-27 14:38:24.310437	DETALLE_UI	Hoja1	B	2
110	9	concepto	CONCEPTO	4	\N	t	t	\N	ALFANUM	\N	t	2026-02-27 14:38:24.310437	DETALLE_UI	Hoja1	D	2
111	9	referencia	REFERENCIA	5	\N	t	t	\N	NUMERIC	\N	t	2026-02-27 14:38:24.310437	DETALLE_UI	Hoja1	E	2
112	9	monto_maximo	MONTO MAXIMO	6	\N	f	t	\N	DECIMAL_2	\N	t	2026-02-27 14:38:24.310437	DETALLE_UI	Hoja1	F	2
113	9	cuenta_origen	CUENTA ORIGEN	7	\N	t	t	\N	NUMERIC	\N	t	2026-02-27 14:38:24.310437	DETALLE_UI	Hoja1	G	2
136	12	beneficiario	NOMBRE BENEFICIARIO	2	\N	t	t	\N	ALFANUM	\N	t	2026-03-01 22:08:50.261259	DETALLE_UI	dispersion	B	2
32	3	cuenta_carg	CUENTA DE CARGO	1	11	t	t	\N	NUMERIC	0	t	2026-02-21 16:11:39.465492	DETALLE_UI	\N	\N	\N
114	10	beneficiario	BENEFICIARIO	1	\N	t	t	\N	ALFANUM	\N	t	2026-02-27 14:40:34.072549	DETALLE_UI	Hoja1	A	2
115	10	clabe	CLABE O TARJETA	2	\N	t	t	\N	NUMERIC	\N	t	2026-02-27 14:40:34.072549	DETALLE_UI	Hoja1	B	2
117	10	concepto	CONCEPTO	4	\N	t	t	\N	ALFANUM	\N	t	2026-02-27 14:40:34.072549	DETALLE_UI	Hoja1	D	2
118	10	referencia	REFERENCIA	5	\N	t	t	\N	NUMERIC	\N	t	2026-02-27 14:40:34.072549	DETALLE_UI	Hoja1	E	2
138	12	concepto	CONCEPTO_PAGO	4	\N	t	t	\N	ALFANUM	\N	t	2026-03-01 22:12:15.750257	DETALLE_UI	dispersion	D	2
128	15	secuencia	SECUENCIA	1	\N	t	f	\N	NUMERIC	\N	t	2026-02-27 17:10:15.047286	DETALLE_TXT	22097300 	A	2
316	14	concepto	CONCEPTO_PAGO	9	\N	f	t	\N	ALFANUM	\N	t	2026-03-09 09:08:06.244966	DETALLE_UI	\N	\N	\N
50	4	banco_receptor	BANCO RECEPTOR	37	5	t	t	\N	ALFANUM	0	t	2026-02-21 16:11:48.388402	DETALLE_UI	\N	\N	\N
47	4	cuenta_carg	CUENTA DE CARGO	1	11	t	t	\N	NUMERIC	0	t	2026-02-21 16:11:48.388402	DETALLE_UI	\N	\N	\N
109	9	importe	MONTO	3	\N	t	t	\N	DECIMAL_2	\N	t	2026-02-27 14:38:24.310437	DETALLE_UI	Hoja1	C	2
119	10	monto_maximo	MONTO MAXIMO	6	\N	f	t	\N	DECIMAL_2	\N	t	2026-02-27 14:40:34.072549	DETALLE_UI	Hoja1	F	2
120	10	cuenta_origen	CUENTA ORIGEN	7	\N	t	t	\N	NUMERIC	\N	t	2026-02-27 14:40:34.072549	DETALLE_UI	Hoja1	G	2
121	11	beneficiario	BENEFICIARIO	1	\N	t	t	\N	ALFANUM	\N	t	2026-02-27 14:40:34.072549	DETALLE_UI	Hoja1	A	2
122	11	clabe	CLABE O TARJETA	2	\N	t	t	\N	NUMERIC	\N	t	2026-02-27 14:40:34.072549	DETALLE_UI	Hoja1	B	2
124	11	concepto	CONCEPTO	4	\N	t	t	\N	ALFANUM	\N	t	2026-02-27 14:40:34.072549	DETALLE_UI	Hoja1	D	2
125	11	referencia	REFERENCIA	5	\N	t	t	\N	NUMERIC	\N	t	2026-02-27 14:40:34.072549	DETALLE_UI	Hoja1	E	2
126	11	monto_maximo	MONTO MAXIMO	6	\N	f	t	\N	DECIMAL_2	\N	t	2026-02-27 14:40:34.072549	DETALLE_UI	Hoja1	F	2
127	11	cuenta_origen	CUENTA ORIGEN	7	\N	t	t	\N	NUMERIC	\N	t	2026-02-27 14:40:34.072549	DETALLE_UI	Hoja1	G	2
116	10	importe	MONTO	3	\N	t	t	\N	DECIMAL_2	\N	t	2026-02-27 14:40:34.072549	DETALLE_UI	Hoja1	C	2
123	11	importe	MONTO	3	\N	t	t	\N	DECIMAL_2	\N	t	2026-02-27 14:40:34.072549	DETALLE_UI	Hoja1	C	2
\.


--
-- Data for Name: cat_origen_opcion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cat_origen_opcion (id_opcion, id_origen, codigo, descripcion, activo, created_at) FROM stdin;
1	1	DEPLESS LAYOUT	\N	t	2026-02-10 16:10:01.803242
2	1	KANTANO LAYOUT	\N	t	2026-02-10 16:10:31.92539
3	1	KOUSTOGERAKO LAYOUT	\N	t	2026-02-10 16:11:03.512928
4	1	SCODELARIO LAYOUT	\N	t	2026-02-10 16:11:29.795075
5	4	TNN LAYOUT	\N	t	2026-02-10 16:12:52.046406
6	4	TRANFERENCIAS LAYOUT	\N	t	2026-02-10 16:13:19.399123
7	6	ADOLESTIC LAYOUT SPEI	\N	t	2026-02-10 16:14:40.316301
8	6	IRONISLAND LAYOUT SPEI	\N	t	2026-02-10 16:14:40.316301
9	7	SANTANDER ADOLESTIC	\N	t	2026-02-10 16:16:05.018427
10	7	SANTANDER KIUGDU	\N	t	2026-02-10 16:16:05.018427
11	7	SANTANDER SMAUG	\N	t	2026-02-10 16:16:05.018427
12	7	SANTANDER YHOSHI	\N	t	2026-02-10 16:16:05.018427
13	5	KUSPIT LAYOUT	\N	t	2026-02-24 19:00:08.854434
14	8	STP LAYOUT	\N	t	2026-02-27 09:54:19.930724
15	3	BANREGIO LAYOUT	\N	t	2026-02-27 09:57:12.306346
16	2	BAJIO LAYOUT	\N	t	2026-02-27 09:58:04.934712
\.


--
-- Data for Name: cat_origen_operativo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cat_origen_operativo (id_origen, codigo, descripcion, activo, created_at) FROM stdin;
1	ASP	ASP Pagos	t	2026-02-10 15:53:12.722321
4	ESPIRAL	Espiral Pagos	t	2026-02-10 15:56:27.907488
5	KUSPIT	Kuspit	t	2026-02-10 15:56:27.907488
6	MIFEL	Mifel	t	2026-02-10 15:56:27.907488
7	SANTANDER	Santander	t	2026-02-10 15:56:27.907488
8	STP	Pagos STP	t	2026-02-10 15:56:27.907488
2	BAJIO	Bajio pagos	f	2026-02-10 15:54:15.483554
3	BANREGIO	Banregio	t	2026-02-10 15:54:15.483554
\.


--
-- Data for Name: cat_plaza_banxico; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cat_plaza_banxico (id_plaza, numero, ciudad, activo, created_at) FROM stdin;
1	00000	SIN PLAZA, NING	t	2026-02-10 15:50:57.716571
2	01001	MEXICO, DF	t	2026-02-10 15:50:57.716571
3	02001	AGUASCALIENTES, AGS	t	2026-02-10 15:50:57.716571
4	02002	CALVILLO, AGS	t	2026-02-10 15:50:57.716571
5	02003	RINCON DE ROMOS, AGS	t	2026-02-10 15:50:57.716571
6	02004	PABELLON, AGS	t	2026-02-10 15:50:57.716571
7	02005	JESUS MARIA, AGS	t	2026-02-10 15:50:57.716571
8	02006	SAN FCO. DE LOS ROMOS, AGS	t	2026-02-10 15:50:57.716571
9	03001	MEXICALI, BCN	t	2026-02-10 15:50:57.716571
10	03002	ENSENADA, BCN	t	2026-02-10 15:50:57.716571
11	03003	TECATE, BCN	t	2026-02-10 15:50:57.716571
12	03004	TIJUANA, BCN	t	2026-02-10 15:50:57.716571
13	03005	CIUDAD MORELOS, BCN	t	2026-02-10 15:50:57.716571
14	03006	ESTACION GPE VICTORIA, BCN	t	2026-02-10 15:50:57.716571
15	03007	LA MESA, BCN	t	2026-02-10 15:50:57.716571
16	03008	ROSARITO, BCN	t	2026-02-10 15:50:57.716571
17	03009	GENERAL GONZALEZ ORTEGA, BCN	t	2026-02-10 15:50:57.716571
18	03010	SAN FELIPE, BCN	t	2026-02-10 15:50:57.716571
19	03011	ALGODONES, BCN	t	2026-02-10 15:50:57.716571
20	03012	SAN QUINTIN, BCN	t	2026-02-10 15:50:57.716571
21	03013	VALLE TRINIDAD, BCN	t	2026-02-10 15:50:57.716571
22	03014	BENITO JUAREZ, BCN	t	2026-02-10 15:50:57.716571
23	03015	LUIS B. SANCHEZ, BCN	t	2026-02-10 15:50:57.716571
24	03016	ISLA DE CEDROS, BCN	t	2026-02-10 15:50:57.716571
25	03017	RODOLFO SANCHEZ TABOADA, BCN	t	2026-02-10 15:50:57.716571
26	03018	LAZARO CARDENAS, BCN	t	2026-02-10 15:50:57.716571
27	03019	DELTA, BCN	t	2026-02-10 15:50:57.716571
28	03020	HECHICERA, BCN	t	2026-02-10 15:50:57.716571
29	03024	EJIDO HERMOSILLO, BCN	t	2026-02-10 15:50:57.716571
30	03025	EJIDO PUEBLA, BCN	t	2026-02-10 15:50:57.716571
31	03026	ESTACION COAHUILA, BCN	t	2026-02-10 15:50:57.716571
32	03028	BATAQUEZ, BCN	t	2026-02-10 15:50:57.716571
33	03029	EJIDO NUEVO LEON, BCN	t	2026-02-10 15:50:57.716571
34	03030	ZUAZUA, BCN	t	2026-02-10 15:50:57.716571
35	04001	LA PAZ, BCS	t	2026-02-10 15:50:57.716571
36	04002	CD CONSTITUCION, BCS	t	2026-02-10 15:50:57.716571
37	04003	SANTA ROSALIA, BCS	t	2026-02-10 15:50:57.716571
38	04004	SAN JOSE DEL CABO, BCS	t	2026-02-10 15:50:57.716571
39	04005	CIUDAD INSURGENTES, BCS	t	2026-02-10 15:50:57.716571
40	04006	LORETO, BCS	t	2026-02-10 15:50:57.716571
41	04007	GERRERO NEGRO, BCS	t	2026-02-10 15:50:57.716571
42	04008	CABO SAN LUCAS, BCS	t	2026-02-10 15:50:57.716571
43	04009	MULEGE, BCS	t	2026-02-10 15:50:57.716571
44	04010	TODOS SANTOS, BCS	t	2026-02-10 15:50:57.716571
45	04012	BAHIA DE TORTUGAS, BCS	t	2026-02-10 15:50:57.716571
46	04013	SAN IGNACIO, BCS	t	2026-02-10 15:50:57.716571
47	05001	CAMPECHE, CAMP	t	2026-02-10 15:50:57.716571
48	05002	CD DEL CARMEN, CAMP	t	2026-02-10 15:50:57.716571
49	05003	PALIZADA, CAMP	t	2026-02-10 15:50:57.716571
50	05004	ESCARCEGA, CAMP	t	2026-02-10 15:50:57.716571
51	05006	CHAMPOTON, CAMP	t	2026-02-10 15:50:57.716571
52	05007	CANDELARIA, CAMP	t	2026-02-10 15:50:57.716571
53	05008	HECELCHAKAN, CAMP	t	2026-02-10 15:50:57.716571
54	05009	HOPELCHEN, CAMP	t	2026-02-10 15:50:57.716571
55	05010	LERMA, CAMP	t	2026-02-10 15:50:57.716571
56	06001	SALTILLO, COAH	t	2026-02-10 15:50:57.716571
57	06002	AGUJITA, COAH	t	2026-02-10 15:50:57.716571
58	06003	ALLENDE, COAH	t	2026-02-10 15:50:57.716571
59	06004	CUATRO CIENEGAS, COAH	t	2026-02-10 15:50:57.716571
60	06005	FRANCISCO I. MADERO, COAH	t	2026-02-10 15:50:57.716571
61	06006	MATAMOROS LAGUNA, COAH	t	2026-02-10 15:50:57.716571
62	06007	MONCLOVA, COAH	t	2026-02-10 15:50:57.716571
63	06008	MUZQUIZ, COAH	t	2026-02-10 15:50:57.716571
64	06009	NUEVA ROSITA, COAH	t	2026-02-10 15:50:57.716571
65	06010	PALAU, COAH	t	2026-02-10 15:50:57.716571
66	06011	PARRAS DE LA FUENTE, COAH	t	2026-02-10 15:50:57.716571
67	06012	PIEDRAS NEGRAS, COAH	t	2026-02-10 15:50:57.716571
68	06013	RAMOS ARIZPE, COAH	t	2026-02-10 15:50:57.716571
69	06014	SABINAS, COAH	t	2026-02-10 15:50:57.716571
70	06015	SAN PEDRO, COAH	t	2026-02-10 15:50:57.716571
71	06016	TORREON, COAH	t	2026-02-10 15:50:57.716571
72	06017	CD ACUÑA, COAH	t	2026-02-10 15:50:57.716571
73	06018	CIUDAD FRONTERA, COAH	t	2026-02-10 15:50:57.716571
74	07001	COLIMA, COL	t	2026-02-10 15:50:57.716571
75	07002	MANZANILLO, COL	t	2026-02-10 15:50:57.716571
76	07003	TECOMAN, COL	t	2026-02-10 15:50:57.716571
77	07004	ARMERIA, COL	t	2026-02-10 15:50:57.716571
78	07005	CERRO DE ORTEGA, COL	t	2026-02-10 15:50:57.716571
79	08001	TUXTLA GUTIERREZ, CHIS	t	2026-02-10 15:50:57.716571
80	08002	ARRIAGA, CHIS	t	2026-02-10 15:50:57.716571
81	08003	COMITAN, CHIS	t	2026-02-10 15:50:57.716571
82	08004	HUIXTLA, CHIS	t	2026-02-10 15:50:57.716571
83	08005	SAN CRISTOBAL DE LAS CASAS, CHIS	t	2026-02-10 15:50:57.716571
84	08006	TAPACHULA, CHIS	t	2026-02-10 15:50:57.716571
85	09001	CHIHUAHUA, CHIH	t	2026-02-10 15:50:57.716571
86	09005	CD JUAREZ, CHIH	t	2026-02-10 15:50:57.716571
87	09009	PARRAL, CHIH	t	2026-02-10 15:50:57.716571
88	10001	DURANGO, DGO	t	2026-02-10 15:50:57.716571
89	10002	GOMEZ PALACIO, DGO	t	2026-02-10 15:50:57.716571
90	10007	CIUDAD LERDO, DGO	t	2026-02-10 15:50:57.716571
91	11001	GUANAJUATO, GTO	t	2026-02-10 15:50:57.716571
92	11003	CELAYA, GTO	t	2026-02-10 15:50:57.716571
93	11008	LEON, GTO	t	2026-02-10 15:50:57.716571
94	12001	CHILPANCINGO, GRO	t	2026-02-10 15:50:57.716571
95	12002	ACAPULCO, GRO	t	2026-02-10 15:50:57.716571
96	13001	PACHUCA, HGO	t	2026-02-10 15:50:57.716571
97	13002	TULANCINGO, HGO	t	2026-02-10 15:50:57.716571
98	14001	GUADALAJARA, JAL	t	2026-02-10 15:50:57.716571
99	14024	ZAPOPAN, JAL	t	2026-02-10 15:50:57.716571
100	15001	TOLUCA, MEX	t	2026-02-10 15:50:57.716571
101	15044	METEPEC, MEX	t	2026-02-10 15:50:57.716571
102	16001	MORELIA, MICH	t	2026-02-10 15:50:57.716571
103	16009	ZAMORA, MICH	t	2026-02-10 15:50:57.716571
104	17001	CUERNAVACA, MOR	t	2026-02-10 15:50:57.716571
105	18001	TEPIC, NAY	t	2026-02-10 15:50:57.716571
106	19001	MONTERREY, NL	t	2026-02-10 15:50:57.716571
107	20001	OAXACA, OAX	t	2026-02-10 15:50:57.716571
108	21001	PUEBLA, PUE	t	2026-02-10 15:50:57.716571
109	22001	QUERETARO, QRO	t	2026-02-10 15:50:57.716571
110	23001	CHETUMAL, Q ROO	t	2026-02-10 15:50:57.716571
111	24001	SAN LUIS POTOSI, SLP	t	2026-02-10 15:50:57.716571
112	25001	CULIACAN, SIN	t	2026-02-10 15:50:57.716571
113	26001	HERMOSILLO, SON	t	2026-02-10 15:50:57.716571
114	27001	VILLAHERMOSA, TAB	t	2026-02-10 15:50:57.716571
115	28001	CD VICTORIA, TAMPS	t	2026-02-10 15:50:57.716571
116	29001	TLAXCALA, TLAX	t	2026-02-10 15:50:57.716571
117	30001	JALAPA, VER	t	2026-02-10 15:50:57.716571
118	31001	MERIDA, YUC	t	2026-02-10 15:50:57.716571
119	32001	ZACATECAS, ZAC	t	2026-02-10 15:50:57.716571
\.


--
-- Name: cat_beneficiario_id_beneficiario_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cat_beneficiario_id_beneficiario_seq', 1, false);


--
-- Name: cat_cuenta_beneficiario_id_cuenta_beneficiario_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cat_cuenta_beneficiario_id_cuenta_beneficiario_seq', 1, false);


--
-- Name: cat_institucion_bancaria_id_institucion_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cat_institucion_bancaria_id_institucion_seq', 1, false);


--
-- Name: cat_institucion_stp_id_stp_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cat_institucion_stp_id_stp_seq', 92, true);


--
-- Name: cat_layout_campo_id_layout_campo_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cat_layout_campo_id_layout_campo_seq', 319, true);


--
-- Name: cat_layout_id_layout_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cat_layout_id_layout_seq', 15, true);


--
-- Name: cat_origen_opcion_id_opcion_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cat_origen_opcion_id_opcion_seq', 16, true);


--
-- Name: cat_origen_operativo_id_origen_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cat_origen_operativo_id_origen_seq', 8, true);


--
-- Name: cat_plaza_banxico_id_plaza_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cat_plaza_banxico_id_plaza_seq', 119, true);


--
-- Name: cat_beneficiario cat_beneficiario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_beneficiario
    ADD CONSTRAINT cat_beneficiario_pkey PRIMARY KEY (id_beneficiario);


--
-- Name: cat_cuenta_beneficiario cat_cuenta_beneficiario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_cuenta_beneficiario
    ADD CONSTRAINT cat_cuenta_beneficiario_pkey PRIMARY KEY (id_cuenta_beneficiario);


--
-- Name: cat_institucion_bancaria cat_institucion_bancaria_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_institucion_bancaria
    ADD CONSTRAINT cat_institucion_bancaria_pkey PRIMARY KEY (id_institucion);


--
-- Name: cat_institucion_stp cat_institucion_stp_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_institucion_stp
    ADD CONSTRAINT cat_institucion_stp_pkey PRIMARY KEY (id_stp);


--
-- Name: cat_layout_campo cat_layout_campo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_layout_campo
    ADD CONSTRAINT cat_layout_campo_pkey PRIMARY KEY (id_layout_campo);


--
-- Name: cat_layout cat_layout_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_layout
    ADD CONSTRAINT cat_layout_pkey PRIMARY KEY (id_layout);


--
-- Name: cat_origen_opcion cat_origen_opcion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_origen_opcion
    ADD CONSTRAINT cat_origen_opcion_pkey PRIMARY KEY (id_opcion);


--
-- Name: cat_origen_operativo cat_origen_operativo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_origen_operativo
    ADD CONSTRAINT cat_origen_operativo_pkey PRIMARY KEY (id_origen);


--
-- Name: cat_plaza_banxico cat_plaza_banxico_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_plaza_banxico
    ADD CONSTRAINT cat_plaza_banxico_pkey PRIMARY KEY (id_plaza);


--
-- Name: ux_cat_inst_banxico_activo; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ux_cat_inst_banxico_activo ON public.cat_institucion_bancaria USING btree (clave_banxico) WHERE (activo = true);


--
-- Name: ux_cuenta_beneficiario_activa; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ux_cuenta_beneficiario_activa ON public.cat_cuenta_beneficiario USING btree (numero_cuenta) WHERE (activo = true);


--
-- Name: ux_layout_campo_posicion_activo; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ux_layout_campo_posicion_activo ON public.cat_layout_campo USING btree (id_layout, posicion_inicio) WHERE (activo = true);


--
-- Name: ux_layout_codigo_activo; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ux_layout_codigo_activo ON public.cat_layout USING btree (codigo) WHERE (activo = true);


--
-- Name: ux_origen_codigo_activo; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ux_origen_codigo_activo ON public.cat_origen_operativo USING btree (codigo) WHERE (activo = true);


--
-- Name: ux_origen_opcion_codigo_activo; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ux_origen_opcion_codigo_activo ON public.cat_origen_opcion USING btree (id_origen, codigo) WHERE (activo = true);


--
-- Name: ux_plaza_banxico_numero_activo; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ux_plaza_banxico_numero_activo ON public.cat_plaza_banxico USING btree (numero) WHERE (activo = true);


--
-- Name: ux_stp_prefijo_activo; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX ux_stp_prefijo_activo ON public.cat_institucion_stp USING btree (prefijo_clabe) WHERE (activo = true);


--
-- Name: cat_cuenta_beneficiario cat_cuenta_beneficiario_id_beneficiario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_cuenta_beneficiario
    ADD CONSTRAINT cat_cuenta_beneficiario_id_beneficiario_fkey FOREIGN KEY (id_beneficiario) REFERENCES public.cat_beneficiario(id_beneficiario);


--
-- Name: cat_layout_campo cat_layout_campo_id_layout_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_layout_campo
    ADD CONSTRAINT cat_layout_campo_id_layout_fkey FOREIGN KEY (id_layout) REFERENCES public.cat_layout(id_layout);


--
-- Name: cat_layout cat_layout_id_opcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_layout
    ADD CONSTRAINT cat_layout_id_opcion_fkey FOREIGN KEY (id_opcion) REFERENCES public.cat_origen_opcion(id_opcion);


--
-- Name: cat_layout cat_layout_id_origen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_layout
    ADD CONSTRAINT cat_layout_id_origen_fkey FOREIGN KEY (id_origen) REFERENCES public.cat_origen_operativo(id_origen);


--
-- Name: cat_origen_opcion cat_origen_opcion_id_origen_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_origen_opcion
    ADD CONSTRAINT cat_origen_opcion_id_origen_fkey FOREIGN KEY (id_origen) REFERENCES public.cat_origen_operativo(id_origen);


--
-- PostgreSQL database dump complete
--

\unrestrict byQ8C09mLadZQWPzLofNdqTPCe8lgQqyDxMkfZPuaI03zaIrUnvkRQAD8ybUOvJ

