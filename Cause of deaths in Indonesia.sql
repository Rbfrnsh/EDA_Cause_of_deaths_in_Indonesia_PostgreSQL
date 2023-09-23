-- Portoflio cause of Death in Indonesia 2000 - 2022
--oke now lets see awhole information in table
select *
from penyebab_kematian_di_indonesia_yang_dilaporkan pkdiyd2 

-- looking at the highest deaths through year 2000 - 2020
select "Year" , sum("Total Deaths")
from penyebab_kematian_di_indonesia_yang_dilaporkan pkdiyd 
group by "Year" 
order by 2 desc

--- Looking at the highest deaths by type and cause 
select "Type",cause, "Year",  sum("Total Deaths")
from penyebab_kematian_di_indonesia_yang_dilaporkan pkdiyd 
group by "Type" , cause, "Year"  
order by 1, 4 desc

--- looking at total death by cause based on bencana alam and change some value in it
select cause, sum("Total Deaths") 
from penyebab_kematian_di_indonesia_yang_dilaporkan pkdiyd 
where "Type"  = 'Bencana Alam'
group by cause 
order by 2 DESC

--- Change some of values in column cause
UPDATE penyebab_kematian_di_indonesia_yang_dilaporkan
SET 
  cause = 
    CASE 
      WHEN cause = 'Angin Topan' THEN 'Angin Topan / Angin Puting Beliung / Angin Puyuh'
      WHEN cause = 'Banjir disertai Tanah Longsor' THEN 'Banjir dan Tanah Longsor'
      WHEN cause = 'Gempa & Tsunami' THEN 'Gempa Bumi dan Tsunami'
      WHEN cause IN ('Letusan/Peningkatan Aktivitas Gunung Api', 'Letusan Gunung Api') THEN 'Letusan Gunung Berapi'
      WHEN cause IN ('Tsunami Aceh (Hilang)', 'Tsunami Aceh (Meninggal)') THEN 'Tsunami Aceh'
      ELSE cause
    END;

 --- looking at total death by cause based on bencana Non Alam dan Penyakit and change some value in it
select cause, sum("Total Deaths") as total_deaths
from penyebab_kematian_di_indonesia_yang_dilaporkan pkdiyd 
where "Type"  = 'Bencana Non Alam dan Penyakit' 
group by 1
order by 1

-- update some values
UPDATE penyebab_kematian_di_indonesia_yang_dilaporkan
SET 
  cause = 
    CASE 
      --WHEN cause IN ('Kejadian Luar Biasa (KLB) - Keracunan', 'KLB Keracunan Makanan', 'Keracunan/KLB' ) THEN 'KLB Keracunan'
       --WHEN cause IN ('KLB Demam Berdarah Dengue (DBD)', 'KLB Dengue High Fever') THEN 'KLB Demam Berdarah'
       when cause = 'Kejadian Luar Biasa (KLB) - Penyakit' then 'KLB Penyakit'
      ELSE cause
    END;
    
   
select cause, sum("Total Deaths") 
from penyebab_kematian_di_indonesia_yang_dilaporkan pkdiyd 
where "Type" = 'Bencana Sosial'
group by 1
order by 2 desc

update penyebab_kematian_di_indonesia_yang_dilaporkan 
set 
cause = 
case 
	when cause = 'Konflik Sosial' then 'Konflik Sosial atau Kerusuhan Sosial'
	else cause 
end; 

--- create view table
create view Cause_of_Deaths_in_indonesia as
select "Type", cause, "Year", "Total Deaths"  
from penyebab_kematian_di_indonesia_yang_dilaporkan pkdiyd 

select *
from cause_of_deaths_in_indonesia codii 