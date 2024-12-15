INSERT INTO secfilter (action, type, data) values(0, 0, 'friendly-scanner');
INSERT INTO secfilter (action, type, data) values(0, 0, 'sipvicious');
INSERT INTO secfilter (action, type, data) values(0, 0, 'pplsip');
INSERT INTO secfilter (action, type, data) values(0, 3, '1.1.1.1');

INSERT INTO domain (domain, last_modified) values('xpto.com', now());

INSERT INTO subscriber (username, domain, password) values('1234', 'xpto.com', 'ola');

INSERT INTO dispatcher (setid, destination, description) values(1, 'sip:172.25.0.3:5060', 'Edge Proxy A');

INSERT INTO dispatcher (setid, destination, description) values(2, 'sip:172.25.0.4:5060', 'Registrar Server A');

INSERT INTO dispatcher (setid, destination, description) values(2, 'sip:172.25.0.5:5060', 'Registrar Server B');

INSERT INTO dispatcher (setid, destination, description) values(2, 'sip:172.25.0.6:5060', 'Registrar Server C');

INSERT INTO dispatcher (setid, destination, description) values(3, 'sip:172.25.0.10:5070', 'Sems Server');

INSERT INTO htable (key_name, "key_type", value_type, key_value, expires) VALUES('carrier_outbound_dispatch_by_matching_ruri', 0, 1, 1, 0);