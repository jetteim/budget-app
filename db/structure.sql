SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE account_groups (
    id bigint NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: account_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE account_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: account_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE account_groups_id_seq OWNED BY account_groups.id;


--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE accounts (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    number character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    balance numeric(10,2) DEFAULT 0.0 NOT NULL,
    account_group_id integer
);


--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE accounts_id_seq OWNED BY accounts.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE categories (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: goals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE goals (
    id bigint NOT NULL,
    category_id integer NOT NULL,
    amount numeric(10,2) DEFAULT 0.0 NOT NULL,
    period character varying(255) DEFAULT 'Month'::character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    type character varying DEFAULT 'Spend'::character varying NOT NULL
);


--
-- Name: goals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE goals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: goals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE goals_id_seq OWNED BY goals.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE payments (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    category_id integer NOT NULL,
    amount numeric(10,2) NOT NULL,
    type character varying(255) DEFAULT 'Spend'::character varying NOT NULL,
    schedule text NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE payments_id_seq OWNED BY payments.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: sorted_transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sorted_transactions (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    transaction_id integer NOT NULL,
    category_id integer NOT NULL,
    account_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    review boolean DEFAULT false NOT NULL,
    tag_ids integer[],
    note text
);


--
-- Name: sorted_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sorted_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sorted_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sorted_transactions_id_seq OWNED BY sorted_transactions.id;


--
-- Name: sorting_rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sorting_rules (
    id bigint NOT NULL,
    contains character varying(255) NOT NULL,
    name character varying(255),
    category_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    review boolean DEFAULT false NOT NULL,
    tag_ids integer[]
);


--
-- Name: sorting_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sorting_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sorting_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sorting_rules_id_seq OWNED BY sorting_rules.id;


--
-- Name: statements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE statements (
    id bigint NOT NULL,
    account_id integer NOT NULL,
    balance numeric(10,2) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    from_date date,
    to_date date
);


--
-- Name: statements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE statements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: statements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE statements_id_seq OWNED BY statements.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tags (
    id bigint NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE transactions (
    id bigint NOT NULL,
    amount numeric(10,2) NOT NULL,
    fit_id character varying(255) NOT NULL,
    memo character varying(255),
    name character varying(255),
    payee character varying(255),
    posted_at timestamp without time zone NOT NULL,
    ref_number character varying(255),
    type character varying(255),
    account_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    statement_id integer,
    search character varying(255) NOT NULL
);


--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE transactions_id_seq OWNED BY transactions.id;


--
-- Name: account_groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_groups ALTER COLUMN id SET DEFAULT nextval('account_groups_id_seq'::regclass);


--
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts ALTER COLUMN id SET DEFAULT nextval('accounts_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: goals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY goals ALTER COLUMN id SET DEFAULT nextval('goals_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments ALTER COLUMN id SET DEFAULT nextval('payments_id_seq'::regclass);


--
-- Name: sorted_transactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sorted_transactions ALTER COLUMN id SET DEFAULT nextval('sorted_transactions_id_seq'::regclass);


--
-- Name: sorting_rules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sorting_rules ALTER COLUMN id SET DEFAULT nextval('sorting_rules_id_seq'::regclass);


--
-- Name: statements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY statements ALTER COLUMN id SET DEFAULT nextval('statements_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY transactions ALTER COLUMN id SET DEFAULT nextval('transactions_id_seq'::regclass);


--
-- Name: account_groups account_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_groups
    ADD CONSTRAINT account_groups_pkey PRIMARY KEY (id);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: goals goals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY goals
    ADD CONSTRAINT goals_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sorted_transactions sorted_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sorted_transactions
    ADD CONSTRAINT sorted_transactions_pkey PRIMARY KEY (id);


--
-- Name: sorting_rules sorting_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sorting_rules
    ADD CONSTRAINT sorting_rules_pkey PRIMARY KEY (id);


--
-- Name: statements statements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY statements
    ADD CONSTRAINT statements_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: index_account_groups_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_account_groups_on_name ON account_groups USING btree (name);


--
-- Name: index_accounts_on_number; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_accounts_on_number ON accounts USING btree (number);


--
-- Name: index_categories_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_categories_on_name ON categories USING btree (name);


--
-- Name: index_goals_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_goals_on_category_id ON goals USING btree (category_id);


--
-- Name: index_payments_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payments_on_category_id ON payments USING btree (category_id);


--
-- Name: index_sorted_transactions_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sorted_transactions_on_account_id ON sorted_transactions USING btree (account_id);


--
-- Name: index_sorted_transactions_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sorted_transactions_on_category_id ON sorted_transactions USING btree (category_id);


--
-- Name: index_sorted_transactions_on_transaction_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sorted_transactions_on_transaction_id ON sorted_transactions USING btree (transaction_id);


--
-- Name: index_sorting_rules_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sorting_rules_on_category_id ON sorting_rules USING btree (category_id);


--
-- Name: index_sorting_rules_on_contains; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_sorting_rules_on_contains ON sorting_rules USING btree (contains);


--
-- Name: index_statements_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_statements_on_account_id ON statements USING btree (account_id);


--
-- Name: index_tags_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_tags_on_name ON tags USING btree (name);


--
-- Name: index_transactions_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_transactions_on_account_id ON transactions USING btree (account_id);


--
-- Name: index_transactions_on_statement_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_transactions_on_statement_id ON transactions USING btree (statement_id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20161024025407');
