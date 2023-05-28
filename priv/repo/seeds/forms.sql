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
-- Data for Name: forms; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.forms (id, name, comment, version, definition, author, inserted_at, updated_at) VALUES (6, 'listdatadef', 'List view of all data definitions', '1.0', '{"type": "overview", "title": "Data definition overview", "actions": [{"list": {"url": "apis/datadefs"}}, {"edit": {"url": "apis/datadefs/:id"}}, {"delete": {"url": "api/forms/datadefs/:id"}}], "elements": [{"pk": true, "type": "hidden", "datapath": "id"}, {"type": "text", "label": "Name", "datapath": "name"}, {"type": "text", "label": "Version", "datapath": "version"}, {"type": "text", "label": "Comment", "datapath": "comment"}], "globalValidations": []}', NULL, '2022-09-19 10:20:34', '2022-09-20 20:50:46');
INSERT INTO public.forms (id, name, comment, version, definition, author, inserted_at, updated_at) VALUES (1, 'listform', 'List view of all forms', '1.0', '{"type": "overview", "title": "Form overview", "actions": [{"list": {"url": "apis/forms"}}, {"edit": {"url": "apis/forms/:id"}}, {"delete": {"url": "api/forms/forms/:id"}}], "elements": [{"pk": true, "type": "hidden", "datapath": "id"}, {"type": "text", "label": "Name", "datapath": "name"}, {"type": "text", "label": "Version", "datapath": "version"}, {"type": "text", "label": "Comment", "datapath": "comment"}], "globalValidations": []}', NULL, '2022-08-24 16:34:49', '2022-09-20 20:51:57');
INSERT INTO public.forms (id, name, comment, version, definition, author, inserted_at, updated_at) VALUES (4, 'detailuser', 'Edit form for user', '1.0', '{"type": "detail", "title": "User detail", "actions": [{"create": {"url": "/iam/users"}}, {"save": {"url": "/iam/users/:id"}}], "elements": [{"type": "hidden", "datapath": "id"}, {"type": "text", "label": "Fist Name", "datapath": "firstname"}, {"type": "text", "label": "Last name", "datapath": "lastname"}, {"type": "text", "label": "email address", "datapath": "email"}], "saveaction": "/iam/users/:id", "globalValidations": []}', NULL, '2022-08-26 20:22:56', '2022-08-31 12:19:19');
INSERT INTO public.forms (id, name, comment, version, definition, author, inserted_at, updated_at) VALUES (2, 'detailsform', 'Edit view for form defintion', '1.0', '{"type": "detail", "title": "Form detail", "actions": [{"create": {"url": "/forms/forms"}}, {"save": {"url": "/forms/forms/:id"}}], "elements": [{"type": "hidden", "datapath": "id"}, {"type": "text", "label": "Form Name", "datapath": "name"}, {"type": "text", "label": "Version", "datapath": "version"}, {"type": "text", "label": "Comment", "datapath": "comment"}, {"type": "number", "label": "Author", "datapath": "author"}, {"type": "json", "label": "Definition", "datapath": "definition"}], "saveaction": "/forms/forms/:id", "globalValidations": []}', NULL, '2022-08-24 16:34:49', '2022-09-19 09:49:53');
INSERT INTO public.forms (id, name, comment, version, definition, author, inserted_at, updated_at) VALUES (3, 'listuser', 'list view of all users', '1.0', '{"type": "overview", "title": "User overview", "actions": [{"list": {"url": "apis/users", "label": "Show users"}}, {"edit": {"url": "apis/users/:id", "label": "Edit"}}, {"create": {"url": "apis/users", "label": "New"}}, {"delete": {"url": "iam/users", "label": "Delete"}}], "elements": [{"pk": true, "type": "hidden", "datapath": "id"}, {"type": "text", "label": "First name", "datapath": "firstname"}, {"type": "text", "label": "Last name", "datapath": "lastname"}, {"type": "text", "label": "email address", "datapath": "email"}], "getaction": "apis/users", "globalValidations": []}', NULL, '2022-08-26 15:43:59', '2022-09-02 18:09:30');
INSERT INTO public.forms (id, name, comment, version, definition, author, inserted_at, updated_at) VALUES (5, 'detaildatadef', 'Edit form for data definition', '1.0', '{"type": "detail", "title": "Data definition detail", "actions": [{"create": {"url": "/forms/datadefs"}}, {"save": {"url": "/forms/datadefs/:id"}}], "elements": [{"type": "hidden", "datapath": "id"}, {"type": "tabs", "elements": [{"type": "tab", "label": "Generic", "elements": [{"type": "grid", "count": 2, "elements": [{"type": "gridcol", "elements": [{"type": "text", "label": "Data definition name", "datapath": "name"}, {"type": "text", "label": "Version", "datapath": "version"}]}, {"type": "gridcol", "elements": [{"type": "textarea", "label": "Comment", "datapath": "comment"}]}]}]}, {"type": "tab", "label": "Definition", "elements": [{"type": "json", "label": "Definition", "datapath": "definition"}]}]}], "saveaction": "/forms/datadefs/:id", "globalValidations": []}', NULL, '2022-09-19 09:42:16', '2022-10-11 12:10:47');


--
-- Name: forms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forms_id_seq', 6, true);


--
-- PostgreSQL database dump complete
--

