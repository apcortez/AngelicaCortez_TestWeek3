USE [master]
GO
/****** Object:  Database [GestionePizze]    Script Date: 10/8/2021 3:15:31 PM ******/
CREATE DATABASE [GestionePizze]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GestionePizze', FILENAME = N'C:\Users\angelica.cortez\GestionePizze.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GestionePizze_log', FILENAME = N'C:\Users\angelica.cortez\GestionePizze_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [GestionePizze] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GestionePizze].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GestionePizze] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GestionePizze] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GestionePizze] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GestionePizze] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GestionePizze] SET ARITHABORT OFF 
GO
ALTER DATABASE [GestionePizze] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [GestionePizze] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GestionePizze] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GestionePizze] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GestionePizze] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GestionePizze] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GestionePizze] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GestionePizze] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GestionePizze] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GestionePizze] SET  ENABLE_BROKER 
GO
ALTER DATABASE [GestionePizze] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GestionePizze] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GestionePizze] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GestionePizze] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GestionePizze] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GestionePizze] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GestionePizze] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GestionePizze] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GestionePizze] SET  MULTI_USER 
GO
ALTER DATABASE [GestionePizze] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GestionePizze] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GestionePizze] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GestionePizze] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GestionePizze] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [GestionePizze] SET QUERY_STORE = OFF
GO
USE [GestionePizze]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [GestionePizze]
GO
/****** Object:  Table [dbo].[Pizza]    Script Date: 10/8/2021 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pizza](
	[IdPizza] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](50) NOT NULL,
	[Prezzo] [decimal](5, 2) NOT NULL,
 CONSTRAINT [Pk_pizza] PRIMARY KEY CLUSTERED 
(
	[IdPizza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[MostraListino]    Script Date: 10/8/2021 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[MostraListino]()
RETURNS TABLE
AS 
RETURN
SELECT Nome, Prezzo FROM Pizza
GO
/****** Object:  Table [dbo].[Ingrediente]    Script Date: 10/8/2021 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingrediente](
	[IdIngrediente] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](50) NOT NULL,
	[Costo] [decimal](5, 2) NOT NULL,
	[QtyMagazzino] [int] NOT NULL,
 CONSTRAINT [Pk_ingrediente] PRIMARY KEY CLUSTERED 
(
	[IdIngrediente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Composizione]    Script Date: 10/8/2021 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Composizione](
	[IdPizza] [int] NULL,
	[IdIngrediente] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[MostraListinoByIngrediente]    Script Date: 10/8/2021 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[MostraListinoByIngrediente](@nomeIngrediente nvarchar(50))
RETURNS TABLE
AS 
RETURN
SELECT Pizza.Nome, Pizza.Prezzo
FROM Pizza join Composizione ON Pizza.IdPizza = Composizione.IdPizza
		   join Ingrediente on Ingrediente.IdIngrediente = Composizione.IdIngrediente
WHERE Ingrediente.Nome = @nomeIngrediente
GO
/****** Object:  UserDefinedFunction [dbo].[MostraByNoIngrediente]    Script Date: 10/8/2021 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[MostraByNoIngrediente](@nomeIngrediente nvarchar(50))
RETURNS TABLE
AS 
RETURN
SELECT DISTINCT Pizza.Nome, Pizza.Prezzo
FROM Pizza join Composizione ON Pizza.IdPizza = Composizione.IdPizza
		   join Ingrediente on Ingrediente.IdIngrediente = Composizione.IdIngrediente
WHERE Composizione.IdPizza NOT IN (SELECT Composizione.IdPizza
								   FROM Composizione join Ingrediente on Composizione.IdIngrediente = Ingrediente.IdIngrediente
								   WHERE Ingrediente.Nome = @nomeIngrediente)
GO
/****** Object:  UserDefinedFunction [dbo].[NPizzeIngrediente]    Script Date: 10/8/2021 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[NPizzeIngrediente](@nomeIngrediente nvarchar(50))
RETURNS TABLE
AS 
RETURN
SELECT Count(IdPizza) as NumeroPizze
FROM Composizione join Ingrediente on Composizione.IdIngrediente = Ingrediente.IdIngrediente
WHERE Ingrediente.Nome  IN (@nomeIngrediente)
GO
/****** Object:  UserDefinedFunction [dbo].[NPizzeNoIngrediente]    Script Date: 10/8/2021 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[NPizzeNoIngrediente](@IdIngrediente int)
RETURNS TABLE
AS 
RETURN
SELECT COUNT(DISTINCT IdPizza) AS NumeroPizze
FROM Composizione join Ingrediente on Composizione.IdIngrediente = Ingrediente.IdIngrediente
WHERE Composizione.IdPizza NOT IN (SELECT DISTINCT IdPizza
						  				 FROM Composizione join Ingrediente on Composizione.IdIngrediente = Ingrediente.IdIngrediente
                                         WHERE Ingrediente.IdIngrediente IN (@IdIngrediente))
GO
/****** Object:  UserDefinedFunction [dbo].[NIngredientiPizza]    Script Date: 10/8/2021 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[NIngredientiPizza](@NomePizza nvarchar(50))
RETURNS TABLE
AS 
RETURN
SELECT COUNT(IdIngrediente) AS NumeroIngredienti
FROM Composizione join Pizza on Composizione.IdPizza = Pizza.IdPizza
WHERE Pizza.Nome = @NomePizza
GO
/****** Object:  View [dbo].[ListinoPizze2]    Script Date: 10/8/2021 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ListinoPizze2] AS
SELECT Pizza.Nome, Pizza.Prezzo,
	   STUFF((SELECT ' , '+  I.Nome
	         FROM Ingrediente I, Composizione C
			 WHERE I.IdIngrediente = C.IdIngrediente
			 ORDER BY Pizza.IdPizza
			 FOR XML PATH('')), 1, 1, '') [Ingredienti]
FROM Pizza 
GROUP BY Pizza.IdPizza, Pizza.Nome, Pizza.Prezzo
GO
/****** Object:  View [dbo].[ListinoPizze]    Script Date: 10/8/2021 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ListinoPizze] AS
SELECT Pizza.Nome, Pizza.Prezzo, Ingrediente.Nome AS Ingredienti
FROM   Composizione JOIN Ingrediente ON Composizione.IdIngrediente = Ingrediente.IdIngrediente 
					JOIN Pizza ON dbo.Composizione.IdPizza = dbo.Pizza.IdPizza
GO
ALTER TABLE [dbo].[Composizione]  WITH CHECK ADD FOREIGN KEY([IdIngrediente])
REFERENCES [dbo].[Ingrediente] ([IdIngrediente])
GO
ALTER TABLE [dbo].[Composizione]  WITH CHECK ADD FOREIGN KEY([IdPizza])
REFERENCES [dbo].[Pizza] ([IdPizza])
GO
ALTER TABLE [dbo].[Ingrediente]  WITH CHECK ADD  CONSTRAINT [CHK_ingcosto] CHECK  (([Costo]>(0)))
GO
ALTER TABLE [dbo].[Ingrediente] CHECK CONSTRAINT [CHK_ingcosto]
GO
ALTER TABLE [dbo].[Ingrediente]  WITH CHECK ADD  CONSTRAINT [CHK_ingQty] CHECK  (([QtyMagazzino]>=(0)))
GO
ALTER TABLE [dbo].[Ingrediente] CHECK CONSTRAINT [CHK_ingQty]
GO
ALTER TABLE [dbo].[Pizza]  WITH CHECK ADD  CONSTRAINT [CHK_prezzo] CHECK  (([Prezzo]>(0)))
GO
ALTER TABLE [dbo].[Pizza] CHECK CONSTRAINT [CHK_prezzo]
GO
/****** Object:  StoredProcedure [dbo].[EliminaIngredientePizza]    Script Date: 10/8/2021 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminaIngredientePizza]
@NomePizza nvarchar(50),
@NomeIngrediente nvarchar(50)
AS
BEGIN
	BEGIN TRY
	DECLARE @IdPizza int
	SELECT @IdPizza = IdPizza
	FROM Pizza
	WHERE Nome = @NomePizza

	DECLARE @IdIngrediente int
	SELECT @IdIngrediente = IdIngrediente
	FROM Ingrediente
	WHERE Nome = @NomeIngrediente
	DELETE Composizione WHERE IdPizza = @IdPizza and IdIngrediente = @IdIngrediente
	END TRY

	BEGIN CATCH
	SELECT ERROR_MESSAGE(), ERROR_LINE()
	END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[InsertComposizionePizza]    Script Date: 10/8/2021 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertComposizionePizza]
@NomePizza nvarchar(50),
@NomeIngrediente nvarchar(50)
AS
BEGIN
	BEGIN TRY
	DECLARE @IdPizza int
	SELECT @IdPizza = IdPizza
	FROM Pizza
	WHERE Nome = @NomePizza

	DECLARE @IdIngrediente int
	SELECT @IdIngrediente = IdIngrediente
	FROM Ingrediente
	WHERE Nome = @NomeIngrediente
	INSERT INTO Composizione(IdPizza, IdIngrediente) VALUES (@IdPizza, @IdIngrediente)
	END TRY

	BEGIN CATCH
	SELECT ERROR_MESSAGE(), ERROR_LINE()
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[InsertPizza]    Script Date: 10/8/2021 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertPizza]
@Nome nvarchar(50),
@Prezzo decimal(5,2)
AS
BEGIN
	BEGIN TRY
	INSERT INTO Pizza(Nome, Prezzo) VALUES (@Nome, @Prezzo);
	END TRY

	BEGIN CATCH
	SELECT ERROR_MESSAGE(), ERROR_LINE()
	END CATCH

END
GO
/****** Object:  StoredProcedure [dbo].[UpdatePizza]    Script Date: 10/8/2021 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePizza]
@NomePizza nvarchar(50),
@Prezzo decimal(5,2)
AS
BEGIN
	BEGIN TRY
	UPDATE Pizza SET Prezzo = @Prezzo WHERE Nome = @NomePizza
	END TRY

	BEGIN CATCH
	SELECT ERROR_MESSAGE(), ERROR_LINE()
	END CATCH
END
GO
USE [master]
GO
ALTER DATABASE [GestionePizze] SET  READ_WRITE 
GO
