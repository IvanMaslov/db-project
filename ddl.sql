-- create database RussianJudgementArchive;


create table citizen
(
    citizenId int primary key,
    name      varchar(50) not null,
    passport  char(20)    not null
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
    citizenId int not null,
    foreign key (citizenId) references citizen (citizenId)
);

create table lawyer
(
    lawyerId  int primary key,
    citizenId int not null,
    foreign key (citizenId) references citizen (citizenId)
);


create table prosecutor
(
    prosecutorId int primary key,
    rnk          int not null,
    citizenId    int not null,
    foreign key (citizenId) references citizen (citizenId)
);


create table application
(
    applicationId int primary key,
    created       timestamp not null,
    askCitizenId  int       not null,
    prosecutorId  int       not null,
    content       text,
    foreign key (askCitizenId) references citizen (citizenId),
    foreign key (prosecutorId) references prosecutor (prosecutorId)
);


create table resolution
(
    resolutionId   int primary key,
    created        timestamp not null,
    applicationId  int       not null,
    judgeId        int       not null,
    lawyerId       int       not null,
    blameCitizenId int       not null,
    actId          int       not null,
    isGuilty       bool      not null,
    content        text,
    foreign key (applicationId) references application (applicationId),
    foreign key (judgeId) references judge (judgeId),
    foreign key (blameCitizenId) references citizen (citizenId),
    foreign key (lawyerId) references lawyer (lawyerId),
    foreign key (actId) references act (actId)
);

create index actNum using hash on act (num);
create index judgeClasses using btree on judge (class);
create index prosecutorRanks using btree on prosecutor (rnk);

create index actTime using btree on act (accepted);
create index applicationTime using btree on application (created);
create index resolutionTime using btree on resolution (created);

-- заявление до решения
-- закон обратной силы не имеет