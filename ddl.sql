create
    database RussianJudgementArchive;

create table judge
(
    id    int primary key,
    name  varchar(50) not null,
    class char(20)    not null
);

create table lawyer
(
    id   int primary key,
    name varchar(50) not null
);


create table prosecutor
(
    id   int primary key,
    name varchar(50) not null,
    rnk  char(20)    not null
);


create table citizen
(
    id       int primary key,
    name     varchar(50) not null,
    passport char(20)    not null
);


create table act
(
    id       int primary key,
    num      int       not null,
    accepted timestamp not null,
    content  text
);


create table application
(
    id                  int primary key,
    created             timestamp not null,
    applicantCitizen    int       not null,
    applicantProsecutor int       not null,
    content             text,
    foreign key (applicantCitizen) references citizen (id),
    foreign key (applicantProsecutor) references prosecutor (id)
);


create table resolution
(
    id            int primary key,
    created       timestamp not null,
    applicationId int       not null,
    blameJudge    int       not null,
    blameCitizen  int       not null,
    blameAct      int       not null,
    isGuilty      bool      not null,
    content       text,
    foreign key (applicationId) references application (id),
    foreign key (blameJudge) references judge (id),
    foreign key (blameCitizen) references citizen (id),
    foreign key (blameAct) references act (id)
);
