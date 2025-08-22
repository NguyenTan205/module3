use QuanLiBanHang;

insert into Customer(cID, cName, cAge)
values (1, 'Minh Quan', 10);
insert into Customer(cID, cName, cAge)
values (2, 'Ngoc Oanh', 20);
insert into Customer(cId, cName, cAge)
values (3, 'Hong Ha', 50);

insert into Orders(oID, cID, oDate)
values (1, 1, '2006-03-21');
insert into Orders(oID, cID, oDate)
values (2, 2, '2006-03-23');
insert into Orders(oID, cID, oDate)
values (3, 1, '2006-03-16');

insert into Product(pID, pName, pPrice)
values (1, 'May Giat', 3);
insert into Product(pID, pName, pPrice)
values (2, 'Tu Lanh', 5);
insert into product(pID, pName, pPrice)
values (3,'Dieu Hoa', 7);
insert into Product(pID, pName, pPrice)
values (4, 'Quat', 1);
insert into Product(pID, pName, pPrice)
values (5, 'Bep Dien', 2);

insert into OrderDetail(oID, pID, odQTY)
values (1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
select *
from Orders;

-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select c.cID, c.cName, p.pName, od.odQTY -- lấy mã khách hàng, tên khách, tên sản phẩm và số lượng mua.
from Customer c -- bắt đầu từ bảng Customer, đặt bí danh c.
join Orders o on c.cID = o.oID -- nối với bảng Orders để lấy các hóa đơn của từng khách.
join OrderDetail od on o.oID = od.oID -- nối với chi tiết hóa đơn, để biết mỗi hóa đơn có những sản phẩm gì.
join Product p on od.pID = p.pID -- nối với bảng sản phẩm, để lấy tên sản phẩm và giá.
order by c.cID, c.cName; -- sắp xếp theo mã khách hàng và sau đó theo tên sản phẩm.

-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select c.cID, c.cName -- chọn mã và tên khách hàng
from Customer c -- từ bảng khách hàng
where c.cID not in(select o.cID from Orders o); -- lọc ra khách hàng có cID không nằm trong danh sách cID của bảng Orders
-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)

select o.oID, o.oDate, sum(od.odQTY * p.pPrice) as TotalPrice -- chọn mã hóa đơn, ngày bán và tính tổng tiền (số lượng * giá sản phẩm).
from Orders o -- từ bảng hóa đơn.
join OrderDetail od on o.oID = od.oID -- nối để biết mỗi hóa đơn gồm những sản phẩm nào và số lượng.
join Product p on od.pID = p.pID -- nối để lấy giá của sản phẩm.
group by o.oID, o.oDate; -- gom theo từng hóa đơn, để SUM(...) tính tổng tiền từng hóa đơn.

