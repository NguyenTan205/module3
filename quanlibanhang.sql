create database QuanLiBanHang;

use QuanLiBanHang;

create table Customer(
	cID int primary key,
    cName varchar(20),
    cAge int
);

create table Orders(
	oID int primary key,
    cID int,
    oDate datetime,
    oTotalPrice double,
    foreign key (cID) references Customer(cID)
);

create table Product(
	pID int primary key,
    pName varchar(50),
    pPrice double
);

create table OrderDetail(
	oID int,
    pID int,
    odQTY int,
    foreign key (oID) references Orders(oID),
    foreign key (pID) references Product(pID)
);

