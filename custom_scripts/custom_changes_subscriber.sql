ALTER TABLE subscriber ADD COLUMN uri VARCHAR(128) GENERATED ALWAYS AS (username || '@' || domain) STORED;

