-- лучший адвокат
-- Better_call_Soul
select name, 1.0 - cast(sum(isGuilty) as float) / cast(count(*) as float) as successRate
from resolution r
         natural join lawyer l
         natural join citizen c
group by lawyerId
order by successRate desc
limit 1;

-- лучший прокурор
-- Vor_dolzhen_sidet_v_turme
select name, cast(sum(isGuilty) as float) / cast(count(*) as float) as successRate
from resolution r
         natural join (select applicationId, prosecutorId from application) a
         natural join prosecutor p
         natural join citizen c
group by prosecutorId
order by successRate desc
limit 1;

-- самый случайный судья
-- три ходки
-- ябида
-- пара судьи и прокурора
