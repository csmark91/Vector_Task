-- 1. Partnerek tábla
CREATE TABLE Partnerek (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    NEV NVARCHAR(100) NOT NULL,
    IRANYITOSZAM NVARCHAR(10) NOT NULL,
    TELEPULES NVARCHAR(50) NOT NULL,
    UTCA NVARCHAR(100) NOT NULL,
    HAZSZAM NVARCHAR(50) NOT NULL,
    ENGEDMENY DECIMAL(5,2) DEFAULT 0.00 NOT NULL,

    CONSTRAINT CK_Partnerek_Engedmeny CHECK (ENGEDMENY BETWEEN 0.00 AND 100.00) -- ENGEDMÉNY 0 és 100 között
);

-- 2. Termékek tábla
CREATE TABLE Termekek (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    CIKKSZAM NVARCHAR(50) NOT NULL UNIQUE,
    MEGNEVEZES NVARCHAR(100) NOT NULL,
    AFA_KULCS INT NOT NULL,
    ELADASI_EGYSEGAR DECIMAL(18,2) NOT NULL,

    CONSTRAINT CK_Termekek_AfaKulcs CHECK (AFA_KULCS BETWEEN 0 AND 100), -- ÁFA nem lehet negatív
    CONSTRAINT CK_Termekek_Egysegar CHECK (ELADASI_EGYSEGAR >= 0) -- EGYSÉGÁR nem lehet negatív
);


-- 3. Tételek tábla - bővített
CREATE TABLE Tetelek (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    PARTNER_ID INT NOT NULL,
    TERMEK_ID INT NOT NULL,
    MENNYISEG DECIMAL(12,3) NOT NULL,
    EGYSEGAR DECIMAL(18,2) NOT NULL,
    ENGEDMENY DECIMAL(5,2) DEFAULT 0.00 NOT NULL,
    KEDV_EGYSEGAR DECIMAL(18,2) NOT NULL,
    NETTO_ERTEK DECIMAL(18,2) NOT NULL,
    AFA_KULCS INT NOT NULL,
    AFATERTEK DECIMAL(18,2) NOT NULL,
    BRUTTO_ERTEK DECIMAL(18,2) NOT NULL,
    MEGJEGYZES NVARCHAR(1000) NULL,
    ROGZITVE DATETIME DEFAULT GETDATE() NOT NULL,

 -- Foreign key 
    CONSTRAINT FK_Tetelek_Partnerek FOREIGN KEY (PARTNER_ID) REFERENCES Partnerek(ID), 
    CONSTRAINT FK_Tetelek_Termekek FOREIGN KEY (TERMEK_ID) REFERENCES Termekek(ID),

    CONSTRAINT CK_Tetelek_Mennyiseg CHECK (MENNYISEG <> 0),
    CONSTRAINT CK_Tetelek_Egysegar CHECK (EGYSEGAR >= 0),
    CONSTRAINT CK_Tetelek_Engedmeny CHECK (ENGEDMENY BETWEEN 0.00 AND 100.00),
    CONSTRAINT CK_Tetelek_AfaKulcs CHECK (AFA_KULCS BETWEEN 0 AND 100)
);

/* Gyakorlati okokból kibővítettem a feladtban kért Tételek szerkezetet: A törzsadatok időközben változhatnak, ezért fontos, hogy az eladáskori adatok rögzítésre kerüljenek, és egy későbbi módosítás esetén visszamenőleges változás ne történhessen.
Kerekítések a rögzítés idejében tárolódnak, így a kimutásban sem keletkezik eltérés. A DATETIME az időszakos kimutatásokhoz kellhet.*/

INSERT INTO Partnerek (NEV, IRANYITOSZAM, TELEPULES, UTCA, HAZSZAM, ENGEDMENY)
VALUES
    (N'Vásá-Royal Kft.', '6640', N'Csongrád',N'Dankó Pista utca', '34.', 0.00),
    (N'Bi Lin Kft.', '1062', N'Budapest', N'Váci út', '1-3', 10.00),
    (N'Mangal Ilona Sertéshizlalda Kft.', '1012', N'Budapest', N'Kuny Domokos utca', '13', 5.00),
    (N'Csiga-Biga Kft.', '1113', N'Budapest', N'Bartók Béka utca', '96', 15.00),
    (N'Szevasz Gyula Kft.', '3526', N'Miskolc', N'Szentpéteri kapu', '80', 8.00);

INSERT INTO Termekek (CIKKSZAM, MEGNEVEZES, AFA_KULCS, ELADASI_EGYSEGAR)
VALUES
    (N'ARP-001', N'Reszelőzsír', 27, 2500.00),
    (N'ARP-002', N'Kanyarfúró', 27, 8300.00),
    (N'ARP-003', N'Balkezes kalapács', 27, 5500.00),
    (N'ARP-004', N'Díszes buborék vízmértékhez', 27, 3900.00),
    (N'ARP-005', N'Violinkulcs', 27, 900.00); 

INSERT INTO Tetelek (PARTNER_ID, TERMEK_ID, MENNYISEG, EGYSEGAR, ENGEDMENY, KEDV_EGYSEGAR, NETTO_ERTEK, AFA_KULCS, AFATERTEK, BRUTTO_ERTEK, MEGJEGYZES) 
VALUES
(1, 1, 10.000, 2500.00, 0.00,  2500.00, 25000.00, 27, 6750.00,  31750.00, N'Hétfőre'),
(2, 3, 2.000,  5500.00, 10.00, 4950.00, 9900.00,  27, 2673.00,  12573.00, N'Egyenesen a Nidavellir-ről'),
(3, 2, 4.000,  8300.00, 5.00,  7885.00, 31540.00, 27, 8515.80,  40055.80, NULL),
(4, 4, 3.000,  3900.00, 15.00, 3315.00, 9945.00,  27, 2685.15,  12630.15, N'Közvetlen szállítás házhoz'),
(5, 1, 1.000,  2500.00, 8.00,  2300.00, 2300.00,  27, 621.00,   2921.00,  N'Gyula bácsi kezébe'),
(4, 5, 5.000,  900.00,  15.00, 765.00,  3825.00,  27, 1032.75,  4857.75,  NULL);


