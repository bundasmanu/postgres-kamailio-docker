
INSERT INTO rtpengine (setid, url, weight, disabled, stamp) values(1, 'udp:172.25.0.30:2223', 2, 0, now());

INSERT INTO rtpengine (setid, url, weight, disabled, stamp) values(1, 'udp:172.25.0.31:2223', 1, 0, now());

CREATE TABLE IF NOT EXISTS ht_rtp_profiles (
    id SERIAL PRIMARY KEY NOT NULL,
    key_name VARCHAR(64) DEFAULT '' NOT NULL,
    key_type INTEGER DEFAULT 0 NOT NULL,
    value_type INTEGER DEFAULT 0 NOT NULL,
    key_value VARCHAR(256) DEFAULT '' NOT NULL,
    expires INTEGER DEFAULT 0 NOT NULL
);

INSERT INTO ht_rtp_profiles (key_name, key_value) values('1', 'internal=public-internal;external=public-external');
