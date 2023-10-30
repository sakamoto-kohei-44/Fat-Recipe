--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Homebrew)
-- Dumped by pg_dump version 14.9 (Homebrew)

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
-- Name: allergies; Type: TABLE; Schema: public; Owner: sakamotokouhei
--

CREATE TABLE public.allergies (
    id bigint NOT NULL,
    item character varying,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.allergies OWNER TO sakamotokouhei;

--
-- Name: allergies_id_seq; Type: SEQUENCE; Schema: public; Owner: sakamotokouhei
--

CREATE SEQUENCE public.allergies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.allergies_id_seq OWNER TO sakamotokouhei;

--
-- Name: allergies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sakamotokouhei
--

ALTER SEQUENCE public.allergies_id_seq OWNED BY public.allergies.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: sakamotokouhei
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO sakamotokouhei;

--
-- Name: favorites; Type: TABLE; Schema: public; Owner: sakamotokouhei
--

CREATE TABLE public.favorites (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    recipe_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.favorites OWNER TO sakamotokouhei;

--
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: sakamotokouhei
--

CREATE SEQUENCE public.favorites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.favorites_id_seq OWNER TO sakamotokouhei;

--
-- Name: favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sakamotokouhei
--

ALTER SEQUENCE public.favorites_id_seq OWNED BY public.favorites.id;


--
-- Name: food_preferences; Type: TABLE; Schema: public; Owner: sakamotokouhei
--

CREATE TABLE public.food_preferences (
    id bigint NOT NULL,
    preference_type character varying,
    food_item character varying,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.food_preferences OWNER TO sakamotokouhei;

--
-- Name: food_preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: sakamotokouhei
--

CREATE SEQUENCE public.food_preferences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.food_preferences_id_seq OWNER TO sakamotokouhei;

--
-- Name: food_preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sakamotokouhei
--

ALTER SEQUENCE public.food_preferences_id_seq OWNED BY public.food_preferences.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: sakamotokouhei
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    content text,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.notifications OWNER TO sakamotokouhei;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: sakamotokouhei
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notifications_id_seq OWNER TO sakamotokouhei;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sakamotokouhei
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: recipes; Type: TABLE; Schema: public; Owner: sakamotokouhei
--

CREATE TABLE public.recipes (
    id bigint NOT NULL,
    title character varying,
    description text,
    total_calories integer,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.recipes OWNER TO sakamotokouhei;

--
-- Name: recipes_id_seq; Type: SEQUENCE; Schema: public; Owner: sakamotokouhei
--

CREATE SEQUENCE public.recipes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recipes_id_seq OWNER TO sakamotokouhei;

--
-- Name: recipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sakamotokouhei
--

ALTER SEQUENCE public.recipes_id_seq OWNED BY public.recipes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: sakamotokouhei
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO sakamotokouhei;

--
-- Name: users; Type: TABLE; Schema: public; Owner: sakamotokouhei
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying,
    password_digest character varying,
    name character varying,
    gender integer,
    age integer,
    height double precision,
    weight double precision,
    activity_level integer,
    goal integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone
);


ALTER TABLE public.users OWNER TO sakamotokouhei;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: sakamotokouhei
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO sakamotokouhei;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sakamotokouhei
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: weight_logs; Type: TABLE; Schema: public; Owner: sakamotokouhei
--

CREATE TABLE public.weight_logs (
    id bigint NOT NULL,
    date date,
    weight double precision,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.weight_logs OWNER TO sakamotokouhei;

--
-- Name: weight_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: sakamotokouhei
--

CREATE SEQUENCE public.weight_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.weight_logs_id_seq OWNER TO sakamotokouhei;

--
-- Name: weight_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sakamotokouhei
--

ALTER SEQUENCE public.weight_logs_id_seq OWNED BY public.weight_logs.id;


--
-- Name: allergies id; Type: DEFAULT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.allergies ALTER COLUMN id SET DEFAULT nextval('public.allergies_id_seq'::regclass);


--
-- Name: favorites id; Type: DEFAULT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.favorites ALTER COLUMN id SET DEFAULT nextval('public.favorites_id_seq'::regclass);


--
-- Name: food_preferences id; Type: DEFAULT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.food_preferences ALTER COLUMN id SET DEFAULT nextval('public.food_preferences_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: recipes id; Type: DEFAULT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.recipes ALTER COLUMN id SET DEFAULT nextval('public.recipes_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: weight_logs id; Type: DEFAULT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.weight_logs ALTER COLUMN id SET DEFAULT nextval('public.weight_logs_id_seq'::regclass);


--
-- Data for Name: allergies; Type: TABLE DATA; Schema: public; Owner: sakamotokouhei
--

COPY public.allergies (id, item, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: sakamotokouhei
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2023-10-01 22:35:00.500973	2023-10-01 22:35:00.500973
\.


--
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: sakamotokouhei
--

COPY public.favorites (id, user_id, recipe_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: food_preferences; Type: TABLE DATA; Schema: public; Owner: sakamotokouhei
--

COPY public.food_preferences (id, preference_type, food_item, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: sakamotokouhei
--

COPY public.notifications (id, content, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: sakamotokouhei
--

COPY public.recipes (id, title, description, total_calories, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: sakamotokouhei
--

COPY public.schema_migrations (version) FROM stdin;
20231001222136
20231001222210
20231001222435
20231001222527
20231001222528
20231001222534
20231002145030
20231001222540
20231003045523
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: sakamotokouhei
--

COPY public.users (id, email, password_digest, name, gender, age, height, weight, activity_level, goal, created_at, updated_at, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at) FROM stdin;
\.


--
-- Data for Name: weight_logs; Type: TABLE DATA; Schema: public; Owner: sakamotokouhei
--

COPY public.weight_logs (id, date, weight, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: allergies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sakamotokouhei
--

SELECT pg_catalog.setval('public.allergies_id_seq', 1, false);


--
-- Name: favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sakamotokouhei
--

SELECT pg_catalog.setval('public.favorites_id_seq', 1, false);


--
-- Name: food_preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sakamotokouhei
--

SELECT pg_catalog.setval('public.food_preferences_id_seq', 1, false);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sakamotokouhei
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- Name: recipes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sakamotokouhei
--

SELECT pg_catalog.setval('public.recipes_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sakamotokouhei
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: weight_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sakamotokouhei
--

SELECT pg_catalog.setval('public.weight_logs_id_seq', 1, false);


--
-- Name: allergies allergies_pkey; Type: CONSTRAINT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.allergies
    ADD CONSTRAINT allergies_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- Name: food_preferences food_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.food_preferences
    ADD CONSTRAINT food_preferences_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: weight_logs weight_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.weight_logs
    ADD CONSTRAINT weight_logs_pkey PRIMARY KEY (id);


--
-- Name: index_allergies_on_user_id; Type: INDEX; Schema: public; Owner: sakamotokouhei
--

CREATE INDEX index_allergies_on_user_id ON public.allergies USING btree (user_id);


--
-- Name: index_favorites_on_recipe_id; Type: INDEX; Schema: public; Owner: sakamotokouhei
--

CREATE INDEX index_favorites_on_recipe_id ON public.favorites USING btree (recipe_id);


--
-- Name: index_favorites_on_user_id; Type: INDEX; Schema: public; Owner: sakamotokouhei
--

CREATE INDEX index_favorites_on_user_id ON public.favorites USING btree (user_id);


--
-- Name: index_food_preferences_on_user_id; Type: INDEX; Schema: public; Owner: sakamotokouhei
--

CREATE INDEX index_food_preferences_on_user_id ON public.food_preferences USING btree (user_id);


--
-- Name: index_notifications_on_user_id; Type: INDEX; Schema: public; Owner: sakamotokouhei
--

CREATE INDEX index_notifications_on_user_id ON public.notifications USING btree (user_id);


--
-- Name: index_recipes_on_user_id; Type: INDEX; Schema: public; Owner: sakamotokouhei
--

CREATE INDEX index_recipes_on_user_id ON public.recipes USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: sakamotokouhei
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: sakamotokouhei
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_weight_logs_on_user_id; Type: INDEX; Schema: public; Owner: sakamotokouhei
--

CREATE INDEX index_weight_logs_on_user_id ON public.weight_logs USING btree (user_id);


--
-- Name: weight_logs fk_rails_1358a59cb8; Type: FK CONSTRAINT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.weight_logs
    ADD CONSTRAINT fk_rails_1358a59cb8 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: favorites fk_rails_22ca1dd2e6; Type: FK CONSTRAINT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT fk_rails_22ca1dd2e6 FOREIGN KEY (recipe_id) REFERENCES public.recipes(id);


--
-- Name: food_preferences fk_rails_7128c5bb97; Type: FK CONSTRAINT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.food_preferences
    ADD CONSTRAINT fk_rails_7128c5bb97 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: recipes fk_rails_9606fce865; Type: FK CONSTRAINT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT fk_rails_9606fce865 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: notifications fk_rails_b080fb4855; Type: FK CONSTRAINT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_rails_b080fb4855 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: allergies fk_rails_c47b93c48a; Type: FK CONSTRAINT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.allergies
    ADD CONSTRAINT fk_rails_c47b93c48a FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: favorites fk_rails_d15744e438; Type: FK CONSTRAINT; Schema: public; Owner: sakamotokouhei
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT fk_rails_d15744e438 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

