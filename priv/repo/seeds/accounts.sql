--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4
-- Dumped by pg_dump version 10.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.accounts (id, hashed_password, confirmed_at, inserted_at, updated_at, login, user_id) VALUES (1, '$pbkdf2-sha512$160000$G21OI1DQsbpyPTJwTyhHdw$b4AvYFOtadLpPhoFi0fw98ZS44zG7QG9YmZWxlDP86cJDVLtEzevTh1oYOgpzG.MivFIFTNLFD4qjRa7ubDIyg', '2022-08-24 18:34:49', '2022-08-24 16:34:49', '2022-08-24 16:34:49', 'admin', 1);


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 1, true);


--
-- PostgreSQL database dump complete
--

