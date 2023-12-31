USE [master]
GO
/****** Object:  Database [electrowallet]    Script Date: 10.10.2023 20:23:39 ******/
CREATE DATABASE [electrowallet]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'electrowallet', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\electrowallet.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'electrowallet_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\electrowallet_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [electrowallet] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [electrowallet].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [electrowallet] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [electrowallet] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [electrowallet] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [electrowallet] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [electrowallet] SET ARITHABORT OFF 
GO
ALTER DATABASE [electrowallet] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [electrowallet] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [electrowallet] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [electrowallet] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [electrowallet] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [electrowallet] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [electrowallet] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [electrowallet] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [electrowallet] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [electrowallet] SET  ENABLE_BROKER 
GO
ALTER DATABASE [electrowallet] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [electrowallet] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [electrowallet] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [electrowallet] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [electrowallet] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [electrowallet] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [electrowallet] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [electrowallet] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [electrowallet] SET  MULTI_USER 
GO
ALTER DATABASE [electrowallet] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [electrowallet] SET DB_CHAINING OFF 
GO
ALTER DATABASE [electrowallet] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [electrowallet] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [electrowallet] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [electrowallet] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [electrowallet] SET QUERY_STORE = ON
GO
ALTER DATABASE [electrowallet] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [electrowallet]
GO
/****** Object:  Table [dbo].[Currencies]    Script Date: 10.10.2023 20:23:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currencies](
	[Code] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[IsCrypto] [bit] NOT NULL,
 CONSTRAINT [PK_Currencies] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Statuses]    Script Date: 10.10.2023 20:23:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statuses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Statuses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 10.10.2023 20:23:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[WalletID] [uniqueidentifier] NOT NULL,
	[BillTo] [nvarchar](max) NOT NULL,
	[TransactionTypeID] [int] NOT NULL,
	[Amount] [real] NOT NULL,
	[StatusID] [int] NOT NULL,
 CONSTRAINT [PK_Transactions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionTypes]    Script Date: 10.10.2023 20:23:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_TransactionTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 10.10.2023 20:23:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](max) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[TokenAPI] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wallets]    Script Date: 10.10.2023 20:23:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wallets](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Amount] [real] NOT NULL,
	[IsFrozen] [bit] NOT NULL,
	[UserID] [int] NOT NULL,
	[CurrencyTypeCode] [nvarchar](450) NULL,
 CONSTRAINT [PK_Wallets] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Currencies] ([Code], [Name], [IsCrypto]) VALUES (N'RUB', N'Рубль', 0)
INSERT [dbo].[Currencies] ([Code], [Name], [IsCrypto]) VALUES (N'USD', N'Доллар', 0)
GO
SET IDENTITY_INSERT [dbo].[Statuses] ON 

INSERT [dbo].[Statuses] ([Id], [Name]) VALUES (1, N'Недостаточно средств')
INSERT [dbo].[Statuses] ([Id], [Name]) VALUES (2, N'Перевод доставлен')
INSERT [dbo].[Statuses] ([Id], [Name]) VALUES (3, N'Ожидание')
INSERT [dbo].[Statuses] ([Id], [Name]) VALUES (4, N'Перевод не доставлен')
SET IDENTITY_INSERT [dbo].[Statuses] OFF
GO
SET IDENTITY_INSERT [dbo].[Transactions] ON 

INSERT [dbo].[Transactions] ([Id], [WalletID], [BillTo], [TransactionTypeID], [Amount], [StatusID]) VALUES (1, N'398dd991-4399-4c28-5e13-08dbc981e20b', N'c135a152-701e-4b87-5e16-08dbc981e20b', 2, 0, 2)
INSERT [dbo].[Transactions] ([Id], [WalletID], [BillTo], [TransactionTypeID], [Amount], [StatusID]) VALUES (2, N'398dd991-4399-4c28-5e13-08dbc981e20b', N'c135a152-701e-4b87-5e16-08dbc981e20b', 2, 3, 2)
INSERT [dbo].[Transactions] ([Id], [WalletID], [BillTo], [TransactionTypeID], [Amount], [StatusID]) VALUES (3, N'398dd991-4399-4c28-5e13-08dbc981e20b', N'c135a152-701e-4b87-5e16-08dbc981e20b', 2, 3, 2)
SET IDENTITY_INSERT [dbo].[Transactions] OFF
GO
SET IDENTITY_INSERT [dbo].[TransactionTypes] ON 

INSERT [dbo].[TransactionTypes] ([Id], [Name]) VALUES (1, N'Перевод между своими')
INSERT [dbo].[TransactionTypes] ([Id], [Name]) VALUES (2, N'Перевод между кошельками')
INSERT [dbo].[TransactionTypes] ([Id], [Name]) VALUES (3, N'Перевод на другой счёт')
SET IDENTITY_INSERT [dbo].[TransactionTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([ID], [Login], [Password], [CreationDate], [TokenAPI]) VALUES (1, N'test', N'123123', CAST(N'2023-10-10T14:11:55.6671825' AS DateTime2), N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoidGVzdCIsImV4cCI6MTY5NjkzNjQzNSwiaXNzIjoiRWxlY3Ryb1dhbGxldCIsImF1ZCI6InRlc3QifQ.WNqH9swyEJuCdiWt_PSoOK48rN4LqTPxBfpfJZ9ZYPI')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
INSERT [dbo].[Wallets] ([Id], [Name], [Amount], [IsFrozen], [UserID], [CurrencyTypeCode]) VALUES (N'7421fc58-0777-45f7-5e12-08dbc981e20b', N'Тест', 0, 0, 1, N'RUB')
INSERT [dbo].[Wallets] ([Id], [Name], [Amount], [IsFrozen], [UserID], [CurrencyTypeCode]) VALUES (N'398dd991-4399-4c28-5e13-08dbc981e20b', N'Тест', 204.43, 0, 1, N'RUB')
INSERT [dbo].[Wallets] ([Id], [Name], [Amount], [IsFrozen], [UserID], [CurrencyTypeCode]) VALUES (N'f4198070-05a2-47a2-5e15-08dbc981e20b', N'Тест', 0, 0, 1, N'RUB')
INSERT [dbo].[Wallets] ([Id], [Name], [Amount], [IsFrozen], [UserID], [CurrencyTypeCode]) VALUES (N'c135a152-701e-4b87-5e16-08dbc981e20b', N'Тест', 9, 0, 1, N'RUB')
GO
/****** Object:  Index [IX_Transactions_StatusID]    Script Date: 10.10.2023 20:23:39 ******/
CREATE NONCLUSTERED INDEX [IX_Transactions_StatusID] ON [dbo].[Transactions]
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Transactions_TransactionTypeID]    Script Date: 10.10.2023 20:23:39 ******/
CREATE NONCLUSTERED INDEX [IX_Transactions_TransactionTypeID] ON [dbo].[Transactions]
(
	[TransactionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Wallets_CurrencyTypeCode]    Script Date: 10.10.2023 20:23:39 ******/
CREATE NONCLUSTERED INDEX [IX_Wallets_CurrencyTypeCode] ON [dbo].[Wallets]
(
	[CurrencyTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Wallets_UserID]    Script Date: 10.10.2023 20:23:39 ******/
CREATE NONCLUSTERED INDEX [IX_Wallets_UserID] ON [dbo].[Wallets]
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Transactions_Statuses_StatusID] FOREIGN KEY([StatusID])
REFERENCES [dbo].[Statuses] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_Transactions_Statuses_StatusID]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Transactions_TransactionTypes_TransactionTypeID] FOREIGN KEY([TransactionTypeID])
REFERENCES [dbo].[TransactionTypes] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_Transactions_TransactionTypes_TransactionTypeID]
GO
ALTER TABLE [dbo].[Wallets]  WITH CHECK ADD  CONSTRAINT [FK_Wallets_Currencies_CurrencyTypeCode] FOREIGN KEY([CurrencyTypeCode])
REFERENCES [dbo].[Currencies] ([Code])
GO
ALTER TABLE [dbo].[Wallets] CHECK CONSTRAINT [FK_Wallets_Currencies_CurrencyTypeCode]
GO
ALTER TABLE [dbo].[Wallets]  WITH CHECK ADD  CONSTRAINT [FK_Wallets_Users_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Wallets] CHECK CONSTRAINT [FK_Wallets_Users_UserID]
GO
USE [master]
GO
ALTER DATABASE [electrowallet] SET  READ_WRITE 
GO
