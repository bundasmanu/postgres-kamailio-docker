CREATE TABLE IF NOT EXISTS ht_params (
    id          SERIAL PRIMARY KEY      NOT NULL,
    key_name    VARCHAR(128) DEFAULT '' NOT NULL,
    key_type    INTEGER DEFAULT 0       NOT NULL,
    value_type  INTEGER DEFAULT 0       NOT NULL,
    key_value   VARCHAR(128) DEFAULT '' NOT NULL,
    expires     INTEGER DEFAULT 0       NOT NULL,
    description VARCHAR(256)
);

INSERT INTO ht_params (key_name, "key_type", value_type, key_value, expires) VALUES('carrier_outbound_dispatch_by_matching_ruri', 0, 1, 1, 0);
