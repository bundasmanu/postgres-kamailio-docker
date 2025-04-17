CREATE TABLE IF NOT EXISTS ht_carrier_dids (
    id          SERIAL PRIMARY KEY      NOT NULL,
    key_name    VARCHAR(128) DEFAULT '' NOT NULL,
    key_type    INTEGER DEFAULT 0       NOT NULL,
    value_type  INTEGER DEFAULT 0       NOT NULL,
    key_value   VARCHAR(128) DEFAULT '' NOT NULL,
    expires     INTEGER DEFAULT 0       NOT NULL,
    description VARCHAR(256)
);

INSERT INTO ht_carrier_dids (key_name, "key_type", value_type, key_value, expires) VALUES('external:111111111', 0, 0, 'id=1;name=provider;ips=172.25.0.10|172.25.0.11', 0);
INSERT INTO ht_carrier_dids (key_name, "key_type", value_type, key_value, expires) VALUES('internal:111111111', 0, 0, 'id=2;name=internal;ips=172.25.0.12|172.25.0.13', 0);
