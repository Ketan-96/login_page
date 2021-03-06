USE [master]
GO
/****** Object:  Database [user_login]    Script Date: 30-04-2018 19:56:12 ******/
CREATE DATABASE [user_login]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'user_login', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\user_login.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'user_login_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\user_login_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [user_login] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [user_login].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [user_login] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [user_login] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [user_login] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [user_login] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [user_login] SET ARITHABORT OFF 
GO
ALTER DATABASE [user_login] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [user_login] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [user_login] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [user_login] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [user_login] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [user_login] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [user_login] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [user_login] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [user_login] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [user_login] SET  DISABLE_BROKER 
GO
ALTER DATABASE [user_login] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [user_login] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [user_login] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [user_login] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [user_login] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [user_login] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [user_login] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [user_login] SET RECOVERY FULL 
GO
ALTER DATABASE [user_login] SET  MULTI_USER 
GO
ALTER DATABASE [user_login] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [user_login] SET DB_CHAINING OFF 
GO
ALTER DATABASE [user_login] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [user_login] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [user_login] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'user_login', N'ON'
GO
ALTER DATABASE [user_login] SET QUERY_STORE = OFF
GO
USE [user_login]
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
USE [user_login]
GO
/****** Object:  Table [dbo].[fgt_pwd]    Script Date: 30-04-2018 19:56:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fgt_pwd](
	[id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[temp_pwd_hash] [nvarchar](256) NOT NULL,
	[valid_till] [datetime] NOT NULL,
	[is_valid] [bit] NOT NULL,
 CONSTRAINT [PK_fgt_pwd] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_login]    Script Date: 30-04-2018 19:56:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_login](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](150) NOT NULL,
	[Pwd_hash] [nvarchar](150) NOT NULL,
	[Fname] [nvarchar](150) NOT NULL,
	[Lname] [nvarchar](150) NOT NULL,
	[Dob] [date] NOT NULL,
	[Email] [nvarchar](150) NOT NULL,
	[Phone] [int] NOT NULL,
	[Is_active] [bit] NOT NULL,
 CONSTRAINT [PK_user_login] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_login_token]    Script Date: 30-04-2018 19:56:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_login_token](
	[token_id] [uniqueidentifier] NOT NULL,
	[user_id] [int] NOT NULL,
	[refresh_time] [uniqueidentifier] NOT NULL,
	[valid_till] [datetime] NOT NULL,
	[is_valid] [bit] NOT NULL,
 CONSTRAINT [PK_user_login_token] PRIMARY KEY CLUSTERED 
(
	[token_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[fgt_pwd]  WITH CHECK ADD  CONSTRAINT [FK_fgt_pwd_user_login] FOREIGN KEY([user_id])
REFERENCES [dbo].[user_login] ([Id])
GO
ALTER TABLE [dbo].[fgt_pwd] CHECK CONSTRAINT [FK_fgt_pwd_user_login]
GO
ALTER TABLE [dbo].[user_login_token]  WITH CHECK ADD  CONSTRAINT [FK_user_login_token_user_login] FOREIGN KEY([user_id])
REFERENCES [dbo].[user_login] ([Id])
GO
ALTER TABLE [dbo].[user_login_token] CHECK CONSTRAINT [FK_user_login_token_user_login]
GO
/****** Object:  StoredProcedure [dbo].[fgt_pwd_user2]    Script Date: 30-04-2018 19:56:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[fgt_pwd_user2]
	-- Add the parameters for the stored procedure here
--	<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
	@id int,
	@user_id nvarchar(100),
	@temp_pwd_hash nvarchar(256),
	@valid_till datetime,
	@is_valid bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into [fgt_pwd] 
	(id,[User_id],Temp_pwd_hash,valid_till,is_valid)
	values
	( @id,@user_id , @temp_pwd_hash ,@valid_till,@is_valid)
END
GO
/****** Object:  StoredProcedure [dbo].[proc_user_login2]    Script Date: 30-04-2018 19:56:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_user_login2]
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<@Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
		@id int,
		@username nvarchar(150),
		@pwd_hash nvarchar(150),
		@fname nvarchar(150),
		@lname nvarchar(150),
		@dob date,
		@email nvarchar(150),
		@phone int,
		@is_active bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into user_login(id,username,pwd_hash,fname,lname,dob,email,phone,is_active)
	values(@id,@username,@pwd_hash,@fname,@lname,@dob,@email,@phone,@is_active)

	--SELECT <@Param1, sysname, @p1>, <@Param2, sysname, @p2>
END
GO
/****** Object:  StoredProcedure [dbo].[user_login_token_proc_new]    Script Date: 30-04-2018 19:56:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[user_login_token_proc_new]
	-- Add the parameters for the stored procedure here
	--<@Param1, sysname, @p1> <Datatype_For_Param1, , int> = <Default_Value_For_Param1, , 0>, 
	--<Param2, sysname, @p2> <Datatype_For_Param2, , int> = <Default_Value_For_Param2, , 0>
	@token_id uniqueidentifier,
	@user_id int,
	@refresh_time uniqueidentifier,
	@valid_till datetime,
	@is_valid bit

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	insert into [user_login_token]
	(token_id,[user_id],refresh_time,valid_till,is_valid)
	values
	(@token_id,@user_id,@refresh_time,@valid_till,@is_valid)
    -- Insert statements for procedure here
--	SELECT <@Param1, sysname, @p1>, <@Param2, sysname, @p2>
END
GO
USE [master]
GO
ALTER DATABASE [user_login] SET  READ_WRITE 
GO
