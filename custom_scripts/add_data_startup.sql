INSERT INTO domain (domain, last_modified) values('xpto.com', now());

INSERT INTO subscriber (username, domain, password) values('1234', 'xpto.com', 'ola');

INSERT INTO dispatcher (setid, destination, description) values(1, 'sip:172.25.0.3:5060', 'Edge Proxy A');

INSERT INTO dispatcher (setid, destination, description) values(2, 'sip:172.25.0.4:5060', 'Registrar Server A');

INSERT INTO dispatcher (setid, destination, description) values(2, 'sip:172.25.0.5:5060', 'Registrar Server B');