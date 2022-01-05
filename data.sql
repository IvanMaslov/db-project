insert into citizen (id, name, passport)
values (1, 'J Norton', 'PASSPORT_000001'),
       (2, 'J Alex', 'PASSPORT_000002'),
       (3, 'J Will', 'PASSPORT_000003'),

       (11, 'P MAJOR Gromov', 'PASSPORT_000011'),
       (12, 'P MAJOR Sherlok Holmes', 'PASSPORT_000012'),
       (13, 'P CAPTAIN Watson', 'PASSPORT_000013'),
       (14, 'P COLONEL Sanders', 'PASSPORT_000014'),

       (21, 'L Devil Advocate ', 'PASSPORT_000021'),
       (22, 'L Wilfrid Robarts', 'PASSPORT_000022'),
       (23, 'L SOUL Goodman', 'PASSPORT_000023'),

       (101, 'G Ivan', 'PASSPORT_000101'),
       (102, 'G Illarion', 'PASSPORT_000102'),
       (103, 'G Victor', 'PASSPORT_000103'),
       (104, 'G Alex', 'PASSPORT_000104'),
       (105, 'G Sasha', 'PASSPORT_000105'),

       (151, 'B Zloy Mambet', 'PASSPORT_000151'),
       (152, 'B Zloy Danil', 'PASSPORT_000152'),
       (153, 'B Zloy Pahan', 'PASSPORT_000153'),
       (154, 'B Zloy Hitler', 'PASSPORT_000154'),
       (155, 'B Zloy Killer', 'PASSPORT_000155');

insert into act (id, num, accepted, content)
values (1, 105, TIMESTAMP '1990-01-01 00:00:00', 'Killing'),
       (2, 228, TIMESTAMP '1990-01-01 00:00:00', 'Drugs'),
       (3, 300, TIMESTAMP '1990-01-01 00:00:00', 'Fraud');

insert
into judge (id, class, citizenId)
values (1, 0, 1),
       (2, 0, 2),
       (3, 1, 3);

-- CAPTAIN - 12
-- MAJOR - 13
-- COLONEL - 15
insert into prosecutor(id, rnk, citizenId)
values (1, 13, 11),
       (2, 13, 12),
       (3, 12, 13),
       (4, 15, 14);

insert into lawyer(id, citizenId)
values (1, 21),
       (2, 22),
       (3, 23);

insert into application (id, created, applicantCitizen, applicantProsecutor, content)
values (1, now(), 101, 1, 'someone beat me'),
       (2, now(), 102, 1, 'someone smoking'),
       (3, now(), 103, 2, 'someone smoking');

insert into resolution(id, created, applicationId, blameAct, blameCitizen, blameJudge, isGuilty)
values (1, now(), 1, 1, 151, 1, true),
       (2, now(), 2, 2, 152, 2, true),
       (3, now(), 3, 2, 153, 3, false);