--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

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
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: attacks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
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
    "timestamp" timestamp without time zone
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
-- Name: battle_stats_updates; Type: TABLE; Schema: public; Owner: -; Tablespace: 
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
-- Name: factions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
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
-- Name: player_info_updates; Type: TABLE; Schema: public; Owner: -; Tablespace: 
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
-- Name: players; Type: TABLE; Schema: public; Owner: -; Tablespace: 
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
 SELECT players.torn_id,
    players.id AS player_id,
    players.least_stats_beaten_by,
    players.most_stats_defended_against,
    info.xanax_taken,
    info.refills,
    info.stat_enhancers_used
   FROM (players
     LEFT JOIN ( SELECT DISTINCT ON (player_info_updates.player_id) player_info_updates.id,
            player_info_updates."timestamp",
            player_info_updates.level,
            player_info_updates.last_action,
            player_info_updates.player_id,
            player_info_updates.awards,
            player_info_updates.friends,
            player_info_updates.enemies,
            player_info_updates.karma,
            player_info_updates.forum_posts,
            player_info_updates.role,
            player_info_updates.donator,
            player_info_updates.max_life,
            player_info_updates.company_id,
            player_info_updates."position",
            player_info_updates.spouse_id,
            player_info_updates.logins,
            player_info_updates.activity,
            player_info_updates.attacks_won,
            player_info_updates.attacks_draw,
            player_info_updates.attacks_lost,
            player_info_updates.highest_beaten,
            player_info_updates.best_kill_streak,
            player_info_updates.defends_lost,
            player_info_updates.defends_won,
            player_info_updates.defends_draw,
            player_info_updates.xanax_taken,
            player_info_updates.ecstasy_taken,
            player_info_updates.times_traveled,
            player_info_updates.networth,
            player_info_updates.refills,
            player_info_updates.stat_enhancers_used,
            player_info_updates.medical_items_used,
            player_info_updates.weapons_bought,
            player_info_updates.bazaar_customers,
            player_info_updates.bazaar_sales,
            player_info_updates.bazaar_profit,
            player_info_updates.points_bought,
            player_info_updates.points_sold,
            player_info_updates.items_bought_abroad,
            player_info_updates.items_bought,
            player_info_updates.trades,
            player_info_updates.items_sent,
            player_info_updates.auctions_won,
            player_info_updates.auctions_sold,
            player_info_updates.money_mugged,
            player_info_updates.attacks_stealthed,
            player_info_updates.critical_hits,
            player_info_updates.respect,
            player_info_updates.rounds_fired,
            player_info_updates.attacks_ran_away,
            player_info_updates.defends_ran_away,
            player_info_updates.people_busted,
            player_info_updates.failed_busts,
            player_info_updates.bails_bought,
            player_info_updates.bails_spent,
            player_info_updates.viruses_coded,
            player_info_updates.city_finds,
            player_info_updates.bounties_placed,
            player_info_updates.bounties_received,
            player_info_updates.bounties_collected,
            player_info_updates.bounty_rewards,
            player_info_updates.bounties_spent,
            player_info_updates.revives,
            player_info_updates.revives_received,
            player_info_updates.trains_received,
            player_info_updates.drugs_taken,
            player_info_updates.overdoses,
            player_info_updates.merits_bought,
            player_info_updates.personals_placed,
            player_info_updates.classifieds_placed,
            player_info_updates.mail_sent,
            player_info_updates.friend_mail_sent,
            player_info_updates.faction_mail_sent,
            player_info_updates.company_mail_sent,
            player_info_updates.spouse_mail_sent,
            player_info_updates.largest_mug,
            player_info_updates.canabis_taken,
            player_info_updates.ketamine_taken,
            player_info_updates.lsd_taken,
            player_info_updates.opium_taken,
            player_info_updates.shrooms_taken,
            player_info_updates.speed_taken,
            player_info_updates.pcp_taken,
            player_info_updates.vicodin_taken,
            player_info_updates.mechanical_hits,
            player_info_updates.artillery_hits,
            player_info_updates.clubbed_hits,
            player_info_updates.temp_hits,
            player_info_updates.machine_gun_hits,
            player_info_updates.pistol_hits,
            player_info_updates.rifle_hits,
            player_info_updates.shotgun_hits,
            player_info_updates.smg_hits,
            player_info_updates.piercing_hits,
            player_info_updates.slashing_hits,
            player_info_updates.argentina_travel,
            player_info_updates.mexico_travel,
            player_info_updates.dubai_travel,
            player_info_updates.hawaii_travel,
            player_info_updates.japan_travel,
            player_info_updates.london_travel,
            player_info_updates.south_africa_travel,
            player_info_updates.switzerland_travel,
            player_info_updates.china_travel,
            player_info_updates.canada_travel,
            player_info_updates.caymans_travel,
            player_info_updates.dump_finds,
            player_info_updates.dump_searches,
            player_info_updates.items_dumped,
            player_info_updates.days_as_donator,
            player_info_updates.times_jailed,
            player_info_updates.times_hospitalized,
            player_info_updates.attacks_assisted,
            player_info_updates.blood_withdrawn,
            player_info_updates.mission_credits,
            player_info_updates.contracts_completed,
            player_info_updates.duke_contracts_completed,
            player_info_updates.missions_completed,
            player_info_updates.name,
            player_info_updates.medical_items_stolen,
            player_info_updates.spies_done,
            player_info_updates.best_damage,
            player_info_updates.kill_streak,
            player_info_updates.one_hit_kills,
            player_info_updates.money_invested,
            player_info_updates.invested_profit,
            player_info_updates.attack_misses,
            player_info_updates.attack_damage,
            player_info_updates.attack_hits
           FROM player_info_updates
          ORDER BY player_info_updates.player_id, player_info_updates."timestamp" DESC) info ON ((players.id = info.player_id)));


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
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
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: attacks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attacks
    ADD CONSTRAINT attacks_pkey PRIMARY KEY (id);


--
-- Name: battle_stats_updates_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY battle_stats_updates
    ADD CONSTRAINT battle_stats_updates_pkey PRIMARY KEY (id);


--
-- Name: factions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY factions
    ADD CONSTRAINT factions_pkey PRIMARY KEY (id);


--
-- Name: player_info_updates_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY player_info_updates
    ADD CONSTRAINT player_info_updates_pkey PRIMARY KEY (id);


--
-- Name: players_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_attacks_on_attacker_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_attacks_on_attacker_id ON attacks USING btree (attacker_id);


--
-- Name: index_attacks_on_defender_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_attacks_on_defender_id ON attacks USING btree (defender_id);


--
-- Name: index_attacks_on_timestamp; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_attacks_on_timestamp ON attacks USING btree ("timestamp");


--
-- Name: index_attacks_on_torn_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_attacks_on_torn_id ON attacks USING btree (torn_id);


--
-- Name: index_battle_stats_updates_on_player_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_battle_stats_updates_on_player_id ON battle_stats_updates USING btree (player_id);


--
-- Name: index_battle_stats_updates_on_timestamp; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_battle_stats_updates_on_timestamp ON battle_stats_updates USING btree ("timestamp");


--
-- Name: index_factions_on_torn_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_factions_on_torn_id ON factions USING btree (torn_id);


--
-- Name: index_player_info_updates_on_player_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_player_info_updates_on_player_id ON player_info_updates USING btree (player_id);


--
-- Name: index_player_info_updates_on_spouse_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_player_info_updates_on_spouse_id ON player_info_updates USING btree (spouse_id);


--
-- Name: index_player_info_updates_on_timestamp; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_player_info_updates_on_timestamp ON player_info_updates USING btree ("timestamp");


--
-- Name: index_players_on_faction_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_players_on_faction_id ON players USING btree (faction_id);


--
-- Name: index_players_on_torn_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_players_on_torn_id ON players USING btree (torn_id);


--
-- Name: index_players_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_players_on_user_id ON players USING btree (user_id);


--
-- Name: index_users_on_api_key; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_api_key ON users USING btree (api_key);


--
-- Name: index_users_on_faction_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
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

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES
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
('20170422181932');


