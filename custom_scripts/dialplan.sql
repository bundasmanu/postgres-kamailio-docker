
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'sip_route') THEN
        CREATE TYPE sip_route AS ENUM ('auth', 'internal', 'dialog', 'location', 'inbound', 'outbound', 'loopback');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'sip_method') THEN
        CREATE TYPE sip_method AS ENUM ('INVITE','ACK', 'BYE', 'CANCEL', 'OPTIONS', 'REGISTER', 'PRACK', 'SUBSCRIBE', 'NOTIFY', 'PUBLISH', 'INFO', 'REFER', 'MESSAGE', 'UPDATE');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'sip_req_type') THEN
        CREATE TYPE sip_req_type AS ENUM ('request', 'reply');
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'sip_cond_key') THEN
        CREATE TYPE sip_cond_key AS ENUM ('domain', 'user', 'gateway', 'req-uri', 'from-uri', 'to-uri', 'source-ip');
    END IF;
END$$;


CREATE TABLE IF NOT EXISTS dialplan (
    id          SERIAL PRIMARY KEY NOT NULL,
    dpid        INTEGER            NOT NULL,
    pr          INTEGER            NOT NULL,
    match_op    INTEGER            NOT NULL,
    match_exp   VARCHAR(512)        NOT NULL,
    match_len   INTEGER            NOT NULL,
    subst_exp   VARCHAR(512)        NOT NULL,
    repl_exp    VARCHAR(512)        NOT NULL,
    attrs       VARCHAR(512)        NOT NULL,
    name        CITEXT,
    description CITEXT
);

CREATE TABLE IF NOT EXISTS dialplan_rules (
    uuid uuid NOT NULL,
    route sip_route NOT NULL,
    request_type sip_req_type,
    methods sip_method[],
    condition_key sip_cond_key NOT NULL,
    condition_value text NOT NULL,
    rules text[] NOT NULL,
    enabled boolean
);

/* views */

CREATE OR REPLACE VIEW ht_dialplans AS
    SELECT concat_ws(':', route, NULLIF(request_type, 'request'), condition_key, condition_value)::varchar as key_name,
    CASE WHEN methods IS NULL THEN array_to_string(rules,';')
    ELSE 'method=' || array_to_string(methods,'|') || ';' || array_to_string(rules,';') END::varchar as key_value,
        0::integer as value_type,
        0::integer as key_type
    FROM dialplan_rules where enabled is not false;


INSERT INTO version (table_name, table_version) VALUES ('dialplan', '2');
