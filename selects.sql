-- преступники и статья
select name, num
from resolution r
         natural join (select actId, num from act) a
         join citizen c on r.blameCitizenId = c.citizenId
where isGuilty = true;

-- практикующие адвокаты
select distinct name
from resolution r
         natural join lawyer
         natural join citizen;

-- преступники, число предьявленных обвинений и число осуждений
select name, count(isGuilty) as blamed, sum(isGuilty) as imprisoned
from resolution r
         join citizen c on r.blameCitizenId = c.citizenId
group by citizenId;

-- граждане НЕ участники судебной системы и НЕ осужденные
-- Law_Abiding_Citizen
select name
from citizen
where citizenId not in (
    select citizenId
    from judge
    union
    select citizenId
    from prosecutor
    union
    select citizenId
    from lawyer
    union
    select blameCitizenId as citizenId
    from resolution
);

-- лучший адвокат
select name, 1.0 - cast(sum(isGuilty) as float) / cast(count(*) as float) as successRate
from resolution r
         natural join lawyer l
         natural join citizen c
group by lawyerId
order by successRate desc
limit 1;

-- лучший прокурор
select name, cast(sum(isGuilty) as float) / cast(count(*) as float) as successRate
from court
         natural join prosecutor p
         natural join citizen c
group by prosecutorId
order by successRate desc
limit 1;

-- случайный судья
-- Chaotic_lawful
select name, abs(0.5 - cast(sum(isGuilty) as float) / cast(count(*) as float)) as randomRate
from resolution r
         natural join judge j
         natural join citizen c
group by judgeId
order by randomRate
limit 1;

-- граждане, получившие три или более срока
-- Tri_kupola
select name
from (select name, sum(isGuilty) as imprisonments
      from resolution r
               join citizen c on r.blameCitizenId = c.citizenId
      group by citizenId) sub
where imprisonments >= 3;

-- пара судьи и прокурора, которые отправили в тюрьму наибольшее количество людей
-- Best_friends
select name as judgeName, prosecutorName, imprisonment
from (select name as prosecutorName, judgeId, imprisonment
      from (select prosecutorId, judgeId, count(distinct (blameCitizenId)) as imprisonment
            from court
                     natural join prosecutor p
            where isGuilty = true
            group by prosecutorId, judgeId
            order by imprisonment desc
            limit 1) pj
               join citizen c on pj.prosecutorId = c.citizenId) pj2
         join citizen c on pj2.judgeId = c.citizenId;

-- самое долгое судебное разбирательство
select resolutionId, TIMESTAMPDIFF(DAY, court.applicationCreated, resolutionCreated) as duration
from court
order by duration desc
limit 1;

-- список людей, подавших заявление в определенный промежуток времени
delimiter //
create procedure witness($from TIMESTAMP, $to TIMESTAMP)
    contains sql reads sql data
begin
    select distinct name, passport
    from court
             join citizen on askCitizenId = citizenId
    where applicationCreated between $from and $to;
end //
delimiter ;

call witness('2020-01-05 00:00:00', '2020-01-09 12:00:00');