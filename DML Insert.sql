USE [Farms];
GO

INSERT INTO [Owner](cvr, firstname, lastname, streetname, no, postcode, city, email)
VALUES(48360791, 'Jake', 'Dowdy', 'Melm Street', 3591, 28531, 'Harkers Island', 'JakeAD@farms.com');

INSERT INTO [OwnerPhone](phone, cvr)
VALUES ('28746972', 48360791);

INSERT INTO [Farm](pnumber, name, streetname, no, postcode, city, cvr)
VALUES (5794387015, 'Mill Farm', 'Hamilton Drive', 937, 21244, 'Windsor Mill', 48360791);

INSERT INTO [FarmChrNo](chrno, pnumber)
VALUES (44441, 5794387015);

INSERT INTO [Stall](no, pnumber)
VALUES (01, 5794387015);

INSERT INTO [Box](type, outdoor, no, stall_no, pnumber)
VALUES ('Pig', 0, 01, 01, 5794387015);

INSERT INTO [Animal](chrno, color, id, sex, type, birth, death, produce_chrno, produce_color, produce_id)
VALUES (44441, 'Yellow', 001, 1, 'Pig', '20200101', NULL, NULL, NULL, NULL);

INSERT INTO [Animal](chrno, color, id, sex, type, birth, death, produce_chrno, produce_color, produce_id)
VALUES (44441, 'Yellow', 002, 0, 'Pig', '20200101', NULL, NULL, NULL, NULL);

INSERT INTO [Animal](chrno, color, id, sex, type, birth, death, produce_chrno, produce_color, produce_id)
VALUES (44441, 'Yellow', 003, 1, 'Pig', '20201019', NULL, 44441, 'Yellow', 001);

INSERT INTO [Animal](chrno, color, id, sex, type, birth, death, produce_chrno, produce_color, produce_id)
VALUES (44441, 'Yellow', 004, 0, 'Pig', '20201019', '20201023', 44441, 'Yellow', 001);

INSERT INTO [LivesIn](moveintime, moveouttime, box_No, stall_no, pnumber, chrno, color, id)
VALUES ('20200102', NULL, 01, 01, 5794387015, 44441, 'Yellow', 001);

INSERT INTO [LivesIn](moveintime, moveouttime, box_no, stall_no, pnumber, chrno, color, id)
VALUES ('20200102', NULL, 01, 01, 5794387015, 44441, 'Yellow', 002);

INSERT INTO [LivesIn](moveintime, moveouttime, box_no, stall_no, pnumber, chrno, color, id)
VALUES ('20201020', NULL, 01, 01, 5794387015, 44441, 'Yellow', 003);

INSERT INTO [LivesIn](moveintime, moveouttime, box_no, stall_no, pnumber, chrno, color, id)
VALUES ('20201020', '20201023', 01, 01, 5794387015, 44441, 'Yellow', 004);

INSERT INTO [SmartUnit](type, serialnumber, ipaddress, macaddress)
VALUES ('Temperature', 149537, '172.16.2.12', '3e:60:54:90:5c:4e');

INSERT INTO [StallMonitor](stall_no, pnumber, serialnumber)
VALUES (001, 5794387015, 149537);

INSERT INTO [BoxMonitor](value, time, box_no, stall_no, pnumber, serialnumber)
VALUES (24, '20201113 04:34:09 PM', 01, 01, 5794387015, 149537);

INSERT INTO [State](severity, id)
VALUES (1, 1);
INSERT INTO [State](severity, id)
VALUES (2, 2);
INSERT INTO [State](severity, id)
VALUES (3, 3);
INSERT INTO [State](severity, id)
VALUES (4, 4);
INSERT INTO [State](severity, id)
VALUES (5, 5);

INSERT INTO [Changes](time, serialnumber, state_id)
VALUES (CONVERT(DATETIME, '20201113 04:34:09 PM'), 149537, 5);
