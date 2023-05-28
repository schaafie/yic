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
-- Data for Name: datadefs; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.datadefs (id, name, comment, version, definition, inserted_at, updated_at) VALUES (3, 'datadef', 'Data definition for datadef', '1.0', '{"root": "datadef", "datatypes": [{"name": "datadef", "type": "form", "fields": [{"field": "id", "required": false}, {"field": "comment", "required": true}, {"field": "definition", "required": true}, {"field": "name", "required": true}, {"field": "version", "required": true}], "basetype": "map"}, {"name": "comment", "basetype": "string", "validations": []}, {"name": "definition", "type": "map", "fields": [{"field": "action", "required": false}, {"field": "saveaction", "required": false}, {"field": "createaction", "required": false}, {"field": "type", "required": true}, {"field": "elements", "required": true}, {"field": "title", "required": true}], "basetype": "string"}, {"name": "id", "basetype": "number", "validations": []}, {"name": "action", "basetype": "string", "validations": []}, {"name": "saveaction", "basetype": "string", "validations": []}, {"name": "createaction", "basetype": "string", "validations": []}, {"name": "type", "basetype": "string", "validations": []}, {"name": "elements", "basetype": "array", "validations": []}, {"name": "title", "basetype": "string", "validations": []}, {"name": "label", "basetype": "string", "validations": []}, {"name": "name", "basetype": "string", "validations": []}, {"name": "version", "basetype": "string", "validations": [{"rule": "^(\\d+\\.)?(\\d+\\.)?(\\*|\\d+)$", "type": "format", "error": "Invalid version format."}]}]}', '2022-09-19 07:32:21', '2022-09-19 07:38:07');
INSERT INTO public.datadefs (id, name, comment, version, definition, inserted_at, updated_at) VALUES (1, 'form', 'datadef for forms', '1.0', '{"root": "form", "datatypes": [{"name": "form", "type": "form", "fields": [{"field": "id", "required": false}, {"field": "comment", "required": true}, {"field": "definition", "required": true}, {"field": "name", "required": true}, {"field": "version", "required": true}, {"field": "author", "required": false}], "basetype": "map"}, {"name": "comment", "basetype": "string", "validations": []}, {"name": "definition", "type": "map", "fields": [{"field": "action", "required": false}, {"field": "saveaction", "required": false}, {"field": "createaction", "required": false}, {"field": "type", "required": true}, {"field": "elements", "required": true}, {"field": "title", "required": true}], "basetype": "string"}, {"name": "id", "basetype": "number", "validations": []}, {"name": "action", "basetype": "string", "validations": []}, {"name": "saveaction", "basetype": "string", "validations": []}, {"name": "createaction", "basetype": "string", "validations": []}, {"name": "type", "basetype": "string", "validations": []}, {"name": "elements", "basetype": "array", "validations": []}, {"name": "title", "basetype": "string", "validations": []}, {"name": "label", "basetype": "string", "validations": []}, {"name": "name", "basetype": "string", "validations": []}, {"name": "version", "basetype": "string", "validations": [{"rule": "^(\\d+\\.)?(\\d+\\.)?(\\*|\\d+)$", "type": "format", "error": "Invalid version format."}]}, {"name": "author", "basetype": "id", "validations": []}]}', '2022-08-25 20:03:47', '2022-10-10 11:20:04');
INSERT INTO public.datadefs (id, name, comment, version, definition, inserted_at, updated_at) VALUES (2, 'user', 'datadef for users', '1.0', '{"root": "user", "datatypes": [{"name": "user", "type": "form", "fields": [{"field": "id", "required": false}, {"field": "firstname", "required": true}, {"field": "lastname", "required": true}, {"field": "email", "required": true}], "basetype": "map"}, {"name": "firstname", "basetype": "string", "validations": []}, {"name": "id", "basetype": "number", "validations": []}, {"name": "lastname", "basetype": "string", "validations": []}, {"name": "email", "basetype": "string", "validations": []}, {"name": "createaction", "basetype": "string", "validations": []}]}', '2022-08-26 14:10:51', '2022-10-10 11:20:21');


--
-- Name: datadefs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.datadefs_id_seq', 3, true);


--
-- PostgreSQL database dump complete
--

