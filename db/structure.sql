--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.8
-- Dumped by pg_dump version 9.5.8

SET statement_timeout = 0;
SET lock_timeout = 0;
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
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: attacks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE attacks (
    id integer NOT NULL,
    torn_id integer,
    timestamp_started timestamp without time zone,
    timestamp_ended timestamp without time zone,
    attacker_id integer,
    defender_id integer,
    result character varying,
    respect_gain double precision,
    "timestamp" timestamp without time zone,
    group_attack boolean DEFAULT false
);


--
-- Name: attacks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE attacks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attacks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE attacks_id_seq OWNED BY attacks.id;


--
-- Name: battle_stats_updates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE battle_stats_updates (
    id integer NOT NULL,
    "timestamp" timestamp without time zone,
    strength double precision,
    dexterity double precision,
    speed double precision,
    defense double precision,
    strength_modifier double precision,
    dexterity_modifier double precision,
    speed_modifier double precision,
    defense_modifier double precision,
    player_id integer
);


--
-- Name: battle_stats_updates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE battle_stats_updates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: battle_stats_updates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE battle_stats_updates_id_seq OWNED BY battle_stats_updates.id;


--
-- Name: factions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE factions (
    id integer NOT NULL,
    torn_id integer,
    api_key character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: factions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE factions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: factions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE factions_id_seq OWNED BY factions.id;


--
-- Name: player_info_updates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE player_info_updates (
    id integer NOT NULL,
    "timestamp" timestamp without time zone,
    level integer,
    last_action timestamp without time zone,
    player_id integer,
    awards integer,
    friends integer,
    enemies integer,
    karma integer,
    forum_posts integer,
    role character varying,
    donator boolean,
    max_life integer,
    company_id integer,
    "position" character varying,
    spouse_id integer,
    logins integer DEFAULT 0 NOT NULL,
    activity integer DEFAULT 0 NOT NULL,
    attacks_won integer DEFAULT 0 NOT NULL,
    attacks_draw integer DEFAULT 0 NOT NULL,
    attacks_lost integer DEFAULT 0 NOT NULL,
    highest_beaten integer DEFAULT 0 NOT NULL,
    best_kill_streak integer DEFAULT 0 NOT NULL,
    defends_lost integer DEFAULT 0 NOT NULL,
    defends_won integer DEFAULT 0 NOT NULL,
    defends_draw integer DEFAULT 0 NOT NULL,
    xanax_taken integer DEFAULT 0 NOT NULL,
    ecstasy_taken integer DEFAULT 0 NOT NULL,
    times_traveled integer DEFAULT 0 NOT NULL,
    networth bigint DEFAULT 0 NOT NULL,
    refills integer DEFAULT 0 NOT NULL,
    stat_enhancers_used integer DEFAULT 0 NOT NULL,
    medical_items_used integer DEFAULT 0 NOT NULL,
    weapons_bought integer DEFAULT 0 NOT NULL,
    bazaar_customers integer DEFAULT 0 NOT NULL,
    bazaar_sales integer DEFAULT 0 NOT NULL,
    bazaar_profit bigint DEFAULT 0 NOT NULL,
    points_bought integer DEFAULT 0 NOT NULL,
    points_sold integer DEFAULT 0 NOT NULL,
    items_bought_abroad integer DEFAULT 0 NOT NULL,
    items_bought integer DEFAULT 0 NOT NULL,
    trades integer DEFAULT 0 NOT NULL,
    items_sent integer DEFAULT 0 NOT NULL,
    auctions_won integer DEFAULT 0 NOT NULL,
    auctions_sold integer DEFAULT 0 NOT NULL,
    money_mugged bigint DEFAULT 0 NOT NULL,
    attacks_stealthed integer DEFAULT 0 NOT NULL,
    critical_hits integer DEFAULT 0 NOT NULL,
    respect integer DEFAULT 0 NOT NULL,
    rounds_fired integer DEFAULT 0 NOT NULL,
    attacks_ran_away integer DEFAULT 0 NOT NULL,
    defends_ran_away integer DEFAULT 0 NOT NULL,
    people_busted integer DEFAULT 0 NOT NULL,
    failed_busts integer DEFAULT 0 NOT NULL,
    bails_bought integer DEFAULT 0 NOT NULL,
    bails_spent bigint DEFAULT 0 NOT NULL,
    viruses_coded integer DEFAULT 0 NOT NULL,
    city_finds integer DEFAULT 0 NOT NULL,
    bounties_placed integer DEFAULT 0 NOT NULL,
    bounties_received integer DEFAULT 0 NOT NULL,
    bounties_collected integer DEFAULT 0 NOT NULL,
    bounty_rewards bigint DEFAULT 0 NOT NULL,
    bounties_spent bigint DEFAULT 0 NOT NULL,
    revives integer DEFAULT 0 NOT NULL,
    revives_received integer DEFAULT 0 NOT NULL,
    trains_received integer DEFAULT 0 NOT NULL,
    drugs_taken integer DEFAULT 0 NOT NULL,
    overdoses integer DEFAULT 0 NOT NULL,
    merits_bought integer DEFAULT 0 NOT NULL,
    personals_placed integer DEFAULT 0 NOT NULL,
    classifieds_placed integer DEFAULT 0 NOT NULL,
    mail_sent integer DEFAULT 0 NOT NULL,
    friend_mail_sent integer DEFAULT 0 NOT NULL,
    faction_mail_sent integer DEFAULT 0 NOT NULL,
    company_mail_sent integer DEFAULT 0 NOT NULL,
    spouse_mail_sent integer DEFAULT 0 NOT NULL,
    largest_mug bigint DEFAULT 0 NOT NULL,
    canabis_taken integer DEFAULT 0 NOT NULL,
    ketamine_taken integer DEFAULT 0 NOT NULL,
    lsd_taken integer DEFAULT 0 NOT NULL,
    opium_taken integer DEFAULT 0 NOT NULL,
    shrooms_taken integer DEFAULT 0 NOT NULL,
    speed_taken integer DEFAULT 0 NOT NULL,
    pcp_taken integer DEFAULT 0 NOT NULL,
    vicodin_taken integer DEFAULT 0 NOT NULL,
    mechanical_hits integer DEFAULT 0 NOT NULL,
    artillery_hits integer DEFAULT 0 NOT NULL,
    clubbed_hits integer DEFAULT 0 NOT NULL,
    temp_hits integer DEFAULT 0 NOT NULL,
    machine_gun_hits integer DEFAULT 0 NOT NULL,
    pistol_hits integer DEFAULT 0 NOT NULL,
    rifle_hits integer DEFAULT 0 NOT NULL,
    shotgun_hits integer DEFAULT 0 NOT NULL,
    smg_hits integer DEFAULT 0 NOT NULL,
    piercing_hits integer DEFAULT 0 NOT NULL,
    slashing_hits integer DEFAULT 0 NOT NULL,
    argentina_travel integer DEFAULT 0 NOT NULL,
    mexico_travel integer DEFAULT 0 NOT NULL,
    dubai_travel integer DEFAULT 0 NOT NULL,
    hawaii_travel integer DEFAULT 0 NOT NULL,
    japan_travel integer DEFAULT 0 NOT NULL,
    london_travel integer DEFAULT 0 NOT NULL,
    south_africa_travel integer DEFAULT 0 NOT NULL,
    switzerland_travel integer DEFAULT 0 NOT NULL,
    china_travel integer DEFAULT 0 NOT NULL,
    canada_travel integer DEFAULT 0 NOT NULL,
    caymans_travel integer DEFAULT 0 NOT NULL,
    dump_finds integer DEFAULT 0 NOT NULL,
    dump_searches integer DEFAULT 0 NOT NULL,
    items_dumped integer DEFAULT 0 NOT NULL,
    days_as_donator integer DEFAULT 0 NOT NULL,
    times_jailed integer DEFAULT 0 NOT NULL,
    times_hospitalized integer DEFAULT 0 NOT NULL,
    attacks_assisted integer DEFAULT 0 NOT NULL,
    blood_withdrawn integer DEFAULT 0 NOT NULL,
    mission_credits integer DEFAULT 0 NOT NULL,
    contracts_completed integer DEFAULT 0 NOT NULL,
    duke_contracts_completed integer DEFAULT 0 NOT NULL,
    missions_completed integer DEFAULT 0 NOT NULL,
    name character varying,
    medical_items_stolen integer DEFAULT 0 NOT NULL,
    spies_done integer DEFAULT 0 NOT NULL,
    best_damage integer DEFAULT 0 NOT NULL,
    kill_streak integer DEFAULT 0 NOT NULL,
    one_hit_kills integer DEFAULT 0 NOT NULL,
    money_invested bigint DEFAULT 0 NOT NULL,
    invested_profit bigint DEFAULT 0 NOT NULL,
    attack_misses integer DEFAULT 0 NOT NULL,
    attack_damage bigint DEFAULT 0 NOT NULL,
    attack_hits integer DEFAULT 0 NOT NULL
);


--
-- Name: player_info_updates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE player_info_updates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: player_info_updates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE player_info_updates_id_seq OWNED BY player_info_updates.id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE players (
    id integer NOT NULL,
    torn_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    faction_id integer,
    signup timestamp without time zone,
    least_stats_beaten_by double precision,
    most_stats_defended_against double precision
);


--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE players_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE players_id_seq OWNED BY players.id;


--
-- Name: relevant_player_infos; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW relevant_player_infos AS
 SELECT p.torn_id,
    p.id AS player_id,
    p.least_stats_beaten_by,
    p.most_stats_defended_against,
    i.xanax_taken,
    i.refills,
    i.stat_enhancers_used
   FROM (players p
     LEFT JOIN LATERAL ( SELECT i2.id,
            i2."timestamp",
            i2.level,
            i2.last_action,
            i2.player_id,
            i2.awards,
            i2.friends,
            i2.enemies,
            i2.karma,
            i2.forum_posts,
            i2.role,
            i2.donator,
            i2.max_life,
            i2.company_id,
            i2."position",
            i2.spouse_id,
            i2.logins,
            i2.activity,
            i2.attacks_won,
            i2.attacks_draw,
            i2.attacks_lost,
            i2.highest_beaten,
            i2.best_kill_streak,
            i2.defends_lost,
            i2.defends_won,
            i2.defends_draw,
            i2.xanax_taken,
            i2.ecstasy_taken,
            i2.times_traveled,
            i2.networth,
            i2.refills,
            i2.stat_enhancers_used,
            i2.medical_items_used,
            i2.weapons_bought,
            i2.bazaar_customers,
            i2.bazaar_sales,
            i2.bazaar_profit,
            i2.points_bought,
            i2.points_sold,
            i2.items_bought_abroad,
            i2.items_bought,
            i2.trades,
            i2.items_sent,
            i2.auctions_won,
            i2.auctions_sold,
            i2.money_mugged,
            i2.attacks_stealthed,
            i2.critical_hits,
            i2.respect,
            i2.rounds_fired,
            i2.attacks_ran_away,
            i2.defends_ran_away,
            i2.people_busted,
            i2.failed_busts,
            i2.bails_bought,
            i2.bails_spent,
            i2.viruses_coded,
            i2.city_finds,
            i2.bounties_placed,
            i2.bounties_received,
            i2.bounties_collected,
            i2.bounty_rewards,
            i2.bounties_spent,
            i2.revives,
            i2.revives_received,
            i2.trains_received,
            i2.drugs_taken,
            i2.overdoses,
            i2.merits_bought,
            i2.personals_placed,
            i2.classifieds_placed,
            i2.mail_sent,
            i2.friend_mail_sent,
            i2.faction_mail_sent,
            i2.company_mail_sent,
            i2.spouse_mail_sent,
            i2.largest_mug,
            i2.canabis_taken,
            i2.ketamine_taken,
            i2.lsd_taken,
            i2.opium_taken,
            i2.shrooms_taken,
            i2.speed_taken,
            i2.pcp_taken,
            i2.vicodin_taken,
            i2.mechanical_hits,
            i2.artillery_hits,
            i2.clubbed_hits,
            i2.temp_hits,
            i2.machine_gun_hits,
            i2.pistol_hits,
            i2.rifle_hits,
            i2.shotgun_hits,
            i2.smg_hits,
            i2.piercing_hits,
            i2.slashing_hits,
            i2.argentina_travel,
            i2.mexico_travel,
            i2.dubai_travel,
            i2.hawaii_travel,
            i2.japan_travel,
            i2.london_travel,
            i2.south_africa_travel,
            i2.switzerland_travel,
            i2.china_travel,
            i2.canada_travel,
            i2.caymans_travel,
            i2.dump_finds,
            i2.dump_searches,
            i2.items_dumped,
            i2.days_as_donator,
            i2.times_jailed,
            i2.times_hospitalized,
            i2.attacks_assisted,
            i2.blood_withdrawn,
            i2.mission_credits,
            i2.contracts_completed,
            i2.duke_contracts_completed,
            i2.missions_completed,
            i2.name,
            i2.medical_items_stolen,
            i2.spies_done,
            i2.best_damage,
            i2.kill_streak,
            i2.one_hit_kills,
            i2.money_invested,
            i2.invested_profit,
            i2.attack_misses,
            i2.attack_damage,
            i2.attack_hits
           FROM player_info_updates i2
          WHERE (i2.player_id = p.id)
          ORDER BY i2."timestamp" DESC
         LIMIT 1) i ON (true));


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    api_key character varying,
    faction_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    requests_available integer
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY attacks ALTER COLUMN id SET DEFAULT nextval('attacks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY battle_stats_updates ALTER COLUMN id SET DEFAULT nextval('battle_stats_updates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY factions ALTER COLUMN id SET DEFAULT nextval('factions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY player_info_updates ALTER COLUMN id SET DEFAULT nextval('player_info_updates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY players ALTER COLUMN id SET DEFAULT nextval('players_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: attacks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY attacks
    ADD CONSTRAINT attacks_pkey PRIMARY KEY (id);


--
-- Name: battle_stats_updates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY battle_stats_updates
    ADD CONSTRAINT battle_stats_updates_pkey PRIMARY KEY (id);


--
-- Name: factions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY factions
    ADD CONSTRAINT factions_pkey PRIMARY KEY (id);


--
-- Name: player_info_updates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY player_info_updates
    ADD CONSTRAINT player_info_updates_pkey PRIMARY KEY (id);


--
-- Name: players_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_attacks_on_attacker_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attacks_on_attacker_id ON attacks USING btree (attacker_id);


--
-- Name: index_attacks_on_defender_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attacks_on_defender_id ON attacks USING btree (defender_id);


--
-- Name: index_attacks_on_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attacks_on_timestamp ON attacks USING btree ("timestamp");


--
-- Name: index_attacks_on_torn_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_attacks_on_torn_id ON attacks USING btree (torn_id);


--
-- Name: index_battle_stats_updates_on_player_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_battle_stats_updates_on_player_id ON battle_stats_updates USING btree (player_id);


--
-- Name: index_battle_stats_updates_on_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_battle_stats_updates_on_timestamp ON battle_stats_updates USING btree ("timestamp");


--
-- Name: index_factions_on_torn_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_factions_on_torn_id ON factions USING btree (torn_id);


--
-- Name: index_player_info_updates_on_player_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_player_info_updates_on_player_id ON player_info_updates USING btree (player_id);


--
-- Name: index_player_info_updates_on_spouse_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_player_info_updates_on_spouse_id ON player_info_updates USING btree (spouse_id);


--
-- Name: index_player_info_updates_on_timestamp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_player_info_updates_on_timestamp ON player_info_updates USING btree ("timestamp");


--
-- Name: index_players_on_faction_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_players_on_faction_id ON players USING btree (faction_id);


--
-- Name: index_players_on_torn_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_players_on_torn_id ON players USING btree (torn_id);


--
-- Name: index_players_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_players_on_user_id ON players USING btree (user_id);


--
-- Name: index_users_on_api_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_api_key ON users USING btree (api_key);


--
-- Name: index_users_on_faction_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_faction_id ON users USING btree (faction_id);


--
-- Name: fk_rails_224cac07ce; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY players
    ADD CONSTRAINT fk_rails_224cac07ce FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_5acdb7adce; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT fk_rails_5acdb7adce FOREIGN KEY (faction_id) REFERENCES factions(id);


--
-- Name: fk_rails_78a58eeca7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY players
    ADD CONSTRAINT fk_rails_78a58eeca7 FOREIGN KEY (faction_id) REFERENCES factions(id);


--
-- Name: fk_rails_98ec90459f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY attacks
    ADD CONSTRAINT fk_rails_98ec90459f FOREIGN KEY (attacker_id) REFERENCES players(id);


--
-- Name: fk_rails_a8a20a8cf1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY battle_stats_updates
    ADD CONSTRAINT fk_rails_a8a20a8cf1 FOREIGN KEY (player_id) REFERENCES players(id);


--
-- Name: fk_rails_bf696e2d47; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY player_info_updates
    ADD CONSTRAINT fk_rails_bf696e2d47 FOREIGN KEY (spouse_id) REFERENCES players(id);


--
-- Name: fk_rails_d1dc290423; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY player_info_updates
    ADD CONSTRAINT fk_rails_d1dc290423 FOREIGN KEY (player_id) REFERENCES players(id);


--
-- Name: fk_rails_e175c01b27; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY attacks
    ADD CONSTRAINT fk_rails_e175c01b27 FOREIGN KEY (defender_id) REFERENCES players(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20170107214937'),
('20170107214959'),
('20170107215012'),
('20170107215240'),
('20170107221214'),
('20170107221439'),
('20170107231325'),
('20170107232000'),
('20170107233230'),
('20170108183952'),
('20170113031704'),
('20170113031841'),
('20170123182202'),
('20170220192212'),
('20170220192311'),
('20170220215406'),
('20170220220717'),
('20170220221158'),
('20170226193058'),
('20170226212340'),
('20170227030812'),
('20170306173312'),
('20170306181547'),
('20170306184948'),
('20170307044317'),
('20170307063902'),
('20170310155026'),
('20170315152118'),
('20170315152623'),
('20170315152949'),
('20170315153159'),
('20170326172356'),
('20170422122932'),
('20170422154116'),
('20170422172932'),
('20170422181301'),
('20170422181932'),
('20170626051038'),
('20171005165029');


