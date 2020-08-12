-----------------------------
/* hoc phan : co so du lieu
Nguoi thuc hien : Nguyen Quoc Vuong
Ma so sinh vien : 1813865
Lab06 : Quan  ly hoc vien

*/
-----------------------------------

Create database Lab06_QLHocVien

go

use Lab06_QLHocVien
create table CaHoc
(
Ca int primary key,
GioBatDau time not null,
GioKetThuc time not null
)
go

create table GiaoVien
(
MSGV char(4) primary key,
HoGV nvarchar(30),
TenGV nvarchar(30),
DienThoai varchar(11)
)
go
create table Lop
(
MaLop char(4) primary key,
TenLop nvarchar(30),
NgayKG datetime not null,
HocPhi int,
Ca int references CaHoc(Ca),
SoTiet int,
SoHV int,
MSGV char(4) references GiaoVien(MSGV)

 )
 go
 create table HocVien
 (
 MSHV char(6) primary key,
 Ho nvarchar(30),
 Ten nvarchar(30),
 NGaySinh date not null,
 Phai nvarchar(30),
 MaLop char(4) references Lop(MaLop)

 

 )
 go
 create table HocPhi
 (
 SoBL char(4),
 MSHV char(6) references HocVien(MSHV),
 NgayThu date not null,
 SoTien int,
 NoiDung nvarchar(30),
 NguoiThu nvarchar(30)
 primary key(SoBL,MSHV)
 )
 go
 select *from  CaHoc
 select *from	GiaoVien
 select *from Lop
 select *from HocVien
 select *from HocPhi

 create proc usp_Insert_CaHoc
 @Ca int,@GioBatDau time,@GioKetThuc time
 as
 if exists (select *from CaHoc where Ca = @Ca)
 print N' Da co ca hoc ' + @Ca + 'trong CSDL'
 else
 begin
		insert into CaHoc
		values(@Ca,@GioBatDau,@GioKetThuc)
		print N'them ca hoc thanh cong .'
		end
go
exec usp_Insert_CaHoc '1','7:30','10:45'
exec usp_Insert_CaHoc '2','13:30','16:45'
exec usp_Insert_CaHoc '3','17:30','20:45'
 
 select *from CaHoc
 create proc usp_Insert_GiaoVien
 @MSGV char(4),@HoGV nvarchar(30),@TenGV nvarchar(30),@DienThoai int
 as
 if exists (select *from GiaoVien where MSGV = @MSGV)
 print N' Da co giao vien' + @MSGV +'trong CSDL'
 else
 begin
		insert into GiaoVien
		values(@MSGV,@HoGV,@TenGV,@DienThoai)
		print N'them giao vien thanh cong'
		end
go
exec usp_Insert_GiaoVien 'G001','Lê Hoàng','Anh','858936'
exec usp_Insert_GiaoVien 'G002','Nguyễn Ngọc','Lan','845623'
exec usp_Insert_GiaoVien 'G003','Trần Minh','Hùng','823456'
exec usp_Insert_GiaoVien 'G004','Võ Thanh','Trung','841256'

select *from GiaoVien

create proc usp_Insert_Lop
@MaLop char(4),@TenLop nvarchar(30),@NgayKG datetime,@HocPhi int,@Ca int,@SoTiet int,@SoHV int,@MSGV char(4)
As
	if exists (select *from CaHoc where Ca =@Ca) and exists (select *from GiaoVien where MSGV =@MSGV)
	begin
	if exists (select *from Lop where MaLop =@MaLop)
	print N'Da co lop ' + @MaLop +'trong CSDL'
	else
	begin
			insert into Lop
			values (@MaLop,@TenLop,@NgayKG,@HocPhi,@Ca,@SoTiet,@SoHV,@MSGV)
			print N'them lop thanh cong'
			end
End
Else
if not exists(select *from CaHoc where Ca =@Ca)
print N'Khong co ca hoc ' + @Ca + 'trong CSDL'
else print N'khong co giao vien' +@MSGV + 'trong csdl'
go
set dateformat dmy
go
exec usp_Insert_Lop 'E114','Excel 3-5-7','02/01/2008','120000','1','45','3','G003'
exec usp_Insert_Lop 'E115','Excel 2-4-6','22/01/2008','120000','3','45','0','G001'
exec usp_Insert_Lop 'W123','Word 2-4-6','18/02/2008','100000','3','45','1','G001'
exec usp_Insert_Lop 'W123',N'Word 2-4-6','18/02/2008', '100000','3','30','1','G001'
exec usp_Insert_Lop 'W124',N'Word 3-5-7','01/03/2008', '100000','1','30','0','G002'


select *from Lop

 