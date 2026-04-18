SELECT [STRUCTURE]
      ,[STRUCTURE_ID]
      ,[STRUCTURE_NAME]
      ,[freq]
      ,[Time frequency]
      ,[unit]
      ,[Unit of measure]
      ,[Time]
      ,[Observation value]
      ,[OBS_FLAG]
      ,[Observation status (Flag) V2 structure]
      ,[CONF_STATUS]
      ,[Confidentiality status (flag)]
      ,[Number of children] 
  FROM adults

-- Osoby
CREATE TABLE Persons(
id NUMERIC(1) PRIMARY KEY IDENTITY(1, 1),
[wstatus] VARCHAR(4),
[zatrudnienie_symbol] VARCHAR(4),
[Employment status] VARCHAR(50),
[Status zatrudnienia] VARCHAR(50))
GO

-- INSERT INTO Persons
(   [wstatus],
    [Employment status],
    [zatrudnienie_symbol],
    [Status zatrudnienia])
SELECT DISTINCT [wstatus], [Labour force and employment status] AS [Employment status], 
    CASE [wstatus]
        WHEN 'NEMP' THEN 'NZAT'
        WHEN 'EMP' THEN 'ZAT'
    END AS [zatrudnienie_symbol],
    CASE [Labour force and employment status]
        WHEN 'Not employed persons' THEN 'Niezatrudnione osoby'
        WHEN 'Employed persons' THEN 'Zatrudnione osoby'
    END AS [Status zatrudnienia]
FROM adults

-- Plec
CREATE TABLE Sex(
id NUMERIC(1) PRIMARY KEY IDENTITY(1, 1),
[sex_symbol] VARCHAR(1),
[plec_symbol] VARCHAR(1),
[Sex] VARCHAR(10),
[Plec] NVARCHAR(10))
GO

-- INSERT INTO Sex
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

-- Wiek
CREATE TABLE Age(
id NUMERIC(1) PRIMARY KEY IDENTITY(1, 1),
[age] VARCHAR(10),
[wiek_symbol] VARCHAR(10),
[Age class] VARCHAR(50),
[Grupa wiekowa] NVARCHAR(50))
GO

-- INSERT INTO Age
([age], [Age class], [wiek_symbol], [Grupa wiekowa])
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

-- Dzieci
CREATE TABLE Children(
id NUMERIC(1) PRIMARY KEY IDENTITY(1, 1),
[n_child] VARCHAR(5),
[dzieci_symbol] VARCHAR(5),
[Number of children] VARCHAR(50),
[Liczba dzieci] NVARCHAR(50))
GO

-- INSERT INTO Children
([n_child], [Number of children], [dzieci_symbol],[Liczba dzieci])
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

-- Wiek dziecka
CREATE TABLE ChildAge(
id NUMERIC(1) PRIMARY KEY IDENTITY(1, 1),
[agechild] VARCHAR(10),
[wiek_dziecka_symbol] VARCHAR(10),
[Age of the child] VARCHAR(50),
[Wiek dziecka] NVARCHAR(50))
GO

-- INSERT INTO ChildAge
([agechild], [Age of the child], [wiek_dziecka_symbol], [Wiek dziecka])
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

-- KRAJ
CREATE TABLE Region(
id NUMERIC(2) PRIMARY KEY IDENTITY(1, 1),
geo VARCHAR(2),
[Country] VARCHAR(50),
[Kraj] NVARCHAR(50))
GO

-- INSERT INTO Region
(geo, [Country], [Kraj])
SELECT DISTINCT
    a.geo,
    a.[Geopolitical entity (reporting)] AS [Country],
    k.[Kraj]
FROM adults a
LEFT JOIN kraje_pl k
    ON a.geo = k.geo
LEFT JOIN Region r
    ON r.geo = a.geo

-- UPDATE Region SET [Country] = 'Turkiye' WHERE geo = 'TR'

-- CZAS
CREATE TABLE [Time](
id NUMERIC(2) PRIMARY KEY IDENTITY(1, 1),
[Year] VARCHAR(4))
GO

-- INSERT INTO [Time]
SELECT DISTINCT [TIME_PERIOD] AS [Year]
FROM adults
ORDER BY 1

-- Fakt
CREATE TABLE Fact(
id_p NUMERIC(1) FOREIGN KEY (id_p) REFERENCES [Persons](id),
id_s NUMERIC(1) FOREIGN KEY (id_s) REFERENCES [Sex](id),
id_a NUMERIC(1) FOREIGN KEY (id_a) REFERENCES [Age](id),
id_ch NUMERIC(1) FOREIGN KEY (id_ch) REFERENCES [Children](id),
id_ca NUMERIC(1) FOREIGN KEY (id_ca) REFERENCES [ChildAge](id),
id_r NUMERIC(2) FOREIGN KEY (id_r) REFERENCES [Region](id),
id_t NUMERIC(2) FOREIGN KEY (id_t) REFERENCES [Time](id),
[Value] NUMERIC(8))

-- INSERT INTO Fact 
(id_p, id_s, id_a, id_ch, id_ca, id_r, id_t, [Value])
SELECT
[Persons].id AS id_p,
[Sex].id AS id_s,
[Age].id AS id_a,
[Children].id AS id_ch,
[ChildAge].id AS id_ca,
[Region].id AS id_r,
[Time].id AS id_t,
TRY_CAST(NULLIF([OBS_VALUE], '') AS NUMERIC(8)) AS [Value]
FROM adults, Persons, Sex, Age, Children, ChildAge, Region, [Time]
WHERE adults.wstatus = Persons.wstatus
   AND adults.sex_symbol = Sex.sex_symbol
   AND adults.age = Age.age
   AND adults.n_child = Children.n_child
   AND adults.agechild = ChildAge.agechild
   AND adults.geo = Region.geo
   AND adults.[TIME_PERIOD] = [Time].[Year]


ALTER TABLE kraje_pl
ALTER COLUMN geo VARCHAR(2) NOT NULL;
