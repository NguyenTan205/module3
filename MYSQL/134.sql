create database QuanLiSinhVien;

use QuanLiSinhVien;

create table Class(
	ClassID int not null auto_increment primary key,
    ClassName varchar(60) not null,
    StartDate datetime not null,
    Status bit
);

create table Student(
	StudentId int not null auto_increment primary key,
    StdudentName varchar(30) not null,
    Address varchar(50),
    Phone varchar(20),
    Status bit,
    ClassID int not null,
    foreign key (ClassID) references Class(ClassID)
);

create table Subject(
	SubId int not null auto_increment primary key,
    SubName varchar(30) not null,
    Credit tinyint not null default 1 check (Credit >= 1),
    Status bit default 1
);


create table Mark(
	MarkId int not null auto_increment primary key,
    SubId int not null,
    StudentId int not null,
    Mark float default 0 check (Mark between 0 and 100),
    Examtimes tinyint default 1,
    unique(SubId, StudentId),
    foreign key (SubId) references Subject(SubId),
    foreign key (StudentId) references Student (StudentId)
);
