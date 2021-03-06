USE [master]
GO
/****** Object:  Database [LMS]    Script Date: 11/26/2018 11:23:06 AM ******/
CREATE DATABASE [LMS]
 CONTAINMENT = NONE
GO
ALTER DATABASE [LMS] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [LMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LMS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LMS] SET RECOVERY FULL 
GO
ALTER DATABASE [LMS] SET  MULTI_USER 
GO
ALTER DATABASE [LMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LMS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LMS] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'LMS', N'ON'
GO
ALTER DATABASE [LMS] SET QUERY_STORE = OFF
GO
USE [LMS]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [LMS]
GO
/****** Object:  Schema [Relationships]    Script Date: 11/26/2018 11:23:06 AM ******/
CREATE SCHEMA [Relationships]
GO
/****** Object:  UserDefinedFunction [dbo].[calculate_day]    Script Date: 11/26/2018 11:23:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[calculate_day](@start_date date, @end_date date)
returns int
as
begin
declare @day int
set @day = DATEDIFF(day,@start_date,@end_date)
return @day
end
GO
/****** Object:  UserDefinedFunction [dbo].[calculate_fee]    Script Date: 11/26/2018 11:23:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[calculate_fee](@Colour_tag varchar(50), @day int)
returns money
as
begin
declare @fees money
if @day>0
	if @Colour_tag = 'Green_Tag'
		set @fees = @day * 1.1
	else if @Colour_tag = 'Open_Stack'
		set @fees = @day * 0.7
else
	set @fees = 0
return @fees
end
GO
/****** Object:  Table [dbo].[Auth_Book_MN]    Script Date: 11/26/2018 11:23:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Auth_Book_MN](
	[Book_ID] [varchar](50) NOT NULL,
	[Author_ID] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Auth_Book_MN] PRIMARY KEY CLUSTERED 
(
	[Author_ID] ASC,
	[Book_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Author]    Script Date: 11/26/2018 11:23:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[Author_ID] [varchar](50) NOT NULL,
	[Author_Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Author] PRIMARY KEY CLUSTERED 
(
	[Author_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Borrowing_Activity]    Script Date: 11/26/2018 11:23:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Borrowing_Activity](
	[Member_ID] [varchar](50) NOT NULL,
	[Book_ID] [varchar](50) NOT NULL,
	[Start_Date] [date] NULL,
	[End_Date] [date] NULL,
	[Submission_Date] [date] NULL,
 CONSTRAINT [PK_Borrowing_Activity] PRIMARY KEY CLUSTERED 
(
	[Member_ID] ASC,
	[Book_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Catalogue]    Script Date: 11/26/2018 11:23:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Catalogue](
	[ISBN] [varchar](50) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Subject_Area] [varchar](50) NOT NULL,
	[Publisher_ID] [varchar](50) NOT NULL,
	[Year_Published] [date] NOT NULL,
	[Description_B] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Catalogue] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 11/26/2018 11:23:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Colour_Tag] [varchar](50) NOT NULL,
	[Lending_Duration] [numeric](18, 0) NOT NULL,
	[Daily_Late_Rate_Fees] [money] NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Colour_Tag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 11/26/2018 11:23:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[Department_ID] [varchar](50) NOT NULL,
	[Department_Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[Department_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Library_Books]    Script Date: 11/26/2018 11:23:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Library_Books](
	[Book_ID] [varchar](50) NOT NULL,
	[ISBN] [varchar](50) NOT NULL,
	[Type_Of_Book] [varchar](50) NOT NULL,
	[Colour_Tag] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Library Books] PRIMARY KEY CLUSTERED 
(
	[Book_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Library_Members]    Script Date: 11/26/2018 11:23:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Library_Members](
	[Member_ID] [varchar](50) NOT NULL,
	[Name_U] [varchar](50) NOT NULL,
	[Member_Type] [varchar](50) NOT NULL,
	[E_mail] [varchar](50) NULL,
	[Department_ID] [varchar](50) NOT NULL,
	[Activity_Books_Per_Year] [numeric](18, 0) NOT NULL,
	[Gender] [varchar](10) NULL,
 CONSTRAINT [PK_Library_Members] PRIMARY KEY CLUSTERED 
(
	[Member_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publisher]    Script Date: 11/26/2018 11:23:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publisher](
	[Publisher_ID] [varchar](50) NOT NULL,
	[Publisher_Name] [varchar](50) NOT NULL,
	[Location] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Publisher] PRIMARY KEY CLUSTERED 
(
	[Publisher_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservations]    Script Date: 11/26/2018 11:23:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservations](
	[Member_ID] [varchar](50) NOT NULL,
	[Book_ID] [varchar](50) NOT NULL,
	[Reservation_Date] [date] NULL,
 CONSTRAINT [PK_Reservations] PRIMARY KEY CLUSTERED 
(
	[Member_ID] ASC,
	[Book_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Type_Of_Books]    Script Date: 11/26/2018 11:23:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Type_Of_Books](
	[Type_of_Books] [varchar](50) NOT NULL,
	[Lendability] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Type_Of_Books] PRIMARY KEY CLUSTERED 
(
	[Type_of_Books] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI021', N'AU000')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI022', N'AU000')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI023', N'AU000')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI046', N'AU000')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI024', N'AU001')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI025', N'AU001')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI026', N'AU001')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI027', N'AU002')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI028', N'AU002')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI029', N'AU002')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI000', N'AU003')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI001', N'AU003')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI009', N'AU003')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI010', N'AU003')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI014', N'AU003')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI036', N'AU003')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI039', N'AU003')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI041', N'AU003')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI006', N'AU004')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI018', N'AU004')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI019', N'AU004')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI020', N'AU004')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI043', N'AU004')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI002', N'AU005')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI013', N'AU005')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI030', N'AU005')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI033', N'AU005')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI002', N'AU006')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI008', N'AU006')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI016', N'AU006')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI017', N'AU006')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI045', N'AU006')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI047', N'AU006')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI048', N'AU006')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI003', N'AU007')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI005', N'AU007')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI008', N'AU007')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI034', N'AU007')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI037', N'AU007')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI012', N'AU008')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI042', N'AU008')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI005', N'AU009')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI011', N'AU009')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI031', N'AU009')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI032', N'AU009')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI038', N'AU009')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI031', N'AU010')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI032', N'AU010')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI004', N'AU011')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI015', N'AU011')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI040', N'AU011')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI007', N'AU012')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI035', N'AU012')
INSERT [dbo].[Auth_Book_MN] ([Book_ID], [Author_ID]) VALUES (N'BI044', N'AU012')
INSERT [dbo].[Author] ([Author_ID], [Author_Name]) VALUES (N'AU000     ', N'Thomas Connolly')
INSERT [dbo].[Author] ([Author_ID], [Author_Name]) VALUES (N'AU001     ', N'Ramez Elmasri')
INSERT [dbo].[Author] ([Author_ID], [Author_Name]) VALUES (N'AU002     ', N'C.J. Date')
INSERT [dbo].[Author] ([Author_ID], [Author_Name]) VALUES (N'AU003     ', N'J. K. Rowling')
INSERT [dbo].[Author] ([Author_ID], [Author_Name]) VALUES (N'AU004     ', N'Pearson Hardman')
INSERT [dbo].[Author] ([Author_ID], [Author_Name]) VALUES (N'AU005     ', N'John Jefferson')
INSERT [dbo].[Author] ([Author_ID], [Author_Name]) VALUES (N'AU006     ', N'Specter Litt')
INSERT [dbo].[Author] ([Author_ID], [Author_Name]) VALUES (N'AU007     ', N'Robert Zane')
INSERT [dbo].[Author] ([Author_ID], [Author_Name]) VALUES (N'AU008     ', N'Michael Bay')
INSERT [dbo].[Author] ([Author_ID], [Author_Name]) VALUES (N'AU009     ', N'Stan Lee')
INSERT [dbo].[Author] ([Author_ID], [Author_Name]) VALUES (N'AU010     ', N'Ronald McDonald')
INSERT [dbo].[Author] ([Author_ID], [Author_Name]) VALUES (N'AU011     ', N'David Haller')
INSERT [dbo].[Author] ([Author_ID], [Author_Name]) VALUES (N'AU012     ', N'Jackie Chan')
INSERT [dbo].[Borrowing_Activity] ([Member_ID], [Book_ID], [Start_Date], [End_Date], [Submission_Date]) VALUES (N'QW000', N'BI001', CAST(N'2018-02-02' AS Date), CAST(N'2018-02-16' AS Date), CAST(N'2018-02-09' AS Date))
INSERT [dbo].[Borrowing_Activity] ([Member_ID], [Book_ID], [Start_Date], [End_Date], [Submission_Date]) VALUES (N'QW000', N'BI027', CAST(N'2018-05-03' AS Date), CAST(N'2018-05-17' AS Date), CAST(N'2018-05-19' AS Date))
INSERT [dbo].[Borrowing_Activity] ([Member_ID], [Book_ID], [Start_Date], [End_Date], [Submission_Date]) VALUES (N'QW000', N'BI033', CAST(N'2018-03-06' AS Date), CAST(N'2018-03-20' AS Date), CAST(N'2018-03-17' AS Date))
INSERT [dbo].[Borrowing_Activity] ([Member_ID], [Book_ID], [Start_Date], [End_Date], [Submission_Date]) VALUES (N'QW002', N'BI029', CAST(N'2018-05-03' AS Date), CAST(N'2018-05-17' AS Date), CAST(N'2018-05-12' AS Date))
INSERT [dbo].[Borrowing_Activity] ([Member_ID], [Book_ID], [Start_Date], [End_Date], [Submission_Date]) VALUES (N'QW003', N'BI030', CAST(N'2018-03-02' AS Date), CAST(N'2018-04-01' AS Date), CAST(N'2018-03-28' AS Date))
INSERT [dbo].[Borrowing_Activity] ([Member_ID], [Book_ID], [Start_Date], [End_Date], [Submission_Date]) VALUES (N'QW004', N'BI035', CAST(N'2018-01-14' AS Date), CAST(N'2018-01-17' AS Date), CAST(N'2018-01-16' AS Date))
INSERT [dbo].[Borrowing_Activity] ([Member_ID], [Book_ID], [Start_Date], [End_Date], [Submission_Date]) VALUES (N'QW006', N'BI040', CAST(N'2018-12-05' AS Date), CAST(N'2018-12-08' AS Date), CAST(N'2018-12-06' AS Date))
INSERT [dbo].[Borrowing_Activity] ([Member_ID], [Book_ID], [Start_Date], [End_Date], [Submission_Date]) VALUES (N'QW008', N'BI036', CAST(N'2018-09-08' AS Date), CAST(N'2018-09-22' AS Date), CAST(N'2018-09-20' AS Date))
INSERT [dbo].[Borrowing_Activity] ([Member_ID], [Book_ID], [Start_Date], [End_Date], [Submission_Date]) VALUES (N'QW009', N'BI010', CAST(N'2018-05-11' AS Date), CAST(N'2018-06-11' AS Date), CAST(N'2018-05-19' AS Date))
INSERT [dbo].[Borrowing_Activity] ([Member_ID], [Book_ID], [Start_Date], [End_Date], [Submission_Date]) VALUES (N'QW009', N'BI043', CAST(N'2018-04-02' AS Date), CAST(N'2018-04-16' AS Date), CAST(N'2018-04-19' AS Date))
INSERT [dbo].[Borrowing_Activity] ([Member_ID], [Book_ID], [Start_Date], [End_Date], [Submission_Date]) VALUES (N'QW009', N'BI049', CAST(N'2018-08-04' AS Date), CAST(N'2018-09-03' AS Date), CAST(N'2018-09-01' AS Date))
INSERT [dbo].[Borrowing_Activity] ([Member_ID], [Book_ID], [Start_Date], [End_Date], [Submission_Date]) VALUES (N'QW011', N'BI045', CAST(N'2018-09-06' AS Date), CAST(N'2018-09-20' AS Date), CAST(N'2018-09-09' AS Date))
INSERT [dbo].[Borrowing_Activity] ([Member_ID], [Book_ID], [Start_Date], [End_Date], [Submission_Date]) VALUES (N'QW013', N'BI028', CAST(N'2018-07-10' AS Date), CAST(N'2018-07-24' AS Date), CAST(N'2018-07-13' AS Date))
INSERT [dbo].[Borrowing_Activity] ([Member_ID], [Book_ID], [Start_Date], [End_Date], [Submission_Date]) VALUES (N'QW014', N'BI047', CAST(N'2018-06-12' AS Date), CAST(N'2018-07-12' AS Date), CAST(N'2018-07-05' AS Date))
INSERT [dbo].[Borrowing_Activity] ([Member_ID], [Book_ID], [Start_Date], [End_Date], [Submission_Date]) VALUES (N'QW017', N'BI027', CAST(N'2018-11-20' AS Date), CAST(N'2018-12-04' AS Date), CAST(N'2018-11-30' AS Date))
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN000', N'The Adventures of Ronald', N'Fantasy', N'PB000', CAST(N'2017-08-15' AS Date), N'This book is about a boy that went through an intriguing adventure where he encounters a lot of monster on his quest to finding the legendary gold mine')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN001', N'The Thrill of Death', N'Biography', N'PB000', CAST(N'2017-07-19' AS Date), N'This book is a about a biography of a man who is driven by the thirst of killing innocent and non-innocent people just to satisfy his stimulants')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN002', N'Foresworn Enemies', N'Biography', N'PB005', CAST(N'1855-08-04' AS Date), N'This book is about an on-going life events of two individual that were once friends who became enemies towards each other')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN003', N'Fundamentals of the World', N'Physics', N'PB003', CAST(N'2007-04-05' AS Date), N'This book is about the how the fundamentals of the world is perceived through the logical understanding in physics')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN004', N'The explicity of Destiny', N'Mystery', N'PB002', CAST(N'1999-04-07' AS Date), N'This book is about the clear and detailed understand of what possible to up come in the near future of a person, a thing or a situation')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN005', N'This Book', N'Self Help', N'PB004', CAST(N'2016-09-04' AS Date), N'This book from how it ironically sound is about self-development, a book that allows a person to better themselves given their personality')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN006', N'That Book', N'Self Help', N'PB004', CAST(N'2018-04-17' AS Date), N'This book is by the same write that wrote “This book” and that book is continuation of this book which is about personal development and self-improvement')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN007', N'Human Anatomy', N'Biology', N'PB001', CAST(N'2011-08-31' AS Date), N'This book is about the study of the human body which covers each part of the human body from molecules to bone')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN008', N'Human Physiology', N'Biology', N'PB001', CAST(N'2012-07-05' AS Date), N'This book is about the study of the functions and mechanisms which work within a living system')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN009', N'Life of Us', N'Science Fiction', N'PB000', CAST(N'2017-02-02' AS Date), N'This book is about how people encounters life in their situation and how they look at it and deal with it in their own perspective')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN010', N'Strange Occurances', N'Science Fiction', N'PB000', CAST(N'2009-05-31' AS Date), N'This book is about how the world is so complex with such event occurrences shapes it with every occurrence it changes bits of the world')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN011', N'Loving Health', N'Self Help', N'PB005', CAST(N'2017-07-19' AS Date), N'This book is about a person can make and maintain their body healthy with a few steps of self-cleansing and training')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN012', N'Electromagnetic Forces ', N'Physics', N'PB003', CAST(N'2012-07-05' AS Date), N'This book is about the study of electromagnetic forces which is a branch of physics a type of physical interaction between electrically charged particles')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN013', N'Compounds and Minerals', N'Chemistry', N'PB003', CAST(N'2011-12-25' AS Date), N'This book is about a branch in chemistry which is know as compounds and minerals, compounds are the building blocks for minerals')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN014', N'Clandestine Publicity', N'Mystery', N'PB000', CAST(N'1956-07-18' AS Date), N'This book is about clandestine label service which was founded in 2011 by the owners of northern spy records to provide marketing and business')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN015', N'Forces Of Our Universe', N'Physics', N'PB003', CAST(N'2004-07-19' AS Date), N'This book is about the forces of the universe this subject was influenced by physicist through their curiosity')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN016', N'The  Revelations of Earth', N'Physics', N'PB003', CAST(N'2015-03-19' AS Date), N'The revelation of earth is a book inspired in the line of physics how the earth came to be in perspective of a logical manner')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN017', N'Organic Chemistry', N'Chemistry', N'PB003', CAST(N'2005-04-17' AS Date), N'This book is about organic chemistry which is the chemistry of subdiscipline for the scientific study of structures etc')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN018', N'Inorganic Chemistry', N'Chemistry ', N'PB000', CAST(N'2000-05-18' AS Date), N'This book is about inorganic chemistry which deals with synthesis and behavior or organic and organometallic compounds')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN019', N'Bacteriophages', N'Biology', N'PB005', CAST(N'2005-09-30' AS Date), N'In the line of biology bacteriophages which is also known informally as a phage, this book talks about a virus that infects and replicates within bacteria ')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN020', N'Viral Infections', N'Biology', N'PB005', CAST(N'2004-08-26' AS Date), N'this is a book about viral infection being caused because virus exposure, viruses cause infection by invading a host’s body')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN021', N'Space Action', N'Science Fiction', N'PB000', CAST(N'2012-01-05' AS Date), N'space action is inspired by a kid’s imagination this book as about a solo space cop who fights for the right of justice until he encounters what seems to be the guy that left him disabled in left eye')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN022', N'Viral Attack', N'Fantasy', N'PB005', CAST(N'2014-07-19' AS Date), N'This is about the German Nazi alien attacking earth in the 21st century, the attacks happened after one of the geographic people discovered the stone of life embedded on earth')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN023', N'Love Sick', N'Romance ', N'PB009', CAST(N'2016-07-02' AS Date), N'Love is strong a bond between to lives that would evolve to something beautiful unless not tampered with love is sick about how love can be so misleading')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN024', N'Fear of Death', N'Thriller', N'PB000', CAST(N'2018-07-14' AS Date), N'What happens after an individual die does the life force of the person cease to exit or is the person judged for their doing what a person can be sure of in the knife piercing their chest and die')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN025', N'Radiowaves and their effects on productivity', N'Physics', N'PB003', CAST(N'2018-05-07' AS Date), N'Radio waves are generated through number of transmitting devices or machines radio waves are also part of physics, radio waves affect productivity')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN026', N'Prolonged Exposure to TV', N'Biology', N'PB004', CAST(N'2019-07-19' AS Date), N'Tv are entertaining but did a person ever wonder how much tv affect the human brain not that only but tv emits radiation that affects the human eyes and skin')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN027', N'Riding Horses', N'Self Help', N'PB008', CAST(N'2011-09-09' AS Date), N'Horses are interesting creature because back in the days where cars did not exist horses were considered vehicles this book is about understanding a horse and how to ride it')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN028', N'Filling Blanks', N'Thriller', N'PB006', CAST(N'2012-12-18' AS Date), N'This book is about a man who is empty inside and man that feels that he has no purpose in life up until stumbles upon the fact that he craves to kill')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN029', N'Writing Blanks', N'Thriller', N'PB006', CAST(N'2014-11-19' AS Date), N'Writing the blanks is a new chapter from filling the blanks of the same man but only this time he finds person that he could connect with and help him stop what he is doing')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN030', N'Under the Mountain', N'Fantasy', N'PB007', CAST(N'2013-01-31' AS Date), N'Is a nature inspired book about mother nature and how vast and extremely uncomprehending it is to man when it comes to exploring it?')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN031', N'Rolling Boulders', N'Fantasy', N'PB008', CAST(N'2014-08-07' AS Date), N'This book is about how man rolled huge boulder of stone in order to craft using magic and ferry creature to assist them')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN032', N'Knowing Knowledge', N'Self Help', N'PB009', CAST(N'2000-03-30' AS Date), N'This book is to show much knowledge matter in life, it allows a person to understand how much a person can do if enough knowledge was acquired but there is never enough when is comes to knowledge')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN033', N'Rageful Phenomenons', N'Physics', N'PB004', CAST(N'2001-07-09' AS Date), N'Rage phenomenon is a physics related subject which talks about numerous phenomenon that can be logically explained')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN034', N'Bonding Forces', N'Chemistry', N'PB009', CAST(N'2017-11-28' AS Date), N'This book does not only cover bonding between elements to shape a compound but the bonding forces between elements')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN035', N'Database Solutions', N'Computing', N'PB003', CAST(N'1999-03-23' AS Date), N'The vast majority of software applications use relational databases that virtually every application developer must work with. This book introduces you to database design')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN036', N'	Business Database Systems ', N'Computing', N'PB003', CAST(N'2008-11-01' AS Date), N'Business Database Systems provides you with the knowledge to analyze, design and implement effective, robust and successful databases. This book is good for students of Business/Management Information Systems, or Computer Science')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN037', N'Newberry Crater', N'Computing', N'PB000', CAST(N'2017-08-18' AS Date), N'The research in this volume derives from investigations conducted in connection with proposed widening and realignment of the Paulina-East Lake Highway, located within the caldera of Newberry Volcano. Formal evaluation of 13 localities and data recovers at four sites produced a wealth of information regarding human uses of the caldera and vicinity throughout the Holocene')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN038', N'Fundamentals of Database Systems', N'Computing', N'PB002', CAST(N'2006-03-17' AS Date), N'Clear explanations of theory and design, broad coverage of models and real systems, and an up-to-date introduction to modern database technologies result in a leading introduction to database systems')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN039', N'Operating Systems: A Spiral Approach', N'Computing', N'PB002', CAST(N'2009-02-01' AS Date), N'Elmasri, Levine, and Carricks "spiral approach" to teaching operating systems develops student understanding of various OS components early on and helps students approach the more difficult aspects of operating systems with confidence')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN040', N'Database Systems', N'Computing', N'PB002', CAST(N'2013-02-28' AS Date), N'Provides in-depth coverage of databases from the point of view of the database designer, user, and application programmer. This book focuses on management, covering the principal techniques in the areas with coverage of query optimization')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN041', N'An Introduction to Database Systems', N'Computing', N'PB000', CAST(N'2017-08-19' AS Date), N'Secret ORACLE is the definitive guide to undocumented and partially documented features of the ORACLE database server. This book will improve your efficiency as an ORACLE database administrator and enable you to master more difficult administrative, tuning, and troubleshooting tasks than you ever thought possible')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN042', N'SQL and Relational Theory', N'Computing', N'PB008', CAST(N'2009-01-30' AS Date), N'Annotation C.J. Date, one of the key researchers in the field of relational databases, explains in this book the best practices of database coding, with clear explanations of the reasoning behind them')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN043', N'The Relational Database Dictionary', N'Computing', N'PB008', CAST(N'2006-08-28' AS Date), N'Chris Date, one of the founders of the relational model, has updated and expanded his relational database dictionary to include more than 900 terms')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN044', N'Forces That Are Deadly', N'Thriller', N'PB007', CAST(N'2016-07-18' AS Date), N'The supernatural is another world the human eye can’t see but what happens when the normal world and the paranormal meet')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN045', N'Naming Towns', N'Fantasy', N'PB000', CAST(N'2009-07-18' AS Date), N'A man with the love of music and a murderous instinct manages to become one the most notorious criminals known in his country')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN046', N'Is This Poison?', N'Romance', N'PB003', CAST(N'2016-06-30' AS Date), N'Falling in love is one the most amazing things a person could ever feel but that state of mind can be extremely dreadful as it can poison a person’s mind')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN047', N'Crying Children', N'Thriller', N'PB007', CAST(N'2010-07-18' AS Date), N'A man who is a cannibal can’t control his hunger for human flesh, so he decides to kidnap kids because of their weak physique compared to him and that they are much fresh')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN048', N'Dual Trinity', N'Mystery', N'PB009', CAST(N'2017-07-19' AS Date), N'The First Wisdom We Learn is Called Duality the Symbol is a Coin showing there are Two Sides to Everything Up-down, God-Goddess, Left-Right, Good-Evil, Forward-Backwards Etc. The 3 Phases of a Female are called Maiden, Mother and Crone what are the 3 Phases of a Male? Could they be Youth, Father, and Elder ')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN049', N'Fighting Justice', N'Self Help', N'PB002', CAST(N'2013-07-18' AS Date), N'Justice is what makes this bettered because everything is being done fairly this book is about how can a person better themselves for the greater good of a cause')
INSERT [dbo].[Catalogue] ([ISBN], [Title], [Subject_Area], [Publisher_ID], [Year_Published], [Description_B]) VALUES (N'ISBN050', N'Feeding Death', N'Fantasy', N'PB007', CAST(N'2011-07-18' AS Date), N'A man who driven by his thoughts of how beautiful a death scene is, finds his way to designing a certain type of death scene in which the man finds amazing and then implements through a real human being')
INSERT [dbo].[Category] ([Colour_Tag], [Lending_Duration], [Daily_Late_Rate_Fees]) VALUES (N'Green_Tag', CAST(14 AS Numeric(18, 0)), 1.1000)
INSERT [dbo].[Category] ([Colour_Tag], [Lending_Duration], [Daily_Late_Rate_Fees]) VALUES (N'Open_Stack', CAST(30 AS Numeric(18, 0)), 0.7000)
INSERT [dbo].[Category] ([Colour_Tag], [Lending_Duration], [Daily_Late_Rate_Fees]) VALUES (N'Red_Tag', CAST(0 AS Numeric(18, 0)), 0.0000)
INSERT [dbo].[Category] ([Colour_Tag], [Lending_Duration], [Daily_Late_Rate_Fees]) VALUES (N'Yellow_Tag', CAST(3 AS Numeric(18, 0)), 1.5000)
INSERT [dbo].[Department] ([Department_ID], [Department_Name]) VALUES (N'DP000', N'IT')
INSERT [dbo].[Department] ([Department_ID], [Department_Name]) VALUES (N'DP001', N'Engineering')
INSERT [dbo].[Department] ([Department_ID], [Department_Name]) VALUES (N'DP002', N'Arts')
INSERT [dbo].[Department] ([Department_ID], [Department_Name]) VALUES (N'DP003', N'Business')
INSERT [dbo].[Department] ([Department_ID], [Department_Name]) VALUES (N'DP004', N'Human Resources')
INSERT [dbo].[Department] ([Department_ID], [Department_Name]) VALUES (N'DP005', N'Medicine')
INSERT [dbo].[Department] ([Department_ID], [Department_Name]) VALUES (N'DP006', N'Politics')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI000', N'ISBN000', N'Fiction', N'Green_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI001', N'ISBN000', N'Computing', N'Green_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI002', N'ISBN003', N'Other', N'Yellow_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI003', N'ISBN002', N'Journals', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI004', N'ISBN007', N'Reference', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI005', N'ISBN007', N'Reference', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI006', N'ISBN005', N'Other', N'Open_Stack')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI007', N'ISBN009', N'Other', N'Yellow_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI008', N'ISBN025', N'Student_Projects', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI009', N'ISBN019', N'Other', N'Yellow_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI010', N'ISBN006', N'Other', N'Open_Stack')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI011', N'ISBN026', N'Student_Projects', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI012', N'ISBN014', N'Computing', N'Open_Stack')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI013', N'ISBN021', N'Computing', N'Green_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI014', N'ISBN023', N'Other', N'Open_Stack')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI015', N'ISBN017', N'Reference', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI016', N'ISBN017', N'Reference', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI017', N'ISBN017', N'Reference', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI018', N'ISBN018', N'Reference', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI019', N'ISBN018', N'Reference', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI020', N'ISBN018', N'Reference', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI021', N'ISBN035', N'Reference', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI022', N'ISBN036', N'Reference', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI023', N'ISBN037', N'Reference', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI024', N'ISBN038', N'Reference', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI025', N'ISBN039', N'Reference', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI026', N'ISBN040', N'Reference', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI027', N'ISBN041', N'Reference', N'Green_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI028', N'ISBN042', N'Reference', N'Green_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI029', N'ISBN043', N'Reference', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI030', N'ISBN027', N'Other', N'Open_Stack')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI031', N'ISBN022', N'Computing', N'Open_Stack')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI032', N'ISBN022', N'Computing', N'Open_Stack')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI033', N'ISBN044', N'Computing', N'Green_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI034', N'ISBN050', N'Other', N'Open_Stack')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI035', N'ISBN029', N'Other', N'Yellow_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI036', N'ISBN032', N'Other', N'Green_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI037', N'ISBN033', N'Journals', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI038', N'ISBN026', N'Student_Projects', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI039', N'ISBN019', N'Reference', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI040', N'ISBN010', N'Other', N'Yellow_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI041', N'ISBN023', N'Other', N'Open_Stack')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI042', N'ISBN028', N'Other', N'Yellow_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI043', N'ISBN046', N'Other', N'Green_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI044', N'ISBN030', N'Computing', N'Open_Stack')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI045', N'ISBN031', N'Other', N'Green_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI046', N'ISBN036', N'Reference', N'Red_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI047', N'ISBN031', N'Other', N'Open_Stack')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI048', N'ISBN031', N'Other', N'Green_Tag')
INSERT [dbo].[Library_Books] ([Book_ID], [ISBN], [Type_Of_Book], [Colour_Tag]) VALUES (N'BI049', N'ISBN047', N'Other', N'Open_Stack')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW000', N'John Lennon', N'Student', N'johnlennon@freeemail.com', N'DP000', CAST(5 AS Numeric(18, 0)), N'M')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW001', N'John Jim', N'Student', N'johnjim@mail.com', N'DP001', CAST(2 AS Numeric(18, 0)), N'M')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW002', N'Adams Sneezy', N'Student', N'asjfh4565@qq.com', N'DP002', CAST(3 AS Numeric(18, 0)), N'M')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW003', N'Baker Dopey', N'Lecturer', N'asd51465@gamil.com', N'DP003', CAST(4 AS Numeric(18, 0)), N'F')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW004', N'Clark Timon', N'Lecturer', N'asdf551@gmai.com', N'DP003', CAST(6 AS Numeric(18, 0)), N'F')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW005', N'Nalty Nala', N'Manager', N'kjg5462@gmail.com', N'DP003', CAST(6 AS Numeric(18, 0)), N'M')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW006', N'Trott Pumbaa', N'Manager', N'fdgh645@gmail.com', N'DP001', CAST(2 AS Numeric(18, 0)), N'F')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW007', N'White Webti', N'Student', N'jhkj654@qq.com', N'DP002', CAST(5 AS Numeric(18, 0)), N'F')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW008', N'Mason Meersa', N'Student', N'fdgh5464@qq.com', N'DP006', CAST(4 AS Numeric(18, 0)), N'M')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW009', N'Xiang Xiao', N'Student', N'kkffds41431@gmail.com', N'DP002', CAST(10 AS Numeric(18, 0)), N'M')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW010', N'Zafar Zara', N'Lecturer', N'kksasd4213@qq.com', N'DP003', CAST(5 AS Numeric(18, 0)), N'M')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW011', N'Yakub Yaka', N'Student', N'sfsad4611@qq.com', N'DP006', CAST(7 AS Numeric(18, 0)), N'F')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW012', N'Ochoa Ozey', N'Cleaner', N'rfrujio46@qq.com', N'DP001', CAST(3 AS Numeric(18, 0)), N'M')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW013', N'Trott Toomy', N'Manager', N'ojosa464@gmail.com', N'DP002', CAST(3 AS Numeric(18, 0)), N'F')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW014', N'Patel Penal', N'Manager', N'ghdg554@qq.com', N'DP006', CAST(8 AS Numeric(18, 0)), N'F')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW015', N'Smith Smooth', N'Student', N'lkdsd456@gmail.com', N'DP003', CAST(12 AS Numeric(18, 0)), N'M')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW016', N'Usman Uma', N'Student', N'gfd643@qq.com', N'DP001', CAST(0 AS Numeric(18, 0)), N'F')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW017', N'Valdo Vavid', N'Student', N'ddas66@apc.com', N'DP004', CAST(0 AS Numeric(18, 0)), N'M')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW018', N'Reily Reli', N'Student', N'dsadsa123456@qq.com', N'DP005', CAST(0 AS Numeric(18, 0)), N'F')
INSERT [dbo].[Library_Members] ([Member_ID], [Name_U], [Member_Type], [E_mail], [Department_ID], [Activity_Books_Per_Year], [Gender]) VALUES (N'QW019', N'Smith', N'Student', N'llaao@gmail.com', N'DP001', CAST(0 AS Numeric(18, 0)), N'M')
INSERT [dbo].[Publisher] ([Publisher_ID], [Publisher_Name], [Location]) VALUES (N'PB000', N'Prentice Hall', N'14, Fortyfirst Street, Remington, 31600')
INSERT [dbo].[Publisher] ([Publisher_ID], [Publisher_Name], [Location]) VALUES (N'PB001', N'Penguin', N'56, Mainway Street, Rotterdam, 6333')
INSERT [dbo].[Publisher] ([Publisher_ID], [Publisher_Name], [Location]) VALUES (N'PB002', N'NY Times', N'45th Avenue, Manhattan, 3232')
INSERT [dbo].[Publisher] ([Publisher_ID], [Publisher_Name], [Location]) VALUES (N'PB003', N'Penguin', N'53rd Rising St, London, 12312')
INSERT [dbo].[Publisher] ([Publisher_ID], [Publisher_Name], [Location]) VALUES (N'PB004', N'Harvard University', N'Cambridge, MA 02138, USA')
INSERT [dbo].[Publisher] ([Publisher_ID], [Publisher_Name], [Location]) VALUES (N'PB005', N'MIT', N'Cambridge, Massachusetts')
INSERT [dbo].[Publisher] ([Publisher_ID], [Publisher_Name], [Location]) VALUES (N'PB006', N'Sage', N'Newbury Park (CA)')
INSERT [dbo].[Publisher] ([Publisher_ID], [Publisher_Name], [Location]) VALUES (N'PB007', N'Channel View Publications', N'Clevedon (England)')
INSERT [dbo].[Publisher] ([Publisher_ID], [Publisher_Name], [Location]) VALUES (N'PB008', N'Taylor & Francis', N'London')
INSERT [dbo].[Publisher] ([Publisher_ID], [Publisher_Name], [Location]) VALUES (N'PB009', N'The Society', N'New York')
INSERT [dbo].[Reservations] ([Member_ID], [Book_ID], [Reservation_Date]) VALUES (N'QW000', N'BI022', CAST(N'2018-01-09' AS Date))
INSERT [dbo].[Reservations] ([Member_ID], [Book_ID], [Reservation_Date]) VALUES (N'QW003', N'BI001', CAST(N'2018-05-19' AS Date))
INSERT [dbo].[Reservations] ([Member_ID], [Book_ID], [Reservation_Date]) VALUES (N'QW004', N'BI030', CAST(N'2018-11-01' AS Date))
INSERT [dbo].[Reservations] ([Member_ID], [Book_ID], [Reservation_Date]) VALUES (N'QW005', N'BI046', CAST(N'2018-08-09' AS Date))
INSERT [dbo].[Reservations] ([Member_ID], [Book_ID], [Reservation_Date]) VALUES (N'QW007', N'BI009', CAST(N'2018-09-28' AS Date))
INSERT [dbo].[Reservations] ([Member_ID], [Book_ID], [Reservation_Date]) VALUES (N'QW009', N'BI012', CAST(N'2018-02-17' AS Date))
INSERT [dbo].[Reservations] ([Member_ID], [Book_ID], [Reservation_Date]) VALUES (N'QW010', N'BI029', CAST(N'2018-06-29' AS Date))
INSERT [dbo].[Reservations] ([Member_ID], [Book_ID], [Reservation_Date]) VALUES (N'QW014', N'BI039', CAST(N'2018-09-12' AS Date))
INSERT [dbo].[Reservations] ([Member_ID], [Book_ID], [Reservation_Date]) VALUES (N'QW015', N'BI005', CAST(N'2018-10-10' AS Date))
INSERT [dbo].[Reservations] ([Member_ID], [Book_ID], [Reservation_Date]) VALUES (N'QW017', N'BI031', CAST(N'2018-04-23' AS Date))
INSERT [dbo].[Reservations] ([Member_ID], [Book_ID], [Reservation_Date]) VALUES (N'QW018', N'BI013', CAST(N'2018-07-19' AS Date))
INSERT [dbo].[Type_Of_Books] ([Type_of_Books], [Lendability]) VALUES (N'Computing', N'Yes')
INSERT [dbo].[Type_Of_Books] ([Type_of_Books], [Lendability]) VALUES (N'Fiction', N'Yes')
INSERT [dbo].[Type_Of_Books] ([Type_of_Books], [Lendability]) VALUES (N'Journals', N'No')
INSERT [dbo].[Type_Of_Books] ([Type_of_Books], [Lendability]) VALUES (N'Maps', N'No')
INSERT [dbo].[Type_Of_Books] ([Type_of_Books], [Lendability]) VALUES (N'Other', N'Yes')
INSERT [dbo].[Type_Of_Books] ([Type_of_Books], [Lendability]) VALUES (N'Reference', N'No')
INSERT [dbo].[Type_Of_Books] ([Type_of_Books], [Lendability]) VALUES (N'Student_Projects', N'No')
ALTER TABLE [dbo].[Auth_Book_MN]  WITH CHECK ADD  CONSTRAINT [FK_Auth_Book_MN_Author] FOREIGN KEY([Author_ID])
REFERENCES [dbo].[Author] ([Author_ID])
GO
ALTER TABLE [dbo].[Auth_Book_MN] CHECK CONSTRAINT [FK_Auth_Book_MN_Author]
GO
ALTER TABLE [dbo].[Auth_Book_MN]  WITH CHECK ADD  CONSTRAINT [FK_Auth_Book_MN_Library Books] FOREIGN KEY([Book_ID])
REFERENCES [dbo].[Library_Books] ([Book_ID])
GO
ALTER TABLE [dbo].[Auth_Book_MN] CHECK CONSTRAINT [FK_Auth_Book_MN_Library Books]
GO
ALTER TABLE [dbo].[Borrowing_Activity]  WITH CHECK ADD  CONSTRAINT [FK_Borrowing_Activity_Library Books] FOREIGN KEY([Book_ID])
REFERENCES [dbo].[Library_Books] ([Book_ID])
GO
ALTER TABLE [dbo].[Borrowing_Activity] CHECK CONSTRAINT [FK_Borrowing_Activity_Library Books]
GO
ALTER TABLE [dbo].[Borrowing_Activity]  WITH CHECK ADD  CONSTRAINT [FK_Borrowing_Activity_Library_Members] FOREIGN KEY([Member_ID])
REFERENCES [dbo].[Library_Members] ([Member_ID])
GO
ALTER TABLE [dbo].[Borrowing_Activity] CHECK CONSTRAINT [FK_Borrowing_Activity_Library_Members]
GO
ALTER TABLE [dbo].[Catalogue]  WITH CHECK ADD  CONSTRAINT [FK_Catalogue_Publisher] FOREIGN KEY([Publisher_ID])
REFERENCES [dbo].[Publisher] ([Publisher_ID])
GO
ALTER TABLE [dbo].[Catalogue] CHECK CONSTRAINT [FK_Catalogue_Publisher]
GO
ALTER TABLE [dbo].[Library_Books]  WITH CHECK ADD  CONSTRAINT [FK_Library Books_Catalogue] FOREIGN KEY([ISBN])
REFERENCES [dbo].[Catalogue] ([ISBN])
GO
ALTER TABLE [dbo].[Library_Books] CHECK CONSTRAINT [FK_Library Books_Catalogue]
GO
ALTER TABLE [dbo].[Library_Books]  WITH CHECK ADD  CONSTRAINT [FK_Library Books_Category] FOREIGN KEY([Colour_Tag])
REFERENCES [dbo].[Category] ([Colour_Tag])
GO
ALTER TABLE [dbo].[Library_Books] CHECK CONSTRAINT [FK_Library Books_Category]
GO
ALTER TABLE [dbo].[Library_Books]  WITH CHECK ADD  CONSTRAINT [FK_Library Books_Type_Of_Books] FOREIGN KEY([Type_Of_Book])
REFERENCES [dbo].[Type_Of_Books] ([Type_of_Books])
GO
ALTER TABLE [dbo].[Library_Books] CHECK CONSTRAINT [FK_Library Books_Type_Of_Books]
GO
ALTER TABLE [dbo].[Library_Members]  WITH CHECK ADD  CONSTRAINT [FK_Library_Members_Department] FOREIGN KEY([Department_ID])
REFERENCES [dbo].[Department] ([Department_ID])
GO
ALTER TABLE [dbo].[Library_Members] CHECK CONSTRAINT [FK_Library_Members_Department]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_Library Books] FOREIGN KEY([Book_ID])
REFERENCES [dbo].[Library_Books] ([Book_ID])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_Library Books]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_Library_Members] FOREIGN KEY([Member_ID])
REFERENCES [dbo].[Library_Members] ([Member_ID])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_Library_Members]
GO
/****** Object:  StoredProcedure [dbo].[q1]    Script Date: 11/26/2018 11:23:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[q1]
AS
SELECT DISTINCT 
	M.Name_U, 
	COUNT(M.Member_ID) AS 'Total Books Borrowed' 
FROM Library_Members M 
INNER JOIN Borrowing_Activity B 
	ON B.Member_ID=M.Member_ID
GROUP BY M.Name_U
HAVING COUNT(B.Book_ID)>2
ORDER BY M.Name_U ASC;
GO
/****** Object:  StoredProcedure [dbo].[q2]    Script Date: 11/26/2018 11:23:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[q2]
AS
SELECT DISTINCT 
	Colour_Tag, 
	COUNT (Colour_Tag) AS 'Total Books' 
FROM Library_Books 
GROUP BY Colour_Tag
ORDER BY 'Total Books' DESC;
GO
/****** Object:  StoredProcedure [dbo].[q3]    Script Date: 11/26/2018 11:23:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[q3]
AS
SELECT DISTINCT
	A.Author_Name, 
	C.Title, 
	P.Publisher_ID, 
	P.Publisher_Name, 
	P.Location
FROM Auth_Book_MN MN
INNER JOIN 
	Author A ON A.Author_ID=MN.Author_ID 
INNER JOIN 
	Library_Books L ON L.Book_ID=MN.Book_ID
INNER JOIN 
	Catalogue C ON L.ISBN=C.ISBN
INNER JOIN 
	Publisher P ON C.Publisher_ID=P.Publisher_ID
WHERE 
	MN.Author_ID IN (SELECT Author_ID FROM Author WHERE Author_Name IN ('Thomas Connolly', 'Ramez Elmasri'));
GO
/****** Object:  StoredProcedure [dbo].[q4]    Script Date: 11/26/2018 11:23:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[q4]
as
SELECT 
	M.Member_ID, 
	M.Name_U,
	M.Member_type,
	M.E_mail,
	M.Department_ID,
	M.Activity_Books_Per_Year,
	M.Gender,
	R.Book_ID,
	C.ISBN,
	C.Title,
	C.Subject_Area,
	C.Publisher_ID,
	C.Year_Published,
	C.Description_B,
	R.Reservation_date
FROM 
	dbo.Reservations R 
INNER JOIN 
	dbo.Library_Members M ON R.Member_ID = M.Member_ID
INNER JOIN 
	dbo.[Library_Books] B ON R.Book_ID = B.Book_ID
INNER JOIN 
	dbo.Catalogue C ON C.ISBN = B.ISBN
ORDER BY M.Member_ID ASC
GO
/****** Object:  StoredProcedure [dbo].[q5]    Script Date: 11/26/2018 11:23:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[q5]
as 
SELECT DISTINCT 
	D.Department_Name, 
	M.Member_Type,
	COUNT(BA.Member_ID) AS 'Total Books Borrowed' 
FROM Department D
INNER JOIN Library_Members M ON M.Department_ID=D.Department_ID
INNER JOIN Borrowing_Activity BA ON BA.Member_ID=M.Member_ID
GROUP BY D.Department_Name, Member_Type;
GO
/****** Object:  StoredProcedure [dbo].[q6]    Script Date: 11/26/2018 11:23:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[q6]
as
SELECT 
	M.Member_ID,
	M.Name_U,
	M.Member_type,
	M.E_mail, 
	M.Department_ID,
	M.Activity_Books_Per_Year, 
	M.Gender, 
	B.Book_ID, 
	B.ISBN, 
	N.Author_ID , 
	L.Author_Name,
	C.Title
FROM 
	dbo.Library_Members M 
INNER JOIN 
	dbo.Borrowing_Activity A ON M.Member_ID = A.Member_ID
INNER JOIN 
	dbo.[Library_Books] B ON B.Book_ID = A.Book_ID
INNER JOIN
	dbo.Catalogue C ON C.ISBN = B.ISBN
INNER JOIN 
	dbo.Auth_Book_MN N ON N.Book_ID = A.Book_ID
INNER JOIN
	dbo.Author L ON N.Author_ID = L.Author_ID
WHERE L.Author_Name ='C.J. Date'
ORDER BY M.Member_ID ASC
GO
/****** Object:  StoredProcedure [dbo].[q7]    Script Date: 11/26/2018 11:23:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[q7]
AS
select c.Title
from Catalogue c inner join Publisher p on c.Publisher_ID = p.Publisher_ID
inner join [Library_Books] l on c.ISBN = l.ISBN
where p.Publisher_Name = 'Prentice Hall' and l.Type_Of_Book='computing';
GO
/****** Object:  StoredProcedure [dbo].[q8]    Script Date: 11/26/2018 11:23:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[q8]
AS
select *
from Library_Members l where l.Activity_Books_Per_Year=0
order by l.Department_ID ASC,l.Name_U;
GO
/****** Object:  StoredProcedure [dbo].[q9]    Script Date: 11/26/2018 11:23:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[q9]
as
SELECT 
	M.Name_U, 
	D.Department_Name, 
	C.Title, 
	CA.Daily_Late_Rate_Fees*DATEDIFF(day,BA.End_Date,BA.Submission_Date) AS 'Fees'
FROM Borrowing_Activity BA 
INNER JOIN Library_Members M ON BA.Member_ID = M.Member_ID
INNER JOIN Library_Books L ON BA.Book_ID = L.Book_ID
INNER JOIN Catalogue C ON L.ISBN=C.ISBN
INNER JOIN Department D ON M.Department_ID=D.Department_ID 
INNER JOIN Category CA ON CA.Colour_Tag=L.Colour_Tag
WHERE Submission_Date>End_Date;
GO
/****** Object:  StoredProcedure [dbo].[q9_alternative]    Script Date: 11/26/2018 11:23:07 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[q9_alternative]
as
select 
	M.Name_U, 
	D.Department_Name, 
	C.Title,
	dbo.calculate_fee(CA.Colour_Tag,dbo.calculate_day(BA.End_Date,BA.Submission_Date)) as fee
from Borrowing_Activity BA
INNER JOIN Library_Members M ON BA.Member_ID = M.Member_ID
INNER JOIN Library_Books L ON BA.Book_ID = L.Book_ID
INNER JOIN Catalogue C ON L.ISBN=C.ISBN
INNER JOIN Department D ON M.Department_ID=D.Department_ID 
INNER JOIN Category CA ON CA.Colour_Tag=L.Colour_Tag
where BA.End_Date<BA.Submission_Date;
GO
USE [master]
GO
ALTER DATABASE [LMS] SET  READ_WRITE 
GO
