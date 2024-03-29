USE [MKTur]
GO
/****** Object:  UserDefinedFunction [dbo].[CalculatePrice]    Script Date: 14.07.2022 17:49:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[CalculatePrice]
(
	@price decimal,
	@rate decimal
)
RETURNS decimal
AS
BEGIN
	
	declare @CalculatedPrice decimal;
	set @CalculatedPrice=@price+(@price*@rate/100);

	-- Return the result of the function
	RETURN @CalculatedPrice

END
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 14.07.2022 17:49:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](max) NULL,
	[LastName] [nvarchar](max) NULL,
	[TcNo] [nvarchar](max) NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cities]    Script Date: 14.07.2022 17:49:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cities](
	[CityId] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [nvarchar](max) NULL,
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Passengers]    Script Date: 14.07.2022 17:49:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Passengers](
	[PassengerId] [int] IDENTITY(1,1) NOT NULL,
	[PassengerName] [nvarchar](max) NULL,
	[PassengerTc] [nvarchar](max) NULL,
	[PassengerTel] [nvarchar](max) NULL,
 CONSTRAINT [PK_Passengers] PRIMARY KEY CLUSTERED 
(
	[PassengerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BusServices]    Script Date: 14.07.2022 17:49:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BusServices](
	[BusServiceId] [int] IDENTITY(1,1) NOT NULL,
	[ToCityId] [int] NOT NULL,
	[Station1Id] [int] NULL,
	[Station2Id] [int] NULL,
	[FromCityId] [int] NOT NULL,
	[Price] [int] NOT NULL,
	[Date] [datetime2](7) NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_BusServices] PRIMARY KEY CLUSTERED 
(
	[BusServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservations]    Script Date: 14.07.2022 17:49:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservations](
	[BusServiceId] [int] NOT NULL,
	[SeatId] [int] NOT NULL,
	[PassengerId] [int] NULL,
	[AppUserId] [int] NULL,
	[PnrNo] [int] NOT NULL,
 CONSTRAINT [PK_Reservations] PRIMARY KEY CLUSTERED 
(
	[BusServiceId] ASC,
	[SeatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ReservationAndBusService]    Script Date: 14.07.2022 17:49:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ReservationAndBusService]
(	

)
RETURNS TABLE 
AS
RETURN 
(
	SELECT
	toct.CityName as Kalkış,
	fromct.CityName as Varış,
	ps.PassengerName as YolcuAdi,
	rs.SeatId as KoltukNo,
	bs.Price as Fiyat,
	bs.Date as Tarih,
	users.UserName as SatinAlanKullanıcıAdi
	
	from  Reservations rs
	inner join Passengers ps on ps.PassengerId=rs.PassengerId
	inner join BusServices bs on bs.BusServiceId=rs.BusServiceId 
	inner join Cities toct on bs.ToCityId=toct.CityId
	inner join Cities fromct on bs.FromCityId=fromct.CityId
	inner join AspNetUsers users on rs.AppUserId=users.Id
)
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 14.07.2022 17:49:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 14.07.2022 17:49:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 14.07.2022 17:49:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 14.07.2022 17:49:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 14.07.2022 17:49:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](450) NOT NULL,
	[ProviderKey] [nvarchar](450) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 14.07.2022 17:49:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 14.07.2022 17:49:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [int] NOT NULL,
	[LoginProvider] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seats]    Script Date: 14.07.2022 17:49:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seats](
	[SeatId] [int] IDENTITY(1,1) NOT NULL,
	[SeatNo] [int] NOT NULL,
 CONSTRAINT [PK_Seats] PRIMARY KEY CLUSTERED 
(
	[SeatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220714133721_mig1', N'5.0.16')
GO
SET IDENTITY_INSERT [dbo].[AspNetUsers] ON 

INSERT [dbo].[AspNetUsers] ([Id], [FirstName], [LastName], [TcNo], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (1, N'Eyüp Murat', N'Kuşcan', NULL, N'muratkscn', N'MURATKSCN', N'muratkscn@gmail.com', N'MURATKSCN@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEMqKSbRBB9s3ivccq5zknzZPRmytIAq7SoF3f9SrFGzPiHex21ceaP9kIudEmyu0fA==', N'KONUQBHZNZ7TYAMHLPTEZZO325DLCTSZ', N'3f68bd2a-3b5a-4920-a3e6-e94a9edaa297', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [FirstName], [LastName], [TcNo], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (2, N'Esra', N'Kurt', NULL, N'Esra', N'ESRA', N'es@gmail.com', N'ES@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEE5y8t+46hLSqLSNNDDUm3ov5jw+E5zR+8N41T9xTKBIslMb0zNti/VLAODMFonSLg==', N'AUWQDUGYFW7XFH7GCYPFQPY2UFENYDUA', N'3fe7bd9c-e432-4b04-8b26-09afc263728c', NULL, 0, 0, NULL, 1, 0)
SET IDENTITY_INSERT [dbo].[AspNetUsers] OFF
GO
SET IDENTITY_INSERT [dbo].[BusServices] ON 

INSERT [dbo].[BusServices] ([BusServiceId], [ToCityId], [Station1Id], [Station2Id], [FromCityId], [Price], [Date], [Status]) VALUES (1, 1, 3, NULL, 2, 100, CAST(N'2022-05-12T20:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[BusServices] ([BusServiceId], [ToCityId], [Station1Id], [Station2Id], [FromCityId], [Price], [Date], [Status]) VALUES (2, 1, 2, 3, 3, 100, CAST(N'2022-05-13T19:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[BusServices] ([BusServiceId], [ToCityId], [Station1Id], [Station2Id], [FromCityId], [Price], [Date], [Status]) VALUES (3, 1, 2, 3, 4, 200, CAST(N'2022-05-13T18:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[BusServices] ([BusServiceId], [ToCityId], [Station1Id], [Station2Id], [FromCityId], [Price], [Date], [Status]) VALUES (4, 1, 2, 3, 5, 300, CAST(N'2022-05-13T17:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[BusServices] ([BusServiceId], [ToCityId], [Station1Id], [Station2Id], [FromCityId], [Price], [Date], [Status]) VALUES (5, 1, 3, 5, 6, 400, CAST(N'2022-05-12T16:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[BusServices] ([BusServiceId], [ToCityId], [Station1Id], [Station2Id], [FromCityId], [Price], [Date], [Status]) VALUES (6, 1, 4, 5, 6, 400, CAST(N'2022-05-13T13:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[BusServices] ([BusServiceId], [ToCityId], [Station1Id], [Station2Id], [FromCityId], [Price], [Date], [Status]) VALUES (7, 1, NULL, NULL, 6, 500, CAST(N'2022-05-12T14:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[BusServices] ([BusServiceId], [ToCityId], [Station1Id], [Station2Id], [FromCityId], [Price], [Date], [Status]) VALUES (8, 1, NULL, NULL, 2, 100, CAST(N'2022-05-12T12:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[BusServices] ([BusServiceId], [ToCityId], [Station1Id], [Station2Id], [FromCityId], [Price], [Date], [Status]) VALUES (9, 1, 2, 3, 4, 400, CAST(N'2022-05-12T14:00:00.0000000' AS DateTime2), 1)
SET IDENTITY_INSERT [dbo].[BusServices] OFF
GO
SET IDENTITY_INSERT [dbo].[Cities] ON 

INSERT [dbo].[Cities] ([CityId], [CityName]) VALUES (1, N'İstanbul')
INSERT [dbo].[Cities] ([CityId], [CityName]) VALUES (2, N'Bolu')
INSERT [dbo].[Cities] ([CityId], [CityName]) VALUES (3, N'Kocaeli')
INSERT [dbo].[Cities] ([CityId], [CityName]) VALUES (4, N'Karabük')
INSERT [dbo].[Cities] ([CityId], [CityName]) VALUES (5, N'Adana')
INSERT [dbo].[Cities] ([CityId], [CityName]) VALUES (6, N'Gaziantep')
INSERT [dbo].[Cities] ([CityId], [CityName]) VALUES (7, N'Afyon')
SET IDENTITY_INSERT [dbo].[Cities] OFF
GO
SET IDENTITY_INSERT [dbo].[Passengers] ON 

INSERT [dbo].[Passengers] ([PassengerId], [PassengerName], [PassengerTc], [PassengerTel]) VALUES (1, N'Burak', N'6084545', N'121')
INSERT [dbo].[Passengers] ([PassengerId], [PassengerName], [PassengerTc], [PassengerTel]) VALUES (2, N'Berke Dursunoğlu', N'213123', N'124124')
INSERT [dbo].[Passengers] ([PassengerId], [PassengerName], [PassengerTc], [PassengerTel]) VALUES (3, N'Murat Kuşcan', N'1654561', N'2134684')
INSERT [dbo].[Passengers] ([PassengerId], [PassengerName], [PassengerTc], [PassengerTel]) VALUES (4, N'Duygu ', N'456456', N'5645645')
INSERT [dbo].[Passengers] ([PassengerId], [PassengerName], [PassengerTc], [PassengerTel]) VALUES (5, N'Hakan Derkan', N'25325658', N'4525645')
INSERT [dbo].[Passengers] ([PassengerId], [PassengerName], [PassengerTc], [PassengerTel]) VALUES (6, N'Onur', N'7856765678', N'53646654')
INSERT [dbo].[Passengers] ([PassengerId], [PassengerName], [PassengerTc], [PassengerTel]) VALUES (7, N'Berkay Emir', N'123123124', N'4215123512')
SET IDENTITY_INSERT [dbo].[Passengers] OFF
GO
INSERT [dbo].[Reservations] ([BusServiceId], [SeatId], [PassengerId], [AppUserId], [PnrNo]) VALUES (1, 5, 2, 1, 207828687)
INSERT [dbo].[Reservations] ([BusServiceId], [SeatId], [PassengerId], [AppUserId], [PnrNo]) VALUES (1, 9, 4, 2, 841370757)
INSERT [dbo].[Reservations] ([BusServiceId], [SeatId], [PassengerId], [AppUserId], [PnrNo]) VALUES (1, 19, 6, 2, 1124814351)
INSERT [dbo].[Reservations] ([BusServiceId], [SeatId], [PassengerId], [AppUserId], [PnrNo]) VALUES (3, 3, 1, 1, 1405273133)
INSERT [dbo].[Reservations] ([BusServiceId], [SeatId], [PassengerId], [AppUserId], [PnrNo]) VALUES (3, 8, 5, 2, 158073791)
INSERT [dbo].[Reservations] ([BusServiceId], [SeatId], [PassengerId], [AppUserId], [PnrNo]) VALUES (4, 4, 7, NULL, 2039894139)
INSERT [dbo].[Reservations] ([BusServiceId], [SeatId], [PassengerId], [AppUserId], [PnrNo]) VALUES (4, 27, 3, 1, 931965676)
GO
SET IDENTITY_INSERT [dbo].[Seats] ON 

INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (1, 1)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (2, 2)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (3, 3)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (4, 4)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (5, 5)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (6, 6)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (7, 7)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (8, 8)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (9, 9)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (10, 10)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (11, 11)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (12, 12)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (13, 13)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (14, 14)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (15, 15)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (16, 16)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (17, 17)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (18, 18)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (19, 19)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (20, 20)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (21, 21)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (22, 22)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (23, 23)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (24, 24)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (25, 25)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (26, 26)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (27, 27)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (28, 28)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (29, 29)
INSERT [dbo].[Seats] ([SeatId], [SeatNo]) VALUES (30, 30)
SET IDENTITY_INSERT [dbo].[Seats] OFF
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[BusServices]  WITH CHECK ADD  CONSTRAINT [FK_BusServices_Cities_FromCityId] FOREIGN KEY([FromCityId])
REFERENCES [dbo].[Cities] ([CityId])
GO
ALTER TABLE [dbo].[BusServices] CHECK CONSTRAINT [FK_BusServices_Cities_FromCityId]
GO
ALTER TABLE [dbo].[BusServices]  WITH CHECK ADD  CONSTRAINT [FK_BusServices_Cities_Station1Id] FOREIGN KEY([Station1Id])
REFERENCES [dbo].[Cities] ([CityId])
GO
ALTER TABLE [dbo].[BusServices] CHECK CONSTRAINT [FK_BusServices_Cities_Station1Id]
GO
ALTER TABLE [dbo].[BusServices]  WITH CHECK ADD  CONSTRAINT [FK_BusServices_Cities_Station2Id] FOREIGN KEY([Station2Id])
REFERENCES [dbo].[Cities] ([CityId])
GO
ALTER TABLE [dbo].[BusServices] CHECK CONSTRAINT [FK_BusServices_Cities_Station2Id]
GO
ALTER TABLE [dbo].[BusServices]  WITH CHECK ADD  CONSTRAINT [FK_BusServices_Cities_ToCityId] FOREIGN KEY([ToCityId])
REFERENCES [dbo].[Cities] ([CityId])
GO
ALTER TABLE [dbo].[BusServices] CHECK CONSTRAINT [FK_BusServices_Cities_ToCityId]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_AspNetUsers_AppUserId] FOREIGN KEY([AppUserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_AspNetUsers_AppUserId]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_BusServices_BusServiceId] FOREIGN KEY([BusServiceId])
REFERENCES [dbo].[BusServices] ([BusServiceId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_BusServices_BusServiceId]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_Passengers_PassengerId] FOREIGN KEY([PassengerId])
REFERENCES [dbo].[Passengers] ([PassengerId])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_Passengers_PassengerId]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_Seats_SeatId] FOREIGN KEY([SeatId])
REFERENCES [dbo].[Seats] ([SeatId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_Seats_SeatId]
GO
/****** Object:  StoredProcedure [dbo].[spCreateAndListCities]    Script Date: 14.07.2022 17:49:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spCreateAndListCities]
	@CityName nvarchar(max)
AS
BEGIN
	
	insert into Cities(CityName) values (@CityName)
	SELECT * from Cities
END
GO
