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
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, firstname, lastname, email, inserted_at, updated_at) VALUES (1, 'ad', 'ministrator', 'admin@example.com', '2022-08-24 16:34:48', '2022-08-24 16:34:48');
INSERT INTO public.users (id, firstname, lastname, email, inserted_at, updated_at) VALUES (2, 'Pieter', 'Schaafsma', 'pieter.schaafsma@casema.nl', '2022-08-26 13:54:24', '2022-08-26 13:54:24');


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 9, true);


--
-- PostgreSQL database dump complete
--

