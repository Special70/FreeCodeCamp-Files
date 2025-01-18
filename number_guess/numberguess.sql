--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.1)

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

DROP DATABASE numberguess;
--
-- Name: numberguess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE numberguess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE numberguess OWNER TO freecodecamp;

\connect numberguess

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
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    user_id integer NOT NULL,
    attempts integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (51, 31, 45);
INSERT INTO public.games VALUES (52, 31, 80);
INSERT INTO public.games VALUES (53, 32, 21);
INSERT INTO public.games VALUES (54, 32, 65);
INSERT INTO public.games VALUES (55, 31, 93);
INSERT INTO public.games VALUES (56, 31, 69);
INSERT INTO public.games VALUES (57, 31, 34);
INSERT INTO public.games VALUES (58, 34, 764);
INSERT INTO public.games VALUES (59, 34, 876);
INSERT INTO public.games VALUES (60, 35, 749);
INSERT INTO public.games VALUES (61, 35, 360);
INSERT INTO public.games VALUES (62, 34, 526);
INSERT INTO public.games VALUES (63, 34, 800);
INSERT INTO public.games VALUES (64, 34, 841);
INSERT INTO public.games VALUES (65, 36, 403);
INSERT INTO public.games VALUES (66, 37, 881);
INSERT INTO public.games VALUES (67, 36, 905);
INSERT INTO public.games VALUES (68, 36, 600);
INSERT INTO public.games VALUES (69, 36, 908);
INSERT INTO public.games VALUES (70, 38, 814);
INSERT INTO public.games VALUES (71, 38, 373);
INSERT INTO public.games VALUES (72, 39, 780);
INSERT INTO public.games VALUES (73, 39, 739);
INSERT INTO public.games VALUES (74, 38, 572);
INSERT INTO public.games VALUES (75, 38, 798);
INSERT INTO public.games VALUES (76, 38, 690);
INSERT INTO public.games VALUES (77, 40, 976);
INSERT INTO public.games VALUES (78, 40, 595);
INSERT INTO public.games VALUES (79, 41, 145);
INSERT INTO public.games VALUES (80, 41, 682);
INSERT INTO public.games VALUES (81, 40, 441);
INSERT INTO public.games VALUES (82, 40, 461);
INSERT INTO public.games VALUES (83, 40, 478);
INSERT INTO public.games VALUES (84, 42, 681);
INSERT INTO public.games VALUES (85, 42, 591);
INSERT INTO public.games VALUES (86, 43, 691);
INSERT INTO public.games VALUES (87, 43, 619);
INSERT INTO public.games VALUES (88, 42, 915);
INSERT INTO public.games VALUES (89, 42, 716);
INSERT INTO public.games VALUES (90, 42, 575);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (31, 'user_1737157978740');
INSERT INTO public.users VALUES (32, 'user_1737157978739');
INSERT INTO public.users VALUES (33, 'Kars');
INSERT INTO public.users VALUES (34, 'user_1737158029980');
INSERT INTO public.users VALUES (35, 'user_1737158029979');
INSERT INTO public.users VALUES (36, 'user_1737158045892');
INSERT INTO public.users VALUES (37, 'user_1737158045891');
INSERT INTO public.users VALUES (38, 'user_1737158053833');
INSERT INTO public.users VALUES (39, 'user_1737158053832');
INSERT INTO public.users VALUES (40, 'user_1737158265077');
INSERT INTO public.users VALUES (41, 'user_1737158265076');
INSERT INTO public.users VALUES (42, 'user_1737158322115');
INSERT INTO public.users VALUES (43, 'user_1737158322114');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 90, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 43, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: games games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

