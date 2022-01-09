delimiter //

-- обновить паспорт
create procedure updateCitizenPassport($citizenId INT, $newPassport CHAR(20))
    contains sql
begin
    update citizen
    set passport = $newPassport
    where citizenId = $citizenId;
end//

delimiter ;
call updateCitizenPassport(3, 'PASSPORT_000003_NEW');