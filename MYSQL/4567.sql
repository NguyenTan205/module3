use QuanLiSinhVien;

select *
from Student
where StudentName like 'h%';

select *
from Class
where month(startdate) = 12;

select *
from Subject
where Credit <= 5 and Credit >= 3;

update Student
set ClassID = 2
where StudentId = 1;

select S.StudentName, Sub.SubName, M.Mark
from Mark M
join Student S on M.StudentId = S.StudentId
join Subject Sub on M.SubId = Sub.SubId
order by M.Mark desc, S.StudentName asc;
