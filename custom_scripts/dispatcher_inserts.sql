
-- INSERT INTO dispatcher (setid, destination, flags, priority, attrs, description) values(1, 'sip:172.25.0.10:5060', 0, 0, 'type=external', 'Provider A'); -- for Asterisk use 172.25.0.20

-- INSERT INTO dispatcher (setid, destination, flags, priority, attrs, description) values(1, 'sip:172.25.0.11:5060', 0, 0, 'type=external', 'Provider B');

-- INSERT INTO dispatcher (setid, destination, flags, priority, attrs, description) values(2, 'sip:172.25.0.12:5060', 0, 0, 'type=internal', 'Internal A');

-- INSERT INTO dispatcher (setid, destination, flags, priority, attrs, description) values(2, 'sip:172.25.0.13:5060', 0, 0, 'type=internal', 'Internal B');

INSERT INTO dispatcher (setid, destination, flags, priority, attrs, description) values(1, 'sip:registrar-server.kamailio.svc.cluster.local:5060', 0, 0, 'sockname=lan-internal;view=webrtc_gateway', 'Registrar Server Pool');
INSERT INTO dispatcher (setid, destination, flags, priority, attrs, description) values(2, 'sip:kamailio-core.kamailio.svc.cluster.local:5060', 0, 0, 'sockname=lan-internal;view=webrtc_gateway,b2bua', 'Kamailio Core Pool');
INSERT INTO dispatcher (setid, destination, flags, priority, attrs, description) values(3, 'sip:webrtc-gateway.kamailio.svc.cluster.local:5060', 0, 0, 'sockname=lan-internal;view=registrar,core', 'WebRTC Gateway Pool');
INSERT INTO dispatcher (setid, destination, flags, priority, attrs, description) values(4, 'sip:b2bua.b2bua.svc.cluster.local:5060', 0, 0, 'sockname=lan-internal;view=core', 'B2BUA Pool');

CREATE OR REPLACE VIEW dispatcher_registrar AS
SELECT *
FROM dispatcher
WHERE attrs ~ '(^|;)view=[^;]*\mregistrar\M';


CREATE OR REPLACE  VIEW dispatcher_core AS
SELECT *
FROM dispatcher
WHERE attrs ~ '(^|;)view=[^;]*\mcore\M';

CREATE OR REPLACE  VIEW dispatcher_webrtc_gateway AS
SELECT *
FROM dispatcher
WHERE attrs ~ '(^|;)view=[^;]*\mwebrtc_gateway\M';

INSERT INTO version (table_name, table_version) values ('dispatcher_registrar','4');
INSERT INTO version (table_name, table_version) values ('dispatcher_core','4');
INSERT INTO version (table_name, table_version) values ('dispatcher_webrtc_gateway','4');
