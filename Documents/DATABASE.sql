/************************************************/
/* Tao kieu du lieu */

exec sp_addtype T_BIT, "bit", "NOT NULL DEFAULT 0"
go

exec sp_addtype T_DATE, "datetime", "NULL"
go

exec sp_addtype T_GIA, "numeric(26,6)", "NOT NULL DEFAULT 0"
go

exec sp_addtype T_ID, "uniqueidentifier", "NULL"
go

exec sp_addtype T_INT, "int", "NULL"
go

exec sp_addtype T_LUONG, "numeric(26,6)", "NOT NULL DEFAULT 0"
go

exec sp_addtype T_PT, "numeric(10,6)", "NOT NULL DEFAULT 0"
go

exec sp_addtype T_TGIA, "numeric(26,9)", "NOT NULL DEFAULT 0"
go

exec sp_addtype T_TIEN, "numeric(26,4)", "NOT NULL DEFAULT 0"
go

exec sp_addtype T_D001, "nvarchar(1)", "NOT NULL"
go

exec sp_addtype T_D002, "nvarchar(2)", "NOT NULL"
go

exec sp_addtype T_D003, "nvarchar(3)", "NOT NULL"
go

exec sp_addtype T_D004, "nvarchar(4)", "NOT NULL"
go

exec sp_addtype T_D006, "nvarchar(6)", "NOT NULL"
go

exec sp_addtype T_D020, "nvarchar(20)", "NULL"
go

exec sp_addtype T_D032, "nvarchar(32)", "NULL"
go

exec sp_addtype T_D128, "nvarchar(128)", "NULL"
go

exec sp_addtype T_D256, "nvarchar(256)", "NULL"
go

/* End kieu du lieu */


/************************************************/
/* Tao he thong */

CREATE TABLE Buffer (
       ID_String            T_D128 NOT NULL,
       Var_Value            T_D256
)
go

ALTER TABLE Buffer
       ADD PRIMARY KEY (ID_String)
go



CREATE TABLE Memvar (
       Var_Name             T_D032 NOT NULL,
       Var_Value            T_D128 NOT NULL
)
go

ALTER TABLE Memvar
       ADD PRIMARY KEY (Var_Name)
go



CREATE TABLE Uservar (
       UserName             T_D032 NOT NULL,
       Var_Name             T_D032 NOT NULL,
       Var_Value            T_D128
)
go

ALTER TABLE Uservar
       ADD PRIMARY KEY (UserName, Var_Name)
go



CREATE TABLE Dvcsvar (
       Ma_Dvcs              T_D004 NOT NULL,
       Var_Name             T_D032 NOT NULL,
       Var_Value            T_D128
)
go

ALTER TABLE Dvcsvar
       ADD PRIMARY KEY (Ma_Dvcs, Var_Name)
go



CREATE TABLE DmFile (
       Id                   T_ID DEFAULT NEWID() NOT NULL,
       Ma_File              T_D032 NOT NULL,
       Ten_File             T_D128 NOT NULL,
       Ten_File_E           T_D128 NOT NULL,
       FieldList            T_D128 NOT NULL,
       FieldName            T_D032 NOT NULL,
       FieldOrder           T_D128,
       FilterFieldList      T_D128 NOT NULL,
       StartPos             T_INT NOT NULL DEFAULT 0,
       MaxRows              T_INT NOT NULL DEFAULT 0,
       EachWord             T_BIT NOT NULL DEFAULT 0,
       FreeFields           T_INT NOT NULL DEFAULT 0,
       Access               T_BIT NOT NULL DEFAULT 1
)
go

ALTER TABLE DmFile
       ADD PRIMARY KEY (Id)
go

CREATE UNIQUE INDEX XEI1DmFile ON DmFile(Ma_File)



CREATE TABLE DmField (
       Ma_Field             T_D032 NOT NULL, --Tên trường trong danh mục
       Ma_File              T_D032 NOT NULL, --Tên table có chứa trường cần thay đổi
       Field_Name           T_D032 NOT NULL  --Tên trường cần thay đổi
)
go

ALTER TABLE DmField ADD PRIMARY KEY (Ma_Field, Ma_File, Field_Name)
go



CREATE TABLE [dbo].[Menu](
	[Id] [dbo].[T_ID] DEFAULT NEWID() NOT NULL,
	[Bar] [dbo].[T_D128] NOT NULL,
	[Bar_E] [dbo].[T_D128] NOT NULL,
	[ParentId] [dbo].[T_ID] NULL,
	[Type] [dbo].[T_D002] NULL,
	[SubId] [dbo].[T_ID] NULL,
	[ChildId] [dbo].[T_ID] NULL,
	[ControlId] [dbo].[T_D128] NULL,
	[ControlType] [dbo].[T_D128] NULL,
	[DockStyle] [dbo].[T_D020] NULL,
	[ChildControlId] [dbo].[T_D128] NULL,
	[Image_Name] [dbo].[T_D128] NULL,
	[OrderId] [dbo].[T_INT] NOT NULL,
	[ExtraVar] [dbo].[T_D256] NULL,
	[IsInputData] [dbo].[T_BIT] NOT NULL DEFAULT 1,
	[IsContract] [dbo].[T_BIT] NOT NULL DEFAULT 1,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE INDEX XIE1Menu ON Menu (OrderId)
GO



CREATE TABLE UserRights (
       UserId               T_ID NOT NULL,
       FuncId               T_ID NOT NULL,
       FuncType             T_D001 NOT NULL,
       Right_1              T_BIT NOT NULL DEFAULT 0, --Thêm
       Right_2              T_BIT NOT NULL DEFAULT 0, --Sửa
       Right_3              T_BIT NOT NULL DEFAULT 0, --Xoá
       Right_4              T_BIT NOT NULL DEFAULT 0, --In danh mục, chứng từ
       Right_5              T_BIT NOT NULL DEFAULT 0, --Gộp mã danh mục/Khoá chứng từ
       Right_6              T_BIT NOT NULL DEFAULT 0, --Đề xuất kiểm tra chứng từ
       Right_7              T_BIT NOT NULL DEFAULT 0, --Đề xuất phê duyệt chứng từ
       Right_8              T_BIT NOT NULL DEFAULT 0, --Phê duyệt chứng từ
	   Right_9              T_BIT NOT NULL DEFAULT 0, --Xem giá
       IsUser               T_BIT NOT NULL DEFAULT 0  --0-User; 1-Group
)
go


CREATE INDEX XEI1UserRights ON UserRights(UserId, FuncType, FuncId)
go



CREATE TABLE DmDvcs (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Ma_TH                T_D001,
       Ten_Dvcs             T_D128 NOT NULL,
       Ten_Dvcs_E           T_D128 NOT NULL,
       Dia_Chi              T_D128 NOT NULL,
       Website              T_D128,
       Email                T_D128,
       Phones               T_D128,
       Faxes                T_D128,
       Ms_Thue              T_D020,
       Tk_NH                T_D032,
       Ten_NH               T_D128,
       Ten_TP               T_D128,
       Ngay_Bd_Ht           T_DATE NOT NULL,
       Ngay_Kt_Ht           T_DATE NOT NULL,
       Director             T_D128,
       Director_E           T_D128,
       Giam_Doc             T_D128,
       Chief_Accountant     T_D128,
       Chief_Accountant_E   T_D128,
       KT_Truong            T_D128,
       Cashier              T_D128,
       Cashier_E            T_D128,
       Thu_Quy              T_D128,
       Stock_Keeper         T_D128,
       Stock_Keeper_E       T_D128,
       Thu_Kho              T_D128,
       Has_Image            T_BIT
)
go

CREATE UNIQUE INDEX XAK1DmDvcs ON DmDvcs
(
       Ma_Dvcs                        ASC
)
go

ALTER TABLE DmDvcs
       ADD PRIMARY KEY (Id)
go



CREATE TABLE DmCt (
       Id                   T_ID DEFAULT NEWID() NOT NULL,
       Ma_Table             T_D020 NOT NULL,
       Ma_Nvu               T_D001,
       Nh_Ct                T_D001,
       Ma_Ct                T_D004 NOT NULL,
       WorkInFlow           T_INT NOT NULL, --Thực hiện chứng từ theo quy trình: 0-Không, 1-Có theo quy trình 7 bước
       Ten_Ct               T_D128 NOT NULL,
       Ten_Ct_E             T_D128 NOT NULL,
       NumFormat            T_D020 NOT NULL,
       NumFormat_LEFT       T_D020 NOT NULL,
       NumFormat_RIGHT      T_D020 NOT NULL,
       DB_Ctrl              T_INT NOT NULL,
       CP_Ctrl              T_INT NOT NULL,
       HH_Ctrl              T_INT NOT NULL,
       Master_Vars          T_D256,
       Detail_Vars          T_D256,
       ChildControlId       T_D128 NULL,
       ControlType          T_D128 NULL,
       DockType             T_D004 NULL
)
go

CREATE UNIQUE INDEX XAK1DmCt ON DmCt
(
       Ma_Ct                          ASC
)
go

ALTER TABLE DmCt
       ADD PRIMARY KEY (Id)
go



CREATE TABLE DmSoCt (
       Ma_Dvcs              T_D004 NOT NULL,
       Ma_Ct                T_D004 NOT NULL,
       So_Ct_Last           T_D020
)
go

ALTER TABLE DmSoCt
       ADD PRIMARY KEY (Ma_Dvcs, Ma_Ct)
go



CREATE TABLE DmInCt (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       RepoFile             T_D020 NOT NULL,
       Title                T_D128,
       Title_E              T_D128,
       Serial               T_D020
)
go

CREATE UNIQUE INDEX XAK1DmInCt ON DmInCt
(
       ParentId, RepoFile                          ASC
)
go

ALTER TABLE DmInCt
       ADD PRIMARY KEY (Id)
go



CREATE TABLE Reports(
	Id						T_ID DEFAULT NEWID() NOT NULL,
	ParentId             	T_ID NOT NULL,
	Code 					T_D032 NOT NULL,
	Bar 					T_D128 NOT NULL,
	Bar_E 					T_D128 NOT NULL,
	Title 					T_D128 NOT NULL,
	Title_E 				T_D128 NOT NULL,
	RepoFile 				T_D032 NULL,
	RepoGrp 				T_D032 NOT NULL,
	Serial 					T_D032 NULL,
	ControlId 				T_D128 NULL,
	ControlType 			T_D128 NULL,
	OrderId 				T_INT NOT NULL,
	ExtraVar 				T_D256 NULL,
	IsContract				T_BIT NOT NULL DEFAULT 1,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE INDEX XEI1Reports ON Reports(Code)
go


/* End he thong */


/************************************************/
/* Tao danh muc */


CREATE TABLE DmTk (
       Id                   T_ID NOT NULL,
       Tk                   T_D032 NOT NULL,
       Ten_Tk               T_D128 NOT NULL,
       Ten_Tk_E             T_D128 NOT NULL,
       Chu_Tk               T_D128,
       Ten_NH               T_D128,
       Chi_Nhanh            T_D128,
       Ten_TP               T_D128,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go

CREATE UNIQUE INDEX XAK1DmTk ON DmTk
(
       Tk                             ASC
)
go

ALTER TABLE DmTk
       ADD PRIMARY KEY (Id)
go


CREATE TABLE DmNhDt (
       Id                   T_ID NOT NULL,
       Ma_Nh_Dt             T_D032 NOT NULL,
       Ten_Nh_Dt            T_D128 NOT NULL,
       Ten_Nh_Dt_E          T_D128,
       IsEnd                T_BIT NOT NULL,
       ParentId             T_ID,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go

CREATE UNIQUE INDEX XAK1DmNhDt ON DmNhDt
(
       Ma_Nh_Dt                       ASC
)
go

ALTER TABLE DmNhDt
       ADD PRIMARY KEY (Id)
go



CREATE TABLE DmDt (
       Id                   T_ID NOT NULL,
       Ma_Dt                T_D032 NOT NULL,
       Ten_Dt               T_D128 NOT NULL,
       Ten_Dt_E             T_D128,
       Dia_Chi              T_D128,
       Ms_Thue              T_D020,
       Doi_Tac              T_D128,
       Website              T_D128,
       Email                T_D128,
       Phones               T_D128,
       Faxes                T_D128,
       Tk_NH                T_D032,
       Chu_Tk               T_D128,
       Ten_NH               T_D128,
       Ten_TP               T_D128,
       Ma_Nh_Dt             T_D032 NOT NULL,
       IsActive             T_D001,
       Has_Image            T_BIT NOT NULL,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go

CREATE UNIQUE INDEX XAK1DmDt ON DmDt
(
       Ma_Dt                          ASC
)
go

CREATE UNIQUE INDEX XEI1DmDt ON DmDt(Ma_Nh_Dt, Ma_Dt)
go

ALTER TABLE DmDt
       ADD PRIMARY KEY (Id)
go



CREATE TABLE DmNhVt (
       Id                   T_ID NOT NULL,
       Ma_Nh_Vt             T_D032 NOT NULL,
       Ten_Nh_Vt            T_D128 NOT NULL,
       Ten_Nh_Vt_E          T_D128,
       IsEnd                T_BIT NOT NULL,
       ParentId             T_ID,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go

CREATE UNIQUE INDEX XAK1DmNhVt ON DmNhVt
(
       Ma_Nh_Vt                       ASC
)
go

ALTER TABLE DmNhVt
       ADD PRIMARY KEY (Id)
go



CREATE TABLE DmVt (
       Id                   T_ID NOT NULL,
       Ma_Vt                T_D032 NOT NULL,
       Ten_Vt               T_D128 NOT NULL,
       Ten_Vt_E             T_D128,
       Dvt                  T_D020 NOT NULL,
       Gia_Mua              T_GIA,
       Gia_Ban              T_GIA,
       Dvt0                 T_D020,
       He_So0               T_GIA,
       Gia_Mua0             T_GIA,
       Gia_Ban0             T_GIA,
       Dvt1                 T_D020,
       He_So1               T_GIA,
       Gia_Mua1             T_GIA,
       Gia_Ban1             T_GIA,
       Dvt2                 T_D020,
       He_So2               T_GIA,
       Gia_Mua2             T_GIA,
       Gia_Ban2             T_GIA,
       Dvt3                 T_D020,
       He_So3               T_GIA,
       Gia_Mua3             T_GIA,
       Gia_Ban3             T_GIA,
       Chiet_Khau           T_PT,
       Loai_Vt              T_D001,
       Ma_Nh_Vt             T_D032 NOT NULL,
       SL_Ton_Min           T_LUONG,
       SL_Ton_Max           T_LUONG,
       IsActive             T_D001,
       VAT_Ck               T_D001,
       Thue_GTGT            T_PT,
       Has_Image            T_BIT,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go

CREATE UNIQUE INDEX XAK1DmVt ON DmVt
(
       Ma_Vt                          ASC
)
go

CREATE UNIQUE INDEX XEI1DmVt ON DmVt(Ma_Nh_Vt, Ma_Vt)
go

ALTER TABLE DmVt
       ADD PRIMARY KEY (Id)
go



CREATE TABLE DmPs ( --Danh sách các nghiệp vụ phát sinh
       Id                   T_ID NOT NULL,
       Ma_Ps                T_D032 NOT NULL,
       Ten_Ps               T_D128 NOT NULL,
       Ten_Ps_E             T_D128,
       Loai_Ps              T_D001, --QL-Quản lý, CF-Chi phí, TH-Thuế, BH-Bảo hiểm
       Loai_Ql              T_D001, --00-Không, TM-Tiền mặt, CK-Chuyển khoản, CN-Công nợ
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go

CREATE UNIQUE INDEX XAK1DmPs ON DmPs
(
       Ma_Ps                          ASC
)
go


ALTER TABLE DmPs
       ADD PRIMARY KEY (Id)
go



CREATE TABLE DmKho (
       Id                   T_ID NOT NULL,
       Ma_Kho               T_D032 NOT NULL,
       Ten_Kho              T_D128 NOT NULL,
       Ten_Kho_E            T_D128,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go

CREATE UNIQUE INDEX XAK1DmKho ON DmKho
(
       Ma_Kho                         ASC
)
go

ALTER TABLE DmKho
       ADD PRIMARY KEY (Id)
go


/* End danh muc */


/************************************************/
/* Chung tu */


CREATE TABLE CTKT (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Nh_Ct                T_D001,
       Ma_Ct                T_D004 NOT NULL,
       Ngay_Ct              T_DATE NOT NULL,
       So_Ct                T_D020,
       Ma_Dt                T_D032,
       Ong_Ba               T_D128,
       Dia_Chi              T_D128,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       TTien                T_TIEN NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL, --Người tạo (sửa cuối cùng, chính là người đề xuất kiểm tra)
       CreatedByF2          T_BIT NOT NULL DEFAULT 1 --Được tạo chủ động (1), hoặc tạo từ chứng từ khác (0)
)
go

CREATE INDEX XIE1CTKT ON CTKT(Ma_Dt)
go

CREATE INDEX XIE2CTKT ON CTKT(Ma_Dvcs, Ma_Ct, Ngay_Ct, So_Ct, Ma_Dt)
go

ALTER TABLE CTKT
       ADD PRIMARY KEY (Id)
go



CREATE TABLE CTMH (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Nh_Ct                T_D001,
       Ma_Ct                T_D004 NOT NULL,
       Ngay_Ct              T_DATE NOT NULL,
       So_Ct                T_D020,
       Ma_Dt                T_D032 NOT NULL,
       Ong_Ba               T_D128,
       Dia_Chi              T_D128,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       TTien0               T_TIEN, --Tổng giá trị nhập kho
       TTien                T_TIEN, --Tổng tiền hàng
       TTien3               T_TIEN, --Tổng tiền thuế GTGT
       TTien8               T_TIEN, --Tổng thuế tiêu thụ đặc biệt
       TTien4               T_TIEN, --Tổng tiền chiết khấu
       TTien6               T_TIEN, --Tổng chi phi mua hàng, thuế nhập khẩu
       Id_CTKT              T_ID, --Để xoá phiếu kế toán kèm theo
       EPosted              T_INT, -- 1: Đã phát hành hóa đơn; -1: Đã lập chưa phát hành; 0: Đã xóa bỏ
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL, --Người tạo (sửa cuối cùng, chính là người đề xuất kiểm tra)
       Posted               T_INT --1: Cập nhật vào sổ; 0: Hủy bỏ
)
go

CREATE INDEX XIE3CTMH ON CTMH(Ma_Dt)
go

CREATE INDEX XIE4CTMH ON CTMH(Ma_Km)
go

CREATE INDEX XIE5CTMH ON CTMH(Ma_Nx)
go

CREATE INDEX XIE6CTMH ON CTMH(Ma_Dvcs, Ma_Ct, Ngay_Ct, So_Ct, Ma_Dt, Ma_Bp, Ma_Hd)
go

ALTER TABLE CTMH
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTMH0 (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       Stt_Nv               T_INT NOT NULL,
       Ma_Vt                T_D032 NOT NULL,
       Ma_Bp                T_D032,
       Ma_Hd                T_D032,
       Ma_Km                T_D032,
       Ma_Sp                T_D032,
       Ma_Kho               T_D032,
       Dvt                  T_D020,
       He_So9               T_GIA,
       So_Luong9            T_LUONG,
       Gia_Nt9              T_GIA,
       Gia9                 T_GIA,
       Tien_Nt9             T_TIEN,
       Tien9                T_TIEN,
       So_Luong             T_LUONG,
       So_LuongR            T_LUONG,
       Gia_Nt               T_GIA,
       Gia                  T_GIA,
       Tien_Nt              T_TIEN,
       Tien                 T_TIEN,
       Tien_413             T_TIEN,
       Thue_GTGT            T_PT,
       Tien_Nt3             T_TIEN,
       Tien3                T_TIEN,
       Tien_Nt5             T_TIEN,
       Tien5                T_TIEN,
       Thue_TTDB            T_PT,
       Tien_Nt8             T_TIEN,
       Tien8                T_TIEN,
       Hoa_Hong             T_PT,
       Tien_Nt4             T_TIEN,
       Tien4                T_TIEN,
       Tien_Nt6             T_TIEN,
       Tien6                T_TIEN,
       Tk_No                T_D032,
       Tk_Co                T_D032,
       Tk_No3               T_D032,
       Tk_Co3               T_D032,
       Tk_No5               T_D032,
       Tk_Co5               T_D032,
       Tk_No8               T_D032,
       Tk_Co8               T_D032,
       Lo_Hang              T_D032,
       Han_Dung             T_DATE,
       So_Ct_D              T_D020, --Số chứng từ đơn hàng mua; Số phiếu nhập mua
       Id_CT_Detail         T_ID,
       Id_CT_Master         T_ID
)
go


CREATE INDEX XIE2CTMH0 ON CTMH0(Ma_Bp)
go

CREATE INDEX XIE3CTMH0 ON CTMH0(Ma_Hd)
go

CREATE INDEX XIE4CTMH0 ON CTMH0(Ma_Vt)
go

CREATE INDEX XIE5CTMH0 ON CTMH0(Ma_Kho)
go

CREATE INDEX XIE6CTMH0 ON CTMH0(Ma_Sp)
go

CREATE INDEX XIE7CTMH0 ON CTMH0(Ma_Km)
go

CREATE INDEX XIE1CTMH0 ON CTMH0
(
       ParentId                            ASC
)
go


ALTER TABLE CTMH0
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTBH (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Nh_Ct                T_D001,
       Ma_Ct                T_D004 NOT NULL,
       So_Seri              T_D020,
       Ngay_Ct              T_DATE NOT NULL,
       So_Ct                T_D020,
       Ma_Bp                T_D032,
       Ma_Hd                T_D032,
       Ma_Dt                T_D032 NOT NULL,
       Ong_Ba               T_D128,
       Dia_Chi              T_D128,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       Ma_Tte               T_D003,
       Ty_Gia               T_TGIA NOT NULL,
       Ty_Gia_Ht            T_TGIA NOT NULL,
       Ma_Km                T_D032,
       Gia_Thue             T_D001,
       VAT_Ck               T_D001,
       Thue_GTGT            T_PT,
       Ma_Nx                T_D032 NOT NULL,
       PostedGL             T_BIT,
       Han_Tt               T_DATE,
       TTien_Nt0            T_TIEN,
       TTien0               T_TIEN,
       TTien_Nt             T_TIEN,
       TTien                T_TIEN,
       TTien_Nt2            T_TIEN,
       TTien2               T_TIEN,
       TTien_413            T_TIEN,
       TTien_Nt3            T_TIEN,
       TTien3               T_TIEN,
       TTien_Nt5            T_TIEN,
       TTien5               T_TIEN,
       TTien_Nt8            T_TIEN,
       TTien8               T_TIEN,
       TTien_Nt4            T_TIEN,
       TTien4               T_TIEN,
       TTien_Nt6            T_TIEN,
       TTien6               T_TIEN,
       Tien_Cash            T_TIEN,
       Ma_Loai1             T_D032,
       Ma_Loai2             T_D032,
       Ma_Loai3             T_D032,
       Id_CTKT              T_ID,
       EPosted              T_INT, -- 1: Đã phát hành hóa đơn; -1: Đã lập chưa phát hành; 0: Đã xóa bỏ; null: Chưa lập
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL, --Người tạo (sửa cuối cùng, chính là người đề xuất kiểm tra)
       Posted               T_INT NOT NULL,
       Prev_User            T_D032, --Người kiểm tra và đề xuất phê duyệt
       Post_User            T_D032, --Người duyệt
       Post_Time            T_DATE,
       Locked               T_BIT,
       Lock_User            T_D032,
       Lock_Time            T_DATE,
       Completed			T_BIT DEFAULT 0
)
go

CREATE INDEX XIE1CTBH ON CTBH(Ma_Bp)
go

CREATE INDEX XIE2CTBH ON CTBH(Ma_Hd)
go

CREATE INDEX XIE3CTBH ON CTBH(Ma_Dt)
go

CREATE INDEX XIE4CTBH ON CTBH(Ma_Km)
go

CREATE INDEX XIE5CTBH ON CTBH(Ma_Nx)
go

CREATE INDEX XIE6CTBH ON CTBH(Ma_Dvcs, Ma_Ct, Ngay_Ct, So_Ct, Ma_Dt, Ma_Bp, Ma_Hd)
go


ALTER TABLE CTBH
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTBH0 (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       Stt_Nv               T_INT NOT NULL,
       Ma_Vt                T_D032 NOT NULL,
       Ma_Hd                T_D032,
       Ma_Bp                T_D032,
       Ma_Km                T_D032,
       Ma_Kho               T_D032,
       Dvt                  T_D020,
       He_So9               T_GIA,
       So_Luong9            T_LUONG,
       Gia_Nt9              T_GIA,
       Gia9                 T_GIA,
       Tien_Nt9             T_TIEN,
       Tien9                T_TIEN,
       So_Luong             T_LUONG,
       So_LuongR            T_LUONG,
       Gia_Tb_Tt            T_D001,
       Gia_Nt               T_GIA,
       Gia                  T_GIA,
       Tien_Nt              T_TIEN,
       Tien                 T_TIEN,
       Gia_Nt2              T_GIA,
       Gia2                 T_GIA,
       Tien_Nt2             T_TIEN,
       Tien2                T_TIEN,
       Tien_413             T_TIEN,
       Thue_GTGT            T_PT,
       Tien_Nt3             T_TIEN,
       Tien3                T_TIEN,
       Thue_XK              T_PT,
       Tien_Nt5             T_TIEN,
       Tien5                T_TIEN,
       Thue_TTDB            T_PT,
       Tien_Nt8             T_TIEN,
       Tien8                T_TIEN,
       Chiet_Khau           T_PT,
       Tien_Nt4             T_TIEN,
       Tien4                T_TIEN,
       Tien_Nt6             T_TIEN,
       Tien6                T_TIEN,
       Tk_No                T_D032,
       Tk_Co                T_D032,
       Tk_No2               T_D032,
       Tk_Co2               T_D032,
       Tk_No3               T_D032,
       Tk_Co3               T_D032,
       Tk_No5               T_D032,
       Tk_Co5               T_D032,
       Tk_No8               T_D032,
       Tk_Co8               T_D032,
       Tk_No4               T_D032,
       Tk_Co4               T_D032,
       Tk_No6               T_D032,
       Tk_Co6               T_D032,
       Lo_Hang              T_D032,
       Han_Dung             T_DATE,
       So_Ct_D              T_D020, --Số chứng từ đơn hàng; Số chứng từ hoá đơn
       Id_CT_Detail         T_ID,
       Id_CT_Master         T_ID
)
go

CREATE INDEX XIE2CTBH0 ON CTBH0(Ma_Bp)
go

CREATE INDEX XIE3CTBH0 ON CTBH0(Ma_Hd)
go

CREATE INDEX XIE4CTBH0 ON CTBH0(Ma_Vt)
go

CREATE INDEX XIE5CTBH0 ON CTBH0(Ma_Kho)
go

CREATE INDEX XIE6CTBH0 ON CTBH0(Ma_Km)
go

CREATE INDEX XIE1CTBH0 ON CTBH0
(
       ParentId                            ASC
)
go


ALTER TABLE CTBH0
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTNX (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Nh_Ct                T_D001,
       Ma_Ct                T_D004 NOT NULL,
       Ngay_Ct              T_DATE NOT NULL,
       So_Ct                T_D020,
       Ma_Bp                T_D032,
       Ma_Hd                T_D032,
       Ma_Dt                T_D032 NOT NULL,
       Ong_Ba               T_D128,
       Dia_Chi              T_D128,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       Ma_Tte               T_D003,
       Ty_Gia               T_TGIA NOT NULL,
       Ty_Gia_Ht            T_TGIA NOT NULL,
       Ma_Km                T_D032,
       Ma_Nx                T_D032 NOT NULL,
       PostedGL             T_BIT,
       Ma_KhoN              T_D032,
       Ma_VtN               T_D032,
       DvtN                 T_D020,
       He_SoN9              T_GIA,
       So_LuongN9           T_LUONG,
       So_LuongN            T_LUONG,
       Lo_HangN             T_D032,
       Han_DungN            T_DATE,
       TTien_Nt0            T_TIEN,
       TTien0               T_TIEN,
       TTien_413            T_TIEN,
       Ma_Loai1             T_D032,
       Ma_Loai2             T_D032,
       Ma_Loai3             T_D032,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL, --Người tạo (sửa cuối cùng, chính là người đề xuất kiểm tra)
       Posted               T_INT NOT NULL,
       Prev_User            T_D032, --Người kiểm tra và đề xuất phê duyệt
       Post_User            T_D032, --Người duyệt
       Post_Time            T_DATE,
       Locked               T_BIT,
       Lock_User            T_D032,
       Lock_Time            T_DATE,
       Completed            T_BIT DEFAULT 0
)
go

CREATE INDEX XIE1CTNX ON CTNX(Ma_Bp)
go

CREATE INDEX XIE2CTNX ON CTNX(Ma_Hd)
go

CREATE INDEX XIE3CTNX ON CTNX(Ma_Dt)
go

CREATE INDEX XIE4CTNX ON CTNX(Ma_Km)
go

CREATE INDEX XIE5CTNX ON CTNX(Ma_Nx)
go

CREATE INDEX XIE6CTNX ON CTNX(Ma_KhoN)
go

CREATE INDEX XIE7CTNX ON CTNX(Ma_VtN)
go

CREATE INDEX XIE8CTNX ON CTNX(Ma_Dvcs, Ma_Ct, Ngay_Ct, So_Ct, Ma_Dt, Ma_Bp, Ma_Hd)
go

ALTER TABLE CTNX
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTNX0 (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       Stt_Nv               T_INT NOT NULL,
       Ma_Vt                T_D032 NOT NULL,
       Ma_Bp                T_D032,
       Ma_Hd                T_D032,
       Ma_Km                T_D032,
       Ma_Sp                T_D032,
       Ma_Yt                T_D032,
       Ma_Kho               T_D032,
       Dvt                  T_D020 NOT NULL,
       He_So9               T_GIA NOT NULL,
       So_Luong9            T_LUONG,
       Gia_Nt9              T_GIA,
       Gia9                 T_GIA,
       So_Luong             T_LUONG NOT NULL,
       So_LuongR            T_LUONG,
       Gia_Tb_Tt            T_D001,
       Gia_Nt               T_GIA,
       Gia                  T_GIA,
       Tien_Nt              T_TIEN,
       Tien                 T_TIEN,
       Tien_413             T_TIEN,
       Tk_No                T_D032,
       Tk_Co                T_D032,
       Lo_Hang              T_D032,
       Han_Dung             T_DATE,
       So_Ct_D              T_D020, --Số chứng từ yêu cầu xuất kho CTYCM
       Id_CT_Detail         T_ID,
       Id_CT_Master         T_ID
)
go


CREATE INDEX XIE2CTNX0 ON CTNX0(Ma_Bp)
go

CREATE INDEX XIE3CTNX0 ON CTNX0(Ma_Hd)
go

CREATE INDEX XIE4CTNX0 ON CTNX0(Ma_Vt)
go

CREATE INDEX XIE5CTNX0 ON CTNX0(Ma_Kho)
go

CREATE INDEX XIE6CTNX0 ON CTNX0(Ma_Sp)
go

CREATE INDEX XIE7CTNX0 ON CTNX0(Ma_Km)
go

CREATE INDEX XIE8CTNX0 ON CTNX0(Ma_Yt)
go

CREATE INDEX XIE1CTNX0 ON CTNX0
(
       ParentId                            ASC
)
go


ALTER TABLE CTNX0
       ADD PRIMARY KEY (Id)
go



CREATE TABLE CTNotes (
	   Id					T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       Notes                ntext,
       CCEmails             xml,
       AttachedFiles        xml,
       Posted               T_INT,
       ModifiedAt           T_DATE,
       ModifiedBy           T_D032
)
go

ALTER TABLE CTNotes
       ADD PRIMARY KEY (Id)
go

CREATE CLUSTERED INDEX XIE1CTNotes ON CTNotes
(
       Id,ParentId                            ASC
)
go



CREATE TABLE CTDocuments (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       FullName             T_D128 NOT NULL,
       ModifiedAt			T_DATE,
       ModifiedBy           T_D032
)
go


CREATE INDEX XIE1CTDocuments ON CTDocuments
(
       Id, ParentId                            ASC
)
go


ALTER TABLE CTDocuments
       ADD PRIMARY KEY (Id)
go


CREATE VIEW CTDocuments_View AS SELECT ParentId, COUNT(*) AS DocumentCount FROM CTDocuments GROUP BY ParentId
go


CREATE TABLE CTEmailLog (
	   Id					T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL,
       Email                xml
)
go

ALTER TABLE CTEmailLog
       ADD PRIMARY KEY (Id)
go

CREATE INDEX XIE1CTEmailLog ON CTEmailLog
(
       Id, ParentId                            ASC
)
go

--CREATE TABLE CTVAT (
--       Id                   T_ID NOT NULL,
--       Ma_Dvcs              T_D004 NOT NULL,
--       ParentId             T_ID,
--       Ma_Ct                T_D004,
--       Ngay_Ct              T_DATE NOT NULL,
--       So_Ct                T_D020,
--       Ngay_Ct0             T_DATE NOT NULL,
--       So_Ct0               T_D020,
--       So_Seri0             T_D020,
--       Mau_So0              T_D032,
--       Ma_Hd0               T_D020,
--       Dien_Giai            T_D256,
--       Ghi_Chu              T_D256,
--       Ma_Dt                T_D032,
--       Ma_DtGTGT            T_D020,
--       Ten_DtGTGT           T_D128,
--       VAT_Ck               T_D001,
--       Thue_GTGT            T_PT,
--       Tk                   T_D032 NOT NULL,
--       No_Co                T_D001,
--       Tk_Du                T_D032 NOT NULL,
--       So_Luong             T_LUONG,
--       Gia                  T_GIA,
--       Tien                 T_TIEN,
--       Tien3                T_TIEN,
--       Hoa_Don              T_D001,
--       Thue_XNK             T_D001,
--       Hang_NLTS            T_D001,
--       TSCD_Ck              T_D001,
--       Dieu_Chinh           T_D001,
--       OnReport             T_D001,
--       Loai_VAT             T_D001,
--       Ma_Sp                T_D032,
--       Loai_Ps              T_D001,
--       UserName             T_D032 NOT NULL,
--       Posted               T_INT NOT NULL,
--       Locked               T_BIT,
--       Lock_User            T_D032,
--       Lock_Time            T_DATE
--)
--go


--CREATE INDEX XIE1CTVAT ON CTVAT
--(
--       ParentId                            ASC
--)
--go


--ALTER TABLE CTVAT
--       ADD PRIMARY KEY (Id)
--go

--drop table ctvat
CREATE TABLE CTVAT (
       Ma_Dvcs              T_D004 NOT NULL,
       ParentId             T_ID, --Id của chứng từ gốc (CTKT, CTMH, CTBH)
       Id                   T_ID NOT NULL,
       Stt_Nv               T_INT NOT NULL,
       Ma_Ct                T_D004,
       Ngay_Ct              T_DATE NOT NULL,
       So_Ct                T_D020,
       Ngay_Ct0             T_DATE NOT NULL,
       So_Ct0               T_D020,
       So_Seri0             T_D020,
       Mau_So0              T_D032,
       Ma_DtGTGT            T_D020,
       Ten_DtGTGT           T_D128,
       TTien                T_TIEN, --Tiền hàng
       TTien3               T_TIEN, --Tiền thuế
       Posted               T_INT
)
go


CREATE INDEX XIE1CTVAT ON CTVAT
(
       ParentId                            ASC
)
go


ALTER TABLE CTVAT
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTVAT0 (
       OldParId             T_ID, --Id của chứng từ gốc (CTKT, CTMH, CTBH)
       ParentId             T_ID, --Id của master (CTVAT)
       Id                   T_ID NOT NULL,
       Stt_Nv               T_INT NOT NULL,
       Ma_Thue              T_D001, --1: Đầu vào, 2: Đầu ra
       Xuat_Xu              T_INT DEFAULT 0 NOT NULL, --0: Trong nước, 1: Nhập khẩu
       Dien_Giai            T_D256,
       Tien                 T_TIEN, --Tiền hàng
       Loai_Thue            T_D001, --Đầu ra: 1. Thuế suất 0%, 2.Thuế suất 5%, 8.Thuế suất 8%, 3.Thuế suất 10%, 0.Không chịu thuế
									--Đầu vào: 0. Tất cả, 1. Có đủ điều kiện khấu trừ thuế, 2. Không đủ điều kiện khấu trừ
       Tien3                T_TIEN, --Tiền thuế
       Kieu_Thue            T_D001, --1. Có đủ điều kiện khấu trừ thuế, 2. Không đủ điều kiện khấu trừ, 3. Dành cho hoạt động đầu tư, 0. Không đưa lên tờ khai
       Loai_Ps              T_D001, --1. Phát sinh tăng, 2. Phát sinh giảm, 3. Điều chỉnh tăng, 4. Điều chỉnh giảm
       Ma_Sp                T_D032, --Dự án
       Ghi_Chu              T_D256
)
go


CREATE INDEX XIE1CTVAT0 ON CTVAT0
(
       OldParId, ParentId                            ASC
)
go


ALTER TABLE CTVAT0
       ADD PRIMARY KEY (Id)
go


CREATE TABLE SoCaiKT (
       Ma_Dvcs              T_D004 NOT NULL,
       Id_Master            T_ID NOT NULL, --Stt
       Id_Detail_No         T_ID, --Stt0_No
       Id_Detail_Co         T_ID, --Stt0_Co
       Stt_Bt               T_INT NOT NULL,
       Ma_Nvu               T_D001,
       Nh_Ct                T_D001,
       Ma_Ct                T_D004 NOT NULL,
       Ngay_Ct              T_DATE NOT NULL,
       So_Ct                T_D020,
       Ma_Dt                T_D032,
       Ong_Ba               T_D128,
       Dia_Chi              T_D128,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       Tk_No                T_D032,
       Ma_Bp_No             T_D032,
       Ma_Hd_No             T_D032,
       Ma_Dt_No             T_D032,
       Han_Tt_No            T_DATE,
       Ma_Km_No             T_D032,
       Ma_Sp_No             T_D032,
       Ma_Tte_No            T_D003,
       Ty_Gia_No            T_TGIA NOT NULL,
       Ty_Gia_HtN           T_TGIA NOT NULL,
       Tien_Nt_No           T_TIEN NOT NULL DEFAULT 0,
       Tien                 T_TIEN NOT NULL DEFAULT 0,
       Tk_Co                T_D032,
       Ma_Bp_Co             T_D032,
       Ma_Hd_Co             T_D032,
       Ma_Dt_Co             T_D032,
       Han_Tt_Co            T_DATE,
       Ma_Km_Co             T_D032,
       Ma_Sp_Co             T_D032,
       Ma_Tte_Co            T_D003,
       Ty_Gia_Co            T_TGIA NOT NULL,
       Ty_Gia_HtC           T_TGIA NOT NULL,
       Tien_Nt_Co           T_TIEN NOT NULL DEFAULT 0,
       Dien_GiaiN           T_D256,
       Dien_GiaiC           T_D256,
       Dien_Giai_EN         T_D256,
       Dien_Giai_EC         T_D256,
       Ma_Yt                T_D032,
       Ma_Vt                T_D032,
       So_Luong             T_LUONG NOT NULL DEFAULT 0,
       Ma_Loai1             T_D032,
       Ma_Loai2             T_D032,
       Ma_Loai3             T_D032,
       Posted               T_INT NOT NULL
)
go


CREATE CLUSTERED INDEX XIE1SoCaiKT ON SoCaiKT
(
       Id_Master                            ASC
)
go


CREATE NONCLUSTERED INDEX XIE2SoCaiKT ON SoCaiKT
(
	Ma_Dvcs, Ngay_Ct, Tk_No, Ma_Dt_No, Tk_Co, Ma_Dt_Co, Posted, Id_Master, Tien, Tien_Nt_No, Tien_Nt_Co
)
go


CREATE INDEX XEI1SoCaiKT ON SoCaiKT(Ngay_Ct)
go


CREATE INDEX XEI2SoCaiKT ON SoCaiKT(Tk_No)
go


CREATE INDEX XEI3SoCaiKT ON SoCaiKT(Ma_Dt_No)
go


CREATE INDEX XEI4SoCaiKT ON SoCaiKT(Tk_Co)
go


CREATE INDEX XEI5SoCaiKT ON SoCaiKT(Ma_Dt_Co)
go



CREATE TABLE SoCaiVT (
       Ma_Dvcs              T_D004 NOT NULL,
       Id_Master            T_ID NOT NULL, -- Stt
       Id_Detail            T_ID NOT NULL, -- Stt0
       Ma_Nvu               T_D001,
       Nh_Ct                T_D001,
       Ma_Ct                T_D004,
       Ngay_Ct              T_DATE,
       So_Ct                T_D020,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       Ma_Hd                T_D032,
       Ma_Dt                T_D032,
       Tk                   T_D032,
       Tk_Du                T_D032,
       Ma_Kho               T_D032,
       Ma_Vt                T_D032,
       Dvt                  T_D020,
       So_Luong9            T_LUONG,
       So_Luong             T_LUONG,
       Gia_Nt               T_GIA,
       Gia                  T_GIA,
       Tien_Nt              T_TIEN,
       Tien                 T_TIEN,
       Lo_Hang              T_D032,
       Han_Dung             T_DATE,
       Gia_Tb_Tt            T_D001,
       Posted               T_INT NOT NULL,
       Id_CT_Master         T_ID, -- Stt_D
       Id_CT_Detail         T_ID, -- Stt0_D
	   ModifiedAt           TIMESTAMP --Dùng để xác định thứ tự nhập liệu khi tính giá vốn theo PP TBDD
)
go


CREATE CLUSTERED INDEX XIE1SoCaiVT ON SoCaiVT
(
       Id_Master                            ASC
)
go


CREATE NONCLUSTERED INDEX XIE2SoCaiVT ON SoCaiVT 
(
	Ma_Dvcs, Ngay_Ct, Nh_Ct, Ma_Kho, Ma_Vt, Posted, Id_Master, So_Luong
)
go


CREATE INDEX XEI3SoCaiVT ON SoCaiVT(Ngay_Ct)
go


CREATE INDEX XEI4SoCaiVT ON SoCaiVT(Ma_Kho)
go


CREATE INDEX XEI5SoCaiVT ON SoCaiVT(Ma_Vt)
go


CREATE INDEX XEI6SoCaiVT ON SoCaiVT(Id_Master)
go


CREATE TABLE SoCaiCN (
       Ma_Dvcs              T_D004,
       Id_Master            T_ID, --Stt
	   Ma_Ct				T_D004,
       Ngay_Ct              T_DATE NOT NULL,
       So_Ct                T_D020,
       Ma_Bp                T_D032,
       Ma_Hd                T_D032,
       Ma_Dt                T_D032,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       Ma_Tte               T_D003,
       Ty_Gia               T_TGIA NOT NULL,
       Ty_Gia_Ht            T_TGIA NOT NULL,
       No_Co                T_D001,
       Tk                   T_D032 NOT NULL,
       Tien_Nt              T_TIEN,
       Tien                 T_TIEN,
       Tien_NtR             T_TIEN DEFAULT 0,
       TienR                T_TIEN DEFAULT 0,
       Han_Tt               T_DATE,
       Posted               T_INT NOT NULL
)
go

CREATE UNIQUE INDEX XIE2SoCaiCN ON SoCaiCN (Id_Master, Ma_Bp, Ma_Hd, Ma_Dt, Ma_Tte, No_Co, Tk, Han_Tt, Posted)
go

CREATE CLUSTERED INDEX XIE1SoCaiCN ON SoCaiCN
(
       Id_Master                            ASC
)
go

CREATE INDEX XIE3SoCaiCN ON SoCaiCN(Ngay_Ct)
go

CREATE INDEX XIE4SoCaiCN ON SoCaiCN(Ma_Bp)
go

CREATE INDEX XIE5SoCaiCN ON SoCaiCN(Ma_Hd)
go

CREATE INDEX XIE6SoCaiCN ON SoCaiCN(Ma_Dt)
go

CREATE INDEX XIE7SoCaiCN ON SoCaiCN(Tk)
go

CREATE TABLE SoCaiTT (
       S_Order              T_ID NOT NULL,
       Ma_Bp                T_D032,
       Ma_Hd                T_D032,
       Ma_Dt                T_D032,
       No_Co                T_D001,
       Tk                   T_D032 NOT NULL,
       Ma_Tte               T_D003,
       Ty_Gia_Ht            T_TGIA,
       Tien_Nt              T_TIEN,
       Tien                 T_TIEN,
       Tien_CL              T_TIEN,
       Han_Tt               T_DATE,
       D_Order              T_ID NOT NULL
)
go


CREATE UNIQUE INDEX XIE2SoCaiTT ON SoCaiTT (S_Order, D_Order, Ma_Bp, Ma_Hd, Ma_Dt, Ma_Tte, No_Co, Tk, Han_Tt)
go


CREATE CLUSTERED INDEX XIE1SoCaiTT ON SoCaiTT
(
       D_Order                            ASC
)
go


CREATE TABLE CdKT0 (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Ngay_Ct              T_DATE NOT NULL,
       So_Ct                T_D020,
       Ma_Bp                T_D032,
       Ma_Hd                T_D032,
       Ma_Dt                T_D032,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       Ma_Tte               T_D003,
       Ty_Gia               T_TGIA NOT NULL,
       Ty_Gia_Ht            T_TGIA NOT NULL,
       Tk                   T_D032 NOT NULL,
       Du_No_Nt             T_TIEN,
       Du_No                T_TIEN,
       Du_Co_Nt             T_TIEN,
       Du_Co                T_TIEN,
       Du_No_Nt0            T_TIEN,
       Du_No0               T_TIEN,
       Du_Co_Nt0            T_TIEN,
       Du_Co0               T_TIEN,
       Han_Tt               T_DATE,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go


ALTER TABLE CdKT0
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CdKT (
       Year_Month           T_D006,
       Ma_Dvcs              T_D004 NOT NULL,
       Tk                   T_D032 NOT NULL,
       Ma_Dt                T_D032,
       Ma_Tte               T_D003,
       Ps_No_Nt             T_TIEN NOT NULL DEFAULT 0,
       Ps_No                T_TIEN NOT NULL DEFAULT 0,
       Ps_Co_Nt             T_TIEN NOT NULL DEFAULT 0,
       Ps_Co                T_TIEN NOT NULL DEFAULT 0,
       Ma_Hd                T_D032,
       Ma_Bp                T_D032,
       Ps_No_Nt0            T_TIEN NOT NULL DEFAULT 0,
       Ps_No0               T_TIEN NOT NULL DEFAULT 0,
       Ps_Co_Nt0            T_TIEN NOT NULL DEFAULT 0,
       Ps_Co0               T_TIEN NOT NULL DEFAULT 0
)
go

CREATE UNIQUE INDEX XAK1CdKT ON CdKT
(
       Year_Month                     ASC,
       Ma_Dvcs                        ASC,
       Tk                             ASC,
       Ma_Bp                          ASC,
       Ma_Hd                          ASC,
       Ma_Dt                          ASC,
       Ma_Tte                         ASC
)
go


CREATE INDEX XEI1CdKT ON CdKT(Tk)
go


CREATE INDEX XEI2CdKT ON CdKT(Ma_Bp)
go


CREATE INDEX XEI3CdKT ON CdKT(Ma_Hd)
go


CREATE INDEX XEI4CdKT ON CdKT(Ma_Dt)
go


CREATE INDEX XEI5CdKT ON CdKT(Tk, Ma_Dt, Year_Month, Ma_Dvcs, Ps_No, Ps_No_Nt, Ps_Co, Ps_Co_Nt)
go




/* End chung tu */



/************************************************/
/* Quan ly nhan su - tien luong */





/* End Quan ly nhan su - tien luong */


/************************************************/
/* Bao gia - Don hang */

CREATE TABLE RefTable (
       S_Order              T_ID NOT NULL,
       D_Order              T_ID NOT NULL,
       Modul                T_INT NOT NULL,
       Posted               T_INT
)
go


ALTER TABLE RefTable
       ADD PRIMARY KEY (S_Order, D_Order, Modul)
go




CREATE TABLE CTBG (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Nh_Ct                T_D001,
       Ma_Ct                T_D004 NOT NULL,
       Ngay_Ct              T_DATE NOT NULL,
       So_Ct                T_D020,
       Ma_Tte               T_D003,
       Ty_Gia               T_TGIA NOT NULL,
       Ma_Bp                T_D032,
       Ma_Hd                T_D032,
       Ma_Dt                T_D032 NOT NULL,
       Ong_Ba               T_D128,
       Dia_Chi              T_D128,
       Phones               T_D128,
       Email                T_D128,
       TTien_Nt0            T_TIEN,
       TTien_Nt             T_TIEN,
       Thue_GTGT            T_PT,
       TTien_Nt3            T_TIEN,
       Ngay_HL1             T_DATE,
       Ngay_HL2             T_DATE,
       Ghi_Chu              T_D256,
       Ma_Loai1             T_D032,
       Ma_Loai2             T_D032,
       Ma_Loai3             T_D032,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL, --Người tạo (sửa cuối cùng, chính là người đề xuất kiểm tra)
       Posted               T_INT NOT NULL,
       Prev_User            T_D032, --Người kiểm tra và đề xuất phê duyệt
       Post_User            T_D032, --Người duyệt
       Post_Time            T_DATE,
       Locked               T_BIT,
       Lock_User            T_D032,
       Lock_Time            T_DATE
)
go


CREATE INDEX XIE1CTBG ON CTBG(Ma_Bp)
go

CREATE INDEX XIE2CTBG ON CTBG(Ma_Hd)
go

CREATE INDEX XIE3CTBG ON CTBG(Ma_Dt)
go

CREATE UNIQUE INDEX XIE4CTBG ON CTBG(Ma_Dvcs, Ma_Ct, So_Ct)
go

CREATE NONCLUSTERED INDEX XIE5CTBG ON CTBG
(
	Ma_Dvcs, Ma_Ct, Ngay_Ct, So_Ct
)
go

ALTER TABLE CTBG
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTBG0 (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       Stt_Nv               T_INT NOT NULL,
       Ma_Vt                T_D032 NOT NULL,
       Ma_Bp                T_D032,
       Ma_Hd                T_D032,
       Ghi_Chu              T_D256,
       So_Luong             T_LUONG,
       Gia_Nt               T_GIA,
       Tien_Nt              T_TIEN,
       Thue_GTGT            T_PT,
       Tien_Nt3             T_TIEN
)
go


CREATE INDEX XIE2CTBG0 ON CTBG0(Ma_Bp)
go

CREATE INDEX XIE3CTBG0 ON CTBG0(Ma_Hd)
go

CREATE INDEX XIE1CTBG0 ON CTBG0
(
       ParentId                            ASC
)
go


ALTER TABLE CTBG0
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTDH (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Nh_Ct                T_D001,
       Ma_Ct                T_D004 NOT NULL,
       Ngay_Ct              T_DATE NOT NULL,
       So_Ct                T_D020,
       Ma_Tte               T_D003,
       Ty_Gia               T_TGIA,
       Ma_Bp                T_D032,
       Ma_Hd                T_D032,
       Ma_Dt                T_D032 NOT NULL,
       Ong_Ba               T_D128,
       Dia_Chi              T_D128,
       Phones               T_D128,
       Email                T_D128,
       Noi_GH               T_D256,
       Lich_TH              T_BIT, --0: Cho phép giao hàng không theo ngày giao, 1: Bắt buộc giao hàng theo ngày giao
       TTien_Nt0            T_TIEN,
       TTien_Nt             T_TIEN,
       Thue_GTGT            T_PT,
       TTien_Nt3            T_TIEN,
       Ghi_Chu              T_D256,
       Huy_DH               T_BIT, --Hoàn thành hoặc Hủy đơn hàng
       Ngay_Huy             T_DATE, --Ngày hoàn thành hoặc Ngày hủy đơn hàng
       Ghi_Chu_Huy          T_D256, --Lý do
       Ma_Loai1             T_D032,
       Ma_Loai2             T_D032,
       Ma_Loai3             T_D032,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL, --Người tạo (sửa cuối cùng, chính là người đề xuất kiểm tra)
       Posted               T_INT NOT NULL,
       Prev_User            T_D032, --Người kiểm tra và đề xuất phê duyệt
       Post_User            T_D032, --Người duyệt
       Post_Time            T_DATE,
       Locked               T_BIT,
       Lock_User            T_D032,
       Lock_Time            T_DATE,
       Completed            T_BIT DEFAULT 0
)
go

CREATE INDEX XIE1CTDH ON CTDH(Ma_Bp)
go

CREATE INDEX XIE2CTDH ON CTDH(Ma_Hd)
go

CREATE INDEX XIE3CTDH ON CTDH(Ma_Dt)
go

CREATE UNIQUE INDEX XIE4CTDH ON CTDH(Ma_Dvcs, Ma_Ct, So_Ct)
go

CREATE NONCLUSTERED INDEX XIE5CTDH ON CTDH
(
	Ma_Dvcs, Ma_Ct, Ngay_Ct, So_Ct
)
go

ALTER TABLE CTDH
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTDH0 (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       Stt_Nv               T_INT NOT NULL,
       Ma_Vt                T_D032 NOT NULL,
       Ma_Bp                T_D032,
       Ma_Hd                T_D032,
       Ghi_Chu              T_D256,
       Ngay_GH1             T_DATE,
       Ngay_GH2             T_DATE,
       Ngay_TH             T_DATE,
       So_Luong             T_LUONG NOT NULL,
       So_LuongR            T_LUONG DEFAULT 0, --Số lượng đã giao
       So_Luong_TK          T_LUONG DEFAULT 0, --Số lượng theo cân đối vật tư (tồn kho)
       Gia_Nt               T_GIA,
       Tien_Nt              T_TIEN,
       Thue_GTGT            T_PT,
       Tien_Nt3             T_TIEN,
       So_Ct_D              T_D020, --Số chứng từ yêu cầu mua hàng
       Id_CT_Detail         T_ID, --Stt0_D
       Id_CT_Master         T_ID  --Stt_D
)
go

CREATE INDEX XIE2CTDH0 ON CTDH0(Ma_Bp)
go

CREATE INDEX XIE3CTDH0 ON CTDH0(Ma_Hd)
go

CREATE INDEX XIE4CTDH0 ON CTDH0(Ma_Vt)
go

CREATE INDEX XIE1CTDH0 ON CTDH0
(
       ParentId                            ASC
)
go


ALTER TABLE CTDH0
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTYCM (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Ma_Ct                T_D004 NOT NULL,
       Ngay_Ct              T_DATE NOT NULL,
       So_Ct                T_D020,
       Ngay_YC              T_DATE,
       Ma_Bp                T_D032,
       Ma_Hd                T_D032,
       Huy_YCM              T_BIT,
       Ngay_Huy             T_DATE,
       Ghi_Chu              T_D256,
       Ma_Loai1             T_D032,
       Ma_Loai2             T_D032,
       Ma_Loai3             T_D032,
       Posted               T_INT NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL, --Người tạo (sửa cuối cùng, chính là người đề xuất kiểm tra)
       Posted               T_INT NOT NULL,
       Prev_User            T_D032, --Người kiểm tra và đề xuất phê duyệt
       Post_User            T_D032, --Người duyệt
       Post_Time            T_DATE,
       Locked               T_BIT,
       Lock_User            T_D032,
       Lock_Time            T_DATE,
       Completed            T_BIT DEFAULT 0
)
go

CREATE INDEX XIE1CTYCM ON CTYCM(Ma_Bp)
go

CREATE INDEX XIE2CTYCM ON CTYCM(Ma_Hd)
go

ALTER TABLE CTYCM
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTYCM0 (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       Stt_Nv               T_INT NOT NULL,
       Ma_Vt                T_D032 NOT NULL,
       Ma_Bp                T_D032,
       Ma_Hd                T_D032,
       Ghi_Chu              T_D256,
       So_Luong             T_LUONG,
       So_LuongR            T_LUONG DEFAULT 0, --Số lượng đã xuất kho theo yêu cầu
       So_LuongD            T_LUONG DEFAULT 0, --Số lượng đã đặt hàng
       Gia                  T_GIA,
       Tien                 T_TIEN
)
go

CREATE INDEX XIE2CTYCM0 ON CTYCM0(Ma_Bp)
go

CREATE INDEX XIE3CTYCM0 ON CTYCM0(Ma_Hd)
go

CREATE INDEX XIE4CTYCM0 ON CTYCM0(Ma_Vt)
go

CREATE INDEX XIE1CTYCM0 ON CTYCM0
(
       ParentId                            ASC
)
go


ALTER TABLE CTYCM0
       ADD PRIMARY KEY (Id)
go



CREATE TABLE CTSX (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Ma_Ct                T_D004 NOT NULL,
       Ngay_Ct              T_DATE NOT NULL,
       So_Ct                T_D020,
       Ma_Bp                T_D032,
       Ma_Hd                T_D032,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       Huy_SX               T_BIT,
       Ngay_Huy             T_DATE,
       Ghi_Chu              T_D256,
       Ngay_Ht              T_DATE,
       Ma_Loai1             T_D032,
       Ma_Loai2             T_D032,
       Ma_Loai3             T_D032,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL, --Người tạo (sửa cuối cùng, chính là người đề xuất kiểm tra)
       Posted               T_INT NOT NULL,
       Prev_User            T_D032, --Người kiểm tra và đề xuất phê duyệt
       Post_User            T_D032, --Người duyệt
       Post_Time            T_DATE,
       Locked               T_BIT,
       Lock_User            T_D032,
       Lock_Time            T_DATE,
       Completed            T_INT DEFAULT 0
)
go

CREATE INDEX XIE1CTSX ON CTSX(Ma_Bp)
go

CREATE INDEX XIE2CTSX ON CTSX(Ma_Hd)
go

ALTER TABLE CTSX
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTSX0 (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       Stt_Nv               T_INT NOT NULL,
       Ma_Vt                T_D032 NOT NULL,
       Ma_Bp                T_D032,
       Ma_Hd                T_D032,
       So_Luong             T_LUONG NOT NULL,
       So_LuongR            T_LUONG,
       So_Ct_D              T_D020, --Số chứng từ yêu cầu bán hàng CTYCM
       Id_CT_Detail         T_ID,
       Id_CT_Master         T_ID
)
go

CREATE INDEX XIE2CTSX0 ON CTSX0(Ma_Bp)
go

CREATE INDEX XIE3CTSX0 ON CTSX0(Ma_Hd)
go

CREATE INDEX XIE4CTSX0 ON CTSX0(Ma_Vt)
go

CREATE INDEX XIE1CTSX0 ON CTSX0
(
       ParentId                            ASC
)
go


ALTER TABLE CTSX0
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTSX1 (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       Ma_Vt_Nh             T_D001,
       Ma_Vt                T_D032 NOT NULL,
       Ma_Hd                T_D032,
       Ma_Bp                T_D032,
       Ma_Sp                T_D032,
       So_Luong             T_LUONG NOT NULL,
       So_LuongR            T_LUONG
)
go

CREATE INDEX XIE2CTSX1 ON CTSX1(Ma_Bp)
go

CREATE INDEX XIE3CTSX1 ON CTSX1(Ma_Hd)
go

CREATE INDEX XIE4CTSX1 ON CTSX1(Ma_Vt)
go

CREATE INDEX XIE5CTSX1 ON CTSX1(Ma_Sp)
go


CREATE INDEX XIE1CTSX1 ON CTSX1
(
       ParentId                            ASC
)
go


ALTER TABLE CTSX1
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTTP (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Ma_Ct                T_D004 NOT NULL,
       Ngay_Ct              T_DATE NOT NULL,
       So_Ct                T_D020,
       Ma_Bp                T_D032,
       Ma_Hd                T_D032,
       Ghi_Chu              T_D256,
       TTien0               T_TIEN,
       Ma_Loai1             T_D032,
       Ma_Loai2             T_D032,
       Ma_Loai3             T_D032,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL, --Người tạo (sửa cuối cùng, chính là người đề xuất kiểm tra)
       Posted               T_INT NOT NULL,
       Prev_User            T_D032, --Người kiểm tra và đề xuất phê duyệt
       Post_User            T_D032, --Người duyệt
       Post_Time            T_DATE,
       Locked               T_BIT,
       Lock_User            T_D032,
       Lock_Time            T_DATE
)
go

CREATE INDEX XIE1CTTP ON CTTP(Ma_Bp)
go

CREATE INDEX XIE2CTTP ON CTTP(Ma_Hd)
go

ALTER TABLE CTTP
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTTP0 (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       Stt_Nv               T_INT NOT NULL,
       Ma_Vt                T_D032 NOT NULL,
       Ma_Bp                T_D032,
       Ma_Hd                T_D032,
       Ma_Sp                T_D032 NOT NULL,
       Ma_Yt                T_D032 NOT NULL,
       So_Luong             T_LUONG NOT NULL,
       Gia                  T_GIA,
       Tien                 T_TIEN,
       Lo_Hang              T_D032,
       Han_Dung             T_DATE,
       So_Ct_D              T_D020, --Số chứng từ yêu cầu sản xuất CTSX
       Id_CT_Detail         T_ID,
       Id_CT_Master         T_ID
)
go

CREATE INDEX XIE2CTTP0 ON CTTP0(Ma_Bp)
go

CREATE INDEX XIE3CTTP0 ON CTTP0(Ma_Hd)
go

CREATE INDEX XIE4CTTP0 ON CTTP0(Ma_Vt)
go

CREATE INDEX XIE5CTTP0 ON CTTP0(Ma_Sp)
go

CREATE INDEX XIE6CTTP0 ON CTTP0(Ma_Yt)
go

CREATE INDEX XIE1CTTP0 ON CTTP0
(
       ParentId                            ASC
)
go


ALTER TABLE CTTP0
       ADD PRIMARY KEY (Id)
go

/* End Bao gia - Don hang */


/************************************************/
/* Quan ly kho */

CREATE TABLE CTKHO (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Nh_Ct                T_D001,
       Ma_Ct                T_D004 NOT NULL,
       Ngay_Ct              T_DATE NOT NULL,
       So_Ct                T_D020,
       Ma_Dt                T_D032 NOT NULL,
       Ong_Ba               T_D128,
       Dia_Chi              T_D128,
       Ma_KhoN              T_D032,
       Ghi_Chu              T_D256,
       Ma_Loai1             T_D032,
       Ma_Loai2             T_D032,
       Ma_Loai3             T_D032,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL, --Người tạo (sửa cuối cùng, chính là người đề xuất kiểm tra)
       Posted               T_INT NOT NULL,
       Prev_User            T_D032, --Người kiểm tra và đề xuất phê duyệt
       Post_User            T_D032, --Người duyệt
       Post_Time            T_DATE,
       Locked               T_BIT,
       Lock_User            T_D032,
       Lock_Time            T_DATE,
)
go

CREATE INDEX XIE1CTKHO ON CTKHO(Ma_Dt)
go

CREATE INDEX XIE2CTKHO ON CTKHO(Ma_KhoN)
go

ALTER TABLE CTKHO
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTKHO0 (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       Stt_Nv               T_INT NOT NULL,
       Ma_Kho               T_D032 NOT NULL,
       Ma_Ke                T_D032,
       Ma_Vt                T_D032 NOT NULL,
       Ghi_Chu              T_D256,
       Dvt                  T_D020,
       He_So9               T_GIA NOT NULL,
       So_Luong9            T_LUONG NOT NULL,
       So_Luong             T_LUONG NOT NULL,
       Lo_Hang              T_D032,
       Han_Dung             T_DATE,
       Ma_KeN               T_D032
)
go

CREATE INDEX XIE2CTKHO0 ON CTKHO0(Ma_Kho)
go

CREATE INDEX XIE3CTKHO0 ON CTKHO0(Ma_Vt)
go

CREATE INDEX XIE1CTKHO0 ON CTKHO0
(
       ParentId                            ASC
)
go


ALTER TABLE CTKHO0
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CdKho (
       Year_Month           T_D006 NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Ma_Kho               T_D032 NOT NULL,
       Ma_Ke                T_D032 NOT NULL,
       Ma_Vt                T_D032 NOT NULL,
       Lo_Hang              T_D032 NOT NULL,
       Dvt                  T_D020 NOT NULL,
       Ton_Kho              T_LUONG, --Theo đơn vị tính
       So_Luong             T_LUONG, --Theo đơn vị tiêu chuẩn
       Han_Dung             T_DATE
)
go


ALTER TABLE CdKho
       ADD PRIMARY KEY (Year_Month, Ma_Dvcs, Ma_Kho, Ma_Ke, Ma_Vt, Lo_Hang, Dvt)
go


CREATE TABLE CdKho0 (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Ma_Kho               T_D032 NOT NULL,
       Ma_Ke                T_D032 NOT NULL,
       Ma_Vt                T_D032 NOT NULL,
       Dvt                  T_D020 NOT NULL,
       He_So9               T_GIA,
       So_Luong9            T_LUONG,
       So_Luong             T_LUONG NOT NULL,
       Lo_Hang              T_D032,
       Han_Dung             T_DATE,
       Ngay_Ct              T_DATE NOT NULL,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go


ALTER TABLE CdKho0
       ADD PRIMARY KEY (Id)
go


CREATE TABLE SoCaiKho (
       Ma_Dvcs              T_D004 NOT NULL,
       Id_Master            T_ID NOT NULL, --Stt
       Id_Detail            T_ID NOT NULL, --Stt0
       Nh_Ct                T_D001,
       Ma_Ct                T_D004,
       Ngay_Ct              T_DATE,
       So_Ct                T_D020,
       Ma_Dt                T_D032,
       Ghi_Chu              T_D256,
       Ma_Kho               T_D032,
       Ma_Ke                T_D032,
       Ma_Vt                T_D032,
       Dvt                  T_D020,
       So_Luong9            T_LUONG,
       So_Luong             T_LUONG,
       Lo_Hang              T_D032,
       Han_Dung             T_DATE,
       Posted               T_INT NOT NULL
)
go


CREATE NONCLUSTERED INDEX XIE2SoCaiKho ON SoCaiKho
(
	Ma_Dvcs, Ngay_Ct, Nh_Ct, Ma_Kho, Ma_Vt, Posted, Id_Master
)
go


CREATE INDEX XIE1SoCaiKho ON SoCaiKho
(
       Id_Master                            ASC
)
go


ALTER TABLE SoCaiKho
       ADD PRIMARY KEY (Ma_Dvcs, Id_Master, Id_Detail, Nh_Ct)
go


/* End Quan ly kho */


/************************************************/
/* So du dau tai khoan, vat tu */

CREATE TABLE CdNTXT (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Ma_Kho               T_D032 NOT NULL,
       Ma_Vt                T_D032 NOT NULL,
       Dvt                  T_D020,
       He_So9               T_GIA NOT NULL,
       So_Luong9            T_LUONG,
       So_Luong             T_LUONG NOT NULL,
       Tien                 T_TIEN,
       Lo_Hang              T_D032,
       Han_Dung             T_DATE,
       Ngay_Ct              T_DATE NOT NULL,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go


ALTER TABLE CdNTXT
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CdNTXT0 (
       Ma_Dvcs              T_D004 NOT NULL,
       Id_Master            T_ID, --Stt
       Id_Detail            T_ID NOT NULL, --Stt0
       Ngay_Ct              T_DATE NOT NULL,
       So_Ct                T_D020,
       Ma_Kho               T_D032 NOT NULL,
       Ma_Vt                T_D032 NOT NULL,
       Lo_Hang              T_D032 NOT NULL,
       So_Luong             T_LUONG,
       Tien                 T_TIEN,
       Posted               T_INT NOT NULL
)
go


CREATE INDEX XIE1CdNTXT0 ON CdNTXT0
(
       Id_Master                            ASC
)
go


ALTER TABLE CdNTXT0
       ADD PRIMARY KEY (Id_Detail)
go



CREATE TABLE CdNTXT1 (
       Id_Master_PN         T_ID, --Stt_PN
       Id_Detail_PN         T_ID, --Stt0_PN
       Id_Master_PX         T_ID, --Stt_PX
       Id_Detail_PX         T_ID, --Stt0_PX
       So_Luong             T_LUONG,
       Tien                 T_TIEN
)
go

CREATE INDEX XIE1CdNTXT1 ON CdNTXT1
(
       Id_Detail_PN                        ASC
)
go

CREATE INDEX XIE2CdNTXT1 ON CdNTXT1
(
       Id_Detail_PX                        ASC
)
go


CREATE TABLE CdVT (
       Year_Month           T_D006 NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Ma_Kho               T_D032 NOT NULL,
       Ma_Vt                T_D032 NOT NULL,
       Lo_Hang              T_D032 NOT NULL,
       Dvt                  T_D020 NOT NULL,
       Ton_Kho              T_LUONG,
       So_Luong             T_LUONG,
       So_Du_Nt             T_TIEN,
       So_Du                T_TIEN,
       Ton_Kho0             T_LUONG,
       So_Luong0            T_LUONG,
       So_Du_Nt0            T_TIEN,
       So_Du0               T_TIEN,
       Han_Dung             T_DATE
)
go


ALTER TABLE CdVT
       ADD PRIMARY KEY (Year_Month, Ma_Dvcs, Ma_Kho, Ma_Vt, Lo_Hang, Dvt)
go


CREATE INDEX XEI1CdVT ON CdVT(Ma_Vt, Ma_Kho, Lo_Hang, Year_Month, Ma_Dvcs, Ton_Kho, So_Luong)
go


CREATE INDEX XEI2CdVT ON CdVT(Ma_Vt)
go


CREATE INDEX XEI3CdVT ON CdVT(Ma_Kho)
go


/* End so du dau tai khoan, vat tu */


/************************************************/
/* Bao cao quyet toan */

CREATE TABLE KQT01 (
       Id                   T_ID NOT NULL,
       IDKey                T_INT NOT NULL,
       Stt0                 T_D020,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       TMinh                T_D020,
       Depth                T_INT NOT NULL,
       Stt_Bac              T_INT NOT NULL,
       Cong_Thuc            T_D256,
       Ts_Nc                T_D001,
       Loai_Ts              T_D001,
       Tk                   T_D256,
       In_Ck                T_BIT,
       Bold                 T_BIT,
       Italic               T_BIT,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go


ALTER TABLE KQT01
       ADD PRIMARY KEY (Id)
go


CREATE TABLE KQT01A (
       Id                   T_ID NOT NULL,
       IDKey                T_INT NOT NULL,
       Stt0                 T_D020,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       TMinh                T_D020,
       Depth                T_INT NOT NULL,
       Stt_Bac              T_INT NOT NULL,
       Cong_Thuc            T_D256,
       Ts_Nc                T_D001,
       Loai_Ts              T_D001,
       Tk                   T_D256,
       In_Ck                T_BIT,
       Bold                 T_BIT,
       Italic               T_BIT,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go


ALTER TABLE KQT01A
       ADD PRIMARY KEY (Id)
go


CREATE TABLE KQT01B (
       Id                   T_ID NOT NULL,
       IDKey                T_INT NOT NULL,
       Stt0                 T_D020,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       TMinh                T_D020,
       Depth                T_INT NOT NULL,
       Stt_Bac              T_INT NOT NULL,
       Cong_Thuc            T_D256,
       Ts_Nc                T_D001,
       Loai_Ts              T_D001,
       Tk                   T_D256,
       In_Ck                T_BIT,
       Bold                 T_BIT,
       Italic               T_BIT,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go


ALTER TABLE KQT01B
       ADD PRIMARY KEY (Id)
go


CREATE TABLE KQT02 (
       Id                   T_ID NOT NULL,
       IDKey                T_INT NOT NULL,
       Stt0                 T_D020,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       TMinh                T_D020,
       Depth                T_INT NOT NULL,
       Stt_Bac              T_INT NOT NULL,
       Cong_Thuc            T_D256,
       Tk_No                T_D256,
       Tk_Co                T_D256,
       In_Ck                T_BIT,
       Bold                 T_BIT,
       Italic               T_BIT,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go


ALTER TABLE KQT02
       ADD PRIMARY KEY (Id)
go


CREATE TABLE KQT032 (
       Id                   T_ID NOT NULL,
       IDKey                T_INT NOT NULL,
       Stt0                 T_D020,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       TMinh                T_D020,
       Depth                T_INT NOT NULL,
       Stt_Bac              T_INT NOT NULL,
       Cong_Thuc            T_D256,
       Tk_No                T_D256,
       Tk_Co                T_D256,
       Bold                 T_BIT,
       In_Ck                T_BIT,
       Italic               T_BIT,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go


ALTER TABLE KQT032
       ADD PRIMARY KEY (Id)
go



CREATE TABLE KQT05 (
       Id                   T_ID NOT NULL,
       IDKey                T_INT NOT NULL,
       Stt0                 T_D020,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       Series01             T_D020,
       Series02             T_D020,
       Depth                T_INT NOT NULL,
       Stt_Bac              T_INT NOT NULL,
       Cong_Thuc            T_D256,
       Vao_Ra               T_D001,
       Xuat_Xu              T_INT DEFAULT 0 NOT NULL, --0: Trong nước, 1: Nhập khẩu
       Dieu_Chinh           T_D001,
       Loai_Thue            T_D001, --1. Thuế suất 0%, 2.Thuế suất 5%, 3.Thuế suất 10%, 0.Không chịu thuế
       Kieu_Ps              T_D001,
       In_Ck                T_BIT,
       Bold                 T_BIT,
       Italic               T_BIT,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go

CREATE UNIQUE INDEX XAK1KQT05 ON KQT05
(
       IDKey                            ASC
)
go


ALTER TABLE KQT05
       ADD PRIMARY KEY (Id)
go



CREATE TABLE KQT09 (
       Id                   T_ID NOT NULL, --Key
       IDKey                T_INT NOT NULL, --Giá trị dùng để tạo công thức
       ItemCode             T_D032, --Chỉ mục I->IV, a->z, A->Z, 1->9
       PartCode             T_D020 NOT NULL, --Thuộc đoạn nào: I, II, III, IV, ...
       ItemType             T_INT NOT NULL, --Tiêu đề: 2, Chi tiết: 0, Tổng hợp: 1 Chú thích: 3
       ItemName             NVARCHAR(1024),
       ItemName_E           NVARCHAR(1024),
       ItemValue            NVARCHAR(MAX),
       ItemValue2           NVARCHAR(MAX), --Dùng trong một số trường hợp đặc biệt. Ví dụ: VI.29b => Đơn vị tính
       ItemNotice           NVARCHAR(MAX),
       F000                 NVARCHAR(MAX), --Chuỗi giá trị công thức, dùng cho cột Tổng cộng
       F001                 NVARCHAR(MAX), --Chuỗi giá trị công thức
       F002                 NVARCHAR(MAX), --Chuỗi giá trị công thức
       F003                 NVARCHAR(MAX), --Chuỗi giá trị công thức
       F004                 NVARCHAR(MAX), --Chuỗi giá trị công thức
       F005                 NVARCHAR(MAX), --Chuỗi giá trị công thức
       F006                 NVARCHAR(MAX), --Chuỗi giá trị công thức
       F007                 NVARCHAR(MAX), --Chuỗi giá trị công thức
       F008                 NVARCHAR(MAX), --Chuỗi giá trị công thức
	   F009                 NVARCHAR(MAX), --Chuỗi giá trị công thức
       FomulaXML            xml,
       ItemFomulaLevel      T_INT NOT NULL, --Bậc chỉ tiêu
       ItemFomula           T_D256, --Công thức
       FontSize             T_INT NOT NULL,
       Depth                T_INT NOT NULL, --Căn lề trái
       Visible              T_BIT,
       Bold                 T_BIT,
       Italic               T_BIT,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go


ALTER TABLE KQT09
       ADD PRIMARY KEY (Id)
go

CREATE UNIQUE INDEX XEI1KQT09 ON KQT09(IDKey)
go

/* End Bao cao quyet toan */


/************************************************/
/* Gia thanh */





/* End gia thanh */

/************************************************/

/* Chenh lech ty gia cuoi ky */
CREATE TABLE SoCaiCL (
       Id_Master            T_ID NOT NULL,
       Ma_Dvcs              T_D004,
       Ngay_Ct              T_DATE NOT NULL,
       Ma_Bp                T_D032,
       Ma_Hd                T_D032,
       Ma_Dt                T_D032,
       Ma_Tte               T_D003,
       Ty_Gia0              T_TGIA NOT NULL,
       Ty_Gia_Ht0           T_TGIA NOT NULL, --Tỷ giá gốc
       Ty_Gia1              T_TGIA NOT NULL,
       Ty_Gia_Ht1           T_TGIA NOT NULL, --Tỷ giá tại thời điểm đánh giá lại
       No_Co                T_D001,
       Tk                   T_D032 NOT NULL,
       Tien_Nt              T_TIEN,
       Tien                 T_TIEN,  --Giá trị chênh lệch khi đánh giá lại
       Han_Tt               T_DATE
)
go


CREATE INDEX XIE2SoCaiCL ON SoCaiCL (Id_Master, Ma_Bp, Ma_Hd, Ma_Dt, Ma_Tte, No_Co, Tk, Han_Tt)
go

CREATE CLUSTERED INDEX XIE1SoCaiCL ON SoCaiCL
(
       Id_Master                            ASC
)
go

CREATE INDEX XIE3SoCaiCL ON SoCaiCL(Ngay_Ct)
go

CREATE INDEX XIE4SoCaiCL ON SoCaiCL(Ma_Bp)
go

CREATE INDEX XIE5SoCaiCL ON SoCaiCL(Ma_Hd)
go

CREATE INDEX XIE6SoCaiCL ON SoCaiCL(Ma_Dt)
go

CREATE INDEX XIE7SoCaiCL ON SoCaiCL(Tk)
go

/* End Chenh lech ty gia cuoi ky */


/* Gia thanh */

CREATE TABLE CdZ (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004,
       Ngay_Ct              T_DATE,
       Ma_Sp                T_D032,
       Ma_Yt                T_D032,
       Ma_Dm_Sp             T_D032 NULL,
       Ton_Cuoi             T_LUONG NULL,
       Du_Cuoi              T_TIEN NULL,
       Ma_Vt_Nh             T_D001,
       Loai_DD              T_D001,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go

CREATE INDEX XIE1CdZ ON CdZ
(
       Ma_Dvcs                        ASC,
       Ngay_Ct                        ASC,
       Ma_Sp                          ASC,
       Ma_Yt                          ASC,
       Ma_Vt_Nh                       ASC,
       Ma_Dm_Sp                       ASC
)
go


ALTER TABLE CdZ
       ADD PRIMARY KEY (Id)
go


CREATE TABLE So_LuongDD (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004,
       Ngay_Ct              T_DATE,
       Ma_Sp                T_D032,
       So_Luong             T_LUONG,
       Ty_Le_Ht             T_PT,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go


ALTER TABLE So_LuongDD
       ADD PRIMARY KEY (Id)
go


CREATE TABLE ZChiTiet (
       Id                   T_ID DEFAULT NEWID() NOT NULL,
       ParentId             T_ID NOT NULL,
       Ma_Dvcs              T_D004,
       Ngay_Ct              T_DATE,
       Ma_Sp                T_D032,
       Ma_Yt                T_D032,
       Ma_Vt                T_D032 NULL,
       So_LuongDM           T_LUONG NULL,
       So_LuongTT           T_LUONG NULL,
       TienDM               T_TIEN NULL,
       TienTT               T_TIEN NULL,
       Tong_SL_DM           T_LUONG NULL,
       Tong_T_DM            T_TIEN NULL,
       So_LuongSP           T_LUONG NULL,
       So_LuongDD           T_LUONG NULL,
       Tong_SL              T_LUONG NULL,
       Tong_Tien            T_TIEN NULL,
       So_Luong             T_LUONG NULL,
       Tien                 T_TIEN NULL,
       So_LuongP            T_LUONG NULL, --Phan bo phan phat sinh trong ky dung de hien thi man hinh tinh gia thanh
       TienP                T_TIEN NULL   --Phan bo phan phat sinh trong ky dung de hien thi man hinh tinh gia thanh
)
go


CREATE INDEX XIE1ZChiTiet ON ZChiTiet
(
       ParentId                       ASC,
       Ma_Dvcs                        ASC,
       Ngay_Ct                        ASC,
       Ma_Sp                          ASC,
       Ma_Yt                          ASC,
       Ma_Vt                          ASC
)
go


ALTER TABLE ZChiTiet
       ADD PRIMARY KEY (Id)
go


CREATE TABLE ZHeSo (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       RowId                T_INT,
       Ma_Sp                T_D032,
       He_So                T_LUONG
)
go


ALTER TABLE ZHeSo
       ADD PRIMARY KEY (Id)
go


CREATE TABLE ZPhanBo (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004,
       Loai_Pb              T_D001, --Loại phân bổ: 1-Trực tiếp, 2-Hệ số, 3-Tỷ lệ, 4-Định mức
       Ma_Yt                T_D032,
       Ma_Sp                T_D032,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       Loai_Yt              T_D001, --Phân bổ định mức: L-Lượng, T-Tiền
       Ma_Yt0               T_D032,
       Yt_Di01              T_D032,
       Yt_Di02              T_D032,
       Yt_Di03              T_D032,
       Yt_Di04              T_D032,
       Yt_Di05              T_D032,
       Lay_DL_TH            T_D001, --Cách lấy dữ liệu: 0-Từ phân bổ chung, 1-Từ phát sinh chi tiết
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go


ALTER TABLE ZPhanBo
       ADD PRIMARY KEY (Id)
go


CREATE TABLE ZHeSoC (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       RowId                T_INT NOT NULL,
       Ma_Sp                T_D032,
       He_So                T_LUONG,
       Tien_PB              T_TIEN
)
go


ALTER TABLE ZHeSoC
       ADD PRIMARY KEY (Id)
go

--Cân nhắc Ngay_Ct1 và Ngay_Ct2 (hiện đang bỏ)
CREATE TABLE ZPhanBoC (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004,
       Ngay_Ct1             T_DATE,
       Ngay_Ct2             T_DATE,
       Ma_Yt                T_D032,
       Ma_Sp                T_D032,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       TTien_PB             T_TIEN,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go


ALTER TABLE ZPhanBoC
       ADD PRIMARY KEY (Id)
go



CREATE TABLE CdS (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004,
       Tk                   T_D032,
       No_Co                T_D001,
       Tk_Du                T_D032,
       Ma_Dt                T_D032,
       Ma_Sp                T_D032,
       Ma_Vt                T_D032,
       So_Luong             T_LUONG,
       Gia_Nt               T_GIA,
       Gia                  T_GIA,
       Tien_Nt              T_TIEN,
       Tien                 T_TIEN,
       DM_Luong             T_D001,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go


ALTER TABLE CdS
       ADD PRIMARY KEY (Id)
go




CREATE TABLE SChiTiet (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       Ma_Dvcs              T_D004,
       Ngay_Ct1             T_DATE,
       Ngay_Ct2             T_DATE,
       Ma_Sp                T_D032,
       Tien1                T_TIEN,
       He_So                T_PT,
       Tien0                T_TIEN
)
go

CREATE INDEX XIE1SChiTiet ON SChiTiet
(
       ParentId                       ASC,
       Ma_Dvcs                        ASC,
       Ma_Sp                          ASC
)
go


ALTER TABLE SChiTiet
       ADD PRIMARY KEY (Id)
go


CREATE TABLE SHeSo (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       RowId                T_INT NOT NULL,
       Ma_Sp                T_D032,
       He_So                T_LUONG
)
go


ALTER TABLE SHeSo
       ADD PRIMARY KEY (Id)
go


CREATE TABLE SPhanBo (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004,
       Loai_Pb              T_D001,
       Tk_Di                T_D032,
       Ma_Sp                T_D032,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       Tk_Den               T_D032,
       Tk_Di01              T_D032,
       Tk_Di02              T_D032,
       Tk_Di03              T_D032,
       Tk_Di04              T_D032,
       Tk_Di05              T_D032,
       CreatedAt            T_DATE NOT NULL,
       CreatedBy            T_D032 NOT NULL,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL
)
go


ALTER TABLE SPhanBo
       ADD PRIMARY KEY (Id)
go



/* End gia thanh */


/* Hoa don dien tu */

CREATE TABLE CTHD (
       Ma_Dvcs              T_D004 NOT NULL,
       Ma_Nvu               T_D001 NOT NULL, --K: CTKT; M: CTMH; B: CTBH; V: Tạo độc lập từ chứng từ hóa đơn điện tử
       Loai_Hd              T_D001 NOT NULL, --1: Gốc; 3: Thay thế; 4: Điều chỉnh tăng; 5: Điều chỉnh giảm; 8: Điều chỉnh tăng chiết khấu; 9: Điều chỉnh giảm chiết khấu
       Id                   T_ID NOT NULL, --Id của chứng từ gốc (CTKT, CTMH, CTBH), trường hợp tạo độc lập thì là mới
       Ma_LHD               T_D020 NOT NULL, --01GTKT, 02GTTT, 07KPTQ, 03XKNB, 04HGDL
       Mau_So               T_D032,
       So_Seri              T_D020,
       Ngay_Ct              T_DATE NOT NULL,
       So_Ct                T_D020,
       Ma_Dt                T_D032 NOT NULL,
       Ten_Dt               T_D256 NOT NULL,
       Ong_Ba               T_D256,
       Dia_Chi              T_D256 NOT NULL,
       Phones               T_D128,
       Emails               T_D128,
       Tk_NH                T_D032,
       Ten_NH               T_D128,
       Ms_Thue              T_D020,
       Ht_Ttoan             T_D128,
       Ma_Tte               T_D003,
       Ty_Gia               T_TGIA NOT NULL,
       TTien_Nt2            T_TIEN, --Tiền hàng
       TTien_Nt3            T_TIEN, --Tiền thuế VAT
       TTien_Nt4            T_TIEN, --Chiết khấu
       TTien_Nt0            T_TIEN, --Tổng tiền thanh toán
       Ghi_Chu              NVARCHAR(512),
       Ghi_Chu4             T_D256,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL, --Người tạo (sửa cuối cùng, chính là người đề xuất kiểm tra)
       Posted               T_INT NOT NULL, -- -1: Trạng thái tạo lập mới; 1:Trạng thái đã phát hành; 0: Trạng thái đã xóa bỏ
       PostedAt             T_DATE, --Thời điểm phát hành
       PostedBy             T_D032, --Người phát hành
       ErasedAt             T_DATE, --Thời điểm xóa bỏ
       ErasedBy             T_D032, --Người xóa bỏ
       CertifiedId          T_D128, --(15)
       OriginalCertifiedId  T_D128, --(15) (CTBH.CertifiedId) Id của chứng từ gốc khi thực hiện điều chỉnh, thay thế
       OriginalKey          T_ID, --(CTBH.Id) Id của chứng từ gốc khi thực hiện điều chỉnh, thay thế
       OriginalDate         T_DATE, --(CTBH.Ngay_Ct) Ngày của chứng từ gốc khi thực hiện điều chỉnh, thay thế
       OriginalNumber       T_D020, --(CTBH.So_Ct) Số của chứng từ gốc khi thực hiện điều chỉnh, thay thế
       OriginalSerial       T_D020, --(CTBH.So_Seri) Ký hiệu của chứng từ gốc khi thực hiện điều chỉnh, thay thế
       OriginalForm         T_D032, --(CTBH.Mau_So) Mẫu hóa đơn của chứng từ gốc khi thực hiện điều chỉnh, thay thế
       AdditionalReferenceDate     T_DATE, --Ngày biên bản thay thế, điều chỉnh
       AdditionalReferenceNo       T_D128, --Số biên bản thay thế, điều chỉnh
       AdditionalReferenceDesc     T_D256, --Lý do thay thế, điều chỉnh
       AdditionalReferenceFile     T_D128,  --File biên bản thay thế, điều chỉnh
       DeletedDate                 T_DATE, --Ngày xóa bỏ
       DeletedReferenceDate        T_DATE, --Ngày biên bản xóa bỏ
       DeletedReferenceNo          T_D128, --Số biên bản
       DeletedReferenceDesc        T_D256, --Lý do xóa bỏ
       DeletedReferenceFile        T_D128  --File biên bản xóa bỏ
)
go

CREATE INDEX XIE1CTHD ON CTHD(Ma_Dt)
go

ALTER TABLE CTHD
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTHD0 (
       ParentId             T_ID NOT NULL,
       Id                   T_ID NOT NULL,
       Stt_Nv               T_INT NOT NULL,
	   Stt_Vt				T_D004, --Số thứ tự dòng khi in
	   Loai_Vt				NVARCHAR(2), --MT: Mô tả; CK: Chiết khấu; KM: Khuyến mãi; Truyền rỗng: Thông thường
       Ma_Vt                T_D032 NOT NULL,
       Ten_Vt               T_D256,
       Dvt                  T_D020,
       Cs_Dau               T_LUONG,
       Cs_Cuoi              T_LUONG,
       So_Luong             T_LUONG,
       Gia_Nt2              T_GIA,
       Tien_Nt2             T_TIEN,
       Thue_GTGT            T_INT, --0: Thuế suất 0%; 5: Thuế suất 5%; 10: Thuế suất 10%; -1: Không chịu thuế; -2: Không kê khai nộp thuế
       Tien_Nt3             T_TIEN,
       Chiet_Khau           T_PT,
       Tien_Nt4             T_TIEN,
       Lo_Hang              T_D032,
       Han_Dung             T_DATE,
       Ghi_Chu              NVARCHAR(512)
)
go

CREATE INDEX XIE1CTHD0 ON CTHD0(Ma_Vt)
go

CREATE INDEX XIE2CTHD0 ON CTHD0
(
       ParentId                    ASC
)
go


ALTER TABLE CTHD0
       ADD PRIMARY KEY (Id)
go

/* End Hoa don dien tu */


/* Nhận hóa đơn điện tử đầu vào */

CREATE TABLE EINVOICE (
       EmailId              T_D020 NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Id                   T_ID NOT NULL,
       Ngay_Ct0             T_DATE NOT NULL,
       So_Ct0               T_D020 NOT NULL,
       So_Seri0             T_D020 NOT NULL,
       Mau_So0              T_D032 NOT NULL,
       Ma_DtGTGT            T_D020 NOT NULL, --Mã số thuế
       Ten_DtGTGT           T_D128,
       Tien2                T_TIEN, --Tiền hàng
       Tien3                T_TIEN, --Tiền thuế
       Tien6                T_TIEN, --Tiền thuế/phí khác
       EPosted              T_BIT NOT NULL DEFAULT 0, --Thông tin cảnh báo: 0-Không có cảnh báo, 1-Có cảnh báo
       Posted               T_INT, --Đã hạch toán chưa: 0-Chưa hạch toán; 1-Đã hạch toán
	   Ma_CTKT				T_D004,
	   Id_CTKT				T_ID,
       ModifiedAt           T_DATE NOT NULL
)
go


CREATE INDEX XIE1EINVOICE ON EINVOICE
(
       EmailId                            ASC
)
go


CREATE UNIQUE INDEX XIE2EINVOICE ON EINVOICE
(
       Ma_Dvcs, Ngay_Ct0, So_Ct0, So_Seri0, Mau_So0, Ma_DtGTGT                            ASC
)
go


ALTER TABLE EINVOICE
       ADD PRIMARY KEY (Id)
go

/* End Nhận hóa đơn điện tử đầu vào */


--CTSG - Chứng từ chính sách giá bán
--CTSG0 - Chi tiết mặt hàng
--CTSG1 - Chi tiết nhóm đối tượng, đối tượng
CREATE TABLE CTSG (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Nh_Ct                T_D001,
       Ma_Ct                T_D004 NOT NULL,
       Ngay_Ct              T_DATE NOT NULL,
       So_Ct                T_D020,
       Ma_Tte               T_D003,
       Ty_Gia               T_TGIA NOT NULL,
       Loai_BG              T_D001 NOT NULL, --0: Áp dụng cho tất cả các khách hàng, 1: Áp dụng cụ thể cho nhóm đối tượng và đối tượng
       Ngay_HL1             T_DATE,
       Ngay_HL2             T_DATE,
       Ghi_Chu              T_D256,
       Ma_Loai1             T_D032,
       Ma_Loai2             T_D032,
       Ma_Loai3             T_D032,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL, --Người tạo (sửa cuối cùng, chính là người đề xuất kiểm tra)
       Posted               T_INT NOT NULL,
       Prev_User            T_D032, --Người kiểm tra và đề xuất phê duyệt
       Post_User            T_D032, --Người duyệt
       Post_Time            T_DATE,
       Locked               T_BIT,
       Lock_User            T_D032,
       Lock_Time            T_DATE
)
go


CREATE UNIQUE INDEX XIE1CTSG ON CTSG(Ma_Dvcs, Ma_Ct, So_Ct)
go

CREATE NONCLUSTERED INDEX XIE2CTSG ON CTSG
(
	Ma_Dvcs, Ma_Ct, Ngay_Ct, So_Ct
)
go

ALTER TABLE CTSG
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTSG0 (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       Stt_Nv               T_INT NOT NULL,
       Ma_Vt                T_D032 NOT NULL,
       Ghi_Chu              T_D256,
       Gia_Nt               T_GIA
)
go


CREATE INDEX XIE1CTSG0 ON CTSG0
(
       ParentId                            ASC
)
go


ALTER TABLE CTSG0
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTSG1 (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       Stt_Nv               T_INT NOT NULL,
       ChildType            T_INT NOT NULL, --1: Nhóm đối tượng, 2: Đối tượng
       ChildId              T_ID NOT NULL, --Id của mã nhóm đối tượng hoặc đối tượng
       Chiet_Khau           T_PT,
       Giam_Gia             T_PT,
       Ghi_Chu              T_D256
)
go


CREATE INDEX XIE1CTSG1 ON CTSG1
(
       ParentId                            ASC
)
go


ALTER TABLE CTSG1
       ADD PRIMARY KEY (Id)
go


--Chuyen tu UNIQUE sang NON UNIQUE
--CREATE UNIQUE INDEX XIE2SoCaiTT ON SoCaiTT (S_Order, D_Order, Ma_Bp, Ma_Hd, Ma_Dt, Ma_Tte, No_Co, Tk, Han_Tt)
--Có thể bổ sung (S,D) vào 2 dòng và thêm vào Index

--Kế hoạch thu - chi
CREATE TABLE CTKH (
       Id                   T_ID NOT NULL,
       Ma_Dvcs              T_D004 NOT NULL,
       Nh_Ct                T_D001,
       Ma_Ct                T_D004 NOT NULL,
       Ngay_Ct              T_DATE NOT NULL,
       So_Ct                T_D020,
       Dien_Giai            T_D256,
       Dien_Giai_E          T_D256,
       Muc_Tieu             T_D256,
       Ma_Nv_PT             T_D032, --Người chịu phụ trách
       Ma_Nv_PH             T_D032, --Người phối hợp
       Lich_TH              T_BIT, --0: Cho phép thực hiện không theo kế hoạch, 1: Bắt buộc phải thực hiện theo thời gian kế hoạch
       TTien                T_TIEN, --Số tiền
       Huy_KH               T_BIT, --Hoàn thành hoặc Hủy kế hoạch
       Ngay_Huy             T_DATE, --Ngày hoàn thành hoặc Ngày hủy kế hoạch
       Ghi_Chu_Huy          T_D256, --Lý do
       Ma_Loai1             T_D032,
       Ma_Loai2             T_D032,
       Ma_Loai3             T_D032,
       ModifiedAt           T_DATE NOT NULL,
       ModifiedBy           T_D032 NOT NULL, --Người tạo (sửa cuối cùng, chính là người đề xuất kiểm tra)
       Posted               T_INT NOT NULL,
       Prev_User            T_D032, --Người kiểm tra và đề xuất phê duyệt
       Post_User            T_D032, --Người duyệt
       Post_Time            T_DATE,
       Locked               T_BIT,
       Lock_User            T_D032,
       Lock_Time            T_DATE
)
go


CREATE NONCLUSTERED INDEX XIE1CTKH ON CTKH
(
	Ma_Dvcs, Ma_Ct, Ngay_Ct, So_Ct
)
go


CREATE UNIQUE INDEX XIE2CTKH ON CTKH(Ma_Dvcs, Ma_Ct, So_Ct)
go


ALTER TABLE CTKH
       ADD PRIMARY KEY (Id)
go


CREATE TABLE CTKH0 (
       Id                   T_ID NOT NULL,
       ParentId             T_ID NOT NULL,
       Stt_Nv               T_INT NOT NULL,
       Ma_Dt                T_D032 NOT NULL,
       Noi_Dung             T_D256,
       Tien                 T_TIEN, --Số tiền
       TienR                T_TIEN, --Số tiền đã thực hiện
       Hthuc_Tt             T_D001, --1: Tiền mặt, 2: Chuyển khoản, 0-Khác
       Dieu_Kien            T_D256, --Điều kiện đảm bảo công việc
       Ngay_TH              T_DATE, --Ngày thực hiện
       Ngay_Bd              T_DATE, --Ngày bắt đầu kế hoạch
       Ngay_Kt              T_DATE, --Ngày kết thúc kế hoạch
       Ngay_Dk              T_DATE --Ngày dự kiến chi
)
go


CREATE INDEX XIE1CTKH0 ON CTKH0
(
       ParentId                            ASC
)
go


CREATE INDEX XIE1CTKH1 ON CTKH0
(
	ParentId, Ma_Dt, Ngay_Dk
)
go



ALTER TABLE CTKH0
       ADD PRIMARY KEY (Id)
go


--Ngay 14/12/2022: Bổ sung sổ cái CTKH (SocaiKH), CTDH (SoCaiDH)
CREATE TABLE SoCaiDH (
       Ma_Dvcs              T_D004 NOT NULL,
       Id_Master            T_ID NOT NULL, -- Stt
       Id_Detail            T_ID NOT NULL, -- Stt0
       Nh_Ct                T_D001,
       Ma_Ct                T_D004,
       Ngay_Ct              T_DATE,
       So_Ct                T_D020,
       Ma_Dt                T_D032,
       Ma_Vt                T_D032,
       Lich_TH              T_BIT, --0: Cho phép giao hàng không theo ngày giao, 1: Bắt buộc giao hàng theo ngày giao
       Ngay_TH              T_DATE,
       Ngay_GH1             T_DATE,
       Ngay_GH2             T_DATE,
       So_Luong             T_LUONG,
       So_LuongR            T_LUONG DEFAULT 0,
       Gia_Nt               T_GIA,
       Tien_Nt              T_TIEN,
       Huy_DH               T_BIT NOT NULL,
       Posted               T_INT NOT NULL,
       Id_CT_Master         T_ID, -- Stt_D
       Id_CT_Detail         T_ID  -- Stt0_D
)
go


CREATE CLUSTERED INDEX XIE1SoCaiDH ON SoCaiDH
(
       Id_Master                            ASC
)
go


CREATE NONCLUSTERED INDEX XIE2SoCaiDH ON SoCaiDH
(
	Ma_Dvcs, Ngay_Ct, Nh_Ct, Ma_Vt, Posted, Id_Master, So_Luong
)
go


CREATE INDEX XEI3SoCaiDH ON SoCaiDH(Ngay_Ct)
go


CREATE INDEX XEI4SoCaiDH ON SoCaiDH(Ma_Vt)
go


ALTER TABLE CTMH0 ADD CONSTRAINT Check_Synchronize_CTMH0 CHECK ((So_Ct_D IS NULL AND Id_CT_Detail IS NULL AND Id_CT_Master IS NULL) OR (So_Ct_D IS NOT NULL AND Id_CT_Detail IS NOT NULL AND Id_CT_Master IS NOT NULL))
ALTER TABLE CTBH0 ADD CONSTRAINT Check_Synchronize_CTBH0 CHECK ((So_Ct_D IS NULL AND Id_CT_Detail IS NULL AND Id_CT_Master IS NULL) OR (So_Ct_D IS NOT NULL AND Id_CT_Detail IS NOT NULL AND Id_CT_Master IS NOT NULL))
ALTER TABLE CTNX0 ADD CONSTRAINT Check_Synchronize_CTNX0 CHECK ((So_Ct_D IS NULL AND Id_CT_Detail IS NULL AND Id_CT_Master IS NULL) OR (So_Ct_D IS NOT NULL AND Id_CT_Detail IS NOT NULL AND Id_CT_Master IS NOT NULL))
ALTER TABLE SoCaiDH ADD CONSTRAINT Check_Implement_Date_SoCaiDH CHECK (Ngay_TH IS NULL OR Ngay_TH >= Ngay_Ct)
ALTER TABLE SoCaiDH ADD CONSTRAINT Check_Implement_Value_SoCaiDH CHECK (So_LuongR BETWEEN 0 AND So_Luong)
ALTER TABLE SoCaiDH ADD CONSTRAINT Check_Schedule_SoCaiDH CHECK (Lich_TH = 0 OR (Lich_TH = 1 AND (Ngay_TH IS NULL OR Ngay_TH BETWEEN Ngay_GH1 AND Ngay_GH2)))
go


CREATE TABLE SoCaiKH (
       Ma_Dvcs              T_D004 NOT NULL,
       Id_Master            T_ID NOT NULL, -- Stt
       Id_Detail            T_ID NOT NULL, -- Stt0
       Nh_Ct                T_D001,
       Ma_Ct                T_D004,
       Ngay_Ct              T_DATE,
       So_Ct                T_D020,
       Ma_Dt                T_D032,
       Noi_Dung             T_D256,
       Lich_TH              T_BIT, --0: Cho phép thực hiện không theo kế hoạch, 1: Bắt buộc phải thực hiện theo thời gian kế hoạch
       Ngay_TH              T_DATE,
       Ngay_Bd              T_DATE,
       Ngay_Kt              T_DATE,
       Ngay_Dk              T_DATE,
       Tien                 T_TIEN,
       TienR                T_TIEN DEFAULT 0,
       Huy_KH               T_BIT NOT NULL,
       Posted               T_INT NOT NULL
)
go


CREATE CLUSTERED INDEX XIE1SoCaiKH ON SoCaiKH
(
       Id_Master                            ASC
)
go


CREATE NONCLUSTERED INDEX XIE2SoCaiKH ON SoCaiKH
(
	Ma_Dvcs, Ngay_Ct, Nh_Ct, Ma_Dt, Posted, Id_Master, Tien
)
go


CREATE INDEX XEI3SoCaiKH ON SoCaiKH(Ngay_Ct)
go


CREATE INDEX XEI4SoCaiKH ON SoCaiKH(Ma_Dt)
go


ALTER TABLE CTKT0 ADD CONSTRAINT Check_Synchronize_CTKT0 CHECK ((So_Ct_D IS NULL AND Id_CT_Detail IS NULL AND Id_CT_Master IS NULL) OR (So_Ct_D IS NOT NULL AND Id_CT_Detail IS NOT NULL AND Id_CT_Master IS NOT NULL))
ALTER TABLE SoCaiKH ADD CONSTRAINT Check_Implement_Date_SoCaiKH CHECK (Ngay_TH IS NULL OR Ngay_TH >= Ngay_Ct)
ALTER TABLE SoCaiKH ADD CONSTRAINT Check_Implement_Value_SoCaiKH CHECK (TienR BETWEEN 0 AND Tien)
ALTER TABLE SoCaiKH ADD CONSTRAINT Check_Schedule_SoCaiKH CHECK (Lich_TH = 0 OR (Lich_TH = 1 AND (Ngay_TH IS NULL OR Ngay_TH BETWEEN Ngay_Bd AND Ngay_Kt)))
go


--Sổ cái thu chi, dùng để tính giá trị thực hiện kế hoạch thu chi
CREATE TABLE SoCaiK (
       Ma_Dvcs              T_D004 NOT NULL,
       Id_Master            T_ID NOT NULL, -- Stt
       Id_Detail            T_ID NOT NULL, -- Stt0
       Nh_Ct                T_D001,
       Ma_Ct                T_D004,
       Ngay_Ct              T_DATE,
       So_Ct                T_D020,
       Ma_Dt                T_D032,
       Tien                 T_TIEN,
       Posted               T_INT NOT NULL,
       Id_CT_Master         T_ID, -- Stt_D
       Id_CT_Detail         T_ID  -- Stt0_D
)
go


CREATE CLUSTERED INDEX XIE1SoCaiK ON SoCaiK
(
       Id_Master                            ASC
)
go


CREATE NONCLUSTERED INDEX XIE2SoCaiK ON SoCaiK
(
	Ma_Dvcs, Ngay_Ct, Nh_Ct, Ma_Dt, Posted, Id_Master, Id_Detail, Tien
)
go


CREATE INDEX XEI3SoCaiK ON SoCaiK(Ngay_Ct)
go


CREATE INDEX XEI4SoCaiK ON SoCaiK(Ma_Dt)
go
