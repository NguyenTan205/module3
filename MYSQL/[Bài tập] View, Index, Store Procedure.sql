create database spldemo;

use spldemo;

create table Products(
	id int,
    productCode int,
    productName varchar(250),
    productPrice double,
    productAmount int,
    productDescription varchar(50),
    productStatus varchar(50)
);

insert into Products
values(1, 1, 'Dieu Hoa', 50000, 5, 'Daikin', 'con hang');
insert into Products
values(2, 2, 'Tu lanh', 30000, 3, 'Toshiba', 'con hang'),
(3, 3, 'May giat', 60000, 0, 'Panasonic', 'het hang');

-- Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
alter table Products add index idx_productCode(productCode);
explain select * from Products where productCode = 1;
-- Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
alter table Products add index idx_product_name_price(productName, productPrice);
explain select * from Products where productName = 'Dieu Hoa' or productPrice = 50000;
-- Tao view
create view v_Products as
select productCode, productName, productPrice, productStatus
from Products;

select * from v_Products;

drop view v_Products;

-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
delimiter //
create procedure findAllProducts()
begin
	select * from Products;
end //
delimiter ;

call findAllProducts();

-- Tạo store procedure thêm một sản phẩm mới
delimiter //
create procedure sp_addProducts(
	in p_id int,
    in p_productCode int,
    in p_productName varchar(250),
    in p_productPrice double,
    in p_productAmount int,
    in p_productDescription varchar(50),
    in p_productStatus varchar(50)
)
begin
	insert into Products(id, productCode, productName, productPrice, productAmount, productDescription, productStatus)
    values(p_id, p_productCode, p_productName, p_productPrice, p_productAmount, p_productDescription, p_productStatus);
end //
delimiter ;

call sp_addProducts(4, 4, 'May tinh', 100000, 1, 'Dell', 'con hang');

-- Tạo store procedure sửa thông tin sản phẩm theo id
delimiter //
create procedure sp_editProducts(
	in p_id int,
    in p_productCode int,
    in p_productName varchar(250),
    in p_productPrice double,
    in p_productAmount int,
    in p_productDescription varchar(50),
    in p_productStatus varchar(50)
)
begin
	update Products
    set productCode = p_productCode,
		productName = p_productName,
		productPrice = p_productPrice,
		productAmount = p_productAmount,
		productDescription = p_productDescription,
		productStatus = p_productStatus
	where id = p_id;
end //
delimiter ;

call sp_editProducts(4, 4, 'May tinh', 200000, 2, 'Dell', 'con hang');
ALTER TABLE Products
ADD INDEX idx_products_id (id);

-- Tạo store procedure xoá product
delimiter //
create procedure sp_deleteProduct(
	in p_id int
)
begin
	delete from Products
    where id = p_id;
end //
delimiter ;
call sp_deleteProduct(4);
