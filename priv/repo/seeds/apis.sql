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
-- Data for Name: apis; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.apis (id, name, description, version, request, definition, inserted_at, updated_at) VALUES (2, 'Show form by id', 'Get the data for the Edit Form (data, datadef and formdef)', '0.1', 'apis/forms/:id', '{"output": {"data": "data", "datadef": "datadef", "formdef": "formdef"}, "actions": [{"url": "http://localhost:4000/api/forms/forms/:id", "token": "jwt_local", "method": "get", "output": "data"}, {"url": "http://localhost:4000/api/forms/datadefbyname/form", "token": "jwt_local", "method": "get", "output": "datadef"}, {"url": "http://localhost:4000/api/forms/formbyname/detailsform", "token": "jwt_local", "method": "get", "output": "formdef"}]}', '2022-08-24 16:34:49', '2022-08-28 20:09:40');
INSERT INTO public.apis (id, name, description, version, request, definition, inserted_at, updated_at) VALUES (3, 'List all users', 'Get the data for list Users (data, datadef and formdef)', '0.1', 'apis/users', '{"output": {"data": "data", "datadef": "datadef", "formdef": "formdef"}, "actions": [{"url": "http://localhost:4000/api/iam/users", "token": "jwt_local", "method": "get", "output": "data"}, {"url": "http://localhost:4000/api/forms/datadefbyname/user", "token": "jwt_local", "method": "get", "output": "datadef"}, {"url": "http://localhost:4000/api/forms/formbyname/listuser", "token": "jwt_local", "method": "get", "output": "formdef"}]}', '2022-08-26 13:03:02', '2022-08-28 11:55:35');
INSERT INTO public.apis (id, name, description, version, request, definition, inserted_at, updated_at) VALUES (4, 'Show user by id', 'Get the data for the edit form (data, datadef and formdef)', '0.1', 'apis/users/:id', '{"output": {"data": "data", "datadef": "datadef", "formdef": "formdef"}, "actions": [{"url": "http://localhost:4000/api/iam/users/:id", "token": "jwt_local", "method": "get", "output": "data"}, {"url": "http://localhost:4000/api/forms/datadefbyname/user", "token": "jwt_local", "method": "get", "output": "datadef"}, {"url": "http://localhost:4000/api/forms/formbyname/detailuser", "token": "jwt_local", "method": "get", "output": "formdef"}]}', '2022-08-26 13:13:34', '2022-08-28 11:55:53');
INSERT INTO public.apis (id, name, description, version, request, definition, inserted_at, updated_at) VALUES (5, 'Show datadef by id', 'Get the data for Data def forms', '0.1', 'apis/datadefs/:id', '{"output": {"data": "data", "datadef": "datadef", "formdef": "formdef"}, "actions": [{"url": "http://localhost:4000/api/forms/datadefs/:id", "token": "jwt_local", "method": "get", "output": "data"}, {"url": "http://localhost:4000/api/forms/datadefbyname/datadef", "token": "jwt_local", "method": "get", "output": "datadef"}, {"url": "http://localhost:4000/api/forms/formbyname/detaildatadef", "token": "jwt_local", "method": "get", "output": "formdef"}]}', '2022-09-19 10:33:06', '2022-09-19 10:45:02');
INSERT INTO public.apis (id, name, description, version, request, definition, inserted_at, updated_at) VALUES (1, 'List all forms', 'Get the data for List Forms (data, datadef and formdef)', '0.1', 'apis/forms', '{"output": {"data": "data", "datadef": "datadef", "formdef": "formdef"}, "actions": [{"url": "http://localhost:4000/api/forms/forms", "token": "jwt_local", "method": "get", "output": "data"}, {"url": "http://localhost:4000/api/forms/datadefbyname/form", "token": "jwt_local", "method": "get", "output": "datadef"}, {"url": "http://localhost:4000/api/forms/formbyname/listform", "token": "jwt_local", "method": "get", "output": "formdef"}]}', '2022-08-24 16:34:49', '2022-08-28 12:17:42');
INSERT INTO public.apis (id, name, description, version, request, definition, inserted_at, updated_at) VALUES (6, 'List all data definitions', 'Get the data for List data definitions', '0.1', 'apis/datadefs', '{"output": {"data": "data", "datadef": "datadef", "formdef": "formdef"}, "actions": [{"url": "http://localhost:4000/api/forms/datadefs", "token": "jwt_local", "method": "get", "output": "data"}, {"url": "http://localhost:4000/api/forms/datadefbyname/datadef", "token": "jwt_local", "method": "get", "output": "datadef"}, {"url": "http://localhost:4000/api/forms/formbyname/listdatadef", "token": "jwt_local", "method": "get", "output": "formdef"}]}', '2022-09-19 10:44:27', '2022-09-19 10:47:13');


--
-- Name: apis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.apis_id_seq', 6, true);


--
-- PostgreSQL database dump complete
--

