-- create database RussianJudgementArchive;


create table citizen
(
    citizenId int primary key,
    name      varchar(50) not null,
    passport  char(20)    not null,
    check ( passport regexp '^[a-zA-Z0-9\_]{5,20}$' )
);


create table act
(
    actId    int primary key,
    num      int       not null,
    accepted timestamp not null,
    content  text
);


create table judge
(
    judgeId   int primary key,
    class     int not null,
    citizenId int not null references citizen (citizenId)
);

create table lawyer
(
    lawyerId  int primary key,
    citizenId int not null references citizen (citizenId)
);


create table prosecutor
(
    prosecutorId int primary key,
    rnk          int not null,
    citizenId    int not null references citizen (citizenId)
);


create table application
(
    applicationId int primary key,
    created       timestamp not null,
    askCitizenId  int       not null references citizen (citizenId),
    prosecutorId  int       not null references prosecutor (prosecutorId),
    content       text
);


create table resolution
(
    resolutionId   int primary key,
    created        timestamp not null,
    applicationId  int       not null references application (applicationId),
    judgeId        int       not null references judge (judgeId),
    lawyerId       int       not null references lawyer (lawyerId),
    blameCitizenId int       not null references citizen (citizenId),
    actId          int       not null references act (actId),
    isGuilty       bool      not null,
    content        text
);

-- сортировка по классу судей
-- example: select * from resolution natural join judge where class >= 1 and isGuilty = true
create index judgeClasses using btree on judge (class);

-- сортировка по званию прокурора
-- example: select * from resolution natural join prosecutor where rnk >= 15 and isGuilty = true
create index prosecutorRanks using btree on prosecutor (rnk);

-- получение нужных статей
create index actNum using hash on act (num);

-- сортировка временных данных для законов
create index actTime using btree on act (accepted);

-- сортировка временных данных для заявлений
create index applicationTime using btree on application (created);

-- сортировка временных данных для решений
create index resolutionTime using btree on resolution (created);

create view court as
select resolutionId,
       applicationId,
       created as resolutionCreated,
       applicationCreated,
       askCitizenId,
       blameCitizenId,
       prosecutorId,
       lawyerId,
       judgeId,
       actId,
       isGuilty
from resolution r
         natural join (select applicationId, created as applicationCreated, askCitizenId, prosecutorId
                       from application) a;

delimiter //
-- заявление до решения
create trigger consistentDates
    before insert
    on resolution
    for each row
begin
    if (select created from application a where a.applicationId = NEW.applicationId) > NEW.created then
        signal sqlstate '10001' set message_text =
                'Inconsistent times of applicationCreated and resolutionCreated';
    end if;
end //

-- закон обратной силы не имеет
create trigger doNotReversLaw
    before insert
    on resolution
    for each row
begin
    if (select created from application a where a.applicationId = NEW.applicationId) <
       (select accepted from act a2 where a2.actId = NEW.actId)
    then
        signal sqlstate '10002' set message_text =
                'Inconsistent resolution on act not active then application created';
    end if;
end //


-- судья не король, сам себя судить не может
create trigger prohibitedSelfJudge
    before insert
    on resolution
    for each row
begin
    if (select citizenId from judge j where j.judgeId = NEW.judgeId) = NEW.blameCitizenId
    then
        signal sqlstate '10003' set message_text =
                'Inconsistent resolution judge self judges';
    end if;
end //


-- в судебной системе человек может занимать только один пост
create procedure checkPerson($citizenId INT)
    contains sql reads sql data
begin
    declare isProsecutor bool default exists(select * from prosecutor where citizenId = $citizenId);
    declare isLawyer bool default exists(select * from lawyer where citizenId = $citizenId);
    declare isJudge bool default exists(select * from judge where citizenId = $citizenId);
    if isProsecutor or isLawyer or isJudge
    then
        signal sqlstate '10004' set message_text =
                'Inconsistent state one person multi roles';
    end if;
end //

create trigger prohibitedMultiJudge
    before insert
    on judge
    for each row
begin
    call checkPerson(NEW.citizenId);
end //

create trigger prohibitedMultiLawyer
    before insert
    on lawyer
    for each row
begin
    call checkPerson(NEW.citizenId);
end //

create trigger prohibitedMultiProsecutor
    before insert
    on prosecutor
    for each row
begin
    call checkPerson(NEW.citizenId);
end //