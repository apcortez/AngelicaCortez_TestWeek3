--CREATE DATABASE GestionePizze;

--CREATE TABLE Pizza(
--IdPizza int IDENTITY(1,1) NOT NULL,
--Nome nvarchar(50) NOT NULL,
--Prezzo decimal(5,2) NOT NULL,
--CONSTRAINT Pk_pizza PRIMARY KEY(IdPizza),
--CONSTRAINT CHK_prezzo CHECK (Prezzo>0)
--);

--CREATE TABLE Ingrediente(
--IdIngrediente int IDENTITY(1,1) NOT NULL,
--Nome nvarchar(50) NOT NULL,
--Costo decimal(5,2) NOT NULL,
--QtyMagazzino int NOT NULL,
--CONSTRAINT Pk_ingrediente PRIMARY KEY(IdIngrediente),
--CONSTRAINT CHK_ingcosto CHECK (Costo>0),
--CONSTRAINT CHK_ingQty CHECK (QtyMagazzino>=0)
--);

--CREATE TABLE Composizione(
--IdPizza int FOREIGN KEY REFERENCES Pizza(IdPizza),
--IdIngrediente int FOREIGN KEY REFERENCES Ingrediente(IdIngrediente)
--);

-----------------------------------------------------------------------------------------------
--INSERT INTO Pizza VALUES ('Margherita', 5);
--INSERT INTO Pizza VALUES ('Bufala', 7);
--INSERT INTO Pizza VALUES ('Diavola', 6);
--INSERT INTO Pizza VALUES ('Quattro Stagioni', 6.50);
--INSERT INTO Pizza VALUES ('Porcini', 7);
--INSERT INTO Pizza VALUES ('Dioniso', 8);
--INSERT INTO Pizza VALUES ('Ortolana', 8);
--INSERT INTO Pizza VALUES ('Patate e Salsiccia', 6);
--INSERT INTO Pizza VALUES ('Pomodorini', 6);
--INSERT INTO Pizza VALUES ('Quattro Formaggi', 7.50);
--INSERT INTO Pizza VALUES ('Caprese', 7.50);
--INSERT INTO Pizza VALUES ('Zeus', 7.50);

--INSERT INTO Ingrediente VALUES ('Pomodoro', 2, 100);
--INSERT INTO Ingrediente VALUES ('Mozzarella', 1.50, 50);
--INSERT INTO Ingrediente VALUES ('Mozzarella di bufala', 3, 20);
--INSERT INTO Ingrediente VALUES ('Spianata piccante', 5, 10);
--INSERT INTO Ingrediente VALUES ('Funghi', 1, 100);
--INSERT INTO Ingrediente VALUES ('Carciofi', 1.50, 30);
--INSERT INTO Ingrediente VALUES ('Prosciutto cotto', 6, 300);
--INSERT INTO Ingrediente VALUES ('Olive', 1, 23);
--INSERT INTO Ingrediente VALUES ('Funghi porcini', 1.50, 30);
--INSERT INTO Ingrediente VALUES ('Stracchino', 3, 46);
--INSERT INTO Ingrediente VALUES ('Speck', 12, 37);
--INSERT INTO Ingrediente VALUES ('Rucola', 2, 300);
--INSERT INTO Ingrediente VALUES ('Grana', 8, 1000);
--INSERT INTO Ingrediente VALUES ('Verdure', 1, 3000);
--INSERT INTO Ingrediente VALUES ('Patate', 2, 23);
--INSERT INTO Ingrediente VALUES ('Salsiccia', 12, 33);
--INSERT INTO Ingrediente VALUES ('Ricotta', 4, 22);
--INSERT INTO Ingrediente VALUES ('Pomodorini', 2, 344);
--INSERT INTO Ingrediente VALUES ('Provola', 12, 55);
--INSERT INTO Ingrediente VALUES ('Gorgonzola', 20, 321);
--INSERT INTO Ingrediente VALUES ('Pomodoro fresco', 2, 800);
--INSERT INTO Ingrediente VALUES ('Basilico', 2, 200);
--INSERT INTO Ingrediente VALUES ('Bresaola', 10, 30);

--INSERT INTO Composizione VALUES(1,1);
--INSERT INTO Composizione VALUES(1,2);
--INSERT INTO Composizione VALUES(2,1);
--INSERT INTO Composizione VALUES(2,3);
--INSERT INTO Composizione VALUES(3,1);
--INSERT INTO Composizione VALUES(3,2);
--INSERT INTO Composizione VALUES(3,4);
--INSERT INTO Composizione VALUES(4,1);
--INSERT INTO Composizione VALUES(4,2);
--INSERT INTO Composizione VALUES(4,5);
--INSERT INTO Composizione VALUES(4,6);
--INSERT INTO Composizione VALUES(4,7);
--INSERT INTO Composizione VALUES(4,8);
--INSERT INTO Composizione VALUES(5,1);
--INSERT INTO Composizione VALUES(5,2);
--INSERT INTO Composizione VALUES(5,9);
--INSERT INTO Composizione VALUES(6,1);
--INSERT INTO Composizione VALUES(6,2);
--INSERT INTO Composizione VALUES(6,10);
--INSERT INTO Composizione VALUES(6,11);
--INSERT INTO Composizione VALUES(6,12);
--INSERT INTO Composizione VALUES(6,13);
--INSERT INTO Composizione VALUES(7,1);
--INSERT INTO Composizione VALUES(7,2);
--INSERT INTO Composizione VALUES(7,14);
--INSERT INTO Composizione VALUES(8,2);
--INSERT INTO Composizione VALUES(8,15);
--INSERT INTO Composizione VALUES(8,16);
--INSERT INTO Composizione VALUES(9,2);
--INSERT INTO Composizione VALUES(9,18);
--INSERT INTO Composizione VALUES(9,17);
--INSERT INTO Composizione VALUES(10,2);
--INSERT INTO Composizione VALUES(10,19);
--INSERT INTO Composizione VALUES(10,20);
--INSERT INTO Composizione VALUES(10,13);
--INSERT INTO Composizione VALUES(11,2);
--INSERT INTO Composizione VALUES(11,21);
--INSERT INTO Composizione VALUES(11,22);
--INSERT INTO Composizione VALUES(12,2);
--INSERT INTO Composizione VALUES(12,23);
--INSERT INTO Composizione VALUES(12,12);

---------------------------------------------------------------------------------------------------------------
----1. Estrarre tutte le pizze con prezzo superiore a 6 euro.
--SELECT *
--FROM Pizza
--WHERE Prezzo>6;

----2. Estrarre la pizza/le pizze più costosa/e.
--SELECT *
--FROM Pizza
--WHERE Prezzo =  (SELECT MAX(Prezzo)FROM Pizza)

----3. Estrarre le pizze «bianche»
--SELECT distinct Pizza.*
--FROM Pizza join Composizione ON Pizza.IdPizza = Composizione.IdPizza
--		   join Ingrediente on Ingrediente.IdIngrediente = Composizione.IdIngrediente
--WHERE Composizione.IdPizza NOT IN (SELECT Composizione.IdPizza
--								   FROM Composizione join Ingrediente on Composizione.IdIngrediente = Ingrediente.IdIngrediente
--								   WHERE Ingrediente.Nome IN ('Pomodoro'))


----4. Estrarre le pizze che contengono funghi (di qualsiasi tipo).
--SELECT Pizza.*
--FROM Pizza join Composizione ON Pizza.IdPizza = Composizione.IdPizza
--		   join Ingrediente on Ingrediente.IdIngrediente = Composizione.IdIngrediente
--WHERE Ingrediente.Nome LIKE 'funghi%'

-------------------------------------------------------------------------------------------------------------------------------------------------
--1. Inserimento di una nuova pizza (parametri: nome, prezzo) 
--CREATE PROCEDURE InsertPizza
--@Nome nvarchar(50),
--@Prezzo decimal(5,2)
--AS
--BEGIN
--	BEGIN TRY
--	INSERT INTO Pizza(Nome, Prezzo) VALUES (@Nome, @Prezzo);
--	END TRY

--	BEGIN CATCH
--	SELECT ERROR_MESSAGE(), ERROR_LINE()
--	END CATCH

--END

--EXECUTE InsertPizza 'Napoletana', 5;


--2. Assegnazione di un ingrediente a una pizza (parametri: nome pizza, nome ingrediente) 
--CREATE PROCEDURE InsertComposizionePizza
--@NomePizza nvarchar(50),
--@NomeIngrediente nvarchar(50)
--AS
--BEGIN
--	BEGIN TRY
--	DECLARE @IdPizza int
--	SELECT @IdPizza = IdPizza
--	FROM Pizza
--	WHERE Nome = @NomePizza

--	DECLARE @IdIngrediente int
--	SELECT @IdIngrediente = IdIngrediente
--	FROM Ingrediente
--	WHERE Nome = @NomeIngrediente
--	INSERT INTO Composizione(IdPizza, IdIngrediente) VALUES (@IdPizza, @IdIngrediente)
--	END TRY

--	BEGIN CATCH
--	SELECT ERROR_MESSAGE(), ERROR_LINE()
--	END CATCH
--END

--EXECUTE InsertComposizionePizza 'Napoletana', 'Mozzarella';

--3. Aggiornamento del prezzo di una pizza (parametri: nome pizza e nuovo prezzo)
--CREATE PROCEDURE UpdatePizza
--@NomePizza nvarchar(50),
--@Prezzo decimal(5,2)
--AS
--BEGIN
--	BEGIN TRY
--	UPDATE Pizza SET Prezzo = @Prezzo WHERE Nome = @NomePizza
--	END TRY

--	BEGIN CATCH
--	SELECT ERROR_MESSAGE(), ERROR_LINE()
--	END CATCH
--END

--EXECUTE UpdatePizza 'Napoletana', 5.50;

--4. Eliminazione di un ingrediente da una pizza (parametri: nome pizza, nome ingrediente)
--CREATE PROCEDURE EliminaIngredientePizza
--@NomePizza nvarchar(50),
--@NomeIngrediente nvarchar(50)
--AS
--BEGIN
--	BEGIN TRY
--	DECLARE @IdPizza int
--	SELECT @IdPizza = IdPizza
--	FROM Pizza
--	WHERE Nome = @NomePizza

--	DECLARE @IdIngrediente int
--	SELECT @IdIngrediente = IdIngrediente
--	FROM Ingrediente
--	WHERE Nome = @NomeIngrediente
--	DELETE Composizione WHERE IdPizza = @IdPizza and IdIngrediente = @IdIngrediente
--	END TRY

--	BEGIN CATCH
--	SELECT ERROR_MESSAGE(), ERROR_LINE()
--	END CATCH

--END

--EXECUTE EliminaIngredientePizza 'Napoletana', 'Mozzarella';

--5. Incremento del 10% del prezzo delle pizze contenenti un ingrediente (parametro: nome ingrediente)
--CREATE PROCEDURE IncrementoPrezzo(@NomeIngrediente nvarchar(50))
--AS
--BEGIN
--	BEGIN TRY
--	DECLARE @IdPizza int
--	SELECT @IdPizza = Composizione.IdPizza
--	FROM Composizione join Ingrediente on Composizione.IdIngrediente = Ingrediente.IdIngrediente
--	WHERE Ingrediente.Nome = @NomeIngrediente
--	UPDATE Pizza SET Prezzo = (Prezzo + Prezzo*10/100) WHERE IdPizza = @IdPizza
--	END TRY

--	BEGIN CATCH
--	SELECT ERROR_MESSAGE(), ERROR_LINE()
--	END CATCH

--END

--EXECUTE IncrementoPrezzo 'Grana';

--------------------------------------------------------------------------------------------------------------------------
--1. Tabella listino pizze (nome, prezzo) (parametri: nessuno)
--CREATE FUNCTION MostraListino()
--RETURNS TABLE
--AS 
--RETURN
--SELECT Nome, Prezzo FROM Pizza
--GO

--SELECT * FROM dbo.MostraListino()


--2. Tabella listino pizze (nome, prezzo) contenenti un ingrediente (parametri: nome ingrediente)
--CREATE FUNCTION MostraListinoByIngrediente(@nomeIngrediente nvarchar(50))
--RETURNS TABLE
--AS 
--RETURN
--SELECT Pizza.Nome, Pizza.Prezzo
--FROM Pizza join Composizione ON Pizza.IdPizza = Composizione.IdPizza
--		   join Ingrediente on Ingrediente.IdIngrediente = Composizione.IdIngrediente
--WHERE Ingrediente.Nome = @nomeIngrediente
--GO

--SELECT * FROM dbo.MostraListinoByIngrediente('Grana');

--3. Tabella listino pizze (nome, prezzo) che non contengono un certo ingrediente(parametri: nome ingrediente)
--CREATE FUNCTION MostraByNoIngrediente(@nomeIngrediente nvarchar(50))
--RETURNS TABLE
--AS 
--RETURN
--SELECT DISTINCT Pizza.Nome, Pizza.Prezzo
--FROM Pizza join Composizione ON Pizza.IdPizza = Composizione.IdPizza
--		   join Ingrediente on Ingrediente.IdIngrediente = Composizione.IdIngrediente
--WHERE Composizione.IdPizza NOT IN (SELECT Composizione.IdPizza
--								   FROM Composizione join Ingrediente on Composizione.IdIngrediente = Ingrediente.IdIngrediente
--								   WHERE Ingrediente.Nome = @nomeIngrediente)
--GO

--SELECT * FROM dbo.MostraByNoIngrediente('Grana');

--4. Calcolo numero pizze contenenti un ingrediente (parametri: nome ingrediente)
--CREATE FUNCTION NPizzeIngrediente(@nomeIngrediente nvarchar(50))
--RETURNS TABLE
--AS 
--RETURN
--SELECT Count(IdPizza) as NumeroPizze
--FROM Composizione join Ingrediente on Composizione.IdIngrediente = Ingrediente.IdIngrediente
--WHERE Ingrediente.Nome  IN (@nomeIngrediente)
--GO

--SELECT * FROM dbo.NPizzeIngrediente('Mozzarella');


--5. Calcolo numero pizze che non contengono un ingrediente (parametri: codice ingrediente)
--CREATE FUNCTION NPizzeNoIngrediente(@IdIngrediente int)
--RETURNS TABLE
--AS 
--RETURN
--SELECT COUNT(DISTINCT IdPizza) AS NumeroPizze
--FROM Composizione join Ingrediente on Composizione.IdIngrediente = Ingrediente.IdIngrediente
--WHERE Composizione.IdPizza NOT IN (SELECT DISTINCT IdPizza
--						  				 FROM Composizione join Ingrediente on Composizione.IdIngrediente = Ingrediente.IdIngrediente
--                                         WHERE Ingrediente.IdIngrediente IN (@IdIngrediente))
--GO

--SELECT * FROM dbo.NPizzeNoIngrediente(1);



--6. Calcolo numero ingredienti contenuti in una pizza (parametri: nome pizza)
--CREATE FUNCTION NIngredientiPizza(@NomePizza nvarchar(50))
--RETURNS TABLE
--AS 
--RETURN
--SELECT COUNT(IdIngrediente) AS NumeroIngredienti
--FROM Composizione join Pizza on Composizione.IdPizza = Pizza.IdPizza
--WHERE Pizza.Nome = @NomePizza
--GO

--SELECT * FROM dbo.NIngredientiPizza('Quattro Stagioni');

---------------------------------------------------------------------------------------------------------------------------
--CREATE VIEW ListinoPizze AS
--SELECT Pizza.Nome, Pizza.Prezzo, Ingrediente.Nome AS Ingredienti
--FROM   Composizione JOIN Ingrediente ON Composizione.IdIngrediente = Ingrediente.IdIngrediente 
--					JOIN Pizza ON dbo.Composizione.IdPizza = dbo.Pizza.IdPizza


--SELECT * FROM ListinoPizze
--DROP VIEW ListinoPizze

CREATE VIEW ListinoPizze2 AS
SELECT Pizza.Nome, Pizza.Prezzo,
	   STUFF((SELECT ', '+  I.Nome
	         FROM Ingrediente I, Composizione C
			 WHERE I.IdIngrediente = C.IdIngrediente and Pizza.IdPizza = C.IdPizza
			 ORDER BY Pizza.IdPizza
			 FOR XML PATH('')), 1, 1, '') [Ingredienti]
FROM Pizza 
GROUP BY Pizza.IdPizza, Pizza.Nome, Pizza.Prezzo


SELECT * FROM ListinoPizze2
DROP VIEW ListinoPizze2



