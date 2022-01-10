delimiter //


-- обновить паспорт
create procedure updateCitizenPassport($citizenId INT, $newPassport CHAR(20))
    contains sql
begin
    update citizen
    set passport = $newPassport
    where citizenId = $citizenId;
end//


-- повышение квалификации
create procedure upgradeJudgeClass($judgeId INT)
    contains sql
begin
    update judge
    set class = class + 1
    where judgeId = $judgeId;
end //


-- призыв гражданина как прокурора
create procedure callToArms($citizenId INT)
    contains sql
begin
    declare prosecutorRank int default 0;
    declare id int;
    set id = (select max(prosecutorId) from prosecutor) + 1;
    insert into prosecutor(prosecutorId, rnk, citizenId) VALUE (id, prosecutorRank, $citizenId);
end //


create procedure amnesty($citizenName VARCHAR(50))
    contains sql
begin
    set transaction isolation level read uncommitted;
    start transaction;
    update resolution
    set isGuilty = false
    where (exists(select * from citizen where citizenId = blameCitizenId and name = $citizenName));
    commit;
end //


-- забрать паспорта у всех осужденных по статье
create procedure theGreatRepression($actNumber INT)
    contains sql
begin
    set transaction isolation level read uncommitted;
    start transaction;
    update citizen
    set passport = 'NO_PASSPORT'
    where (exists(select *
                  from resolution r
                           natural join (select num, actId from act) a
                  where r.blameCitizenId = citizenId
                    and r.isGuilty is true
                    and a.num = $actNumber));
    commit;
end //


delimiter ;
call updateCitizenPassport(3, 'PASSPORT_000003_NEW');
call upgradeJudgeClass(3);
call callToArms(101);
call amnesty('B Bill Buffalo');
call theGreatRepression(159);