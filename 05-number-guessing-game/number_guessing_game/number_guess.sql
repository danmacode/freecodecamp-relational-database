--
-- PostgreSQL database dump
--
-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Usage: psql -U postgres < number_guess.sql
SET statement_timeout = 0;
SET LOCK_TIMEOUT = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = ON;

SELECT pg_catalog.set_config('search_path', '', false);

SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = OFF;

DROP DATABASE number_guess;

--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--
CREATE DATABASE number_guess
    WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';

ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET LOCK_TIMEOUT = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = ON;

SELECT pg_catalog.set_config('search_path', '', false);

SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = OFF;
SET default_tablespace = '';
SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--
CREATE TABLE PUBLIC.games (
    game_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    guesses_num INTEGER DEFAULT 0 NOT NULL
    );

ALTER TABLE PUBLIC.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--
CREATE SEQUENCE PUBLIC.games_game_id_seq AS INTEGER START
    WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER TABLE PUBLIC.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--
ALTER SEQUENCE PUBLIC.games_game_id_seq OWNED BY PUBLIC.games.game_id;

--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--
CREATE TABLE PUBLIC.users (
    user_id INTEGER NOT NULL,
    username CHARACTER VARYING(22) NOT NULL,
    games_played INTEGER DEFAULT 0 NOT NULL
    );

ALTER TABLE PUBLIC.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--
CREATE SEQUENCE PUBLIC.users_user_id_seq AS INTEGER START
    WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;

ALTER TABLE PUBLIC.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--
ALTER SEQUENCE PUBLIC.users_user_id_seq OWNED BY PUBLIC.users.user_id;

--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--
ALTER TABLE ONLY PUBLIC.games

ALTER COLUMN game_id

SET DEFAULT nextval('public.games_game_id_seq'::regclass);

--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--
ALTER TABLE ONLY PUBLIC.users

ALTER COLUMN user_id

SET DEFAULT nextval('public.users_user_id_seq'::regclass);

--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--
--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--
--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--
SELECT pg_catalog.setval('public.games_game_id_seq', 1, false);

--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--
SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);

--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--
ALTER TABLE ONLY PUBLIC.games ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);

--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--
ALTER TABLE ONLY PUBLIC.users ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);

--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--
ALTER TABLE ONLY PUBLIC.users ADD CONSTRAINT users_username_key UNIQUE (username);

--
-- Name: games users_fk; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--
ALTER TABLE ONLY PUBLIC.games ADD CONSTRAINT users_fk FOREIGN KEY (user_id) REFERENCES PUBLIC.users (user_id);
--
-- PostgreSQL database dump complete
--
