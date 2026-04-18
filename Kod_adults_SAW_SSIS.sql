-- Tworzenie bazy ETL_adults
if not exists (select name from sys.databases where name = N'ETL_adults')
BEGIN
    CREATE DATABASE ETL_adults
END

-- Tworzenie tabeli Persons
IF NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[Persons]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Persons](
[id] [NUMERIC](1, 0) IDENTITY(1, 1) NOT NULL,
[wstatus] [VARCHAR](4) NULL,
[zatrudnienie_symbol] [VARCHAR](4) NULL,
[Employment status] [VARCHAR](50) NULL,
[Status zatrudnienia] [VARCHAR](50) NULL,
PRIMARY KEY CLUSTERED 
(
    [id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END

-- Tworzenie tabeli Sex
IF NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[Sex]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Sex](
[id] [NUMERIC](1, 0) IDENTITY(1, 1) NOT NULL,
[sex_symbol] [VARCHAR](1) NULL,
[plec_symbol] [VARCHAR](1) NULL,
[Sex] [VARCHAR](10) NULL,
[Plec] [NVARCHAR](10) NULL,
PRIMARY KEY CLUSTERED 
(
    [id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END

-- Tworzenie tabeli Age
IF NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[Age]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Age](
[id] [NUMERIC](1, 0) IDENTITY(1, 1) NOT NULL,
[age] [VARCHAR](10) NULL,
[wiek_symbol] [VARCHAR](10) NULL,
[Age class] [VARCHAR](50) NULL,
[Grupa wiekowa] [NVARCHAR](50) NULL,
PRIMARY KEY CLUSTERED 
(
    [id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END

-- Tworzenie tabeli Children
IF NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[Children]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Children](
[id] [NUMERIC](1, 0) IDENTITY(1, 1) NOT NULL,
[n_child] [VARCHAR](5) NULL,
[dzieci_symbol] [VARCHAR](5) NULL,
[Number of children] [VARCHAR](50) NULL,
[Liczba dzieci] [NVARCHAR](50) NULL,
PRIMARY KEY CLUSTERED 
(
    [id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END

-- Tworzenie tabeli ChildAge
IF NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[ChildAge]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ChildAge](
[id] [NUMERIC](1, 0) IDENTITY(1, 1) NOT NULL,
[agechild] [VARCHAR](10) NULL,
[wiek_dziecka_symbol] [VARCHAR](10) NULL,
[Age of the child] [VARCHAR](50) NULL,
[Wiek dziecka] [NVARCHAR](50) NULL,
PRIMARY KEY CLUSTERED 
(
    [id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END

-- Tworzenie tabeli Region
IF NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[Region]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Region](
[id] [NUMERIC](2, 0) IDENTITY(1, 1) NOT NULL,
[geo] [VARCHAR](2) NULL,
[Country] [VARCHAR](50) NULL,
[Kraj] [NVARCHAR](50) NULL,
PRIMARY KEY CLUSTERED 
(
    [id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END

-- Tworzenie tabeli Time
IF NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[Time]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Time](
[id] [NUMERIC](2) IDENTITY(1, 1) NOT NULL,
[Year] [VARCHAR](4) NULL,
PRIMARY KEY CLUSTERED 
(
    [id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END

-- Tworzenie tabeli Fact
IF NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[Fact]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Fact](
[id_p] [NUMERIC](1, 0) FOREIGN KEY ([id_p]) REFERENCES [dbo].[Persons]([id]),
[id_s] [NUMERIC](1, 0) FOREIGN KEY ([id_s]) REFERENCES [dbo].[Sex]([id]),
[id_a] [NUMERIC](1, 0) FOREIGN KEY ([id_a]) REFERENCES [dbo].[Age]([id]),
[id_ch] [NUMERIC](1, 0) FOREIGN KEY ([id_ch]) REFERENCES [dbo].[Children]([id]),
[id_ca] [NUMERIC](1, 0) FOREIGN KEY ([id_ca]) REFERENCES [dbo].[ChildAge]([id]),
[id_r] [NUMERIC](2, 0) FOREIGN KEY ([id_r]) REFERENCES [dbo].[Region]([id]),
[id_t] [NUMERIC](2, 0) FOREIGN KEY ([id_t]) REFERENCES [dbo].[Time]([id]),
[Value] [NUMERIC](8, 0) NULL
) ON [PRIMARY]
END

-- Czyszczenie tabeli Fact
DELETE FROM Fact

-- Czyszczenie pozostałych tabel
DELETE FROM Persons;
DBCC CHECKIDENT ('Persons', RESEED, 0);
DELETE FROM Sex;
DBCC CHECKIDENT ('Sex', RESEED, 0);
DELETE FROM Age;
DBCC CHECKIDENT ('Age', RESEED, 0);
DELETE FROM Children;
DBCC CHECKIDENT ('Children', RESEED, 0);
DELETE FROM ChildAge;
DBCC CHECKIDENT ('ChildAge', RESEED, 0);
DELETE FROM Region;
DBCC CHECKIDENT ('Region', RESEED, 0);
DELETE FROM [Time];
DBCC CHECKIDENT ('[Time]', RESEED, 0);

-- Wypełnianie tabeli Persons
IF NOT EXISTS (select * from Persons)
BEGIN
INSERT INTO Persons
([wstatus],
    [Employment status],
    [zatrudnienie_symbol],
    [Status zatrudnienia])
SELECT DISTINCT [wstatus], 
[Labour force and employment status] AS [Employment status],
    CASE [wstatus]
        WHEN 'NEMP' THEN 'NZAT'
        WHEN 'EMP' THEN 'ZAT'
    END AS [zatrudnienie_symbol],
    CASE [Labour force and employment status]
        WHEN 'Not employed persons' THEN 'Niezatrudnione osoby'
        WHEN 'Employed persons' THEN 'Zatrudnione osoby'
    END AS [Status zatrudnienia]
FROM adults
END

-- Wypełnianie tabeli Sex
IF NOT EXISTS (select * from Sex)
BEGIN
INSERT INTO Sex
([sex_symbol],
    [Sex],
    [plec_symbol],
    [Plec])
SELECT DISTINCT [sex_symbol], [Sex],
    CASE [sex_symbol]
        WHEN 'M' THEN 'M'
        WHEN 'F' THEN 'K'
    END AS [plec_symbol],
    CASE [Sex]
        WHEN 'Males' THEN N'Mężczyźni'
        WHEN 'Females' THEN N'Kobiety'
    END AS [Plec]
FROM adults
END

-- Wypełnianie tabeli Age
IF NOT EXISTS (select * from Age)
BEGIN
INSERT INTO Age
(   [age],
    [Age class],
    [wiek_symbol],
    [Grupa wiekowa])
SELECT DISTINCT [age], [Age class],
    CASE [age]
        WHEN 'Y25-54' THEN '25-54L'
        WHEN 'Y18-24' THEN '18-24L'
        WHEN 'Y_GE55' THEN '>=55L'
    END AS [wiek_symbol],
    CASE [Age class]
        WHEN 'From 25 to 54 years' THEN N'Między 25. a 54. rokiem życia'
        WHEN 'From 18 to 24 years' THEN N'Między 18. a 24. rokiem życia'
        WHEN '55 years or over' THEN N'55. rok życia lub więcej'
    END AS [Grupa wiekowa]
FROM adults
END

-- Wypełnianie tabeli Children
IF NOT EXISTS (select * from Children)
BEGIN
INSERT INTO Children
([n_child],
    [Number of children],
    [dzieci_symbol],[Liczba dzieci])
SELECT DISTINCT [n_child], [Number of children], 
    CASE [n_child]
        WHEN '2' THEN '2'
        WHEN 'GE3' THEN '>=3'
        WHEN '1' THEN '1'
        WHEN '0' THEN '0'
    END AS [dzieci_symbol],
    CASE [Number of children]
        WHEN '2 children' THEN N'2 dzieci'
        WHEN '3 children or more' THEN N'3 dzieci lub więcej'
        WHEN '1 child' THEN N'1 dziecko'
        WHEN 'No children' THEN N'Brak dzieci'
    END AS [Liczba dzieci]
FROM adults
END

-- Wypełnianie tabeli ChildAge
IF NOT EXISTS (select * from ChildAge)
BEGIN
INSERT INTO ChildAge
([agechild],
    [Age of the child], [wiek_dziecka_symbol], [Wiek dziecka])
SELECT DISTINCT [agechild], [Age of the child],
    CASE [agechild]
        WHEN 'Y_LT6' THEN '<6L'
        WHEN 'Y6-11' THEN '6-11L'
        WHEN 'Y_GE12' THEN '>=12L'
        WHEN 'NAP' THEN 'NDOT'
    END AS [wiek_dziecka_symbol],
    CASE [Age of the child]
        WHEN '12 years or over' THEN N'12. rok życia lub więcej'
        WHEN 'Less than 6 years' THEN N'Poniżej 6. roku życia'
        WHEN 'From 6 to 11 years' THEN N'Od 6. do 11. roku życia'
        WHEN 'Not applicable' THEN N'Niedotyczy'
    END AS [Wiek dziecka]
FROM adults
END

-- Wypełnianie tabeli Region
IF NOT EXISTS (select * from Region)
BEGIN
INSERT INTO Region
([geo], [Country], [Kraj])
SELECT DISTINCT
    [geo],
    [Geopolitical entity (reporting)] AS [Country],
    [Kraj]
FROM adults
END

-- Zaaktualizowanie Turcji w tabeli Region
UPDATE Region
 SET Country = 'Turkiye'
 WHERE geo = 'TR'


-- Wypełnianie tabeli Time
IF NOT EXISTS (select * from [Time])
BEGIN
INSERT INTO [Time]
SELECT DISTINCT [TIME_PERIOD] AS [Year]
FROM adults
ORDER BY 1
END

-- Wypełnianie tabeli Fact
IF NOT EXISTS (select * from Fact)
BEGIN
INSERT INTO Fact 
(id_p, id_s, id_a, id_ch, id_ca, id_r, id_t, [Value])
SELECT
[Persons].id AS id_p,
[Sex].id AS id_s,
[Age].id AS id_a,
[Children].id AS id_ch,
[ChildAge].id AS id_ca,
[Region].id AS id_r,
[Time].id AS id_t,
TRY_CAST(NULLIF([OBS_VALUE], '') AS [NUMERIC](8, 0)) AS [Value]
FROM adults, Persons, Sex, Age, Children, ChildAge, Region, [Time]
WHERE adults.wstatus = Persons.wstatus
   AND adults.sex_symbol = Sex.sex_symbol
   AND adults.age = Age.age
   AND adults.n_child = Children.n_child
   AND adults.agechild = ChildAge.agechild
   AND adults.geo = Region.geo
   AND adults.[TIME_PERIOD] = [Time].[Year]
END