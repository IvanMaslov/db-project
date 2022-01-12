insert into citizen (citizenId, name, passport)
values (1, 'J Norton', 'PASSPORT_000001'),
       (2, 'J Alex', 'PASSPORT_000002'),
       (3, 'J Will', 'PASSPORT_000003'),

       (11, 'P MAJOR Gromov', 'PASSPORT_000011'),
       (12, 'P MAJOR Sherlok Holmes', 'PASSPORT_000012'),
       (13, 'P CAPTAIN Watson', 'PASSPORT_000013'),
       (14, 'P COLONEL Sanders', 'PASSPORT_000014'),

       (21, 'L Devil Advocate ', 'PASSPORT_000021'),
       (22, 'L Wilfrid Robarts', 'PASSPORT_000022'),
       (23, 'L Soul Goodman', 'PASSPORT_000023'),

       (101, 'G Ivan', 'PASSPORT_000101'),
       (102, 'G Georgiy', 'PASSPORT_000102'),
       (103, 'G Victor', 'PASSPORT_000103'),
       (104, 'G Alex', 'PASSPORT_000104'),
       (105, 'G Sasha', 'PASSPORT_000105'),

       (151, 'B Adolf Hitler', 'PASSPORT_000151'),
       (152, 'B Andrey Chikatilo', 'PASSPORT_000152'),
       (153, 'B Bill Buffalo', 'PASSPORT_000153'),
       (154, 'B Jack Ripper', 'PASSPORT_000154'),
       (155, 'B Zodiac', 'PASSPORT_000155');

insert into act (actId, num, accepted, content)
values (105, 105, TIMESTAMP '1990-01-01 00:00:00', 'Killing'),
       (159, 159, TIMESTAMP '1990-01-02 00:00:00', 'Fraud'),
       (228, 228, TIMESTAMP '1990-01-03 00:00:00', 'Drugs');

insert
into judge (judgeId, class, citizenId)
values (1, 0, 1),
       (2, 0, 2),
       (3, 1, 3);

-- CAPTAIN - 12
-- MAJOR - 13
-- COLONEL - 15
insert into prosecutor(prosecutorId, rnk, citizenId)
values (11, 13, 11),
       (12, 13, 12),
       (13, 12, 13),
       (14, 15, 14);

insert into lawyer(lawyerId, citizenId)
values (21, 21),
       (22, 22),
       (23, 23);

insert into application (applicationId, created, askCitizenId, prosecutorId, content)
values (1001, TIMESTAMP '2020-01-01 00:00:00', 101, 11, 'beat'),
       (1002, TIMESTAMP '2020-01-02 00:00:00', 102, 11, 'smoke'),
       (1003, TIMESTAMP '2020-01-03 00:00:00', 102, 11, 'smoke'),
       (1004, TIMESTAMP '2020-01-04 00:00:00', 103, 11, 'smoke'),
       (1005, TIMESTAMP '2020-01-05 00:00:00', 104, 11, 'smoke'),
       (1006, TIMESTAMP '2020-01-06 00:00:00', 105, 13, 'steal'),
       (1007, TIMESTAMP '2020-01-07 00:00:00', 104, 13, 'genocid'),
       (1008, TIMESTAMP '2020-01-08 00:00:00', 103, 13, 'genocid'),
       (1009, TIMESTAMP '2020-01-09 00:00:00', 104, 13, 'steal'),
       (1100, TIMESTAMP '2020-01-10 00:00:00', 103, 12, 'smoke');

insert into resolution(resolutionId, created, applicationId, actId, blameCitizenId, lawyerId, judgeId, isGuilty)
values (2001, TIMESTAMP '2020-02-01 00:00:00', 1001, 105, 151, 21, 1, true),
       (2002, TIMESTAMP '2020-02-02 00:00:00', 1002, 228, 152, 22, 2, true),
       (2003, TIMESTAMP '2020-02-03 00:00:00', 1003, 228, 153, 23, 3, false),
       (2004, TIMESTAMP '2020-02-04 00:00:00', 1004, 228, 153, 23, 3, false),
       (2005, TIMESTAMP '2020-02-05 00:00:00', 1005, 228, 153, 23, 3, false),
       (2006, TIMESTAMP '2020-02-06 00:00:00', 1006, 228, 154, 22, 2, false),
       (2007, TIMESTAMP '2020-02-07 00:00:00', 1007, 105, 151, 21, 1, true),
       (2008, TIMESTAMP '2020-02-08 00:00:00', 1008, 105, 151, 21, 1, true),
       (2009, TIMESTAMP '2020-02-09 00:00:00', 1009, 159, 152, 21, 1, true),
       (2100, TIMESTAMP '2020-02-10 11:11:11', 1100, 228, 153, 23, 3, true);
