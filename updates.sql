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

delimiter ;
call updateCitizenPassport(3, 'PASSPORT_000003_NEW');
call upgradeJudgeClass(3);
call callToArms(101);
