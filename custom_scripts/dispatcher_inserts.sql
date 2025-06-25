
INSERT INTO dispatcher (setid, destination, flags, priority, attrs, description) values(1, 'sip:172.25.0.10:5060', 0, 0, 'type=external', 'Provider A'); -- for Asterisk use 172.25.0.20

INSERT INTO dispatcher (setid, destination, flags, priority, attrs, description) values(1, 'sip:172.25.0.11:5060', 0, 0, 'type=external', 'Provider B');

INSERT INTO dispatcher (setid, destination, flags, priority, attrs, description) values(2, 'sip:172.25.0.12:5060', 0, 0, 'type=internal', 'Internal A');

INSERT INTO dispatcher (setid, destination, flags, priority, attrs, description) values(2, 'sip:172.25.0.13:5060', 0, 0, 'type=internal', 'Internal B');
