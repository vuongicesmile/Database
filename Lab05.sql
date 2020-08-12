------------------
/* học phần: cơ sở dữ liệu
	Ngày : 5/11/2020
	Người thực hiện : Nguyễn Quốc Vương
	Mã số sinh viên :
	Lab05 : quản lý du lịch
	*/
--------------------------------------------
CREATE DATABASE Lab05_QLTour
go

use Lab05_QLTour 
create table Tour 
(
MaTour char(4) primary key , 
TongSoNgay int 
)

go
create table ThanhPho 
(
MaTP char(2) primary key, 
TenTP nvarchar(30)
)
go
create table Tour_TP 
(
MaTour char(4) references Tour(MaTour), 
MaTP char(2) references ThanhPho(MaTP), 
SoNgay int , 
primary key(MaTour,MaTP))
go

create table Lich_TourDL 
(
MaTour char(4) references Tour(MaTour), 
NgayKH date, 
TenHDV nvarchar(20), 
SoNguoi int, 
TenKH nvarchar(20),
primary key(MaTour,NgayKH)
)

select *from Tour
select *from ThanhPho
select *from Tour_TP
select *from Lich_TourDL

create  proc usp_Insert_Tour
@MaTour char(4),@TongSoNgay int 
as
if	exists(select * from Tour where MaTour = @MaTour)
print N'Đã có mã tour '+ @MaTour +' trong CSDL!'
else
begin
	insert into Tour
	values(@MaTour,@TongSoNgay)
	print N'Thêm tour thành công.'
	end
go
exec usp_Insert_Tour 'T001','3'
exec usp_Insert_Tour 'T002','4'
exec usp_Insert_Tour 'T003','5'
exec usp_Insert_Tour 'T004','7'

create  proc usp_Insert_ThanhPho
@MaTP char(2), @TenTP nvarchar(30)
as
if	exists(select * from ThanhPho where MaTP = @MaTP)
print N'Đã có mã TP '+ @MaTP +' trong CSDL!'
else
begin
	insert into ThanhPho
	values(@MaTP,@TenTP)
	print N'Thêm TP thành công.'
	end
go
exec usp_Insert_ThanhPho '01',N'Đà Lạt'
exec usp_Insert_ThanhPho '02',N'Nha Trang'
exec usp_Insert_ThanhPho '03',N'Phan Thiết'
exec usp_Insert_ThanhPho '04',N'Huế'
exec usp_Insert_ThanhPho '05',N'Đà Nẵng'

select *from ThanhPho

create proc usp_insert_Tour_TP
@MaTour char(4) , --khoa ngoai kc:mt matp
@MaTP char(2) , --kn
@SoNgay int
as
if exists (select *from Tour where MaTour=@MaTour) and exists (select * from ThanhPho where MaTP=@MaTP) --khoa ngoai
begin
if exists (select * from Tour_TP where MaTour=@MaTour and MaTP =@MaTP)
print N'Đã có tour TP ' + @MaTour +', ' +@MaTP +'trong CSDL'
Else
	begin 
		insert into Tour_TP
	values(@MaTour,@MaTP,@SoNgay)
	print N' Thêm tour thành phố thành công '
	end
End
Else if not exists (select * from Tour where MaTour=@MaTour)
	print N'Vi phạm  RBTV' + @MaTour +N'trong csdl'
	else print N'Vi phạm RBTV' + @MaTP +N'trong csdl'


exec usp_insert_Tour_TP 'T001','01',02
exec usp_insert_Tour_TP 'T001','03',01
exec usp_insert_Tour_TP 'T002','01',02
exec usp_insert_Tour_TP 'T002','02',02
exec usp_insert_Tour_TP 'T003','02',02
exec usp_insert_Tour_TP 'T003','01',01
exec usp_insert_Tour_TP 'T003','04',02
exec usp_insert_Tour_TP 'T004','02',02
exec usp_insert_Tour_TP 'T004','05',02
exec usp_insert_Tour_TP 'T004','04',03



select *from Tour_TP


create proc usp_Insert_Lich_TourDL
@MaTour char(4) ,  @NgayKH date, @TenHDV nvarchar(20),  @SoNguoi int, @TenKH nvarchar(20)
as
if exists (select * from Tour where MaTour = @MaTour)
if exists (select *from Lich_TourDL where MaTour=@MaTour and NgayKH=@NgayKH)
print N'Đã có mã tour, ngày '+ @Matour+ ', '+ @NgayKH

else
begin
insert into Lich_TourDL
values (@MaTour  ,  @NgayKH , @TenHDV,  @SoNguoi, @TenKH)
	print N'Thêm Lich_TourDL thành công'
	
	end
	
Else if not exists(select *from Tour where MaTour=@MaTour)
print	N'vi phạm BRTV khóa ngoại '+@MaTour