-- -*-mode: sql; sql-product: postgres;-*- vim:ft=postgresql
--
-- PostgreSQL database dump - db dump after planet table creation & values inserted
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: filler_table; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.filler_table (
    filler_table_id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text
);


ALTER TABLE public.filler_table OWNER TO freecodecamp;

--
-- Name: filler_table_filler_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.filler_table_filler_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.filler_table_filler_id_seq OWNER TO freecodecamp;

--
-- Name: filler_table_filler_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.filler_table_filler_id_seq OWNED BY public.filler_table.filler_table_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    speed numeric DEFAULT 1 NOT NULL,
    description text,
    long_description text
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30) NOT NULL,
    lone boolean DEFAULT true NOT NULL,
    radius numeric,
    partners integer DEFAULT 0 NOT NULL,
    planet_id integer,
    description text
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    dwarf boolean DEFAULT false NOT NULL,
    gaseous boolean DEFAULT false NOT NULL,
    moons integer DEFAULT 0 NOT NULL,
    radius numeric,
    star_id integer,
    description text
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    galaxy_id integer,
    random_int integer,
    description text
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: filler_table filler_table_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.filler_table ALTER COLUMN filler_table_id SET DEFAULT nextval('public.filler_table_filler_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: filler_table; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.filler_table VALUES (1, 'filler1', 'text1');
INSERT INTO public.filler_table VALUES (2, 'filler2', 'text2');
INSERT INTO public.filler_table VALUES (3, 'filler3', 'text3');


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 2, 'the galaxy etc', NULL);
INSERT INTO public.galaxy VALUES (2, 'Androm', 3, 'hola', NULL);
INSERT INTO public.galaxy VALUES (3, 'third', 3, 'si hola', NULL);
INSERT INTO public.galaxy VALUES (4, 'fourth', 4, 'qtal', NULL);
INSERT INTO public.galaxy VALUES (5, 'fifth', 5, 'sip', NULL);
INSERT INTO public.galaxy VALUES (6, 'sixth', 6, 'end', NULL);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'moon1', true, 2439.7, 0, 1, 'moon1');
INSERT INTO public.moon VALUES (2, 'moon2', true, 2439.7, 0, 1, 'moon2');
INSERT INTO public.moon VALUES (3, 'moon3', true, 2439.7, 0, 1, 'moon3');
INSERT INTO public.moon VALUES (4, 'moon4', true, 2439.7, 0, 1, 'moon4');
INSERT INTO public.moon VALUES (5, 'moon5', true, 2439.7, 0, 1, 'moon5');
INSERT INTO public.moon VALUES (6, 'moon6', true, 2439.7, 0, 1, 'moon6');
INSERT INTO public.moon VALUES (7, 'moon7', true, 2439.7, 0, 1, 'moon7');
INSERT INTO public.moon VALUES (8, 'moon8', true, 2439.7, 0, 1, 'moon8');
INSERT INTO public.moon VALUES (9, 'moon9', true, 2439.7, 0, 1, 'moon9');
INSERT INTO public.moon VALUES (10, 'moon10', true, 2439.7, 0, 1, 'moon10');
INSERT INTO public.moon VALUES (11, 'moon11', true, 2439.7, 0, 1, 'moon11');
INSERT INTO public.moon VALUES (12, 'moon12', true, 2439.7, 0, 1, 'moon12');
INSERT INTO public.moon VALUES (13, 'moon13', true, 2439.7, 0, 1, 'moon13');
INSERT INTO public.moon VALUES (14, 'moon14', true, 2439.7, 0, 1, 'moon14');
INSERT INTO public.moon VALUES (15, 'moon15', true, 2439.7, 0, 1, 'moon15');
INSERT INTO public.moon VALUES (16, 'moon16', true, 2439.7, 0, 1, 'moon16');
INSERT INTO public.moon VALUES (17, 'moon17', true, 2439.7, 0, 1, 'moon17');
INSERT INTO public.moon VALUES (18, 'moon18', true, 2439.7, 0, 1, 'moon18');
INSERT INTO public.moon VALUES (19, 'moon19', true, 2439.7, 0, 1, 'moon18');
INSERT INTO public.moon VALUES (20, 'moon20', true, 2439.7, 0, 1, 'moon18');


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', false, false, 0, 2439.7, 1, 'planet1');
INSERT INTO public.planet VALUES (2, 'Venus', false, false, 0, 6051.8, 1, 'planet2');
INSERT INTO public.planet VALUES (3, 'Earth', false, false, 1, 6371, 1, 'planet3');
INSERT INTO public.planet VALUES (4, 'Mars', false, false, 2, 3389.5, 1, 'planet4');
INSERT INTO public.planet VALUES (5, 'Jupiter', false, true, 4, 69911, 1, 'planet5');
INSERT INTO public.planet VALUES (6, 'Saturn', false, true, 83, 58232, 1, 'planet6');
INSERT INTO public.planet VALUES (7, 'Uranus', false, true, 27, 25362, 1, 'planet7');
INSERT INTO public.planet VALUES (8, 'Neptune', false, true, 14, 24622, 1, 'planet8');
INSERT INTO public.planet VALUES (9, 'Pluto', true, false, 5, 1187, 1, 'planet9');
INSERT INTO public.planet VALUES (10, 'Pluto2', true, false, 5, 1187, 1, 'planet10');
INSERT INTO public.planet VALUES (11, 'Pluto3', true, false, 5, 1187, 1, 'planet11');
INSERT INTO public.planet VALUES (12, 'Pluto4', true, false, 5, 1187, 1, 'planet12');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 1, 20, 'Lone star');
INSERT INTO public.star VALUES (2, 'Star2', 2, 24, 'Second');
INSERT INTO public.star VALUES (3, 'Star3', 3, 34, 'Third');
INSERT INTO public.star VALUES (4, 'Star4', 4, 55, 'Fourth');
INSERT INTO public.star VALUES (5, 'Star5', 5, 71, 'Fifth');
INSERT INTO public.star VALUES (6, 'Star6', 6, 80, 'Sixth');


--
-- Name: filler_table_filler_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.filler_table_filler_id_seq', 3, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: filler_table filler_table_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.filler_table
    ADD CONSTRAINT filler_table_name_key UNIQUE (name);


--
-- Name: filler_table filler_table_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.filler_table
    ADD CONSTRAINT filler_table_pkey PRIMARY KEY (filler_table_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

