ALTER TABLE subscriber ADD COLUMN uri VARCHAR(128) GENERATED ALWAYS AS (username || '@' || domain) STORED;

INSERT INTO subscriber (username, domain, password) values('1234', 'xpto.com', 'ola');
