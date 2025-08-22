use QuanLiSinhVien;

-- Hiển thị tất cả thông tin sinh viên bắt đầu bằng 'h'
select *
from Student
where StudentName like 'h%';

-- Hiển thị thông tin lớp học bắt đầu vào tháng 12
select *
from class
where month(startdate) = 12;

-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
select *
from Subject
where Credit >= 3 and Credit <= 5;

-- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
update Student 
set ClassID = 2
where StudentId = 1;

-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
select s.StudentName, sub.SubName, m.Mark
from Mark m
join Student s on m.StudentId = s.StudentId
join Subject sub on m.StudentId = sub.SubId
order by m.Mark desc, s.StudentName asc;