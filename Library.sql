USE [master]
GO
/****** Object:  Database [demo]    Script Date: 2017/11/11 17:45:04 ******/
CREATE DATABASE [demo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'demo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\demo.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'demo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\demo_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [demo] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [demo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [demo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [demo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [demo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [demo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [demo] SET ARITHABORT OFF 
GO
ALTER DATABASE [demo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [demo] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [demo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [demo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [demo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [demo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [demo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [demo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [demo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [demo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [demo] SET  DISABLE_BROKER 
GO
ALTER DATABASE [demo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [demo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [demo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [demo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [demo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [demo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [demo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [demo] SET RECOVERY FULL 
GO
ALTER DATABASE [demo] SET  MULTI_USER 
GO
ALTER DATABASE [demo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [demo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [demo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [demo] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'demo', N'ON'
GO
USE [demo]
GO
/****** Object:  Table [dbo].[BookDatabase]    Script Date: 2017/11/11 17:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookDatabase](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[BookName] [nvarchar](50) NOT NULL,
	[Author] [nvarchar](50) NOT NULL,
	[PubHouse] [nvarchar](50) NOT NULL,
	[Class] [nvarchar](50) NOT NULL,
	[Num] [int] NOT NULL,
	[LeftNum] [int] NOT NULL,
 CONSTRAINT [PK_BookDate] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BookEvent]    Script Date: 2017/11/11 17:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookEvent](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[BookID] [int] NOT NULL,
	[UserName] [nchar](20) NOT NULL,
	[BookName] [nvarchar](50) NOT NULL,
	[DateFrom] [nvarchar](50) NOT NULL,
	[DateTo] [nvarchar](50) NOT NULL,
	[DateTo_con] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
 CONSTRAINT [PK_BookEvent] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users]    Script Date: 2017/11/11 17:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nchar](20) NOT NULL,
	[password] [nchar](20) NOT NULL,
	[RealName] [nvarchar](50) NULL,
	[Sex] [nvarchar](50) NULL,
	[PwdQuestion] [nvarchar](50) NULL,
	[PwdAnswer] [nvarchar](50) NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[BookDatabase] ON 

INSERT [dbo].[BookDatabase] ([id], [BookName], [Author], [PubHouse], [Class], [Num], [LeftNum]) VALUES (6, N'线性代数', N'123', N'玄学出版社     ', N'1', 100, 99)
INSERT [dbo].[BookDatabase] ([id], [BookName], [Author], [PubHouse], [Class], [Num], [LeftNum]) VALUES (7, N'泛函分析', N'123', N'玄学出版社     ', N'1', 100, 98)
INSERT [dbo].[BookDatabase] ([id], [BookName], [Author], [PubHouse], [Class], [Num], [LeftNum]) VALUES (13, N'你的名字', N'新海诚', N'日语出版社     ', N'1', 50, 47)
INSERT [dbo].[BookDatabase] ([id], [BookName], [Author], [PubHouse], [Class], [Num], [LeftNum]) VALUES (19, N'大英三', N'123', N'英语出版社', N'2', 214, 214)
INSERT [dbo].[BookDatabase] ([id], [BookName], [Author], [PubHouse], [Class], [Num], [LeftNum]) VALUES (20, N'模电', N'123', N'哲学出版社', N'3', 123, 122)
INSERT [dbo].[BookDatabase] ([id], [BookName], [Author], [PubHouse], [Class], [Num], [LeftNum]) VALUES (21, N'高数', N'123', N'玄学出版社', N'5', 123, 122)
INSERT [dbo].[BookDatabase] ([id], [BookName], [Author], [PubHouse], [Class], [Num], [LeftNum]) VALUES (22, N'亲热天堂', N'卡卡西', N'不明状出版社', N'9', 11, 9)
INSERT [dbo].[BookDatabase] ([id], [BookName], [Author], [PubHouse], [Class], [Num], [LeftNum]) VALUES (23, N'亲热天堂', N'卡卡西', N'不明出版社', N'9', 1, 1)
INSERT [dbo].[BookDatabase] ([id], [BookName], [Author], [PubHouse], [Class], [Num], [LeftNum]) VALUES (25, N'好好学习天天向上', N'天天', N'学习出版社', N'不知道', 10, 7)
INSERT [dbo].[BookDatabase] ([id], [BookName], [Author], [PubHouse], [Class], [Num], [LeftNum]) VALUES (26, N'四月谎', N'343', N'日语出版社', N'催泪', 100, 99)
INSERT [dbo].[BookDatabase] ([id], [BookName], [Author], [PubHouse], [Class], [Num], [LeftNum]) VALUES (27, N'近纲', N'123', N'政治出版社', N'政治', 10, 9)
INSERT [dbo].[BookDatabase] ([id], [BookName], [Author], [PubHouse], [Class], [Num], [LeftNum]) VALUES (28, N'C语言程序设计', N'谭浩强', N'清华大学出版社', N'科技', 200, 199)
INSERT [dbo].[BookDatabase] ([id], [BookName], [Author], [PubHouse], [Class], [Num], [LeftNum]) VALUES (29, N'海洋学3', N'132', N'海洋出版社', N'35', 15, 13)
SET IDENTITY_INSERT [dbo].[BookDatabase] OFF
SET IDENTITY_INSERT [dbo].[BookEvent] ON 

INSERT [dbo].[BookEvent] ([id], [UserID], [BookID], [UserName], [BookName], [DateFrom], [DateTo], [DateTo_con], [Status]) VALUES (4, 1002, 22, N'丁进仁2                ', N'亲热天堂', N'2017年11月5日', N'2017年12月20日', NULL, N'A')
INSERT [dbo].[BookEvent] ([id], [UserID], [BookID], [UserName], [BookName], [DateFrom], [DateTo], [DateTo_con], [Status]) VALUES (5, 1002, 7, N'丁进仁2                ', N'泛函分析', N'2017年11月5日', N'2017年11月20日', NULL, N'D')
INSERT [dbo].[BookEvent] ([id], [UserID], [BookID], [UserName], [BookName], [DateFrom], [DateTo], [DateTo_con], [Status]) VALUES (1002, 1002, 13, N'丁进仁2                ', N'你的名字', N'2017年11月8日', N'2017年11月23日', NULL, NULL)
INSERT [dbo].[BookEvent] ([id], [UserID], [BookID], [UserName], [BookName], [DateFrom], [DateTo], [DateTo_con], [Status]) VALUES (1003, 1002, 21, N'丁进仁                 ', N'高数', N'2017年11月8日', N'2017年11月23日', N'2017年12月8日', N'R')
INSERT [dbo].[BookEvent] ([id], [UserID], [BookID], [UserName], [BookName], [DateFrom], [DateTo], [DateTo_con], [Status]) VALUES (1004, 1002, 13, N'丁进仁                 ', N'你的名字', N'2017年11月8日', N'2017年11月23日', N'2017年12月8日', N'R')
INSERT [dbo].[BookEvent] ([id], [UserID], [BookID], [UserName], [BookName], [DateFrom], [DateTo], [DateTo_con], [Status]) VALUES (2006, 1008, 26, N'玉子                  ', N'四月谎', N'2017年11月8日', N'2017年11月23日', NULL, NULL)
INSERT [dbo].[BookEvent] ([id], [UserID], [BookID], [UserName], [BookName], [DateFrom], [DateTo], [DateTo_con], [Status]) VALUES (2008, 1005, 29, N'天天                  ', N'海洋学3', N'2017年11月8日', N'2017年11月23日', NULL, NULL)
INSERT [dbo].[BookEvent] ([id], [UserID], [BookID], [UserName], [BookName], [DateFrom], [DateTo], [DateTo_con], [Status]) VALUES (2009, 1009, 25, N'蕾米莉亚                ', N'好好学习天天向上', N'2017年11月8日', N'2017年11月23日', N'2017年12月8日', N'R')
INSERT [dbo].[BookEvent] ([id], [UserID], [BookID], [UserName], [BookName], [DateFrom], [DateTo], [DateTo_con], [Status]) VALUES (2010, 1013, 28, N'帕希菲卡                ', N'C语言程序设计', N'2017年11月8日', N'2017年11月23日', NULL, NULL)
INSERT [dbo].[BookEvent] ([id], [UserID], [BookID], [UserName], [BookName], [DateFrom], [DateTo], [DateTo_con], [Status]) VALUES (2012, 1017, 13, N'小樱                  ', N'你的名字', N'2017年11月8日', N'2017年11月23日', N'2017年12月8日', N'R')
INSERT [dbo].[BookEvent] ([id], [UserID], [BookID], [UserName], [BookName], [DateFrom], [DateTo], [DateTo_con], [Status]) VALUES (2013, 1011, 25, N'nagisa              ', N'好好学习天天向上', N'2017年11月8日', N'2017年11月23日', NULL, NULL)
INSERT [dbo].[BookEvent] ([id], [UserID], [BookID], [UserName], [BookName], [DateFrom], [DateTo], [DateTo_con], [Status]) VALUES (2014, 1015, 22, N'桐人                  ', N'亲热天堂', N'2017年11月8日', N'2017年11月23日', N'2017年12月8日', N'R')
INSERT [dbo].[BookEvent] ([id], [UserID], [BookID], [UserName], [BookName], [DateFrom], [DateTo], [DateTo_con], [Status]) VALUES (2016, 1007, 27, N'枢木朱雀                ', N'近纲', N'2017年11月8日', N'2017年11月23日', NULL, NULL)
INSERT [dbo].[BookEvent] ([id], [UserID], [BookID], [UserName], [BookName], [DateFrom], [DateTo], [DateTo_con], [Status]) VALUES (2017, 1016, 6, N'赫萝                  ', N'线性代数', N'2017年11月8日', N'2017年11月23日', NULL, NULL)
INSERT [dbo].[BookEvent] ([id], [UserID], [BookID], [UserName], [BookName], [DateFrom], [DateTo], [DateTo_con], [Status]) VALUES (2019, 1014, 25, N'忠邦                  ', N'好好学习天天向上', N'2017年11月8日', N'2017年11月23日', NULL, NULL)
INSERT [dbo].[BookEvent] ([id], [UserID], [BookID], [UserName], [BookName], [DateFrom], [DateTo], [DateTo_con], [Status]) VALUES (2020, 1012, 20, N'观铃                  ', N'模电', N'2017年11月8日', N'2017年11月23日', N'2017年12月8日', N'R')
INSERT [dbo].[BookEvent] ([id], [UserID], [BookID], [UserName], [BookName], [DateFrom], [DateTo], [DateTo_con], [Status]) VALUES (2021, 1010, 7, N'琪露诺                 ', N'泛函分析', N'2017年11月8日', N'2017年11月23日', NULL, NULL)
INSERT [dbo].[BookEvent] ([id], [UserID], [BookID], [UserName], [BookName], [DateFrom], [DateTo], [DateTo_con], [Status]) VALUES (2024, 1017, 29, N'小樱                  ', N'海洋学3', N'2017年11月8日', N'2017年11月23日', N'2017年12月8日', N'R')
SET IDENTITY_INSERT [dbo].[BookEvent] OFF
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [username], [password], [RealName], [Sex], [PwdQuestion], [PwdAnswer]) VALUES (0, N'administrator       ', N'password123456789   ', NULL, NULL, NULL, NULL)
INSERT [dbo].[users] ([id], [username], [password], [RealName], [Sex], [PwdQuestion], [PwdAnswer]) VALUES (1, N'1234                ', N'123456789           ', N'123', N'1', N'1', N'125')
INSERT [dbo].[users] ([id], [username], [password], [RealName], [Sex], [PwdQuestion], [PwdAnswer]) VALUES (1002, N'丁进仁                 ', N'djr123456           ', N'丁进仁', N'1', N'1', N'321')
INSERT [dbo].[users] ([id], [username], [password], [RealName], [Sex], [PwdQuestion], [PwdAnswer]) VALUES (1003, N'猪                   ', N'456789              ', N'猪', N'1', N'2', N'23')
INSERT [dbo].[users] ([id], [username], [password], [RealName], [Sex], [PwdQuestion], [PwdAnswer]) VALUES (1004, N'鲁鲁修                 ', N'134796              ', N'鲁鲁修·v·布里塔尼亚', N'1', N'3', N'朱雀')
INSERT [dbo].[users] ([id], [username], [password], [RealName], [Sex], [PwdQuestion], [PwdAnswer]) VALUES (1005, N'天天                  ', N'asd123              ', N'天天', N'2', N'3', N'123')
INSERT [dbo].[users] ([id], [username], [password], [RealName], [Sex], [PwdQuestion], [PwdAnswer]) VALUES (1006, N'银古                  ', N'1234567             ', N'四木', N'1', N'1', N'321')
INSERT [dbo].[users] ([id], [username], [password], [RealName], [Sex], [PwdQuestion], [PwdAnswer]) VALUES (1007, N'枢木朱雀                ', N'123123              ', N'天真', N'1', N'1', N'123')
INSERT [dbo].[users] ([id], [username], [password], [RealName], [Sex], [PwdQuestion], [PwdAnswer]) VALUES (1008, N'玉子                  ', N'123456              ', N'北白川玉子', N'2', N'2', N'大路饼藏')
INSERT [dbo].[users] ([id], [username], [password], [RealName], [Sex], [PwdQuestion], [PwdAnswer]) VALUES (1009, N'蕾米莉亚                ', N'123456789           ', N'蕾米', N'2', N'1', N'抱头防蹲')
INSERT [dbo].[users] ([id], [username], [password], [RealName], [Sex], [PwdQuestion], [PwdAnswer]) VALUES (1010, N'琪露诺                 ', N'99999999            ', N'9', N'2', N'2', N'大妖精')
INSERT [dbo].[users] ([id], [username], [password], [RealName], [Sex], [PwdQuestion], [PwdAnswer]) VALUES (1011, N'nagisa              ', N'123456789           ', N'古河渚', N'2', N'2', N'冈崎朋也')
INSERT [dbo].[users] ([id], [username], [password], [RealName], [Sex], [PwdQuestion], [PwdAnswer]) VALUES (1012, N'观铃                  ', N'123456789           ', N'神尾观铃', N'2', N'2', N'国崎往人')
INSERT [dbo].[users] ([id], [username], [password], [RealName], [Sex], [PwdQuestion], [PwdAnswer]) VALUES (1013, N'帕希菲卡                ', N'123456454           ', N'废弃王女', N'2', N'1', N'坚强的倒霉蛋')
INSERT [dbo].[users] ([id], [username], [password], [RealName], [Sex], [PwdQuestion], [PwdAnswer]) VALUES (1014, N'忠邦                  ', N'12346546            ', N'志原忠邦', N'1', N'1', N'女装大佬')
INSERT [dbo].[users] ([id], [username], [password], [RealName], [Sex], [PwdQuestion], [PwdAnswer]) VALUES (1015, N'桐人                  ', N'13431345            ', N'桐谷和人', N'1', N'1', N'人生赢家')
INSERT [dbo].[users] ([id], [username], [password], [RealName], [Sex], [PwdQuestion], [PwdAnswer]) VALUES (1016, N'赫萝                  ', N'135465131           ', N'萌狼', N'2', N'2', N'克拉福·罗伦斯')
INSERT [dbo].[users] ([id], [username], [password], [RealName], [Sex], [PwdQuestion], [PwdAnswer]) VALUES (1017, N'小樱                  ', N'165461132           ', N'木之本樱', N'2', N'2', N'小狼')
SET IDENTITY_INSERT [dbo].[users] OFF
ALTER TABLE [dbo].[BookEvent]  WITH CHECK ADD  CONSTRAINT [FK_BookEvent_BookDatabase] FOREIGN KEY([BookID])
REFERENCES [dbo].[BookDatabase] ([id])
GO
ALTER TABLE [dbo].[BookEvent] CHECK CONSTRAINT [FK_BookEvent_BookDatabase]
GO
ALTER TABLE [dbo].[BookEvent]  WITH CHECK ADD  CONSTRAINT [FK_BookEvent_users] FOREIGN KEY([UserID])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[BookEvent] CHECK CONSTRAINT [FK_BookEvent_users]
GO
USE [master]
GO
ALTER DATABASE [demo] SET  READ_WRITE 
GO
