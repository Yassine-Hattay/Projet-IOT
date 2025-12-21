--
-- PostgreSQL database dump
--

\restrict YjByqKIBi31xHdDSTQ10IgtSmkT8L3M1vggBnZ0aMslIs32ycxyXN7SPszDSeaC

-- Dumped from database version 14.20
-- Dumped by pg_dump version 14.20

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

--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: __diesel_schema_migrations; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.__diesel_schema_migrations (
    version character varying(50) NOT NULL,
    run_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.__diesel_schema_migrations OWNER TO chirpstack;

--
-- Name: api_key; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.api_key (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    name character varying(100) NOT NULL,
    is_admin boolean NOT NULL,
    tenant_id uuid
);


ALTER TABLE public.api_key OWNER TO chirpstack;

--
-- Name: application; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.application (
    id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    mqtt_tls_cert bytea,
    tags jsonb NOT NULL
);


ALTER TABLE public.application OWNER TO chirpstack;

--
-- Name: application_integration; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.application_integration (
    application_id uuid NOT NULL,
    kind character varying(20) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    configuration jsonb NOT NULL
);


ALTER TABLE public.application_integration OWNER TO chirpstack;

--
-- Name: device; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.device (
    dev_eui bytea NOT NULL,
    application_id uuid NOT NULL,
    device_profile_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    last_seen_at timestamp with time zone,
    scheduler_run_after timestamp with time zone,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    external_power_source boolean NOT NULL,
    battery_level numeric(5,2),
    margin integer,
    dr smallint,
    latitude double precision,
    longitude double precision,
    altitude real,
    dev_addr bytea,
    enabled_class character(1) NOT NULL,
    skip_fcnt_check boolean NOT NULL,
    is_disabled boolean NOT NULL,
    tags jsonb NOT NULL,
    variables jsonb NOT NULL,
    join_eui bytea NOT NULL,
    secondary_dev_addr bytea,
    device_session bytea,
    app_layer_params jsonb NOT NULL,
    f_cnt_up bigint NOT NULL
);


ALTER TABLE public.device OWNER TO chirpstack;

--
-- Name: device_keys; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.device_keys (
    dev_eui bytea NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    nwk_key bytea NOT NULL,
    app_key bytea NOT NULL,
    dev_nonces jsonb NOT NULL,
    join_nonce integer NOT NULL,
    gen_app_key bytea NOT NULL
);


ALTER TABLE public.device_keys OWNER TO chirpstack;

--
-- Name: device_profile; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.device_profile (
    id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(100) NOT NULL,
    region character varying(10) NOT NULL,
    mac_version character varying(10) NOT NULL,
    reg_params_revision character varying(20) NOT NULL,
    adr_algorithm_id character varying(100) NOT NULL,
    payload_codec_runtime character varying(20) NOT NULL,
    uplink_interval integer NOT NULL,
    device_status_req_interval integer NOT NULL,
    supports_otaa boolean NOT NULL,
    supports_class_b boolean NOT NULL,
    supports_class_c boolean NOT NULL,
    tags jsonb NOT NULL,
    payload_codec_script text NOT NULL,
    flush_queue_on_activate boolean NOT NULL,
    description text NOT NULL,
    measurements jsonb NOT NULL,
    auto_detect_measurements boolean NOT NULL,
    region_config_id character varying(100),
    allow_roaming boolean NOT NULL,
    rx1_delay smallint NOT NULL,
    abp_params jsonb,
    class_b_params jsonb,
    class_c_params jsonb,
    relay_params jsonb,
    app_layer_params jsonb NOT NULL
);


ALTER TABLE public.device_profile OWNER TO chirpstack;

--
-- Name: device_profile_template; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.device_profile_template (
    id text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    vendor character varying(100) NOT NULL,
    firmware character varying(100) NOT NULL,
    region character varying(10) NOT NULL,
    mac_version character varying(10) NOT NULL,
    reg_params_revision character varying(20) NOT NULL,
    adr_algorithm_id character varying(100) NOT NULL,
    payload_codec_runtime character varying(20) NOT NULL,
    payload_codec_script text NOT NULL,
    uplink_interval integer NOT NULL,
    device_status_req_interval integer NOT NULL,
    flush_queue_on_activate boolean NOT NULL,
    supports_otaa boolean NOT NULL,
    supports_class_b boolean NOT NULL,
    supports_class_c boolean NOT NULL,
    class_b_timeout integer NOT NULL,
    class_b_ping_slot_periodicity integer NOT NULL,
    class_b_ping_slot_dr smallint NOT NULL,
    class_b_ping_slot_freq bigint NOT NULL,
    class_c_timeout integer NOT NULL,
    abp_rx1_delay smallint NOT NULL,
    abp_rx1_dr_offset smallint NOT NULL,
    abp_rx2_dr smallint NOT NULL,
    abp_rx2_freq bigint NOT NULL,
    tags jsonb NOT NULL,
    measurements jsonb NOT NULL,
    auto_detect_measurements boolean NOT NULL
);


ALTER TABLE public.device_profile_template OWNER TO chirpstack;

--
-- Name: device_queue_item; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.device_queue_item (
    id uuid NOT NULL,
    dev_eui bytea NOT NULL,
    created_at timestamp with time zone NOT NULL,
    f_port smallint NOT NULL,
    confirmed boolean NOT NULL,
    data bytea NOT NULL,
    is_pending boolean NOT NULL,
    f_cnt_down bigint,
    timeout_after timestamp with time zone,
    is_encrypted boolean NOT NULL,
    expires_at timestamp with time zone
);


ALTER TABLE public.device_queue_item OWNER TO chirpstack;

--
-- Name: fuota_deployment; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.fuota_deployment (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    started_at timestamp with time zone,
    completed_at timestamp with time zone,
    name character varying(100) NOT NULL,
    application_id uuid NOT NULL,
    device_profile_id uuid NOT NULL,
    multicast_addr bytea NOT NULL,
    multicast_key bytea NOT NULL,
    multicast_group_type character(1) NOT NULL,
    multicast_class_c_scheduling_type character varying(20) NOT NULL,
    multicast_dr smallint NOT NULL,
    multicast_class_b_ping_slot_periodicity smallint NOT NULL,
    multicast_frequency bigint NOT NULL,
    multicast_timeout smallint NOT NULL,
    multicast_session_start timestamp with time zone,
    multicast_session_end timestamp with time zone,
    unicast_max_retry_count smallint NOT NULL,
    fragmentation_fragment_size smallint NOT NULL,
    fragmentation_redundancy_percentage smallint NOT NULL,
    fragmentation_session_index smallint NOT NULL,
    fragmentation_matrix smallint NOT NULL,
    fragmentation_block_ack_delay smallint NOT NULL,
    fragmentation_descriptor bytea NOT NULL,
    request_fragmentation_session_status character varying(20) NOT NULL,
    payload bytea NOT NULL,
    on_complete_set_device_tags jsonb NOT NULL
);


ALTER TABLE public.fuota_deployment OWNER TO chirpstack;

--
-- Name: fuota_deployment_device; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.fuota_deployment_device (
    fuota_deployment_id uuid NOT NULL,
    dev_eui bytea NOT NULL,
    created_at timestamp with time zone NOT NULL,
    completed_at timestamp with time zone,
    mc_group_setup_completed_at timestamp with time zone,
    mc_session_completed_at timestamp with time zone,
    frag_session_setup_completed_at timestamp with time zone,
    frag_status_completed_at timestamp with time zone,
    error_msg text NOT NULL
);


ALTER TABLE public.fuota_deployment_device OWNER TO chirpstack;

--
-- Name: fuota_deployment_gateway; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.fuota_deployment_gateway (
    fuota_deployment_id uuid NOT NULL,
    gateway_id bytea NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.fuota_deployment_gateway OWNER TO chirpstack;

--
-- Name: fuota_deployment_job; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.fuota_deployment_job (
    fuota_deployment_id uuid NOT NULL,
    job character varying(20) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    completed_at timestamp with time zone,
    max_retry_count smallint NOT NULL,
    attempt_count smallint NOT NULL,
    scheduler_run_after timestamp with time zone NOT NULL,
    warning_msg text NOT NULL,
    error_msg text NOT NULL
);


ALTER TABLE public.fuota_deployment_job OWNER TO chirpstack;

--
-- Name: gateway; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.gateway (
    gateway_id bytea NOT NULL,
    tenant_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    last_seen_at timestamp with time zone,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    altitude real NOT NULL,
    stats_interval_secs integer NOT NULL,
    tls_certificate bytea,
    tags jsonb NOT NULL,
    properties jsonb NOT NULL
);


ALTER TABLE public.gateway OWNER TO chirpstack;

--
-- Name: multicast_group; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.multicast_group (
    id uuid NOT NULL,
    application_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(100) NOT NULL,
    region character varying(10) NOT NULL,
    mc_addr bytea NOT NULL,
    mc_nwk_s_key bytea NOT NULL,
    mc_app_s_key bytea NOT NULL,
    f_cnt bigint NOT NULL,
    group_type character(1) NOT NULL,
    dr smallint NOT NULL,
    frequency bigint NOT NULL,
    class_b_ping_slot_periodicity smallint NOT NULL,
    class_c_scheduling_type character varying(20) NOT NULL
);


ALTER TABLE public.multicast_group OWNER TO chirpstack;

--
-- Name: multicast_group_device; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.multicast_group_device (
    multicast_group_id uuid NOT NULL,
    dev_eui bytea NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.multicast_group_device OWNER TO chirpstack;

--
-- Name: multicast_group_gateway; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.multicast_group_gateway (
    multicast_group_id uuid NOT NULL,
    gateway_id bytea NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.multicast_group_gateway OWNER TO chirpstack;

--
-- Name: multicast_group_queue_item; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.multicast_group_queue_item (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    scheduler_run_after timestamp with time zone NOT NULL,
    multicast_group_id uuid NOT NULL,
    gateway_id bytea NOT NULL,
    f_cnt bigint NOT NULL,
    f_port smallint NOT NULL,
    data bytea NOT NULL,
    emit_at_time_since_gps_epoch bigint,
    expires_at timestamp with time zone
);


ALTER TABLE public.multicast_group_queue_item OWNER TO chirpstack;

--
-- Name: relay_device; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.relay_device (
    relay_dev_eui bytea NOT NULL,
    dev_eui bytea NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.relay_device OWNER TO chirpstack;

--
-- Name: relay_gateway; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.relay_gateway (
    tenant_id uuid NOT NULL,
    relay_id bytea NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    last_seen_at timestamp with time zone,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    stats_interval_secs integer NOT NULL,
    region_config_id character varying(100) NOT NULL
);


ALTER TABLE public.relay_gateway OWNER TO chirpstack;

--
-- Name: tenant; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.tenant (
    id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    can_have_gateways boolean NOT NULL,
    max_device_count integer NOT NULL,
    max_gateway_count integer NOT NULL,
    private_gateways_up boolean NOT NULL,
    private_gateways_down boolean NOT NULL,
    tags jsonb NOT NULL
);


ALTER TABLE public.tenant OWNER TO chirpstack;

--
-- Name: tenant_user; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public.tenant_user (
    tenant_id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    is_admin boolean NOT NULL,
    is_device_admin boolean NOT NULL,
    is_gateway_admin boolean NOT NULL
);


ALTER TABLE public.tenant_user OWNER TO chirpstack;

--
-- Name: user; Type: TABLE; Schema: public; Owner: chirpstack
--

CREATE TABLE public."user" (
    id uuid NOT NULL,
    external_id text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    is_admin boolean NOT NULL,
    is_active boolean NOT NULL,
    email text NOT NULL,
    email_verified boolean NOT NULL,
    password_hash character varying(200) NOT NULL,
    note text NOT NULL
);


ALTER TABLE public."user" OWNER TO chirpstack;

--
-- Data for Name: __diesel_schema_migrations; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.__diesel_schema_migrations (version, run_on) FROM stdin;
00000000000000	2025-12-17 09:33:06.298459
20220426153628	2025-12-17 09:33:06.44104
20220428071028	2025-12-17 09:33:06.445889
20220511084032	2025-12-17 09:33:06.449091
20220614130020	2025-12-17 09:33:06.473491
20221102090533	2025-12-17 09:33:06.477215
20230103201442	2025-12-17 09:33:06.48137
20230112130153	2025-12-17 09:33:06.483573
20230206135050	2025-12-17 09:33:06.485579
20230213103316	2025-12-17 09:33:06.498068
20230216091535	2025-12-17 09:33:06.5005
20230925105457	2025-12-17 09:33:06.528232
20231019142614	2025-12-17 09:33:06.530442
20231122120700	2025-12-17 09:33:06.534442
20240207083424	2025-12-17 09:33:06.536515
20240326134652	2025-12-17 09:33:06.542615
20240430103242	2025-12-17 09:33:06.554404
20240613122655	2025-12-17 09:33:06.557003
20240916123034	2025-12-17 09:33:06.564656
20241112135745	2025-12-17 09:33:06.566476
20250113152218	2025-12-17 09:33:06.57642
20250121093745	2025-12-17 09:33:06.586771
20250605100843	2025-12-17 09:33:06.621314
20250804085822	2025-12-17 09:33:06.62365
20251001085546	2025-12-17 09:33:06.626051
\.


--
-- Data for Name: api_key; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.api_key (id, created_at, name, is_admin, tenant_id) FROM stdin;
\.


--
-- Data for Name: application; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.application (id, tenant_id, created_at, updated_at, name, description, mqtt_tls_cert, tags) FROM stdin;
1ef8dd59-d231-4119-91cb-65d8c7cc3638	5672112a-e4c1-4e7b-92e8-ed09db4eca01	2025-12-17 10:10:03.191274+00	2025-12-17 10:10:03.191274+00	industrial-monitoring		\N	{}
\.


--
-- Data for Name: application_integration; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.application_integration (application_id, kind, created_at, updated_at, configuration) FROM stdin;
\.


--
-- Data for Name: device; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.device (dev_eui, application_id, device_profile_id, created_at, updated_at, last_seen_at, scheduler_run_after, name, description, external_power_source, battery_level, margin, dr, latitude, longitude, altitude, dev_addr, enabled_class, skip_fcnt_check, is_disabled, tags, variables, join_eui, secondary_dev_addr, device_session, app_layer_params, f_cnt_up) FROM stdin;
\\x44cff40d883a74cc	1ef8dd59-d231-4119-91cb-65d8c7cc3638	2f529310-7063-484e-ba6d-6ee31e5b1fdc	2025-12-17 10:15:06.370976+00	2025-12-17 10:15:06.370976+00	2025-12-19 19:43:43.835407+00	2025-12-19 19:43:48.831254+00	vib-sensor		f	\N	\N	0	\N	\N	\N	\\x00fa2f64	A	f	f	{}	{}	\\x0000000000000000	\N	\\x120400fa2f6420032a1003f7aae0ce4ee68852ae781343ed9f8e321003f7aae0ce4ee68852ae781343ed9f8e3a1003f7aae0ce4ee68852ae781343ed9f8e42121210997691f4901cab2fd20827577f85641e7001880188cccf9e0392010800010203040506079a010c0805120808e0ffd39d0318059a010c0806120808a09ae09d0318059a010c0804120808a0e5c79d0318059a010c0803120808e0cabb9d0318059a010c0807120808e0b4ec9d031805b80101c202056575383638	{"ts004_session_cnt": [0, 0, 0, 0]}	0
\\x4f3a8f05adfafeef	1ef8dd59-d231-4119-91cb-65d8c7cc3638	2f529310-7063-484e-ba6d-6ee31e5b1fdc	2025-12-17 10:55:55.373614+00	2025-12-17 10:55:55.373614+00	2025-12-19 19:43:22.153627+00	2025-12-19 19:43:19.783359+00	temp-sensor	temp-sensor	t	\N	14	0	\N	\N	\N	\\x00041bc0	A	t	f	{}	{}	\\x0000000000000000	\N	\\x120400041bc020032a10504635b2de44ee877ac66115105b78c73210504635b2de44ee877ac66115105b78c73a10504635b2de44ee877ac66115105b78c742121210bc2604d799dbbf64716b68bf1265740968017001880188cccf9e0392010800010203040506079a010c0803120808e0cabb9d0318059a010c0806120808a09ae09d0318059a010c0807120808e0b4ec9d0318059a010c0805120808e0ffd39d0318059a010c0804120808a0e5c79d031805b80101c202056575383638	{"ts004_session_cnt": [0, 0, 0, 0]}	0
\\xfa1e11ec1249c037	1ef8dd59-d231-4119-91cb-65d8c7cc3638	2f529310-7063-484e-ba6d-6ee31e5b1fdc	2025-12-17 10:14:14.853911+00	2025-12-17 10:14:14.853911+00	2025-12-19 19:43:53.06347+00	2025-12-19 19:43:58.059331+00	hum-sensor		f	\N	\N	0	\N	\N	\N	\\x0140d413	A	f	f	{}	{}	\\x0000000000000000	\N	\\x12040140d41320032a100c8217b1e85132b19ee1660e47c176d432100c8217b1e85132b19ee1660e47c176d43a100c8217b1e85132b19ee1660e47c176d44212121085232d8a2dc5a7f28149a0decd7d57e750017001880188cccf9e0392010800010203040506079a010c0805120808e0ffd39d0318059a010c0807120808e0b4ec9d0318059a010c0803120808e0cabb9d0318059a010c0806120808a09ae09d0318059a010c0804120808a0e5c79d031805b80101f2011508ac09150000e040200128c4ffffffffffffffff01f2011508ad09150000e040200128c4ffffffffffffffff0182020c08f8d596ca0610d694f3e901c202056575383638da02050806120106	{"ts004_session_cnt": [0, 0, 0, 0]}	1198
\.


--
-- Data for Name: device_keys; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.device_keys (dev_eui, created_at, updated_at, nwk_key, app_key, dev_nonces, join_nonce, gen_app_key) FROM stdin;
\\x4f3a8f05adfafeef	2025-12-17 10:56:05.473663+00	2025-12-19 19:43:52.91972+00	\\xda6dcc535ee5c1c3e578392b9c259673	\\x00000000000000000000000000000000	{"0000000000000000": [11033, 7579, 52640, 12609, 61604, 15802, 22120, 41199, 42439, 18722, 26497, 38258, 6399, 41424, 28470, 2553, 17562, 40954, 17650, 39668, 33805, 51662, 46519, 34034, 12457, 41496, 56987, 59762, 64408, 3591, 14230, 44222, 8819, 541, 47547, 36617, 9693, 33706, 35750, 16561, 17129, 30224, 36658, 51179, 18966, 31170, 51797, 32432, 2029, 53329, 19881, 5839, 22551, 47314, 50967, 33235, 22375, 41040, 25083, 23799, 5269, 47975, 50438, 12790, 1707, 38189, 5, 62914, 1085, 11459, 42396, 1669, 23872, 8693, 59087, 16148, 45223, 65051, 25787, 19996, 51418, 64491, 58994, 25056, 59992, 57077, 20970, 51198, 10152, 39878, 16058, 34176, 46770, 53828, 40339, 24146, 2409, 4194, 55137, 53478, 17944, 52685, 63214, 13055, 39237, 32060, 45971, 23217, 10730, 38709, 51893, 11831, 16957, 45976, 14391, 18383, 35913, 34, 61321, 59423, 59522, 20735, 18888, 31602, 40228, 53249, 61859, 49212, 25029, 63479, 52911, 23041, 61307, 50375, 17044, 53692, 30417, 55649, 2371, 62994, 63521, 20452, 52894, 49899, 63476, 31011, 7198, 42072, 33942, 25427, 47462, 2215, 31840, 45834, 41697, 7411, 62596, 44008, 50592, 61872, 46594, 31280, 60106, 367, 51574, 18925, 62857, 46441, 58756, 36059, 52589, 2121, 6373, 61161, 63251, 20104, 63652, 17855, 20731, 33470, 42580, 56458, 48334, 41728, 36897, 49460, 17908, 50020, 885, 41920, 50886, 20568, 18960, 53645, 25293, 11054, 96, 19156, 6395, 43692, 26471, 46148, 13119, 58935, 56754, 49479, 24286, 32289, 61855, 29571, 13994, 17510, 53066, 8650, 23042, 60364, 34543, 11065, 49917, 37805, 16875, 54347, 42, 38539, 60438, 10471, 47625, 19784, 36944, 57769, 22245, 20007, 47823, 45191, 35906, 34380, 44490, 47877, 457, 24838, 55704, 36924, 25515, 15172, 45274, 29662, 57904, 26841, 43748, 3617, 4920, 38862, 53226, 50359, 60596, 51239, 45048, 62632, 1821, 56007, 5917, 52985, 15787, 13191, 53309, 15087, 43909, 11705, 47896, 49559, 34406, 52264, 21394, 16992, 15479, 25036, 44481, 43519, 44313, 17029, 39852, 15964, 60204, 32992, 27042, 1424, 20208, 58951, 42679, 43803, 22462, 37970, 6222, 41531, 10213, 42131, 36843, 4175, 15865, 31756, 4975, 58206, 51204, 39968, 48545, 65330, 23353, 32934, 22603, 11952, 33274, 36721, 34361, 54364, 25541, 56944, 49454, 10066, 9081, 65304, 18178, 38039, 52551, 16122, 5381, 30951, 60435, 936, 47043, 53878, 28125, 4842, 24804, 34442, 59527, 60851, 40424, 31572, 54844, 53313, 53487, 45374, 23985, 54571, 60050, 25124, 29378, 25847, 57514, 47583, 44161, 47247, 15119, 5190, 742, 56147, 22465, 63311, 35388, 4221, 32245, 27576, 43792, 21840, 52103, 35230, 59609, 3506, 16216, 4797, 1324, 28497, 63208, 48853, 9275, 36810, 5296, 64125, 2074, 43282, 35482, 33439, 55001, 12083, 35135, 57590, 37027, 40184, 15615, 30023, 51948, 58689, 50749, 16979, 5820, 47962, 38478, 42154, 47729, 54512, 35007, 30660, 5423, 42541, 22429, 50047, 49002, 24288, 7120, 54692, 34893, 49080, 15474, 49566, 6545, 30793, 31900, 45311, 63444, 51478, 30664, 36146, 25354, 6258, 64967, 64513, 4263, 56493, 39939, 45513, 30807, 45610, 52233, 958, 55710, 888, 59107, 12156, 2200, 43463, 61499, 45847, 32629, 10783, 59351, 50512, 27199, 22995, 6312, 42846, 37134, 28407, 50511, 63524, 61644, 52786, 34882, 11960, 31106, 30216, 59215, 49541, 8085, 37556, 17957, 10309, 10292, 27751, 6554, 26684, 34242, 43292, 51941, 37249, 1147, 45244, 27651, 19109, 42308, 51143, 40595, 38649, 2481, 9311, 43854, 29028, 42853, 58425, 40910, 1791, 20806, 10438, 20683, 33662, 24657, 53440, 19803, 5364, 25768, 36634, 32346, 14209, 9034, 30275, 28777, 28064, 16974, 17245, 51735, 39653, 8086, 21432, 62698, 12138, 4380, 42627, 40046, 40876, 17765, 17886, 49616, 36991, 34370, 22022, 13575, 12480, 16778, 28292, 35980, 56451, 36433, 23568, 32630, 44849, 62006, 38292, 6820, 2406, 44985, 56947, 34898, 36616, 1156, 21807, 49484, 26262, 19887, 56323, 43261, 18401, 34194, 54710, 5217, 5304, 18749, 18255, 46524, 22787, 17728, 1387, 55516, 11950, 49016, 37586, 43295, 3278, 40372, 6040, 56115, 63805, 34184, 31239, 20261, 22237, 37499, 32670, 53498, 35050, 44540, 21185, 8919, 27958, 10377, 57604, 63085, 20608, 55340, 18631, 33833, 13161, 36258, 42509, 24096, 48456, 10076, 25622, 64096, 26290, 65070, 50386, 58811, 41133, 59600, 5931, 3417, 42151, 1728, 21780, 40726, 56131, 3941, 30721, 12276, 33895, 51995, 54726, 38629, 26279, 7601, 3803, 35362, 10036, 45519, 65410, 27747, 57045, 51782, 33072, 24138, 275, 26069, 28764, 63127, 65081, 2998, 38925, 40319, 20278, 2040, 64064, 25087, 10190, 49388, 63547, 46635, 55866, 28645, 19502, 13374, 8283, 55968, 55917, 58119, 59892, 15088, 36007, 7861, 65517, 51933, 41047, 61372, 1470, 37291, 3836, 31989, 7390, 7829, 21619, 43661, 60535, 55763, 13261, 61672, 24654, 57196, 3882, 9712, 24734, 22835, 31998, 23737, 7388, 41930, 17227, 26191, 29942, 2847, 41414, 23409, 32610, 50340, 50345, 26374, 52767, 20262, 4943, 33940, 32360, 35661, 26678, 22949, 20384, 49591, 46786, 64759, 51809, 22017, 41174, 2083, 16522, 18328, 36877, 12289, 60887, 50885, 25709, 34151, 5034, 23920, 2674, 4887, 54546, 34386, 18957, 30540, 57554, 59598, 63440, 46268, 4927, 39813, 39188, 58086, 24464, 5273, 809, 30031, 41544, 47965, 52672, 27065, 52466, 25327, 59012, 58847, 48190, 18387, 62172, 49973, 52088, 17995, 17374, 25987, 5720, 13992, 26377, 58127, 4264, 46389, 53960, 63817, 52012, 36361, 33347, 34617, 56699, 793, 61007, 34261, 20379, 37511, 45817, 18972, 45777, 65074, 48808, 50869, 63829, 6056, 48272, 931, 61703, 58528, 60514, 35472, 61336, 25023, 13728, 21145, 56424, 11308, 55960, 5966, 62891, 22499, 58774, 25114, 47424, 17431, 37282, 63825, 8532, 7697, 43372, 26952, 41304, 7655, 3994, 14492, 17558, 2487, 34352, 10707, 2086, 46816, 61548, 48153, 13642, 62324, 53412, 4934, 2475, 39755, 27420, 63294, 27905, 59578, 12241, 26441, 57782, 18777, 63731, 21148, 1981, 5518, 11783, 54638, 61962, 61836, 26708, 36101, 5105, 4678, 18586, 64753, 38340, 53761, 58276, 51264, 38624, 65069, 2476, 6252, 22357, 63944, 62633, 45497, 9462, 22074, 59548, 34070, 13460, 30439, 1817, 9453, 19367, 65272, 56516, 20772, 50286, 17509, 41856, 11943, 15603, 59780, 61365, 44412, 14369, 42712, 36771, 39189, 33348, 31983, 20126, 59464, 49773, 47140, 8361, 56212, 24069, 8902, 26996, 46211, 44010, 27762, 23794, 57654, 19199, 36098, 61635, 1607, 9578, 25455, 14188, 59291, 55999, 59880, 29849, 47268, 51022, 17719, 61006, 55125, 51456, 24886, 62343, 22553, 25133, 51165, 65066, 57254, 38403, 33898, 63079, 47229, 14197, 15711, 14108, 30330, 530, 24370, 45653, 61457, 25673, 3989, 62650, 54607, 32857, 31003, 55000, 47698, 48482, 44505, 38912, 33379, 29651, 59125, 51685, 64801, 22384, 15582, 16833, 8324, 53454, 57252, 34808, 12362, 64436, 29602, 6029, 7311, 13654, 3858, 23670, 28842, 736, 22149, 38679, 58893, 57276, 10447, 48458, 51389, 59341, 43120, 10255, 41605, 6211, 17306, 33742, 61886, 32815, 62242, 12446, 32336, 4809, 19842, 39796, 4187, 50343, 6796, 51568, 60621, 55032, 2051, 52524, 62014, 5091, 16146, 34507, 43857, 53606, 54923, 29293, 46554, 2123, 28734, 40911, 36782, 26911, 23341, 37554, 61684, 18671, 58809, 14848, 12538, 65020, 7588, 12637, 57979, 24759, 20102, 45113, 28115, 11690, 58922, 29811, 61629, 56655, 18126, 62288, 39547, 29129, 30155, 37098, 43588, 31140, 46492, 21621, 59045, 33579, 64423, 46520, 5681, 48152, 37829, 11819, 50096, 60862, 53026, 55451, 50906, 29560, 47052, 36850, 22502, 455, 48680, 5982, 16093, 9276, 2181, 48580, 36331, 47478, 40833, 45829, 4103, 50081, 12691, 20305, 9874, 12065, 38776, 2405, 5436, 17686, 1845, 46528, 29847, 6497, 55441, 35485, 38801, 19867, 46673, 58835, 28312, 14687, 13342, 50489, 19433, 60331, 35716, 22735, 50082, 7996, 64640, 48988, 52734, 54008, 29939, 52287, 33543, 49246, 21657, 6225, 46193, 45618, 25840, 24432, 14029, 37804, 8072, 30320, 54477, 52837, 41562, 63860, 2352, 39433, 2856, 25872, 54065, 50933, 20389, 26300, 31022, 50936, 2577, 36882, 41756, 22339, 10947, 44016, 34452, 18344, 13845, 21455, 12176, 24119, 43086, 4583, 35721, 30980, 21630, 17141, 40386, 207, 52838, 39603, 40120, 8143, 15208, 56985, 14451, 30603, 40842, 42556, 15985, 41214, 3013, 32276, 24481, 7321, 50802, 40086, 56839, 4470, 5956, 31709, 16002, 28198, 12438, 13619, 41592, 20200, 5877, 22984, 51115, 63096, 58214, 54396, 1616, 2899, 64287, 7050, 21270, 58148, 14669, 2827, 22641, 32600, 52699, 58984, 22662, 26491, 31894, 41320, 49095, 52742, 47472, 36671, 49770, 31060, 46611, 32634, 56816, 49427, 17464, 48211, 27319, 974, 46991, 35525, 58587, 29592, 48571, 33182, 39229, 57266, 14629, 9164, 40740, 51599, 65512, 54110, 25806, 10984, 4704, 57203, 46507, 15557, 4158, 39771, 11334, 52396, 4454, 33593, 9880, 15774, 52888, 52427, 64590, 50514, 49006, 37714, 18753, 36696, 15747, 14576, 30314, 30081, 40935, 2134, 22659, 4126, 43992, 28492, 65496, 11442, 9049, 30395, 16947, 15355, 33678, 21085, 17505, 22177, 13989, 48037, 40255, 64993, 12839, 35228, 36544, 28352, 60445, 60419, 62399, 42042, 60785, 25795, 13942, 59495, 42005, 10082, 26969, 1494, 35950, 25475, 5569, 47821, 50845, 20858, 54276, 10615, 38184, 27595, 5543, 14960, 43699, 17171, 21306, 39707, 25161, 42828, 60644, 34478, 51105, 43902, 56890, 15684, 38845, 53576, 43987, 2413, 45634, 26147, 37326, 59278, 2643, 28549, 11271, 2067, 13296, 46848, 24446, 2498, 16664, 4409, 49783, 28111, 5340, 4292, 63950, 16463, 8506, 7313, 48875, 20764, 15645, 31696, 62011, 26674, 42010, 11143, 55986, 11090, 51006, 7359, 36662, 14347, 61224, 39002, 11237, 54338, 15023, 61158, 626, 20192, 41940, 29649, 10597, 56686, 19179, 38670, 5908, 34663, 51001, 36603, 21424, 14422, 34611, 61186, 52437, 16836, 62496, 62590, 5790, 42409, 6025, 20051, 57594, 4338, 26686, 41300, 13766, 45735, 10354, 42438, 61948, 32366, 57321, 24144, 9299, 43982, 20467, 37489, 42966, 50074, 6653, 13263, 31291, 5520, 16849, 46250, 35338, 4431, 39395]}	1411	\\x00000000000000000000000000000000
\\xfa1e11ec1249c037	2025-12-17 10:14:20.570016+00	2025-12-19 19:43:47.133117+00	\\xdb1dba81aeadb7c2baad6cd0acea456a	\\x00000000000000000000000000000000	{"0000000000000000": [14991, 7579, 52640, 4391, 63020, 26478, 48926, 35747, 31630, 26340, 16064, 49871, 28600, 8017, 48122, 25427, 44075, 5936, 9982, 39245, 24841, 50517, 64668, 29402, 50503, 43683, 29105, 36175, 16894, 29493, 18668, 48069, 34414, 61557, 6824, 4577, 1468, 14847, 37769, 28188, 62068, 51854, 37784, 43462, 3891, 3824, 46841, 10282, 39232, 12261, 50137, 44757, 50816, 41081, 42497, 18709, 17485, 17945, 51240, 56585, 9675, 63508, 7499, 14531, 27411, 47725, 30526, 49948, 5542, 61219, 49050, 4722, 5880, 46678, 9796, 26219, 28324, 48679, 43725, 54723, 27112, 53043, 53632, 52468, 31436, 25201, 46231, 60674, 18856, 29190, 58019, 50097, 41164, 667, 51217, 63590, 55826, 8342, 20158, 37046, 38801, 41575, 39084, 35539, 57399, 60322, 42406, 4883, 6483, 38928, 31830, 44058, 9529, 25920, 30427, 5083, 35211, 7468, 30018, 46748, 38652, 54463, 263, 54736, 2050, 25595, 55870, 29664, 10213, 24730, 5123, 60418, 54396, 3678, 32056, 30545, 41620, 51982, 61941, 52205, 24529, 45286, 6656, 21437, 65366, 46525, 7604, 27193, 40570, 51908, 5803, 22981, 3922, 54842, 9592, 6270, 63910, 6823, 62628, 59357, 50809, 57513, 50176, 25781, 31231, 65304, 25854, 6001, 47259, 33553, 39311, 62413, 32861, 38294, 45671, 39372, 32751, 46350, 28946, 14515, 37952, 20962, 60915, 58672, 39740, 744, 23443, 55743, 46844, 43641, 30805, 6640, 12363, 31810, 33272, 30426, 42022, 43297, 32767, 44051, 56427, 35695, 31395, 2350, 27021, 58520, 48269, 54471, 65111, 35838, 4545, 9399, 23532, 33807, 45744, 6372, 43879, 7612, 50597, 6535, 198, 53185, 58319, 11543, 30148, 42882, 21449, 40934, 52745, 56159, 59274, 60268, 43723, 29611, 46690, 24773, 13503, 39752, 43230, 16089, 62128, 14008, 60165, 63338, 4193, 24626, 38896, 28675, 44443, 1180, 866, 38247, 31105, 62692, 11267, 46452, 42641, 26198, 25435, 37182, 33913, 64035, 62670, 12702, 52433, 26438, 44907, 462, 58696, 22058, 32127, 18179, 13981, 23250, 61670, 17644, 303, 63842, 29441, 9550, 10208, 30753, 15900, 64301, 64619, 9710, 36629, 34548, 51327, 32463, 50754, 43544, 52650, 65055, 17738, 22599, 13610, 5695, 1544, 105, 39442, 9390, 6512, 32631, 44012, 53681, 22522, 17596, 5805, 41864, 17431, 14796, 45011, 43125, 55006, 4692, 16955, 36660, 30068, 50174, 51236, 31757, 31113, 25852, 45714, 38025, 43088, 4172, 24080, 3732, 19536, 6383, 40990, 42926, 22231, 38573, 54012, 46078, 37234, 49757, 2927, 31008, 29525, 7211, 61193, 40710, 32213, 30336, 44194, 18335, 17723, 62028, 52476, 56514, 15051, 35814, 45102, 58853, 3794, 18358, 19252, 65283, 5378, 5003, 30163, 63402, 9328, 55283, 10426, 17043, 11732, 36388, 35908, 48180, 63757, 1343, 30285, 34318, 2247, 44795, 48055, 49044, 40151, 61036, 25771, 6061, 44249, 33529, 2889, 39907, 54700, 45966, 49308, 38695, 37153, 27642, 13004, 32986, 475, 48613, 64783, 63099, 58719, 52084, 43995, 22626, 23895, 22307, 27512, 44780, 58864, 42801, 26640, 40318, 12435, 33101, 867, 28320, 24657, 23686, 49969, 47937, 43037, 63606, 6672, 43689, 6208, 8098, 17813, 28776, 6155, 45246, 21068, 33902, 44280, 37391, 27904, 53696, 8578, 45428, 13678, 6134, 15143, 35701, 28329, 28843, 24230, 50814, 32508, 29022, 24424, 1476, 9040, 59348, 15820, 59579, 40154, 46981, 24107, 1406, 57188, 1251, 13547, 55702, 45809, 29723, 50768, 47687, 62454, 22906, 56738, 56301, 3373, 2294, 3304, 52489, 17972, 21008, 34802, 5726, 61736, 44773, 54965, 28273, 34646, 33828, 9831, 9709, 43296, 46082, 26862, 35473, 51655, 41249, 3802, 15591, 28033, 13244, 39334, 38438, 56973, 20236, 63284, 46777, 24482, 31018, 17294, 4743, 20716, 16735, 16884, 46991, 56827, 27301, 49547, 22212, 12664, 51406, 36330, 56857, 20950, 30572, 6428, 35995, 58737, 30777, 16335, 26050, 27274, 46558, 37670, 39001, 37243, 8939, 42632, 14623, 13351, 4633, 36896, 16065, 32894, 57338, 4768, 29194, 35943, 21531, 6250, 54061, 29255, 3806, 43784, 37822, 9006, 58810, 55456, 56367, 40917, 35287, 50795, 37014, 6097, 60371, 7752, 3704, 17496, 54451, 15199, 9395, 44261, 27788, 22121, 19886, 47261, 12623, 44687, 18122, 29204, 50387, 20471, 30496, 4785, 19502, 13374, 26804, 2166, 20512, 25168, 57413, 23957, 57950, 14095, 28028, 41461, 22345, 59119, 20818, 32805, 34374, 2359, 1359, 48611, 63497, 33339, 61212, 23899, 53935, 28233, 59491, 50573, 2498, 61907, 33086, 5187, 65225, 3405, 14343, 10854, 3510, 7003, 44809, 6232, 29375, 32787, 29272, 20082, 5326, 43220, 44089, 11141, 55086, 32688, 26641, 28030, 5469, 57128, 17491, 4596, 5406, 5488, 27376, 55127, 55661, 45191, 6588, 58094, 47620, 24746, 22011, 43918, 7010, 38621, 18158, 1493, 61262, 56354, 9890, 23088, 56633, 39176, 25895, 22608, 43583, 11670, 65298, 20988, 36421, 24040, 16174, 37300, 25912, 1033, 22881, 54617, 34308, 6586, 29559, 61933, 23834, 44413, 18768, 11673, 27704, 952, 65320, 49337, 29582, 55741, 57210, 10492, 55360, 7413, 16494, 61127, 47453, 12821, 8642, 23935, 8112, 36771, 26755, 22116, 334, 65364, 40251, 60666, 42130, 50974, 15421, 13287, 55904, 24775, 37621, 32993, 53336, 41498, 55541, 44314, 5823, 14591, 63953, 47813, 49095, 24019, 20119, 29473, 12321, 28131, 44028, 41363, 2828, 17645, 65327, 60129, 50405, 15203, 38070, 52802, 59975, 34953, 47932, 51579, 44927, 65293, 36844, 13150, 59120, 19433, 30850, 27610, 37802, 21200, 20121, 40648, 33877, 44501, 49653, 11375, 25679, 33760, 4115, 26147, 16906, 38731, 51814, 53131, 21546, 18807, 22115, 64058, 42612, 21353, 36303, 20413, 48585, 5068, 20027, 54385, 64010, 12753, 13372, 13474, 50170, 36681, 58662, 10839, 1754, 9807, 8990, 15106, 43535, 20396, 32552, 21494, 55417, 3135, 26787, 11676, 13068, 34233, 25094, 40930, 21122, 54357, 51117, 31426, 23127, 19895, 57194, 25080, 54648, 28498, 41767, 30692, 51934, 51565, 14628, 59365, 23632, 5393, 13432, 46916, 51273, 32820, 23095, 46241, 44826, 52929, 59435, 23205, 55527, 7324, 59385, 21411, 6192, 18642, 47540, 51941, 53079, 26245, 12595, 39066, 33685, 8649, 29539, 49313, 4366, 5969, 50577, 47593, 17749, 15946, 51464, 57987, 52524, 35305, 64454, 20176, 20523, 4438, 20468, 59465, 60877, 59248, 25585, 6907, 60934, 28336, 54161, 37261, 37903, 45436, 27782, 10244, 41753, 55972, 31815, 61940, 17802, 53170, 46574, 16754, 20938, 4374, 16930, 60406, 54111, 58702, 61083, 50546, 41360, 59391, 35776, 12993, 65069, 39382, 38463, 50790, 64385, 12865, 20407, 59034, 295, 45938, 9022, 36409, 41014, 45908, 38034, 26702, 20104, 58871, 41894, 43549, 56497, 54791, 44433, 44338, 22796, 24859, 47181, 1465, 39356, 58970, 63897, 5438, 33518, 3601, 45678, 42220, 14647, 47292, 44625, 61688, 57690, 53972, 3055, 29411, 22662, 41070, 53467, 11480, 54427, 52972, 26827, 28575, 18719, 36795, 59872, 19922, 36692, 36477, 51194, 29474, 24998, 1694, 21332, 46521, 18477, 36641, 47332, 13673, 39309, 12776, 53861, 53260, 63146, 47373, 54172, 58740, 10971, 51229, 51703, 26485, 3088, 27046, 9538, 47470, 51957, 49380, 50834, 14209, 11910, 4671, 44764, 59770, 57544, 29535, 62734, 10382, 47571, 23253, 28015, 15913, 60964, 45952, 32924, 34307, 45124, 38635, 36525, 53034, 12282, 57123, 59016, 44566, 26411, 6725, 50213, 59809, 6738, 53168, 20839, 20235, 24377, 13975, 31184, 52099, 31775, 65378, 17311, 63674, 36561, 6447, 7596, 15625, 45386, 59413, 60947, 32932, 35074, 11301, 8808, 10451, 32920, 20797, 45948, 22847, 8111, 40924, 2156, 14613, 30306, 27971, 27660, 51076, 24665, 18115, 4289, 1571, 1811, 43358, 37006, 52379, 14284, 63416, 10572, 53304, 61048, 61628, 61923, 62114, 18294, 49782, 206, 50412, 58449, 24150, 58353, 46502, 34192, 17994, 5191, 36417, 52987, 33561, 27054, 53062, 45719, 27762, 50160, 16820, 53880, 62558, 18394, 9793, 7764, 54444, 37881, 4739, 25003, 6977, 13267, 65251, 23050, 35477, 40249, 16939, 33160, 19707, 23006, 21161, 6467, 57406, 64991, 40107, 21679, 39606, 13057, 30288, 41619, 45216, 26962, 59821, 24395, 40160, 46370, 5249, 54329, 64118, 61355, 4177, 729, 17013, 37920, 37141, 60109, 47921, 52729, 4204, 23676, 48481, 52754, 8738, 52995, 54174, 56578, 65114, 18268, 31062, 46971, 53051, 39674, 47896, 6381, 62193, 39572, 59705, 35431, 25605, 58634, 35446, 23072, 57609, 65316, 52653, 62791, 52633, 57930, 34810, 24692, 21830, 51205, 65332, 30743, 50316, 44203, 36655, 52146, 13428, 35919, 12124, 52759, 26842, 25538, 3069, 58546, 24723, 22686, 22266, 11851, 46508, 8519, 5434, 23907, 20304, 54112, 60384, 61777, 17572, 31913, 44371, 20164, 8291, 20002, 54739, 24085, 55652, 45209, 58429, 7974, 63574, 39767, 6954, 11829, 63596, 64972, 24602, 43987, 45596, 60853, 55288, 15771, 60812, 6289, 25417, 26569, 29346, 3507, 60234, 10643, 8629, 50844, 7862, 45082, 56105, 21765, 29542, 63593, 63307, 26204, 35282, 28410, 31662, 15645, 3460, 57002, 2413, 26170, 51999, 65525, 45970, 2922, 289, 44014, 41305, 49360, 44890, 42790, 52879, 35694, 31266, 9498, 33132, 19840, 49170, 24226, 56709, 12763, 19206, 24475, 62139, 31471, 63129, 18400, 35983, 20084, 23397, 40208, 65310, 35570, 15392, 1977, 28764, 4505, 4338, 7462, 30319, 31194, 61945, 28180, 41701, 51876, 11149, 13349, 10989, 55021, 56317, 5415, 28756, 11985, 27323, 22163, 23510, 64209, 56119, 31051, 25069, 806]}	1298	\\x00000000000000000000000000000000
\\x44cff40d883a74cc	2025-12-17 10:15:09.131494+00	2025-12-19 19:43:50.157991+00	\\xe7bcab831b19e7e15b8334c9a9503e2d	\\x00000000000000000000000000000000	{"0000000000000000": [56749, 19141, 15893, 19448, 12031, 7916, 63974, 53571, 50291, 46667, 18068, 33788, 25851, 54356, 49090, 32736, 22358, 43519, 4011, 41037, 56200, 5177, 26874, 47251, 53781, 54367, 21550, 47574, 33680, 46376, 60697, 20883, 12166, 53274, 2329, 50304, 24164, 35478, 9989, 63658, 59253, 9093, 30656, 18799, 63137, 56205, 12851, 17609, 57885, 31510, 49568, 41451, 53036, 39755, 30222, 48711, 35120, 9403, 4712, 24370, 2244, 14751, 9805, 46449, 7544, 59940, 1633, 35999, 36732, 53971, 3780, 56881, 20315, 55277, 35278, 32728, 48951, 17491, 17047, 19455, 41222, 21494, 52679, 56243, 16937, 31571, 62573, 45770, 16807, 23713, 14254, 51907, 32862, 12177, 33735, 4680, 39040, 6623, 25016, 29288, 41607, 15026, 12410, 9227, 8752, 10432, 36914, 59909, 16697, 21744, 23373, 42396, 58901, 18928, 53045, 23561, 53354, 38026, 37235, 21730, 13959, 24346, 22589, 18256, 25435, 14606, 51148, 65206, 16992, 7984, 45326, 60348, 39274, 54200, 57314, 3349, 17313, 38779, 27925, 16251, 23807, 12898, 18751, 8297, 14298, 21940, 51647, 15724, 544, 789, 51086, 61067, 16633, 7140, 9847, 29308, 53401, 29786, 36995, 41898, 3691, 19766, 47897, 37786, 42879, 26346, 45132, 45178, 24364, 20498, 29771, 61757, 11637, 27786, 26912, 21203, 47665, 7414, 45119, 36175, 16049, 57170, 28236, 34003, 48023, 34407, 42640, 37938, 10774, 7118, 1108, 45582, 271, 2710, 21784, 4230, 55713, 32239, 54600, 58508, 8068, 12381, 50030, 33380, 23168, 26884, 59899, 14319, 2632, 36472, 34330, 64899, 37771, 18759, 7527, 7608, 22881, 26471, 11610, 39808, 44882, 60712, 45806, 36236, 7592, 51556, 63379, 42175, 12646, 28384, 62747, 7421, 35490, 10518, 14181, 26373, 10344, 2065, 53545, 26350, 3201, 64404, 36654, 10262, 10377, 61998, 60610, 63905, 43628, 4066, 25790, 23873, 60650, 50764, 13915, 34524, 25745, 63982, 10548, 45615, 4261, 61009, 24205, 27768, 56033, 59834, 62787, 55457, 20984, 1928, 5962, 40005, 36434, 62666, 57509, 34373, 8760, 58902, 29295, 5365, 13186, 29545, 50876, 42868, 25775, 26496, 62602, 52905, 51168, 24155, 53709, 4501, 6396, 8593, 18010, 40781, 1905, 28401, 62931, 25141, 50804, 17612, 9946, 57816, 11567, 58931, 42800, 34655, 17045, 20750, 46731, 18691, 28856, 23913, 56654, 41031, 44867, 8510, 12093, 57643, 20370, 15346, 59770, 407, 34805, 25169, 46191, 9369, 23180, 46611, 35383, 1265, 53796, 34895, 16907, 47992, 14143, 26840, 17657, 41443, 19255, 26528, 48460, 54994, 17334, 56977, 46548, 17772, 35376, 35689, 23428, 45642, 25653, 448, 4147, 17778, 41132, 34126, 39569, 19872, 41777, 58428, 61822, 51675, 283, 21500, 59851, 41509, 6944, 53962, 16070, 37093, 15977, 52225, 4049, 39541, 32891, 54181, 64175, 65159, 44316, 23149, 10543, 30246, 10668, 40556, 13362, 444, 2913, 48444, 48276, 55487, 16546, 47390, 19592, 46369, 6572, 19724, 33849, 1801, 44909, 42920, 36740, 24343, 18408, 4220, 5491, 50107, 29033, 39081, 14713, 40192, 5965, 35315, 17030, 127, 61906, 29364, 32652, 12566, 33873, 9686, 15205, 40989, 21759, 34289, 42441, 26551, 32158, 27440, 54814, 24682, 16829, 54388, 41993, 19908, 51117, 19801, 44357, 30242, 30547, 18046, 52758, 52022, 7906, 17214, 58394, 63400, 34513, 33066, 41963, 2693, 1064, 1966, 37302, 25930, 64638, 20298, 28361, 34442, 7824, 48588, 31688, 1867, 42521, 16522, 42059, 62135, 56929, 17932, 53034, 7701, 35597, 49655, 44603, 45522, 58840, 16476, 29710, 57435, 22702, 4810, 13315, 33377, 5723, 33831, 52165, 27793, 56124, 45087, 33527, 37679, 47964, 42329, 56044, 59750, 38902, 43841, 27777, 54717, 42397, 23348, 30120, 12917, 24014, 60222, 57367, 56089, 59873, 12114, 5764, 61477, 13957, 36143, 24962, 12599, 36783, 47524, 21769, 5476, 46721, 51899, 45322, 56673, 42122, 60069, 37723, 32954, 11543, 34749, 20101, 50201, 8665, 53018, 63471, 44910, 31022, 36141, 12278, 39643, 5947, 145, 25282, 42999, 63816, 3531, 13971, 38137, 22472, 16643, 3828, 60374, 9775, 2570, 57275, 10099, 5091, 51416, 34989, 20499, 40767, 31716, 54763, 31937, 734, 64150, 10072, 14706, 59129, 24071, 5524, 4911, 46348, 2512, 50005, 34522, 55217, 2362, 6284, 64072, 49920, 7894, 56306, 45917, 48194, 56363, 57471, 40580, 59345, 16493, 22703, 8643, 38808, 5772, 13587, 36381, 10638, 64534, 39506, 65232, 8432, 11813, 17036, 7351, 10939, 57681, 21801, 20210, 13075, 42631, 2852, 12641, 42171, 19642, 23062, 14989, 45890, 30034, 56360, 64121, 54638, 37140, 36671, 16164, 22680, 25015, 26626, 4710, 55305, 16376, 22210, 4631, 7282, 13714, 40094, 10310, 1886, 60827, 26119, 29653, 7761, 58207, 50372, 44557, 36930, 27340, 35857, 24626, 48317, 56822, 52665, 43255, 24902, 53468, 27996, 22784, 25011, 55952, 59447, 1589, 58407, 23658, 62323, 31287, 33636, 28836, 57068, 58773, 14682, 32333, 55367, 34809, 11295, 58072, 26312, 13638, 40047, 53583, 20361, 33049, 18603, 26481, 65134, 24114, 20784, 13711, 16591, 48220, 14073, 59596, 32816, 38721, 41428, 24862, 1895, 5570, 41383, 62756, 65095, 41722, 16516, 18670, 18680, 7747, 56162, 24945, 59979, 64991, 27495, 47772, 20524, 56581, 7039, 11612, 16178, 48848, 2075, 54533, 59610, 64841, 59608, 52383, 36618, 56273, 62413, 36480, 44024, 54812, 61616, 55500, 63388, 46186, 32406, 30275, 25799, 26306, 49426, 33290, 3227, 23114, 65267, 25556, 35858, 19314, 35103, 59078, 44638, 49436, 60418, 41864, 60691, 17249, 14076, 43815, 18182, 59226, 31573, 10567, 3709, 37754, 20880, 49099, 9623, 11759, 50984, 39180, 31592, 20136, 21039, 42167, 7750, 57075, 4987, 2965, 12420, 23859, 31403, 22832, 17709, 44636, 39013, 58620, 59835, 35033, 48239, 8898, 63491, 4831, 18221, 58058, 53456, 22835, 46145, 1111, 17331, 57587, 19188, 33851, 39243, 11113, 51393, 60597, 44669, 64809, 57433, 40343, 25852, 7664, 2646, 26364, 26531, 52053, 36405, 11500, 47443, 24800, 62504, 33226, 27889, 41609, 8912, 33720, 59066, 25736, 44292, 23034, 58371, 41240, 44041, 10790, 22321, 7021, 6760, 52479, 32930, 12047, 60976, 56739, 64255, 8018, 9916, 11531, 65456, 44245, 60420, 24609, 44781, 57397, 21447, 21466, 8567, 19161, 29865, 40787, 60926, 61803, 15136, 61548, 2057, 14839, 40867, 29947, 15594, 58116, 41684, 22208, 63862, 31371, 18984, 16246, 40184, 25402, 60731, 6795, 57576, 48480, 9363, 42267, 39749, 64816, 12992, 27542, 23784, 62701, 2168, 40894, 22512, 52904, 26765, 9327, 24204, 7347, 37417, 52735, 64830, 17263, 21679, 6151, 48546, 25854, 25302, 50779, 10542, 35848, 64161, 6185, 31905, 6768, 47800, 118, 55253, 41540, 39115, 26646, 9780, 39469, 26162, 28966, 28734, 37501, 57073, 34179, 53588, 51049, 46940, 52413, 18687, 39830, 42666, 57817, 55606, 51342, 48533, 44839, 47726, 52270, 36510, 28918, 18774, 39073, 39144, 29967, 38336, 6296, 5768, 18389, 28716, 3146, 55155, 44145, 52215, 17727, 50318, 19620, 36684, 61891, 32133, 13008, 42149, 18618, 26685, 4908, 44126, 49954, 31504, 52773, 12069, 54482, 21906, 16072, 49321, 858, 7743, 11784, 21287, 41923, 45096, 55458, 51896, 53890, 31090, 35068, 1847, 7139, 5834, 43694, 31407, 2750, 37318, 28727, 22521, 33308, 48572, 8354, 55448, 13310, 48463, 51457, 57177, 11750, 32028, 35179, 39587, 21463, 50294, 10621, 55478, 60367, 1852, 57558, 47719, 25762, 3776, 58483, 55649, 12312, 48400, 46866, 31292, 33405, 57634, 24338, 16110, 10117, 48609, 50347, 65091, 1209, 34130, 20635, 14539, 22995, 33837, 10596, 54324, 7407, 41336, 60230, 11503, 24146, 30690, 49029, 54700, 28023, 50336, 48233, 30857, 16270, 15757, 60177, 4677, 9556, 17267, 56027, 42914, 35149, 47202, 50205, 16352, 27630, 39745, 19693, 10598, 49651, 2435, 29764, 9979, 37486, 53652, 25544, 7489, 29132, 27301, 6130, 54270, 58178, 35166, 13974, 21875, 58400, 30520, 61260, 51800, 1957, 56773, 25032, 54456, 57150, 35582, 35396, 16865, 964, 1635, 4366, 24382, 44031, 24152, 43857, 18454, 45941, 36352, 14774, 45879, 57839, 28651, 52834, 49637, 65144, 29887, 26986, 32806, 7982, 33190, 58856, 34031, 48102, 34694, 49818, 60955, 19202, 8519, 4259, 15320, 4474, 5102, 59584, 4431, 46443, 44128, 7449, 49092, 898, 62988, 38145, 4411, 1544, 50512, 14541, 50530, 61814, 39925, 2126, 33919, 16256, 9994, 52394, 18888, 2868, 31463, 49402, 49852, 10443, 25238, 50694, 10630, 64321, 10401, 52245, 22184, 29809, 11436, 42125, 19175, 63750, 24915, 1602, 52961, 7497, 21, 2376, 6913, 8200, 2237, 19438, 29659, 48164, 22966, 22705, 22657, 3231, 28592, 38440, 47386, 53039, 25885, 6197, 30679, 6850, 18642, 6570, 62625, 36919, 9263, 42030, 10191, 35454, 30768, 6504, 16831, 22630, 50635, 47190, 35184, 7704, 51642, 38362, 34826, 39597, 8846, 16503, 9198, 38192, 25637, 44730, 44961, 44716, 22683, 190, 37104, 39305, 19585, 61219, 38909, 26336, 48313, 10568, 19600, 2293, 38565, 19851, 39625, 12922, 20097, 61659, 9310, 37767, 43689, 7768, 5777, 49744, 30070, 40937, 27770, 55590, 58728, 65376, 62280, 29148, 50184, 38894, 58093, 36083, 16298, 45785, 42680, 26250, 52927, 7693, 20878, 21285, 26910, 32432, 20770, 59611, 55006, 57487, 38683, 48837, 48426, 34703, 37428, 54508, 23543, 46406, 49509, 48343, 3092, 19079, 5649, 60689, 44762, 65057, 54858, 17532, 46655, 51806, 59986, 18346, 10282, 61635, 10378, 18631, 28610, 26682, 60102, 57995, 23520, 15571, 60027, 20478, 35995, 56734, 58921, 10840, 10474, 49654, 48863, 7087, 33702, 28394, 17012, 13696, 31246, 549, 12919, 42045, 39068, 21131, 15763, 13353, 12454, 26445, 35014, 23400, 50642, 2278, 6687, 63544, 33560, 3136, 45528, 16533, 58316, 38324, 33681, 7604, 13777, 56558, 504, 16196, 18363, 5452, 37515, 12008, 37378, 53874, 18706, 15735, 32680, 25772, 34908, 17683, 62538, 10718, 27748, 46986, 21811, 62585, 540, 16176, 13261, 5029, 26429, 54458, 18434, 45140, 30829, 16118, 58936, 56126, 60512, 40572, 58290, 58579, 51814, 28515, 40978, 63230, 53823, 22684, 54662, 5812, 5041, 8411, 38289, 13375, 48914, 58825, 14814, 1160, 16290, 46102, 46364, 17248, 61868, 60865, 50793, 50241, 61308, 9384, 59702, 61116, 4897, 23187, 33935, 63835, 25829, 43247, 61324, 40879, 61636, 8176, 53925, 58832, 41199, 27342, 47573, 2123, 12612, 31602, 14631, 18739, 6673, 37394, 16750, 28302, 6344, 19268, 51227, 59629, 22234, 50905, 55134, 50893, 14007, 54609, 41592, 30823, 24435, 32203, 58581, 32227, 1255, 29070, 23108, 13286, 2063, 31626, 33386, 778, 27827, 42621, 20557, 42200, 46533, 40568, 62377, 18616, 27437, 39418, 34570, 56593, 52729, 40480, 57387, 49467, 59514, 38458, 21911, 29575, 60849, 19165, 62434, 24265, 21858, 49209, 50986, 6110, 17879, 11922, 11296, 10228, 22069, 29635, 42393, 54196, 43142, 63031, 43400, 765, 26317, 65030, 41196, 38486, 33846, 60848, 44083, 24984, 57641, 44825, 10211, 11003, 24248, 19987, 5845, 12119, 65490, 59487, 48440, 39039, 23902, 48394, 24957, 47962, 29566, 3312, 19967, 22493, 53136, 29108, 54359, 26143, 6900, 6658, 24386, 30900, 31369, 45835, 39183, 15344, 12292, 55572, 22709, 56140, 3478, 5548, 42620, 36817, 59867, 45372, 34038, 3515, 41404, 60548, 45640, 27826, 59170, 25086, 45226, 61664, 48595, 22525, 31915, 2569, 46697, 33593, 52451, 17969, 3225, 61624, 43743, 18818, 47754, 46268, 3541, 37178, 5282, 60874, 65041, 10153, 43520, 57255, 61284, 41436, 28099, 5101, 29799, 61563, 11553, 36579, 21385, 53648, 45166, 37219, 20647, 40013, 14711, 40862, 37273, 54361, 55258, 40171, 8185, 16712, 17595, 20208, 3878, 56448, 34107, 35873, 3942, 51609, 64652, 50794, 3370, 16911, 6421, 46838, 21789, 47904, 9591, 25791, 43291, 14224, 41478, 41067, 16875, 24565, 49904, 44402, 34135, 29250, 15036, 49383, 8787, 63871, 44183, 8993, 13250, 46656, 39682, 48885, 58388, 1894, 10359, 4246, 13565, 59571, 58052, 8099, 23241, 31414, 16458, 2280, 8082, 47359, 44000, 563, 6338, 2975, 4693, 45442, 42765, 580, 5129, 6327, 51321, 61120, 21206, 3084, 449, 38293, 44750, 30344, 30899, 53122, 9564, 1624, 29413, 23217, 40426, 43855, 63302, 34744, 4790, 43773, 61877, 25800, 4877, 58624, 61325, 55447, 64983, 9992, 9764, 25280, 20711, 17518, 12878, 44424, 11760, 23640, 9040, 65528, 2002, 9121, 3102, 25018, 61480, 59978, 9074, 2115, 44051, 61717, 38792, 62342, 35249, 37700, 45685, 33832, 37090, 56952, 60776, 52026, 25569, 32477, 62477, 4405, 56962, 22779, 19863, 2167, 24196, 47670, 1936, 36468, 47991, 27803, 8627, 13161, 58639, 57289, 18661, 53079, 15107, 2523, 35092, 27962, 57131, 36921, 38589, 9831, 50697, 11635, 5180, 57288, 34339, 20540, 60605, 36015, 58126, 41869, 48256, 37575, 59375, 36650, 45944, 34855, 18296, 37933, 29142, 55181, 44341, 6544, 49023, 49816, 41033, 64135, 57169, 21420, 47348, 11814, 45464, 30636, 42843, 1162, 58301, 46076, 65088, 49849, 58729, 12321, 18001, 25354, 27157, 41171, 8275, 23659, 502, 45957, 32331, 21585, 58468, 32624, 44569, 55642, 41841, 14449, 58740, 64204, 53333, 54622, 42994, 28402, 13594, 27298, 27883, 51065, 34214, 65525, 15957, 12060, 58777, 8976, 13798, 3557, 25094, 26052, 49138, 49387, 31101, 41697, 6984, 27353, 61398, 10657, 54530, 43226, 28887, 21370, 19237, 11486, 61859, 8972, 12449, 21446, 8259, 10699, 2696, 34444, 295, 8170, 12262, 52732, 27576, 32855, 55048, 30788, 63932, 44663, 43428, 1542, 30385, 8083, 31786, 1820, 30848, 39267, 10655, 15490, 36099, 3132, 18608, 38296, 33579, 28858, 16874, 16054, 54675, 29141, 35243, 57757, 33068, 44683, 43269, 48341, 34028, 6916, 63719, 61885, 56253, 47000, 31368, 15356, 19333, 641, 27527, 32571, 16916, 28599, 8337, 20996, 35212, 2302, 62117, 61383, 43429, 14866, 18167, 27004, 45694, 16704, 44980, 37854, 28552, 12620, 4578, 38247, 30452, 43492, 59036, 51300, 3983, 15322, 39083, 18960, 56056, 42807, 29145, 20390, 50660, 14264, 54254, 53629, 50430, 279, 35265, 12063, 8229, 45495, 58671, 32789, 7111, 22458, 5027, 17499, 57513, 2902, 967, 12901, 45317, 52424, 5686, 14287, 5626, 6990, 15511, 14897, 10013, 65369, 6023, 41925, 53551, 45754, 26058, 33006, 42164, 22985, 63988, 16942, 13407, 32084, 58010, 51966, 62163, 56370, 50171, 60076, 33230, 48046, 311, 27354, 59828, 16604, 53929, 42838, 55430, 1385, 59523, 64874, 50247, 10538, 43443, 3755, 40645, 47406, 42148, 6236, 38707, 33247, 45433, 26575, 15743, 46139, 40299, 59922, 3615, 55599, 44214, 29162, 412, 56937, 64782, 52889, 14504, 18150, 44535, 6543, 27805, 28486, 28176, 26641, 14967, 5875, 38363, 31587, 47959, 53406, 33465, 41647, 25831, 51606, 42906, 62797, 16857, 26165, 32896, 52853, 63524, 34841, 14221, 30414, 32627, 45392, 12575, 17714, 35835, 64055, 3330, 39786, 46768, 43896, 8992, 9249, 21612, 39250, 5468, 61033, 14668, 38606, 42504, 15501, 17071, 41012, 51726, 57805, 21365, 38691, 57248, 17225, 16999, 41094, 15582, 28381, 26006, 8475, 37340, 47232, 57454, 26737, 15103, 40574, 9922, 17154, 59240, 36305, 60277, 20333, 58065, 1491, 31820, 47044, 47460, 65417, 35657, 10134, 30703, 907, 29921, 64173, 14354, 35471, 32824, 40267, 54627, 28808, 29018, 33219, 27203, 1169, 54918, 6422, 38087, 54991, 43445, 33690, 29923, 29549, 20273, 22654, 15032, 39789, 13800, 6003, 50979, 49311, 531, 34986, 2081, 24335, 44837, 59000, 6508, 21489, 26757, 8544, 26711, 3540, 48459, 54526, 62376, 38436, 56382, 9035, 13602, 24987, 24092, 26031, 60571, 7572, 36957, 53553, 30911, 19537, 55088, 55900, 936, 59708, 53003, 18135, 60079, 59448, 34394, 36433, 3646, 11602, 56563, 91, 53951, 55766, 62840, 25517, 30067, 55109, 36403, 45329, 44580, 27754, 33916, 3953, 10143, 43301, 52402, 17146, 15499, 36550, 11502, 32163, 64149, 51236, 43754, 36463, 44250, 49629, 35955, 45734, 43641, 6386, 6098, 24610, 6403, 44282, 24577, 45669, 8407, 58084, 191, 57987, 37132, 31341, 11277, 22736, 6561, 46568, 50436, 20836, 39007, 44365, 57280, 53152, 51854, 4312, 28849, 51585, 50662, 36129, 39441, 30075, 35653, 12557, 11827, 29041, 6157, 55107, 26818, 15827, 47540, 26697, 63187, 40831, 45926, 47909, 46626, 4840, 15654, 30718, 47502, 28020, 50631, 33176, 33117, 21607, 59776, 735, 18478, 48860, 56480, 57571, 17850, 55755, 40247, 25014, 890, 53128, 61684, 52620, 18771, 28129, 13021, 3865, 4510, 32949, 27330, 17094, 28121, 12445, 35375, 5509, 13233, 63198, 16383, 46144, 59671, 54168, 20383, 50328, 41694, 27129, 16731, 48507, 40306, 38762, 58041, 53960, 44339, 7867, 25810, 54796, 269, 9066, 27065, 10462, 59350, 46609, 57026, 42959, 10354, 20817, 49929, 29727, 13958, 59833, 45061, 30482, 57507, 63623, 58828, 20046, 38899, 57797, 25191, 39226, 44623, 42410, 52483, 10409, 4135, 4679, 10460, 7520, 55279, 40245, 28559, 50486, 46341, 41191, 20501, 48014, 1087, 30993, 15381, 25527, 48579, 26520, 47183, 12032, 7622, 52848, 50781, 18585, 37169, 35026, 19065, 57922, 22272, 15246, 34714, 40163, 56211, 25685, 53830, 62893, 50363, 50509, 16300, 22109, 28951, 11865, 32443, 8575, 18138, 46949, 46814, 47196, 30784, 3305, 6652, 6320, 44611, 62446, 10891, 8256, 27642, 29119, 3018, 9566, 26769, 23987, 48059, 33668, 42188, 3991, 61317, 22369, 28370, 19442, 7165, 56860, 43738, 42556, 60632, 64201, 27513, 24490, 33338, 29765, 4016, 5164, 50173, 64310, 6829, 8703, 13896, 30754, 31830, 60539, 22262, 3367, 5885, 15094, 22839, 33939, 5137, 62138, 7459, 49616, 20863, 4145, 4579, 36086, 22436, 50485, 9297, 54595, 60549, 26142, 53706, 8952, 27406, 9778, 29552, 27942, 11721, 19984, 57651, 45481, 30969, 40872, 57696, 3740, 30308, 1559, 5173, 24803, 33316, 15183, 7014, 5407, 50837, 32666, 8688, 3819, 36456, 40674, 48105, 59822, 52903, 19080, 24387, 25063, 50772, 53790, 51380, 60373, 20932, 38450, 47765, 15528, 41228, 23514, 2730, 61711, 18813, 29627, 24925, 7393, 28546, 10850, 44425, 40404, 55147, 61233, 25085, 61626, 56856, 63455, 10012, 12334, 45752, 22467, 60761, 61333, 46075, 4807, 26118, 19536, 15470, 58695, 5229, 16260, 11939, 29712, 8684, 9483, 846, 50060, 6505, 41317, 61527, 28244, 32041, 57654, 736, 23063, 29525, 20222, 4732, 45316, 57740, 32244, 15674, 24193, 416, 37287, 23252, 26727, 30367, 19185, 3793, 45438, 16964, 2203, 44395, 58975, 36789, 49125, 14977, 63737, 62539, 16920, 61145, 42197, 58416, 44496, 42189, 1777, 26121, 36670, 27114, 5344, 44369, 57804, 4720, 20260, 21580, 49774, 50322, 50227, 38857, 11659, 25182, 1049, 17547, 21225, 5553, 1560, 49442, 57483, 4991, 6188, 45865, 42444, 44362, 213, 57296, 36094, 30877, 18120, 51030, 47337, 55995, 2410, 50002, 26640, 49732, 61580, 58405, 62634, 36602, 5077, 9792, 16521, 23970, 30512, 16177, 57909, 62767, 866, 12241, 25752, 41208, 46291, 24731, 19763, 24884, 48777, 14173, 22733, 54405, 10376, 12732, 57659, 48813, 1017, 21996, 61071, 39435, 53869, 31682, 13722, 60208, 39484, 22990, 12274, 52820, 35085, 21400, 3430, 19447, 18186, 49686, 9796, 25594, 15335, 1327, 13189, 45008, 56932, 25259]}	2639	\\x00000000000000000000000000000000
\.


--
-- Data for Name: device_profile; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.device_profile (id, tenant_id, created_at, updated_at, name, region, mac_version, reg_params_revision, adr_algorithm_id, payload_codec_runtime, uplink_interval, device_status_req_interval, supports_otaa, supports_class_b, supports_class_c, tags, payload_codec_script, flush_queue_on_activate, description, measurements, auto_detect_measurements, region_config_id, allow_roaming, rx1_delay, abp_params, class_b_params, class_c_params, relay_params, app_layer_params) FROM stdin;
2f529310-7063-484e-ba6d-6ee31e5b1fdc	5672112a-e4c1-4e7b-92e8-ed09db4eca01	2025-12-17 10:12:47.099871+00	2025-12-17 10:12:47.099871+00	Profile 1	EU868	1.0.3	A	default	NONE	3600	1	t	f	f	{}	/**\n * Decode uplink function\n * \n * @param {object} input\n * @param {number[]} input.bytes Byte array containing the uplink payload, e.g. [255, 230, 255, 0]\n * @param {number} input.fPort Uplink fPort.\n * @param {Record<string, string>} input.variables Object containing the configured device variables.\n * \n * @returns {{data: object, errors: string[], warnings: string[]}}\n * An object containing:\n * - data: Object representing the decoded payload.\n * - errors: An array of errors (optional).\n * - warnings: An array of warnings (optional).\n */\nfunction decodeUplink(input) {\n  return {\n    data: {\n      temp: 22.5,\n    }\n  };\n}\n\n/**\n * Encode downlink function.\n * \n * @param {object} input\n * @param {object} input.data Object representing the payload that must be encoded.\n * @param {Record<string, string>} input.variables Object containing the configured device variables.\n * \n * @returns {{bytes: number[], fPort: number, errors: string[], warnings: string[]}}\n * An object containing:\n * - bytes: Byte array containing the downlink payload.\n * - fPort: The downlink LoRaWAN fPort.\n * - errors: An array of errors (optional).\n * - warnings: An array of warnings (optional).\n */\nfunction encodeDownlink(input) {\n  return {\n    fPort: 10,\n    bytes: [225, 230, 255, 0],\n  };\n}\n	t		{}	t	\N	f	0	\N	\N	\N	\N	{"ts003_f_port": 202, "ts004_f_port": 201, "ts005_f_port": 200, "ts003_version": null, "ts004_version": null, "ts005_version": null}
\.


--
-- Data for Name: device_profile_template; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.device_profile_template (id, created_at, updated_at, name, description, vendor, firmware, region, mac_version, reg_params_revision, adr_algorithm_id, payload_codec_runtime, payload_codec_script, uplink_interval, device_status_req_interval, flush_queue_on_activate, supports_otaa, supports_class_b, supports_class_c, class_b_timeout, class_b_ping_slot_periodicity, class_b_ping_slot_dr, class_b_ping_slot_freq, class_c_timeout, abp_rx1_delay, abp_rx1_dr_offset, abp_rx2_dr, abp_rx2_freq, tags, measurements, auto_detect_measurements) FROM stdin;
\.


--
-- Data for Name: device_queue_item; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.device_queue_item (id, dev_eui, created_at, f_port, confirmed, data, is_pending, f_cnt_down, timeout_after, is_encrypted, expires_at) FROM stdin;
\.


--
-- Data for Name: fuota_deployment; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.fuota_deployment (id, created_at, updated_at, started_at, completed_at, name, application_id, device_profile_id, multicast_addr, multicast_key, multicast_group_type, multicast_class_c_scheduling_type, multicast_dr, multicast_class_b_ping_slot_periodicity, multicast_frequency, multicast_timeout, multicast_session_start, multicast_session_end, unicast_max_retry_count, fragmentation_fragment_size, fragmentation_redundancy_percentage, fragmentation_session_index, fragmentation_matrix, fragmentation_block_ack_delay, fragmentation_descriptor, request_fragmentation_session_status, payload, on_complete_set_device_tags) FROM stdin;
\.


--
-- Data for Name: fuota_deployment_device; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.fuota_deployment_device (fuota_deployment_id, dev_eui, created_at, completed_at, mc_group_setup_completed_at, mc_session_completed_at, frag_session_setup_completed_at, frag_status_completed_at, error_msg) FROM stdin;
\.


--
-- Data for Name: fuota_deployment_gateway; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.fuota_deployment_gateway (fuota_deployment_id, gateway_id, created_at) FROM stdin;
\.


--
-- Data for Name: fuota_deployment_job; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.fuota_deployment_job (fuota_deployment_id, job, created_at, completed_at, max_retry_count, attempt_count, scheduler_run_after, warning_msg, error_msg) FROM stdin;
\.


--
-- Data for Name: gateway; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.gateway (gateway_id, tenant_id, created_at, updated_at, last_seen_at, name, description, latitude, longitude, altitude, stats_interval_secs, tls_certificate, tags, properties) FROM stdin;
\\xcc8e1ec115cb6e74	5672112a-e4c1-4e7b-92e8-ed09db4eca01	2025-12-17 10:35:10.685024+00	2025-12-17 10:35:10.685024+00	2025-12-19 19:43:52.854231+00	LWN-Gateway		0	0	0	30	\N	{}	{"region_config_id": "eu868", "region_common_name": "EU868"}
\.


--
-- Data for Name: multicast_group; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.multicast_group (id, application_id, created_at, updated_at, name, region, mc_addr, mc_nwk_s_key, mc_app_s_key, f_cnt, group_type, dr, frequency, class_b_ping_slot_periodicity, class_c_scheduling_type) FROM stdin;
\.


--
-- Data for Name: multicast_group_device; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.multicast_group_device (multicast_group_id, dev_eui, created_at) FROM stdin;
\.


--
-- Data for Name: multicast_group_gateway; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.multicast_group_gateway (multicast_group_id, gateway_id, created_at) FROM stdin;
\.


--
-- Data for Name: multicast_group_queue_item; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.multicast_group_queue_item (id, created_at, scheduler_run_after, multicast_group_id, gateway_id, f_cnt, f_port, data, emit_at_time_since_gps_epoch, expires_at) FROM stdin;
\.


--
-- Data for Name: relay_device; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.relay_device (relay_dev_eui, dev_eui, created_at) FROM stdin;
\.


--
-- Data for Name: relay_gateway; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.relay_gateway (tenant_id, relay_id, created_at, updated_at, last_seen_at, name, description, stats_interval_secs, region_config_id) FROM stdin;
\.


--
-- Data for Name: tenant; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.tenant (id, created_at, updated_at, name, description, can_have_gateways, max_device_count, max_gateway_count, private_gateways_up, private_gateways_down, tags) FROM stdin;
5672112a-e4c1-4e7b-92e8-ed09db4eca01	2025-12-17 09:33:06.298459+00	2025-12-17 10:50:44.350758+00	ChirpStack		t	0	0	f	f	{}
\.


--
-- Data for Name: tenant_user; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public.tenant_user (tenant_id, user_id, created_at, updated_at, is_admin, is_device_admin, is_gateway_admin) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: chirpstack
--

COPY public."user" (id, external_id, created_at, updated_at, is_admin, is_active, email, email_verified, password_hash, note) FROM stdin;
8908d8fa-c298-470d-b597-ec61d93157f2	\N	2025-12-17 09:33:06.298459+00	2025-12-17 09:33:06.298459+00	t	t	admin	f	$pbkdf2-sha512$i=1,l=64$l8zGKtxRESq3PA2kFhHRWA$H3lGMxOt55wjwoc+myeOoABofJY9oDpldJa7fhqdjbh700V6FLPML75UmBOt9J5VFNjAL1AvqCozA1HJM0QVGA	
\.


--
-- Name: __diesel_schema_migrations __diesel_schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.__diesel_schema_migrations
    ADD CONSTRAINT __diesel_schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: api_key api_key_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.api_key
    ADD CONSTRAINT api_key_pkey PRIMARY KEY (id);


--
-- Name: application_integration application_integration_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.application_integration
    ADD CONSTRAINT application_integration_pkey PRIMARY KEY (application_id, kind);


--
-- Name: application application_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT application_pkey PRIMARY KEY (id);


--
-- Name: device_keys device_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device_keys
    ADD CONSTRAINT device_keys_pkey PRIMARY KEY (dev_eui);


--
-- Name: device device_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device
    ADD CONSTRAINT device_pkey PRIMARY KEY (dev_eui);


--
-- Name: device_profile device_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device_profile
    ADD CONSTRAINT device_profile_pkey PRIMARY KEY (id);


--
-- Name: device_profile_template device_profile_template_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device_profile_template
    ADD CONSTRAINT device_profile_template_pkey PRIMARY KEY (id);


--
-- Name: device_queue_item device_queue_item_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device_queue_item
    ADD CONSTRAINT device_queue_item_pkey PRIMARY KEY (id);


--
-- Name: fuota_deployment_device fuota_deployment_device_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.fuota_deployment_device
    ADD CONSTRAINT fuota_deployment_device_pkey PRIMARY KEY (fuota_deployment_id, dev_eui);


--
-- Name: fuota_deployment_gateway fuota_deployment_gateway_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.fuota_deployment_gateway
    ADD CONSTRAINT fuota_deployment_gateway_pkey PRIMARY KEY (fuota_deployment_id, gateway_id);


--
-- Name: fuota_deployment_job fuota_deployment_job_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.fuota_deployment_job
    ADD CONSTRAINT fuota_deployment_job_pkey PRIMARY KEY (fuota_deployment_id, job);


--
-- Name: fuota_deployment fuota_deployment_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.fuota_deployment
    ADD CONSTRAINT fuota_deployment_pkey PRIMARY KEY (id);


--
-- Name: gateway gateway_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.gateway
    ADD CONSTRAINT gateway_pkey PRIMARY KEY (gateway_id);


--
-- Name: multicast_group_device multicast_group_device_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group_device
    ADD CONSTRAINT multicast_group_device_pkey PRIMARY KEY (multicast_group_id, dev_eui);


--
-- Name: multicast_group_gateway multicast_group_gateway_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group_gateway
    ADD CONSTRAINT multicast_group_gateway_pkey PRIMARY KEY (multicast_group_id, gateway_id);


--
-- Name: multicast_group multicast_group_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group
    ADD CONSTRAINT multicast_group_pkey PRIMARY KEY (id);


--
-- Name: multicast_group_queue_item multicast_group_queue_item_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group_queue_item
    ADD CONSTRAINT multicast_group_queue_item_pkey PRIMARY KEY (id);


--
-- Name: relay_device relay_device_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.relay_device
    ADD CONSTRAINT relay_device_pkey PRIMARY KEY (relay_dev_eui, dev_eui);


--
-- Name: relay_gateway relay_gateway_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.relay_gateway
    ADD CONSTRAINT relay_gateway_pkey PRIMARY KEY (tenant_id, relay_id);


--
-- Name: tenant tenant_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.tenant
    ADD CONSTRAINT tenant_pkey PRIMARY KEY (id);


--
-- Name: tenant_user tenant_user_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.tenant_user
    ADD CONSTRAINT tenant_user_pkey PRIMARY KEY (tenant_id, user_id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: idx_api_key_tenant_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_api_key_tenant_id ON public.api_key USING btree (tenant_id);


--
-- Name: idx_application_name_trgm; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_application_name_trgm ON public.application USING gin (name public.gin_trgm_ops);


--
-- Name: idx_application_tags; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_application_tags ON public.application USING gin (tags);


--
-- Name: idx_application_tenant_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_application_tenant_id ON public.application USING btree (tenant_id);


--
-- Name: idx_device_application_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_application_id ON public.device USING btree (application_id);


--
-- Name: idx_device_dev_addr; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_dev_addr ON public.device USING btree (dev_addr);


--
-- Name: idx_device_dev_addr_trgm; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_dev_addr_trgm ON public.device USING gin (encode(dev_addr, 'hex'::text) public.gin_trgm_ops);


--
-- Name: idx_device_dev_eui_trgm; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_dev_eui_trgm ON public.device USING gin (encode(dev_eui, 'hex'::text) public.gin_trgm_ops);


--
-- Name: idx_device_device_profile_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_device_profile_id ON public.device USING btree (device_profile_id);


--
-- Name: idx_device_name_trgm; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_name_trgm ON public.device USING gin (name public.gin_trgm_ops);


--
-- Name: idx_device_profile_name_trgm; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_profile_name_trgm ON public.device_profile USING gin (name public.gin_trgm_ops);


--
-- Name: idx_device_profile_tags; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_profile_tags ON public.device_profile USING gin (tags);


--
-- Name: idx_device_profile_tenant_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_profile_tenant_id ON public.device_profile USING btree (tenant_id);


--
-- Name: idx_device_queue_item_created_at; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_queue_item_created_at ON public.device_queue_item USING btree (created_at);


--
-- Name: idx_device_queue_item_dev_eui; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_queue_item_dev_eui ON public.device_queue_item USING btree (dev_eui);


--
-- Name: idx_device_queue_item_timeout_after; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_queue_item_timeout_after ON public.device_queue_item USING btree (timeout_after);


--
-- Name: idx_device_secondary_dev_addr; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_secondary_dev_addr ON public.device USING btree (secondary_dev_addr);


--
-- Name: idx_device_tags; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_device_tags ON public.device USING gin (tags);


--
-- Name: idx_fuota_deployment_job_completed_at; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_fuota_deployment_job_completed_at ON public.fuota_deployment_job USING btree (completed_at);


--
-- Name: idx_fuota_deployment_job_scheduler_run_after; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_fuota_deployment_job_scheduler_run_after ON public.fuota_deployment_job USING btree (scheduler_run_after);


--
-- Name: idx_gateway_id_trgm; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_gateway_id_trgm ON public.gateway USING gin (encode(gateway_id, 'hex'::text) public.gin_trgm_ops);


--
-- Name: idx_gateway_name_trgm; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_gateway_name_trgm ON public.gateway USING gin (name public.gin_trgm_ops);


--
-- Name: idx_gateway_tags; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_gateway_tags ON public.gateway USING gin (tags);


--
-- Name: idx_gateway_tenant_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_gateway_tenant_id ON public.gateway USING btree (tenant_id);


--
-- Name: idx_multicast_group_application_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_multicast_group_application_id ON public.multicast_group USING btree (application_id);


--
-- Name: idx_multicast_group_name_trgm; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_multicast_group_name_trgm ON public.multicast_group USING gin (name public.gin_trgm_ops);


--
-- Name: idx_multicast_group_queue_item_multicast_group_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_multicast_group_queue_item_multicast_group_id ON public.multicast_group_queue_item USING btree (multicast_group_id);


--
-- Name: idx_multicast_group_queue_item_scheduler_run_after; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_multicast_group_queue_item_scheduler_run_after ON public.multicast_group_queue_item USING btree (scheduler_run_after);


--
-- Name: idx_tenant_name_trgm; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_tenant_name_trgm ON public.tenant USING gin (name public.gin_trgm_ops);


--
-- Name: idx_tenant_tags; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_tenant_tags ON public.tenant USING gin (tags);


--
-- Name: idx_tenant_user_user_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE INDEX idx_tenant_user_user_id ON public.tenant_user USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE UNIQUE INDEX idx_user_email ON public."user" USING btree (email);


--
-- Name: idx_user_external_id; Type: INDEX; Schema: public; Owner: chirpstack
--

CREATE UNIQUE INDEX idx_user_external_id ON public."user" USING btree (external_id);


--
-- Name: api_key api_key_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.api_key
    ADD CONSTRAINT api_key_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(id) ON DELETE CASCADE;


--
-- Name: application_integration application_integration_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.application_integration
    ADD CONSTRAINT application_integration_application_id_fkey FOREIGN KEY (application_id) REFERENCES public.application(id) ON DELETE CASCADE;


--
-- Name: application application_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT application_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(id) ON DELETE CASCADE;


--
-- Name: device device_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device
    ADD CONSTRAINT device_application_id_fkey FOREIGN KEY (application_id) REFERENCES public.application(id) ON DELETE CASCADE;


--
-- Name: device device_device_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device
    ADD CONSTRAINT device_device_profile_id_fkey FOREIGN KEY (device_profile_id) REFERENCES public.device_profile(id) ON DELETE CASCADE;


--
-- Name: device_keys device_keys_dev_eui_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device_keys
    ADD CONSTRAINT device_keys_dev_eui_fkey FOREIGN KEY (dev_eui) REFERENCES public.device(dev_eui) ON DELETE CASCADE;


--
-- Name: device_profile device_profile_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device_profile
    ADD CONSTRAINT device_profile_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(id) ON DELETE CASCADE;


--
-- Name: device_queue_item device_queue_item_dev_eui_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.device_queue_item
    ADD CONSTRAINT device_queue_item_dev_eui_fkey FOREIGN KEY (dev_eui) REFERENCES public.device(dev_eui) ON DELETE CASCADE;


--
-- Name: fuota_deployment fuota_deployment_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.fuota_deployment
    ADD CONSTRAINT fuota_deployment_application_id_fkey FOREIGN KEY (application_id) REFERENCES public.application(id) ON DELETE CASCADE;


--
-- Name: fuota_deployment_device fuota_deployment_device_dev_eui_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.fuota_deployment_device
    ADD CONSTRAINT fuota_deployment_device_dev_eui_fkey FOREIGN KEY (dev_eui) REFERENCES public.device(dev_eui) ON DELETE CASCADE;


--
-- Name: fuota_deployment_device fuota_deployment_device_fuota_deployment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.fuota_deployment_device
    ADD CONSTRAINT fuota_deployment_device_fuota_deployment_id_fkey FOREIGN KEY (fuota_deployment_id) REFERENCES public.fuota_deployment(id) ON DELETE CASCADE;


--
-- Name: fuota_deployment fuota_deployment_device_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.fuota_deployment
    ADD CONSTRAINT fuota_deployment_device_profile_id_fkey FOREIGN KEY (device_profile_id) REFERENCES public.device_profile(id) ON DELETE CASCADE;


--
-- Name: fuota_deployment_gateway fuota_deployment_gateway_fuota_deployment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.fuota_deployment_gateway
    ADD CONSTRAINT fuota_deployment_gateway_fuota_deployment_id_fkey FOREIGN KEY (fuota_deployment_id) REFERENCES public.fuota_deployment(id) ON DELETE CASCADE;


--
-- Name: fuota_deployment_gateway fuota_deployment_gateway_gateway_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.fuota_deployment_gateway
    ADD CONSTRAINT fuota_deployment_gateway_gateway_id_fkey FOREIGN KEY (gateway_id) REFERENCES public.gateway(gateway_id) ON DELETE CASCADE;


--
-- Name: fuota_deployment_job fuota_deployment_job_fuota_deployment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.fuota_deployment_job
    ADD CONSTRAINT fuota_deployment_job_fuota_deployment_id_fkey FOREIGN KEY (fuota_deployment_id) REFERENCES public.fuota_deployment(id) ON DELETE CASCADE;


--
-- Name: gateway gateway_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.gateway
    ADD CONSTRAINT gateway_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(id) ON DELETE CASCADE;


--
-- Name: multicast_group multicast_group_application_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group
    ADD CONSTRAINT multicast_group_application_id_fkey FOREIGN KEY (application_id) REFERENCES public.application(id) ON DELETE CASCADE;


--
-- Name: multicast_group_device multicast_group_device_dev_eui_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group_device
    ADD CONSTRAINT multicast_group_device_dev_eui_fkey FOREIGN KEY (dev_eui) REFERENCES public.device(dev_eui) ON DELETE CASCADE;


--
-- Name: multicast_group_device multicast_group_device_multicast_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group_device
    ADD CONSTRAINT multicast_group_device_multicast_group_id_fkey FOREIGN KEY (multicast_group_id) REFERENCES public.multicast_group(id) ON DELETE CASCADE;


--
-- Name: multicast_group_gateway multicast_group_gateway_gateway_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group_gateway
    ADD CONSTRAINT multicast_group_gateway_gateway_id_fkey FOREIGN KEY (gateway_id) REFERENCES public.gateway(gateway_id) ON DELETE CASCADE;


--
-- Name: multicast_group_gateway multicast_group_gateway_multicast_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group_gateway
    ADD CONSTRAINT multicast_group_gateway_multicast_group_id_fkey FOREIGN KEY (multicast_group_id) REFERENCES public.multicast_group(id) ON DELETE CASCADE;


--
-- Name: multicast_group_queue_item multicast_group_queue_item_gateway_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group_queue_item
    ADD CONSTRAINT multicast_group_queue_item_gateway_id_fkey FOREIGN KEY (gateway_id) REFERENCES public.gateway(gateway_id) ON DELETE CASCADE;


--
-- Name: multicast_group_queue_item multicast_group_queue_item_multicast_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.multicast_group_queue_item
    ADD CONSTRAINT multicast_group_queue_item_multicast_group_id_fkey FOREIGN KEY (multicast_group_id) REFERENCES public.multicast_group(id) ON DELETE CASCADE;


--
-- Name: relay_device relay_device_dev_eui_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.relay_device
    ADD CONSTRAINT relay_device_dev_eui_fkey FOREIGN KEY (dev_eui) REFERENCES public.device(dev_eui) ON DELETE CASCADE;


--
-- Name: relay_device relay_device_relay_dev_eui_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.relay_device
    ADD CONSTRAINT relay_device_relay_dev_eui_fkey FOREIGN KEY (relay_dev_eui) REFERENCES public.device(dev_eui) ON DELETE CASCADE;


--
-- Name: relay_gateway relay_gateway_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.relay_gateway
    ADD CONSTRAINT relay_gateway_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(id) ON DELETE CASCADE;


--
-- Name: tenant_user tenant_user_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.tenant_user
    ADD CONSTRAINT tenant_user_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenant(id) ON DELETE CASCADE;


--
-- Name: tenant_user tenant_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chirpstack
--

ALTER TABLE ONLY public.tenant_user
    ADD CONSTRAINT tenant_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict YjByqKIBi31xHdDSTQ10IgtSmkT8L3M1vggBnZ0aMslIs32ycxyXN7SPszDSeaC

