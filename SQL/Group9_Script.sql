-- DROP DATABASE FEDPN; #we used this to re run the script from the begining without having to create a new database
-- Creating our database
CREATE DATABASE IF NOT EXISTS FEDPN;
USE FEDPN;

-- Tables Creation
CREATE TABLE IF NOT EXISTS `city` (
  `CITY_ID` varchar(2) NOT NULL,
  `CITY_NAME` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`CITY_ID`)
);

CREATE TABLE IF NOT EXISTS `location` (
  `LOCATION_ID` tinyint NOT NULL DEFAULT '0',
  `LOCATION_NAME` varchar(25) DEFAULT NULL,
  `STREET_ADDRESS` varchar(40) DEFAULT NULL,
  `POSTAL_CODE` varchar(8) DEFAULT NULL,
  `CITY_ID` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`LOCATION_ID`),
  CONSTRAINT `fk_location_1`
    FOREIGN KEY (`CITY_ID`)
    REFERENCES `city` (`CITY_ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `Job` (
    `Job_ID` tinyint PRIMARY KEY,
    `Job_Position` VARCHAR(25) NOT NULL,
    `Min_Salary` DECIMAL(10, 2) NOT NULL,
    `Max_Salary` DECIMAL(10, 2) NOT NULL,
    `Contract_Type` VARCHAR(25) NOT NULL
);
CREATE TABLE IF NOT EXISTS `Coaches` (
    `Coach_ID` tinyint PRIMARY KEY,
    `First_Name` VARCHAR(20) NOT NULL,
    `Last_Name` VARCHAR(20) NOT NULL,
    `Phone_Number` VARCHAR(15) NOT NULL,
    `Job_ID` tinyint,
    `Salary` DECIMAL(10, 2) NOT NULL,
    `Hire_Date` DATE NOT NULL,
    FOREIGN KEY (`Job_ID`) REFERENCES `Job` (`Job_ID`)
);

CREATE TABLE IF NOT EXISTS `Level` (
    `LevelID` tinyint PRIMARY KEY,
    `LevelName` VARCHAR(10),
    `LocationID` tinyint,
    `Coach_ID` tinyint,
    FOREIGN KEY (`LocationID`) REFERENCES `location` (`LOCATION_ID`),
    FOREIGN KEY (`Coach_ID`) REFERENCES `Coaches` (`Coach_ID`)
);

CREATE TABLE IF NOT EXISTS `Mensality` (
    `MensalityID` tinyint PRIMARY KEY,
    `LevelID` tinyint,
    `Price` DECIMAL(5, 2),
    FOREIGN KEY (`LevelID`) REFERENCES `Level` (`LevelID`)
);

CREATE TABLE IF NOT EXISTS `members` (
    `memberID` tinyint PRIMARY KEY,
    `memberFName` VARCHAR(25),
    `memberLName` VARCHAR(25),
    `DateOfBirth` DATE,
    `Gender` CHAR(1),
    `email` VARCHAR(100),
    `Address` VARCHAR(250),
    `PhoneNumber` VARCHAR(15),
    `LevelID` tinyint,
    `MensalityID` tinyint,
    FOREIGN KEY (`LevelID`) REFERENCES `Level` (`LevelID`),
    FOREIGN KEY (`MensalityID`) REFERENCES `Mensality` (`MensalityID`),
    `SubscriptionDate` DATE,
    `RateSatisfaction` tinyint,
    `Discount` DECIMAL(4, 2) DEFAULT 0.00
);

CREATE TABLE IF NOT EXISTS `payment` (
    `InvoiceID` INT PRIMARY KEY,
    `memberID` tinyint,
    FOREIGN KEY (`memberID`) REFERENCES `members` (`memberID`) ON UPDATE CASCADE,
    `PaymentDate` DATE,
    `Amount` DECIMAL(5, 2),
    `PaymentMethod` VARCHAR(30),
    `Status` VARCHAR(20)
);




CREATE TABLE IF NOT EXISTS `Coaches_Tenure` (
    `Coach_ID` tinyint,
    `Start_Date` DATE,
    `End_Date` DATE,
    `Job_ID` tinyint,
    PRIMARY KEY (`Coach_ID`, `Start_Date`),
    FOREIGN KEY (`Coach_ID`) REFERENCES `Coaches` (`Coach_ID`),
    FOREIGN KEY (`Job_ID`) REFERENCES `Job` (`Job_ID`)
);

-- LOG TABLE CREATION

CREATE TABLE log (
    LogID tinyint PRIMARY KEY AUTO_INCREMENT,
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    EventType VARCHAR(50),
    Details TEXT
);

-- Inserts 

INSERT INTO city (CITY_ID, CITY_NAME) VALUES 

('C1', 'Lisboa'), 

('C2', 'Porto'), 

('C3', 'Coimbra'), 

('C4', 'Portalegre'); 

 

 

INSERT INTO location (LOCATION_ID, LOCATION_NAME, STREET_ADDRESS, POSTAL_CODE, CITY_ID) VALUES 

(1,'PiaPia', 'Rua Maria Pia', '1350', 'C1'), 

(2,'Oriental', 'Rua Câmara Reis', '1800', 'C1'), 

(3,'Campanhinha', 'Rua Sousa Ávides', '4300', 'C2'), 

(4,'Olimpicus', 'Rua do Ultramar', '3030', 'C3'), 

(5,'Reguenguinho', 'Estrada Nacional', '7300', 'C4');

 



INSERT INTO Job (Job_ID, Job_Position, Min_Salary, Max_Salary, Contract_Type) VALUES 

(1, 'Day_Coach', 1500.00, 950.00, 'Full-Time'), 

(2, 'Evening_Coach', 700.00, 550.00, 'Part-Time'); 

 

 

INSERT INTO Coaches (Coach_ID, First_Name, Last_Name, Phone_Number, Job_ID, Salary, Hire_Date) VALUES 

(1, 'João', 'Almeida', '+351915432109', 1, 1400.00, '2019-08-15'), 

(2, 'Mariana', 'Oliveira', '+351918765432', 2, 650.00, '2020-11-20'), 

(3, 'Pedro', 'Fonseca', '+351913246789', 1, 1250.00, '2022-02-10'), 

(4, 'Ana', 'Gomes', '+351916789012', 1, 1450.00, '2021-05-25'), 

(5, 'Luís', 'Mendes', '+351911234567', 1, 1030.00, '2020-03-08'), 

(6, 'Carolina', 'Pereira', '+351919012345', 2, 700.00, '2022-08-03'), 

(7, 'Carla','Andrino','+351919012343', 2, 550.00, '2019-03-18'), 

(8, 'Duarte', 'Pacheco','+351915432170', 2,560.00, '2020-01-03'), 

(9, 'Ricardo', 'Silva', '+351912345678', 1, 950.00, '2021-09-12'), 

(10, 'Sofia', 'Martins', '+351917890123', 1, 1500.00, '2020-06-18'); 

 

INSERT INTO Level (LevelID, LevelName, LocationID, Coach_ID) VALUES 

(1, 'Azul', 1, 1), 

(2, 'Amarelo', 1, 1), 

(3, 'Branco', 1, 2),

(4, 'Verde', 2, 3), 

(5, 'Laranja', 2, 4), 

(6, 'Preto', 2, 5),

(7, 'Lilás', 3, 6), 

(8, 'Vermelho', 3, 6), 

(9, 'Ciano', 4, 7), 

(10, 'Bordeaux', 4, 8), 

(11, 'Cinza', 4, 8), 

(12, 'Roxo', 5, 9), 

(13, 'Grená', 5, 10); 

/*Cores frias- begginers 

Cores quentes- intermédios 

Cores neutras- avancados */

 

 

 

INSERT INTO Mensality (MensalityID, LevelID, PricE) VALUES 

(1, 1, 55.00), 

(2, 4, 55.00), 

(3, 7, 50.00), 

(4, 9, 50.00), 

(5, 12, 50.00),

(6, 2, 85.00),

 (7, 5, 85.00),

 (8, 8, 80.00),

(9,10, 80.00),

 (10,13, 80.00),

 (11, 3, 130.00),

 (12, 6, 130.00),

 (13, 11, 120.00);

 


INSERT INTO members (memberID, memberFName, memberLName, DateOfBirth, Gender, email, Address, PhoneNumber, LevelID, MensalityID, SubscriptionDate, RateSatisfaction, Discount) VALUES 

(1,  'Carlos',   'Silva',  '1995-02-14',  'M',   'carlos.silva@gmail.com',  'Rua Azul',  '+351912345678', 1, 1,  '2022-01-10', 4.5,  0.1),
(2,   'Marta',  'Ribeiro',  '1998-06-22',  'F',   'marta.ribeiro@gmail.com',   'Avenida Azul',   '+351918765432', 1, 1,   '2022-03-05',  NULL,  0),
(3,   'João',  'Sousa',  '2000-11-05',  'M',   'joao.sousa@gmail.com',  'Praça Azul',  '+351917890123', 1, 1,  '2022-05-20', 4.8,  0.15),
(4,   'Ana',  'Pereira',  '1997-08-18',  'F',   'ana.pereira@gmail.com',   'Avenida Azul',   '+351915432109', 1, 1,   '2021-09-15',  NULL,  0.1),
(5,   'Rui',  'Gonçalves',  '1999-03-30',  'M',   'rui.goncalves@gmail.com',  'Rua Azul',  '+351913246789', 1, 1,  '2022-11-12',  NULL,   0.15),
(6,   'Sofia',  'Fernandes',  '1996-04-25',  'F',   'sofia.fernandes@gmail.com',   'Avenida Amarela',   '+351919012345', 2, 6,   '2021-08-07', 4.7,  0),
(7,   'Diogo',  'Lopes',  '1998-09-12',  'M',   'diogo.lopes@gmail.com',  'Rua Amarela',  '+351916789012', 2, 6,  '2022-02-28', 4.4,  0.1),
(8,   'Carolina',  'Machado',  '1999-12-03',  'F',   'carolina.machado@gmail.com',   'Avenida Amarela',   '+351915432170', 2, 6,   '2021-05-10',  NULL,  0),
(9,   'Ricardo',  'Martins',  '1997-07-14',  'M',   'ricardo.martins@gmail.com',   'Rua Amarela',  '+351911234567', 2, 6,  '2022-10-18',  NULL,   0.15),
(10,   'Mariana',  'Santos',  '2000-01-28',  'F',   'mariana.santos@gmail.com',   'Avenida Amarela',   '+351917890123', 2, 6,   '2022-06-30', 4.5,  0.1),
(11,   'André',  'Mendes',  '1996-08-10',  'M',   'andre.mendes@gmail.com',  'Rua Branca',  '+351918765432', 3, 11,  '2019-07-22', 4.2,  0.15),
(12,   'Catarina',  'Oliveira',  '1999-02-28',  'F',   'catarina.oliveira@gmail.com',   'Avenida Branca',   '+351917890123', 3, 11,   '2019-04-15',  NULL,  0),
(13,   'José',  'Rocha',  '2001-05-15',  'M',   'jose.rocha@gmail.com',  'Praça Branca',  '+351911234567', 3, 11,  '2019-09-05', 4.7,  0.1),
(14,   'Sara',  'Ferreira',  '1998-11-20',  'F',   'sara.ferreira@gmail.com',   'Avenida Branca',   '+351915432109', 3, 11,   '2019-12-18',  NULL,  0),
(15,   'Tiago',  'Pinto',  '2000-04-03',  'M',   'tiago.pinto@gmail.com',  'Rua Branca',  '+351913246789', 3, 11,  '2019-02-01', 4.8,  0.1),
(16,   'Miguel',  'Oliveira',  '1997-09-22',  'M',   'miguel.oliveira@gmail.com',   'Rua Verde',  '+351916789012', 4, 2,  '2022-03-14', 4.6,  0),
(17,   'Inês',  'Santos',  '2000-03-12',  'F',   'ines.santos@gmail.com',   'Avenida Verde',   '+351915432170', 4, 2,   '2021-06-28',  NULL,  0.15),
(18,   'Hugo',  'Pereira',  '1998-08-05',  'M',   'hugo.pereira@gmail.com',   'Praça Verde',  '+351911234567', 4, 2,  '2019-10-05', 4.3,  0.1),
(19,   'Beatriz',  'Ribeiro',  '1999-01-18',  'F',   'beatriz.ribeiro@gmail.com',   'Avenida Verde',   '+351917890123', 4, 2,   '2021-04-12',  NULL,  0),
(20,   'Daniel',  'Martins',  '2001-04-02',  'M',   'daniel.martins@gmail.com',   'Rua Verde',  '+351913246789', 4, 2,  '2019-01-25', 4.8,  0.1),
(21,   'Gabriel',  'Mendes',  '1996-10-15',  'M',   'gabriel.mendes@gmail.com',   'Rua Laranja',  '+351918765432', 5, 7,  '2021-08-25', 4.2,  0.15),
(22,   'Laura',  'Oliveira',  '1999-03-28',  'F',   'laura.oliveira@gmail.com',   'Avenida Laranja',   '+351917890123', 5, 7,   '2022-02-15',  NULL,  0),
(23,   'Rafael',  'Rocha',  '2001-06-10',  'M',   'rafael.rocha@gmail.com',   'Praça Laranja',   '+351911234567', 5, 7,   '2022-07-05', 4.7,  0.1),
(24,   'Mariana',  'Ferreira',  '1998-12-18',  'F',   'mariana.ferreira@gmail.com',   'Avenida Laranja',   '+351915432109', 5, 7,   '2019-10-12',  NULL,  0),
(25,   'Gustavo',  'Pinto',  '2000-05-01',  'M',   'gustavo.pinto@gmail.com',  'Rua Laranja',  '+351913246789', 5, 7,  '2019-04-01', 4.8,  0.1),
(26,   'Isabel',  'Oliveira',  '1997-11-22',  'F',   'isabel.oliveira@gmail.com',   'Rua Preto',  '+351916789012', 6, 12,  '2021-05-14', 4.6,  0),
(27,   'Diogo',  'Lopes',  '2000-04-12',  'M',   'diogo.lopes@gmail.com',   'Avenida Preto',   '+351915432170', 6, 12,   '2022-09-28',  NULL,  0.15),
(28,   'Marta',  'Pereira',  '1998-09-05',  'F',   'marta.pereira@gmail.com',   'Praça Preto',  '+351911234567', 6, 12,  '2022-01-15', 4.3,  0.1),
(29,   'João',  'Ribeiro',  '1999-02-18',  'M',   'joao.ribeiro@gmail.com',   'Avenida Preto',   '+351917890123', 6, 12,   '2021-04-22',  NULL,  0),
(30,   'Inês',  'Martins',  '2001-05-04',  'F',   'ines.martins@gmail.com',  'Rua Preto',  '+351913246789', 6, 12,  '2022-02-05', 4.8,  0.1),
(31,   'Pedro',  'Mendes',  '1996-12-15',  'M',   'pedro.mendes@gmail.com',  'Rua Lilás',  '+351918765432', 7, 3,  '2019-08-30', 4.2,  0.15),
(32,   'Cátia',  'Oliveira',  '1999-05-28',  'F',   'catia.oliveira@gmail.com',   'Avenida Lilás',   '+351917890123', 7, 3,   '2022-03-15',  NULL,  0),
(33,   'José',  'Rocha',  '2001-09-10',  'M',   'jose.rocha@gmail.com',  'Praça Lilás',  '+351911234567', 7, 3,  '2019-07-08', 4.7,  0.1),
(34,   'Sara',  'Ferreira',  '1998-01-18',  'F',   'sara.ferreira@gmail.com',   'Avenida Lilás',   '+351915432109', 7, 3,   '2019-11-15',  NULL,  0),
(35,   'Tiago',  'Pinto',  '2000-06-01',  'M',   'tiago.pinto@gmail.com',  'Rua Lilás',  '+351913246789', 7, 3,  '2019-05-01', 4.8,  0.1),
(36,   'Isabel',  'Oliveira',  '1997-01-22',  'F',   'isabel.oliveira@gmail.com',   'Rua Vermelha',   '+351916789012', 8, 8,   '2021-06-14', 4.6,  0),
(37,   'Diogo',  'Lopes',  '2000-05-12',  'M',   'diogo.lopes@gmail.com',   'Avenida Vermelha',   '+351915432170', 8, 8,   '2022-10-28',  NULL,  0.15),
(38,   'Marta',  'Pereira',  '1998-10-05',  'F',   'marta.pereira@gmail.com',   'Praça Vermelha',   '+351911234567', 8, 8,   '2022-02-15', 4.3,  0.1),
(39,   'João',  'Ribeiro',  '1999-03-18',  'M',   'joao.ribeiro@gmail.com',   'Avenida Vermelha',   '+351917890123', 8, 8,   '2021-05-22',  NULL,  0),
(40,   'Inês',  'Martins',  '2001-06-04',  'F',   'ines.martins@gmail.com',  'Rua Vermelha',  '+351913246789', 8, 8,  '2022-02-05', 4.8,  0.1),
(41,   'Aurora',  'Mendes',  '1996-03-15',  'F',   'aurora.mendes@gmail.com',  'Rua Ciano',  '+351918765432', 9, 4,  '2021-08-30', 4.2,  0.15),
(42,   'Cosme',  'Oliveira',  '1999-07-28',  'M',   'cosme.oliveira@gmail.com',   'Avenida Ciano',   '+351917890123', 9, 4,   '2022-03-15',  NULL,  0),
(43,   'Jasmim',  'Rocha',  '2001-10-10',  'F',   'jasmim.rocha@gmail.com',   'Praça Ciano',  '+351911234567', 9, 4,  '2022-07-08', 4.7,  0.1),
(44,   'Silvano',  'Ferreira',  '1998-02-18',  'M',   'silvano.ferreira@gmail.com',   'Avenida Ciano',   '+351915432109', 9, 4,   '2021-11-15',  NULL,  0),
(45,   'Vitória',  'Pinto',  '2000-07-01',  'F',   'vitoria.pinto@gmail.com',  'Rua Ciano',  '+351913246789', 9, 4,  '2022-05-01', 4.8,  0.1),
(46,   'Isadora',  'Oliveira',  '1997-04-22',  'F',   'isadora.oliveira@gmail.com',   'Rua Bordeaux',   '+351916789012', 10, 9,   '2021-06-14', 4.6,  0),
(47,   'Dinis',  'Lopes',  '2000-08-12',  'M',   'dinis.lopes@gmail.com',   'Avenida Bordeaux',   '+351915432170', 10, 9,   '2022-10-28',  NULL,  0.15),
(48,   'Marcelina',  'Pereira',  '1998-11-05',  'F',   'marcelina.pereira@gmail.com',   'Praça Bordeaux',   '+351911234567', 10, 9,   '2022-02-15', 4.3,  0.1),
(49,   'Leandro',  'Ribeiro',  '1999-04-18',  'M',   'leandro.ribeiro@gmail.com',   'Avenida Bordeaux',   '+351917890123', 10, 9,   '2021-05-22',  NULL,  0),
(50,   'Inês',  'Martins',  '2001-07-04',  'F',   'ines.martins@gmail.com',  'Rua Bordeaux',  '+351913246789', 10, 9,  '2022-02-05', 4.8,  0.1),
(51,   'Eustáquio',  'Mendes',  '1996-05-15',  'M',   'eustaquio.mendes@gmail.com',   'Rua Cinza',  '+351918765432', 11, 13,  '2019-08-30', 4.2,  0.15),
(52,   'Clarinda',  'Oliveira',  '1999-09-28',  'F',   'clarinda.oliveira@gmail.com',   'Avenida Cinza',   '+351917890123', 11, 13,   '2020-03-15',  NULL,  0),
(53,   'Valentim',  'Rocha',  '2001-01-10',  'M',   'valentim.rocha@gmail.com',   'Praça Cinza',  '+351911234567', 11, 13,  '2019-07-08', 4.7,  0.1),
(54,   'Esmeralda',  'Ferreira',  '1998-05-18',  'F',   'esmeralda.ferreira@gmail.com',   'Avenida Cinza',   '+351915432109', 11, 13,   '2019-11-15',  NULL,  0),
(55,   'Gastão',  'Pinto',  '2000-08-01',  'M',   'gastao.pinto@gmail.com',  'Rua Cinza',  '+351913246789', 11, 13,  '2020-05-01', 4.8,  0.1),
(56,   'Isaura',  'Oliveira',  '1997-06-22',  'F',   'isaura.oliveira@gmail.com',   'Rua Roxa',  '+351916789012', 12, 5,  '2019-06-14', 4.6,  0),
(57,   'Dário',  'Lopes',  '2000-10-12',  'M',   'dario.lopes@gmail.com',   'Avenida Roxa',   '+351915432170', 12, 5,   '2019-10-28',  NULL,  0.15),
(58,   'Margarida',  'Pereira',  '1998-11-05',  'F',   'margarida.pereira@gmail.com',   'Praça Roxa',  '+351911234567', 12, 5,  '2019-02-15', 4.3,  0.1),
(59,   'Leopoldo',  'Ribeiro',  '1999-04-18',  'M',   'leopoldo.ribeiro@gmail.com',   'Avenida Roxa',   '+351917890123', 12, 5,   '2021-05-22',  NULL,  0),
(60,   'Ísis',  'Martins',  '2001-07-04',  'F',   'isis.martins@gmail.com',  'Rua Roxa',  '+351913246789', 12, 5,  '2022-02-05', 4.8,  0.1),
(61,   'Quirino',  'Mendes',  '1996-09-15',  'M',   'quirino.mendes@gmail.com',   'Rua Grená',  '+351918765432', 13, 10,  '2021-08-30', 4.2,  0.15),
(62,   'Emanuela',  'Oliveira',  '1999-11-28',  'F',   'emanuela.oliveira@gmail.com',   'Avenida Grená',   '+351917890123', 13, 10,   '2022-03-15',  NULL,  0),
(63,   'Virgílio',  'Rocha',  '2002-02-10',  'M',   'virgilio.rocha@gmail.com',   'Praça Grená',  '+351911234567', 13, 10,  '2019-07-08', 4.7,  0.1),
(64,   'Eleonora',  'Ferreira',  '1998-06-18',  'F',   'eleonora.ferreira@gmail.com',   'Avenida Grená',   '+351915432109', 13, 10,   '2019-11-15',  NULL,  0),
(65,   'Gregório',  'Pinto',  '2000-09-01',  'M',   'gregorio.pinto@gmail.com',   'Rua Grená',  '+351913246789', 13, 10,  '2019-05-01', 4.8,  0.1);
 



INSERT INTO payment (InvoiceID, memberID, PaymentDate, Amount, PaymentMethod, Status) VALUES 
(1, 1, '2022-01-10', 55.00, 'Credit Card', 'Complete'),

(2, 1, '2022-02-10', 55.00, 'Debit Card', 'Complete'),

(3, 1, '2022-03-10', 55.00, 'MBWay', 'Complete'),

(4, 1, '2022-04-10', 55.00, 'PayPal', 'Complete'),

(5, 1, '2022-05-10', 55.00, 'Cash', 'Complete'),

(6, 1, '2022-06-10', 55.00, 'Credit Card', 'Complete'),

(7, 1, '2022-07-10', 55.00, 'Debit Card', 'Complete'),

(8, 1, '2022-08-10', 55.00, 'MBWay', 'Complete'),

(9, 1, '2022-09-10', 55.00, 'PayPal', 'Complete'),

(10, 1, '2022-10-10', 55.00, 'Cash', 'Complete'),

(11, 1, '2022-11-10', 55.00, 'Credit Card', 'Complete'),

(12, 1, '2022-12-10', 55.00, 'Debit Card', 'Complete'), 

(13, 1, '2023-01-10', 55.00, 'MBWay', 'Complete'),

(14, 1, '2023-02-10', 55.00, 'PayPal', 'Complete'),

(15, 1, '2023-03-10', 55.00, 'Cash', 'Complete'),

(16, 1, '2023-04-10', 55.00, 'Credit Card', 'Complete'),

(17, 1, '2023-05-10', 55.00, 'Debit Card', 'Complete'), 

(18, 1, '2023-06-10', 55.00, 'MBWay', 'Complete'), 

(19, 1, '2023-07-10', 55.00, 'PayPal', 'Complete'), 

(20, 1, '2023-08-10', 55.00, 'Cash', 'Complete'), 

(21, 1, '2023-09-10', 55.00, 'Credit Card', 'Complete'), 

(22, 1, '2023-10-10', 55.00, 'Debit Card', 'Complete'),

(23, 1, '2023-11-10', 55.00, 'MBWay', 'Complete'), 

(24, 1, '2023-12-10', 55.00, 'PayPal', 'Complete'), 

(25, 2, '2022-03-05', 55.00, 'Cash', 'Complete'), 

(26, 2, '2022-04-05', 55.00, 'Credit Card', 'Complete'), 

(27, 2, '2022-05-05', 55.00, 'Debit Card', 'Complete'), 

(28, 2, '2022-06-05', 55.00, 'MBWay', 'Complete'), 

(29, 2, '2022-07-05', 55.00, 'PayPal', 'Complete'), 

(30, 2, '2022-08-05', 55.00, 'Cash', 'Complete'), 

(31, 2, '2022-09-05', 55.00, 'Credit Card', 'Complete'),

(32, 2, '2022-10-05', 55.00, 'Debit Card', 'Complete'),

(33, 2, '2022-11-05', 55.00, 'MBWay', 'Complete'),

(34, 2, '2022-12-05', 55.00, 'PayPal', 'Complete'), 

(35, 2, '2023-01-05', 55.00, 'Cash', 'Complete'),

(36, 2, '2023-02-05', 55.00, 'Credit Card', 'Complete'), 

(37, 2, '2023-03-05', 55.00, 'Debit Card', 'Complete'),

(38, 2, '2023-04-05', 55.00, 'MBWay', 'Complete'),

(39, 2, '2023-05-05', 55.00, 'PayPal', 'Complete'), 

(40, 2, '2023-06-05', 55.00, 'Cash', 'Complete'),

(41, 2, '2023-07-05', 55.00, 'Credit Card', 'Complete'), 

(42, 2, '2023-08-05', 55.00, 'Debit Card', 'Complete'),

(43, 2, '2023-09-05', 55.00, 'MBWay', 'Complete'),

(44, 2, '2023-10-05', 55.00, 'PayPal', 'Complete'), 

(45, 2, '2023-11-05', 55.00, 'Cash', 'Complete'),

(46, 2, '2023-12-05', 55.00, 'Credit Card', 'Complete'), 

(47, 3, '2022-05-20', 55.00, 'Debit Card', 'Complete'),

(48, 3, '2022-06-20', 55.00, 'MBWay', 'Complete'),

(49, 3, '2022-07-20', 55.00, 'PayPal', 'Complete'), 

(50, 3, '2022-08-20', 55.00, 'Cash', 'Complete'),

(51, 3, '2022-09-20', 55.00, 'Credit Card', 'Complete'), 

(52, 3, '2022-10-20', 55.00, 'Debit Card', 'Complete'),

(53, 3, '2022-11-20', 55.00, 'MBWay', 'Complete'),

(54, 3, '2022-12-20', 55.00, 'PayPal', 'Complete'), 

(55, 3, '2023-01-20', 55.00, 'Cash', 'Complete'),

(56, 3, '2023-02-20', 55.00, 'Credit Card', 'Complete'), 

(57, 3, '2023-03-20', 55.00, 'Debit Card', 'Complete'),

(58, 3, '2023-04-20', 55.00, 'MBWay', 'Complete'),

(59, 3, '2023-05-20', 55.00, 'PayPal', 'Complete'), 

(60, 3, '2023-06-20', 55.00, 'Cash', 'Complete'),

(61, 3, '2023-07-20', 55.00, 'Credit Card', 'Complete'), 

(62, 3, '2023-08-20', 55.00, 'Debit Card', 'Complete'),

(63, 3, '2023-09-20', 55.00, 'MBWay', 'Complete'),

(64, 3, '2023-10-20', 55.00, 'PayPal', 'Complete'), 

(65, 3, '2023-11-20', 55.00, 'Cash', 'Complete'),

(66, 3, '2023-12-20', 55.00, 'Credit Card', 'Not Complete'),

(67, 4, '2021-09-15', 55.00, 'Debit Card', 'Complete'),

(68, 4, '2021-10-15', 55.00, 'MBWay', 'Complete'), 

(69, 4, '2021-11-15', 55.00, 'PayPal', 'Complete'), 

(70, 4, '2021-12-15', 55.00, 'Cash', 'Complete'), 

(71, 4, '2022-01-15', 55.00, 'Credit Card', 'Complete'), 

(72, 4, '2022-02-15', 55.00, 'Debit Card', 'Complete'), 

(73, 4, '2022-03-15', 55.00, 'MBWay', 'Complete'), 

(74, 4, '2022-04-15', 55.00, 'PayPal', 'Complete'), 

(75, 4, '2022-05-15', 55.00, 'Cash', 'Complete'), 

(76, 4, '2022-06-15', 55.00, 'Credit Card', 'Complete'), 

(77, 4, '2022-07-15', 55.00, 'Debit Card', 'Complete'), 

(78, 4, '2022-08-15', 55.00, 'MBWay', 'Complete'),

(79, 4, '2022-09-15', 55.00, 'PayPal', 'Complete'), 

(80, 4, '2022-10-15', 55.00, 'Cash', 'Complete'),

(81, 4, '2022-11-15', 55.00, 'Credit Card', 'Complete'), 

(82, 4, '2022-12-15', 55.00, 'Debit Card', 'Complete') ,

(83, 4, '2023-01-15', 55.00, 'MBWay', 'Complete') ,

(84, 4, '2023-02-15', 55.00, 'PayPal', 'Complete') ,

(85, 4, '2023-03-15', 55.00, 'Cash', 'Complete') ,

(86, 4, '2023-04-15', 55.00, 'Credit Card', 'Complete'), 

(87, 4, '2023-05-15', 55.00, 'Debit Card', 'Complete') ,

(88, 4, '2023-06-15', 55.00, 'MBWay', 'Complete') ,

(89, 4, '2023-07-15', 55.00, 'PayPal', 'Complete') ,

(90, 4, '2023-08-15', 55.00, 'Cash', 'Complete') ,

(91, 4, '2023-09-15', 55.00, 'Credit Card', 'Complete'), 

(92, 4, '2023-10-15', 55.00, 'Debit Card', 'Complete') ,

(93, 4, '2023-11-15', 55.00, 'MBWay', 'Complete') ,

(94, 4, '2023-12-15', 55.00, 'PayPal', 'Complete') ,

(95, 5, '2022-11-12', 55.00, 'Cash', 'Complete') ,

(96, 5, '2022-12-12', 55.00, 'Credit Card', 'Complete'), 

(97, 5, '2023-01-12', 55.00, 'Debit Card', 'Complete') ,

(98, 5, '2023-02-12', 55.00, 'MBWay', 'Complete') ,

(99, 5, '2023-03-12', 55.00, 'PayPal', 'Complete') ,

(100, 5, '2023-04-12', 55.00, 'Cash', 'Complete') ,

(101, 5, '2023-05-12', 55.00, 'Credit Card', 'Complete'), 

(102, 5, '2023-06-12', 55.00, 'Debit Card', 'Complete') ,

(103, 5, '2023-07-12', 55.00, 'MBWay', 'Complete') ,

(104, 5, '2023-08-12', 55.00, 'PayPal', 'Complete') ,

(105, 5, '2023-09-12', 55.00, 'Cash', 'Complete') ,

(106, 5, '2023-10-12', 55.00, 'Credit Card', 'Complete'), 

(107, 5, '2023-11-12', 55.00, 'Debit Card', 'Complete') ,

(108, 5, '2023-12-12', 55.00, 'MBWay', 'Complete') ,

(109, 6, '2021-08-07', 55.00, 'PayPal', 'Complete') ,

(110, 6, '2021-09-07', 55.00, 'Cash', 'Complete') ,

(111, 6, '2021-10-07', 55.00, 'Credit Card', 'Complete'), 

(112, 6, '2021-11-07', 55.00, 'Debit Card', 'Complete') ,

(113, 6, '2021-12-07', 55.00, 'MBWay', 'Complete') ,

(114, 6, '2022-01-07', 55.00, 'PayPal', 'Complete') ,

(115, 6, '2022-02-07', 55.00, 'Cash', 'Complete') ,

(116, 6, '2022-03-07', 55.00, 'Credit Card', 'Complete'), 

(117, 6, '2022-04-07', 55.00, 'Debit Card', 'Complete') ,

(118, 6, '2022-05-07', 55.00, 'MBWay', 'Complete') ,

(119, 6, '2022-06-07', 55.00, 'PayPal', 'Complete') ,

(120, 6, '2022-07-07', 55.00, 'Cash', 'Complete') ,

(121, 6, '2022-08-07', 55.00, 'Credit Card', 'Complete'), 

(122, 6, '2022-09-07', 55.00, 'Debit Card', 'Complete') ,

(123, 6, '2022-10-07', 55.00, 'MBWay', 'Complete') ,

(124, 6, '2022-11-07', 55.00, 'PayPal', 'Complete') ,

(125, 6, '2022-12-07', 55.00, 'Cash', 'Complete') ,

(126, 6, '2023-01-07', 55.00, 'Credit Card', 'Complete'), 

(127, 6, '2023-02-07', 55.00, 'Debit Card', 'Complete') ,

(128, 6, '2023-03-07', 55.00, 'MBWay', 'Complete') ,

(129, 6, '2023-04-07', 55.00, 'PayPal', 'Complete') ,

(130, 6, '2023-05-07', 55.00, 'Cash', 'Complete') ,

(131, 6, '2023-06-07', 55.00, 'Credit Card', 'Complete'), 

(132, 6, '2023-07-07', 55.00, 'Debit Card', 'Complete') ,

(133, 6, '2023-08-07', 55.00, 'MBWay', 'Complete') ,

(134, 6, '2023-09-07', 55.00, 'PayPal', 'Complete') ,

(135, 6, '2023-10-07', 55.00, 'Cash', 'Complete') ,

(136, 6, '2023-11-07', 55.00, 'Credit Card', 'Complete'), 

(137, 6, '2023-12-07', 55.00, 'Debit Card', 'Complete') ,

(138, 7, '2022-02-28', 55.00, 'MBWay', 'Complete') ,

(139, 7, '2022-03-28', 55.00, 'PayPal', 'Complete') ,

(140, 7, '2022-04-28', 55.00, 'Cash', 'Complete') ,

(141, 7, '2022-05-28', 55.00, 'Credit Card', 'Complete'), 

(142, 7, '2022-06-28', 55.00, 'Debit Card', 'Complete') ,

(143, 7, '2022-07-28', 55.00, 'MBWay', 'Complete') ,

(144, 7, '2022-08-28', 55.00, 'PayPal', 'Complete') ,

(145, 7, '2022-09-28', 55.00, 'Cash', 'Complete') ,

(146, 7, '2022-10-28', 55.00, 'Credit Card', 'Complete'), 

(147, 7, '2022-11-28', 55.00, 'Debit Card', 'Complete') ,

(148, 7, '2022-12-28', 55.00, 'MBWay', 'Complete') ,

(149, 7, '2023-01-28', 55.00, 'PayPal', 'Complete') ,

(150, 7, '2023-02-28', 55.00, 'Cash', 'Complete') ,

(151, 7, '2023-03-28', 55.00, 'Credit Card', 'Complete'), 

(152, 7, '2023-04-28', 55.00, 'Debit Card', 'Complete') ,

(153, 7, '2023-05-28', 55.00, 'MBWay', 'Complete') ,

(154, 7, '2023-06-28', 55.00, 'PayPal', 'Complete') ,

(155, 7, '2023-07-28', 55.00, 'Cash', 'Complete') ,

(156, 7, '2023-08-28', 55.00, 'Credit Card', 'Complete'), 

(157, 7, '2023-09-28', 55.00, 'Debit Card', 'Complete') ,

(158, 7, '2023-10-28', 55.00, 'MBWay', 'Complete') ,

(159, 7, '2023-11-28', 55.00, 'PayPal', 'Complete') ,

(160, 7, '2023-12-28', 55.00, 'Cash', 'Not Complete'), 

(161, 8, '2021-05-10', 55.00, 'Credit Card', 'Complete'), 

(162, 8, '2021-06-10', 55.00, 'Debit Card', 'Complete') ,

(163, 8, '2021-07-10', 55.00, 'MBWay', 'Complete') ,

(164, 8, '2021-08-10', 55.00, 'PayPal', 'Complete') ,

(165, 8, '2021-09-10', 55.00, 'Cash', 'Complete') ,

(166, 8, '2021-10-10', 55.00, 'Credit Card', 'Complete'), 

(167, 8, '2021-11-10', 55.00, 'Debit Card', 'Complete') ,

(168, 8, '2021-12-10', 55.00, 'MBWay', 'Complete') ,

(169, 8, '2022-01-10', 55.00, 'PayPal', 'Complete') ,

(170, 8, '2022-02-10', 55.00, 'Cash', 'Complete') ,

(171, 8, '2022-03-10', 55.00, 'Credit Card', 'Complete'), 

(172, 8, '2022-04-10', 55.00, 'Debit Card', 'Complete') ,

(173, 8, '2022-05-10', 55.00, 'MBWay', 'Complete') ,

(174, 8, '2022-06-10', 55.00, 'PayPal', 'Complete') ,

(175, 8, '2022-07-10', 55.00, 'Cash', 'Complete') ,

(176, 8, '2022-08-10', 55.00, 'Credit Card', 'Complete'), 

(177, 8, '2022-09-10', 55.00, 'Debit Card', 'Complete') ,

(178, 8, '2022-10-10', 55.00, 'MBWay', 'Complete') ,

(179, 8, '2022-11-10', 55.00, 'PayPal', 'Complete') ,

(180, 8, '2022-12-10', 55.00, 'Cash', 'Complete') ,

(181, 8, '2023-01-10', 55.00, 'Credit Card', 'Complete'), 

(182, 8, '2023-02-10', 55.00, 'Debit Card', 'Complete') ,

(183, 8, '2023-03-10', 55.00, 'MBWay', 'Complete') ,

(184, 8, '2023-04-10', 55.00, 'PayPal', 'Complete') ,

(185, 8, '2023-05-10', 55.00, 'Cash', 'Complete') ,

(186, 8, '2023-06-10', 55.00, 'Credit Card', 'Complete'), 

(187, 8, '2023-07-10', 55.00, 'Debit Card', 'Complete') ,

(188, 8, '2023-08-10', 55.00, 'MBWay', 'Complete') ,

(189, 8, '2023-09-10', 55.00, 'PayPal', 'Complete') ,

(190, 8, '2023-10-10', 55.00, 'Cash', 'Complete') ,

(191, 8, '2023-11-10', 55.00, 'Credit Card', 'Complete') ,

(192, 8, '2023-12-10', 55.00, 'Debit Card', 'Complete') ,

(193, 9, '2022-10-18', 55.00, 'MBWay', 'Complete') ,

(194, 9, '2022-11-18', 55.00, 'PayPal', 'Complete') ,

(195, 9, '2022-12-18', 55.00, 'Cash', 'Complete') ,

(196, 9, '2023-01-18', 55.00, 'Credit Card', 'Complete'), 

(197, 9, '2023-02-18', 55.00, 'Debit Card', 'Complete') ,

(198, 9, '2023-03-18', 55.00, 'MBWay', 'Complete') ,

(199, 9, '2023-04-18', 55.00, 'PayPal', 'Complete') ,

(200, 9, '2023-05-18', 55.00, 'Cash', 'Complete') ,

(201, 9, '2023-06-18', 55.00, 'Credit Card', 'Complete'), 

(202, 9, '2023-07-18', 55.00, 'Debit Card', 'Complete') ,

(203, 9, '2023-08-18', 55.00, 'MBWay', 'Complete') ,

(204, 9, '2023-09-18', 55.00, 'PayPal', 'Complete') ,

(205, 9, '2023-10-18', 55.00, 'Cash', 'Complete') ,

(206, 9, '2023-11-18', 55.00, 'Credit Card', 'Complete'), 

(207, 9, '2023-12-18', 55.00, 'Debit Card', 'Not Complete') ,

(208, 10, '2022-06-30', 55.00, 'MBWay', 'Complete') ,

(209, 10, '2022-07-30', 55.00, 'PayPal', 'Complete') ,

(210, 10, '2022-08-30', 55.00, 'Cash', 'Complete') ,

(211, 10, '2022-09-30', 55.00, 'Credit Card', 'Complete'), 

(212, 10, '2022-10-30', 55.00, 'Debit Card', 'Complete') ,

(213, 10, '2022-11-30', 55.00, 'MBWay', 'Complete') ,

(214, 10, '2022-12-30', 55.00, 'PayPal', 'Complete') ,

(215, 10, '2023-01-30', 55.00, 'Cash', 'Complete') ,

(216, 10, '2023-02-28', 55.00, 'Credit Card', 'Complete'), 

(217, 10, '2023-03-30', 55.00, 'Debit Card', 'Complete') ,

(218, 10, '2023-04-30', 55.00, 'MBWay', 'Complete') ,

(219, 10, '2023-05-30', 55.00, 'PayPal', 'Complete') ,

(220, 10, '2023-06-30', 55.00, 'Cash', 'Complete') ,

(221, 10, '2023-07-30', 55.00, 'Credit Card', 'Complete'), 

(222, 10, '2023-08-30', 55.00, 'Debit Card', 'Complete') ,

(223, 10, '2023-09-30', 55.00, 'MBWay', 'Complete') ,

(224, 10, '2023-10-30', 55.00, 'PayPal', 'Complete') ,

(225, 10, '2023-11-30', 55.00, 'Cash', 'Complete') ,

(226, 10, '2023-12-30', 55.00, 'Credit Card', 'Not Complete'), 

(227, 11, '2019-07-22', 50.00, 'Debit Card', 'Complete') ,

(228, 11, '2019-08-22', 50.00, 'MBWay', 'Complete') ,

(229, 11, '2019-09-22', 50.00, 'PayPal', 'Complete') ,

(230, 11, '2019-10-22', 50.00, 'Cash', 'Complete') ,

(231, 11, '2019-11-22', 50.00, 'Credit Card', 'Complete'), 

(232, 11, '2019-12-22', 50.00, 'Debit Card', 'Complete') ,

(233, 11, '2020-01-22', 50.00, 'MBWay', 'Complete') ,

(234, 11, '2020-02-22', 50.00, 'PayPal', 'Complete') ,

(235, 11, '2020-03-22', 50.00, 'Cash', 'Complete') ,

(236, 11, '2020-04-22', 50.00, 'Credit Card', 'Complete'), 

(237, 11, '2020-05-22', 50.00, 'Debit Card', 'Complete') ,

(238, 11, '2020-06-22', 50.00, 'MBWay', 'Complete') ,

(239, 11, '2020-07-22', 50.00, 'PayPal', 'Complete') ,

(240, 11, '2020-08-22', 50.00, 'Cash', 'Complete') ,

(241, 11, '2020-09-22', 50.00, 'Credit Card', 'Complete'), 

(242, 11, '2020-10-22', 50.00, 'Debit Card', 'Complete') ,

(243, 11, '2020-11-22', 50.00, 'MBWay', 'Complete') ,

(244, 11, '2020-12-22', 50.00, 'PayPal', 'Complete') ,

(245, 11, '2021-01-22', 50.00, 'Cash', 'Complete') ,

(246, 11, '2021-02-22', 50.00, 'Credit Card', 'Complete'), 

(247, 11, '2021-03-22', 50.00, 'Debit Card', 'Complete') ,

(248, 11, '2021-04-22', 50.00, 'MBWay', 'Complete') ,

(249, 11, '2021-05-22', 50.00, 'PayPal', 'Complete') ,

(250, 11, '2021-06-22', 50.00, 'Cash', 'Complete') ,

(251, 11, '2021-07-22', 50.00, 'Credit Card', 'Complete'), 

(252, 11, '2021-08-22', 50.00, 'Debit Card', 'Complete') ,

(253, 11, '2021-09-22', 50.00, 'MBWay', 'Complete') ,

(254, 11, '2021-10-22', 50.00, 'PayPal', 'Complete') ,

(255, 11, '2021-11-22', 50.00, 'Cash', 'Complete') ,

(256, 11, '2021-12-22', 50.00, 'Credit Card', 'Complete'), 

(257, 11, '2022-01-22', 50.00, 'Debit Card', 'Complete') ,

(258, 11, '2022-02-22', 50.00, 'MBWay', 'Complete') ,

(259, 11, '2022-03-22', 50.00, 'PayPal', 'Complete') ,

(260, 11, '2022-04-22', 50.00, 'Cash', 'Complete') ,

(261, 11, '2022-05-22', 50.00, 'Credit Card', 'Complete'), 

(262, 11, '2022-06-22', 50.00, 'Debit Card', 'Complete') ,

(263, 11, '2022-07-22', 50.00, 'MBWay', 'Complete') ,

(264, 11, '2022-08-22', 50.00, 'PayPal', 'Complete') ,

(265, 11, '2022-09-22', 50.00, 'Cash', 'Complete') ,

(266, 11, '2022-10-22', 50.00, 'Credit Card', 'Complete'), 

(267, 11, '2022-11-22', 50.00, 'Debit Card', 'Complete') ,

(268, 11, '2022-12-22', 50.00, 'MBWay', 'Complete') ,

(269, 11, '2023-01-22', 50.00, 'PayPal', 'Complete') ,

(270, 11, '2023-02-22', 50.00, 'Cash', 'Complete') ,

(271, 11, '2023-03-22', 50.00, 'Credit Card', 'Complete'), 

(272, 11, '2023-04-22', 50.00, 'Debit Card', 'Complete') ,

(273, 11, '2023-05-22', 50.00, 'MBWay', 'Complete') ,

(274, 11, '2023-06-22', 50.00, 'PayPal', 'Complete') ,

(275, 11, '2023-07-22', 50.00, 'Cash', 'Complete') ,

(276, 11, '2023-08-22', 50.00, 'Credit Card', 'Complete'), 

(277, 11, '2023-09-22', 50.00, 'Debit Card', 'Complete') ,

(278, 11, '2023-10-22', 50.00, 'MBWay', 'Complete') ,

(279, 11, '2023-11-22', 50.00, 'PayPal', 'Complete') ,

(280, 11, '2023-12-22', 50.00, 'Cash', 'Not Complete'), 

(281, 12, '2019-04-15', 50.00, 'Credit Card', 'Complete'), 

(282, 12, '2019-05-15', 50.00, 'Debit Card', 'Complete') ,

(283, 12, '2019-06-15', 50.00, 'MBWay', 'Complete') ,

(284, 12, '2019-07-15', 50.00, 'PayPal', 'Complete') ,

(285, 12, '2019-08-15', 50.00, 'Cash', 'Complete') ,

(286, 12, '2019-09-15', 50.00, 'Credit Card', 'Complete'), 

(287, 12, '2019-10-15', 50.00, 'Debit Card', 'Complete') ,

(288, 12, '2019-11-15', 50.00, 'MBWay', 'Complete') ,

(289, 12, '2019-12-15', 50.00, 'PayPal', 'Complete') ,

(290, 12, '2020-01-15', 50.00, 'Cash', 'Complete') ,

(291, 12, '2020-02-15', 50.00, 'Credit Card', 'Complete'), 

(292, 12, '2020-03-15', 50.00, 'Debit Card', 'Complete') ,

(293, 12, '2020-04-15', 50.00, 'MBWay', 'Complete') ,

(294, 12, '2020-05-15', 50.00, 'PayPal', 'Complete') ,

(295, 12, '2020-06-15', 50.00, 'Cash', 'Complete') ,

(296, 12, '2020-07-15', 50.00, 'Credit Card', 'Complete'), 

(297, 12, '2020-08-15', 50.00, 'Debit Card', 'Complete') ,

(298, 12, '2020-09-15', 50.00, 'MBWay', 'Complete') ,

(299, 12, '2020-10-15', 50.00, 'PayPal', 'Complete') ,

(300, 12, '2020-11-15', 50.00, 'Cash', 'Complete') ,

(301, 12, '2020-12-15', 50.00, 'Credit Card', 'Complete'), 

(302, 12, '2021-01-15', 50.00, 'Debit Card', 'Complete') ,

(303, 12, '2021-02-15', 50.00, 'MBWay', 'Complete') ,

(304, 12, '2021-03-15', 50.00, 'PayPal', 'Complete') ,

(305, 12, '2021-04-15', 50.00, 'Cash', 'Complete') ,

(306, 12, '2021-05-15', 50.00, 'Credit Card', 'Complete'), 

(307, 12, '2021-06-15', 50.00, 'Debit Card', 'Complete') ,

(308, 12, '2021-07-15', 50.00, 'MBWay', 'Complete') ,

(309, 12, '2021-08-15', 50.00, 'PayPal', 'Complete') ,

(310, 12, '2021-09-15', 50.00, 'Cash', 'Complete') ,

(311, 12, '2021-10-15', 50.00, 'Credit Card', 'Complete'), 

(312, 12, '2021-11-15', 50.00, 'Debit Card', 'Complete') ,

(313, 12, '2021-12-15', 50.00, 'MBWay', 'Complete') ,

(314, 12, '2022-01-15', 50.00, 'PayPal', 'Complete') ,

(315, 12, '2022-02-15', 50.00, 'Cash', 'Complete') ,

(316, 12, '2022-03-15', 50.00, 'Credit Card', 'Complete'), 

(317, 12, '2022-04-15', 50.00, 'Debit Card', 'Complete') ,

(318, 12, '2022-05-15', 50.00, 'MBWay', 'Complete') ,

(319, 12, '2022-06-15', 50.00, 'PayPal', 'Complete') ,

(320, 12, '2022-07-15', 50.00, 'Cash', 'Complete') ,

(321, 12, '2022-08-15', 50.00, 'Credit Card', 'Complete'), 

(322, 12, '2022-09-15', 50.00, 'Debit Card', 'Complete') ,

(323, 12, '2022-10-15', 50.00, 'MBWay', 'Complete') ,

(324, 12, '2022-11-15', 50.00, 'PayPal', 'Complete') ,

(325, 12, '2022-12-15', 50.00, 'Cash', 'Complete') ,

(326, 12, '2023-01-15', 50.00, 'Credit Card', 'Complete'), 

(327, 12, '2023-02-15', 50.00, 'Debit Card', 'Complete') ,

(328, 12, '2023-03-15', 50.00, 'MBWay', 'Complete') ,

(329, 12, '2023-04-15', 50.00, 'PayPal', 'Complete') ,

(330, 12, '2023-05-15', 50.00, 'Cash', 'Complete') ,

(331, 12, '2023-06-15', 50.00, 'Credit Card', 'Complete'), 

(332, 12, '2023-07-15', 50.00, 'Debit Card', 'Complete') ,

(333, 12, '2023-08-15', 50.00, 'MBWay', 'Complete') ,

(334, 12, '2023-09-15', 50.00, 'PayPal', 'Complete') ,

(335, 12, '2023-10-15', 50.00, 'Cash', 'Complete') ,

(336, 12, '2023-11-15', 50.00, 'Credit Card', 'Complete'), 

(337, 12, '2023-12-15', 50.00, 'Debit Card', 'Complete') ,

(338, 13, '2019-09-05', 50.00, 'MBWay', 'Complete'), 

(339, 13, '2019-10-05', 50.00, 'PayPal', 'Complete'), 

(340, 13, '2019-11-05', 50.00, 'Cash', 'Complete') ,

(341, 13, '2019-12-05', 50.00, 'Credit Card', 'Complete'), 

(342, 13, '2020-01-05', 50.00, 'Debit Card', 'Complete') ,

(343, 13, '2020-02-05', 50.00, 'MBWay', 'Complete') ,

(344, 13, '2020-03-05', 50.00, 'PayPal', 'Complete') ,

(345, 13, '2020-04-05', 50.00, 'Cash', 'Complete') ,

(346, 13, '2020-05-05', 50.00, 'Credit Card', 'Complete'), 

(347, 13, '2020-06-05', 50.00, 'Debit Card', 'Complete') ,

(348, 13, '2020-07-05', 50.00, 'MBWay', 'Complete') ,

(349, 13, '2020-08-05', 50.00, 'PayPal', 'Complete') ,

(350, 13, '2020-09-05', 50.00, 'Cash', 'Complete') ,

(351, 13, '2020-10-05', 50.00, 'Credit Card', 'Complete'), 

(352, 13, '2020-11-05', 50.00, 'Debit Card', 'Complete') ,

(353, 13, '2020-12-05', 50.00, 'MBWay', 'Complete') ,

(354, 13, '2021-01-05', 50.00, 'PayPal', 'Complete') ,

(355, 13, '2021-02-05', 50.00, 'Cash', 'Complete') ,

(356, 13, '2021-03-05', 50.00, 'Credit Card', 'Complete'), 

(357, 13, '2021-04-05', 50.00, 'Debit Card', 'Complete') ,

(358, 13, '2021-05-05', 50.00, 'MBWay', 'Complete') ,

(359, 13, '2021-06-05', 50.00, 'PayPal', 'Complete') ,

(360, 13, '2021-07-05', 50.00, 'Cash', 'Complete') ,

(361, 13, '2021-08-05', 50.00, 'Credit Card', 'Complete'), 

(362, 13, '2021-09-05', 50.00, 'Debit Card', 'Complete') ,

(363, 13, '2021-10-05', 50.00, 'MBWay', 'Complete') ,

(364, 13, '2021-11-05', 50.00, 'PayPal', 'Complete') ,

(365, 13, '2021-12-05', 50.00, 'Cash', 'Complete') ,

(366, 13, '2022-01-05', 50.00, 'Credit Card', 'Complete'), 

(367, 13, '2022-02-05', 50.00, 'Debit Card', 'Complete') ,

(368, 13, '2022-03-05', 50.00, 'MBWay', 'Complete') ,

(369, 13, '2022-04-05', 50.00, 'PayPal', 'Complete') ,

(370, 13, '2022-05-05', 50.00, 'Cash', 'Complete') ,

(371, 13, '2022-06-05', 50.00, 'Credit Card', 'Complete'), 

(372, 13, '2022-07-05', 50.00, 'Debit Card', 'Complete') ,

(373, 13, '2022-08-05', 50.00, 'MBWay', 'Complete') ,

(374, 13, '2022-09-05', 50.00, 'PayPal', 'Complete') ,

(375, 13, '2022-10-05', 50.00, 'Cash', 'Complete') ,

(376, 13, '2022-11-05', 50.00, 'Credit Card', 'Complete'), 

(377, 13, '2022-12-05', 50.00, 'Debit Card', 'Complete') ,

(378, 13, '2023-01-05', 50.00, 'MBWay', 'Complete') ,

(379, 13, '2023-02-05', 50.00, 'PayPal', 'Complete') ,

(380, 13, '2023-03-05', 50.00, 'Cash', 'Complete') ,

(381, 13, '2023-04-05', 50.00, 'Credit Card', 'Complete'), 

(382, 13, '2023-05-05', 50.00, 'Debit Card', 'Complete') ,

(383, 13, '2023-06-05', 50.00, 'MBWay', 'Complete') ,

(384, 13, '2023-07-05', 50.00, 'PayPal', 'Complete') ,

(385, 13, '2023-08-05', 50.00, 'Cash', 'Complete') ,

(386, 13, '2023-09-05', 50.00, 'Credit Card', 'Complete'), 

(387, 13, '2023-10-05', 50.00, 'Debit Card', 'Complete') ,

(388, 13, '2023-11-05', 50.00, 'MBWay', 'Complete') ,

(389, 13, '2023-12-05', 50.00, 'PayPal', 'Complete') ,

(390, 14, '2019-12-18', 50.00, 'Cash', 'Complete') ,

(391, 14, '2020-01-18', 50.00, 'Credit Card', 'Complete'), 

(392, 14, '2020-02-18', 50.00, 'Debit Card', 'Complete') ,

(393, 14, '2020-03-18', 50.00, 'MBWay', 'Complete') ,

(394, 14, '2020-04-18', 50.00, 'PayPal', 'Complete') ,

(395, 14, '2020-05-18', 50.00, 'Cash', 'Complete') ,

(396, 14, '2020-06-18', 50.00, 'Credit Card', 'Complete'), 

(397, 14, '2020-07-18', 50.00, 'Debit Card', 'Complete') ,

(398, 14, '2020-08-18', 50.00, 'MBWay', 'Complete') ,

(399, 14, '2020-09-18', 50.00, 'PayPal', 'Complete') ,

(400, 14, '2020-10-18', 50.00, 'Cash', 'Complete') ,

(401, 14, '2020-11-18', 50.00, 'Credit Card', 'Complete'), 

(402, 14, '2020-12-18', 50.00, 'Debit Card', 'Complete') ,

(403, 14, '2021-01-18', 50.00, 'MBWay', 'Complete') ,

(404, 14, '2021-02-18', 50.00, 'PayPal', 'Complete') ,

(405, 14, '2021-03-18', 50.00, 'Cash', 'Complete') ,

(406, 14, '2021-04-18', 50.00, 'Credit Card', 'Complete'), 

(407, 14, '2021-05-18', 50.00, 'Debit Card', 'Complete') ,

(408, 14, '2021-06-18', 50.00, 'MBWay', 'Complete') ,

(409, 14, '2021-07-18', 50.00, 'PayPal', 'Complete') ,

(410, 14, '2021-08-18', 50.00, 'Cash', 'Complete') ,

(411, 14, '2021-09-18', 50.00, 'Credit Card', 'Complete'), 

(412, 14, '2021-10-18', 50.00, 'Debit Card', 'Complete') ,

(413, 14, '2021-11-18', 50.00, 'MBWay', 'Complete') ,

(414, 14, '2021-12-18', 50.00, 'PayPal', 'Complete') ,

(415, 14, '2022-01-18', 50.00, 'Cash', 'Complete') ,

(416, 14, '2022-02-18', 50.00, 'Credit Card', 'Complete'), 

(417, 14, '2022-03-18', 50.00, 'Debit Card', 'Complete') ,

(418, 14, '2022-04-18', 50.00, 'MBWay', 'Complete') ,

(419, 14, '2022-05-18', 50.00, 'PayPal', 'Complete') ,

(420, 14, '2022-06-18', 50.00, 'Cash', 'Complete') ,

(421, 14, '2022-07-18', 50.00, 'Credit Card', 'Complete'), 

(422, 14, '2022-08-18', 50.00, 'Debit Card', 'Complete') ,

(423, 14, '2022-09-18', 50.00, 'MBWay', 'Complete') ,

(424, 14, '2022-10-18', 50.00, 'PayPal', 'Complete') ,

(425, 14, '2022-11-18', 50.00, 'Cash', 'Complete') ,

(426, 14, '2022-12-18', 50.00, 'Credit Card', 'Complete'), 

(427, 14, '2023-01-18', 50.00, 'Debit Card', 'Complete') ,

(428, 14, '2023-02-18', 50.00, 'MBWay', 'Complete') ,

(429, 14, '2023-03-18', 50.00, 'PayPal', 'Complete') ,

(430, 14, '2023-04-18', 50.00, 'Cash', 'Complete') ,

(431, 14, '2023-05-18', 50.00, 'Credit Card', 'Complete'), 

(432, 14, '2023-06-18', 50.00, 'Debit Card', 'Complete') ,

(433, 14, '2023-07-18', 50.00, 'MBWay', 'Complete') ,

(434, 14, '2023-08-18', 50.00, 'PayPal', 'Complete') ,

(435, 14, '2023-09-18', 50.00, 'Cash', 'Complete') ,

(436, 14, '2023-10-18', 50.00, 'Credit Card', 'Complete'), 

(437, 14, '2023-11-18', 50.00, 'Debit Card', 'Complete') ,

(438, 14, '2023-12-18', 50.00, 'MBWay', 'Not Complete') ,

(439, 15, '2019-02-01', 50.00, 'PayPal', 'Complete') ,

(440, 15, '2019-03-01', 50.00, 'Cash', 'Complete') ,

(441, 15, '2019-04-01', 50.00, 'Credit Card', 'Complete'), 

(442, 15, '2019-05-01', 50.00, 'Debit Card', 'Complete') ,

(443, 15, '2019-06-01', 50.00, 'MBWay', 'Complete') ,

(444, 15, '2019-07-01', 50.00, 'PayPal', 'Complete') ,

(445, 15, '2019-08-01', 50.00, 'Cash', 'Complete') ,

(446, 15, '2019-09-01', 50.00, 'Credit Card', 'Complete'), 

(447, 15, '2019-10-01', 50.00, 'Debit Card', 'Complete') ,

(448, 15, '2019-11-01', 50.00, 'MBWay', 'Complete') ,

(449, 15, '2019-12-01', 50.00, 'PayPal', 'Complete') ,

(450, 15, '2020-01-01', 50.00, 'Cash', 'Complete') ,

(451, 15, '2020-02-01', 50.00, 'Credit Card', 'Complete'), 

(452, 15, '2020-03-01', 50.00, 'Debit Card', 'Complete') ,

(453, 15, '2020-04-01', 50.00, 'MBWay', 'Complete') ,

(454, 15, '2020-05-01', 50.00, 'PayPal', 'Complete') ,

(455, 15, '2020-06-01', 50.00, 'Cash', 'Complete') ,

(456, 15, '2020-07-01', 50.00, 'Credit Card', 'Complete'), 

(457, 15, '2020-08-01', 50.00, 'Debit Card', 'Complete') ,

(458, 15, '2020-09-01', 50.00, 'MBWay', 'Complete') ,

(459, 15, '2020-10-01', 50.00, 'PayPal', 'Complete') ,

(460, 15, '2020-11-01', 50.00, 'Cash', 'Complete') ,

(461, 15, '2020-12-01', 50.00, 'Credit Card', 'Complete'), 

(462, 15, '2021-01-01', 50.00, 'Debit Card', 'Complete') ,

(463, 15, '2021-02-01', 50.00, 'MBWay', 'Complete') ,

(464, 15, '2021-03-01', 50.00, 'PayPal', 'Complete') ,

(465, 15, '2021-04-01', 50.00, 'Cash', 'Complete') ,

(466, 15, '2021-05-01', 50.00, 'Credit Card', 'Complete'), 

(467, 15, '2021-06-01', 50.00, 'Debit Card', 'Complete') ,

(468, 15, '2021-07-01', 50.00, 'MBWay', 'Complete') ,

(469, 15, '2021-08-01', 50.00, 'PayPal', 'Complete') ,

(470, 15, '2021-09-01', 50.00, 'Cash', 'Complete') ,

(471, 15, '2021-10-01', 50.00, 'Credit Card', 'Complete'), 

(472, 15, '2021-11-01', 50.00, 'Debit Card', 'Complete') ,

(473, 15, '2021-12-01', 50.00, 'MBWay', 'Complete') ,

(474, 15, '2022-01-01', 50.00, 'PayPal', 'Complete') ,

(475, 15, '2022-02-01', 50.00, 'Cash', 'Complete') ,

(476, 15, '2022-03-01', 50.00, 'Credit Card', 'Complete'), 

(477, 15, '2022-04-01', 50.00, 'Debit Card', 'Complete') ,

(478, 15, '2022-05-01', 50.00, 'MBWay', 'Complete') ,


(479, 15, '2022-06-01', 50.00, 'PayPal', 'Complete'), 

(480, 15, '2022-07-01', 50.00, 'Cash', 'Complete'), 

(481, 15, '2022-08-01', 50.00, 'Credit Card', 'Complete'), 

(482, 15, '2022-09-01', 50.00, 'Debit Card', 'Complete'), 

(483, 15, '2022-10-01', 50.00, 'MBWay', 'Complete'), 

(484, 15, '2022-11-01', 50.00, 'PayPal', 'Complete'), 

(485, 15, '2022-12-01', 50.00, 'Cash', 'Complete'), 

(486, 15, '2023-01-01', 50.00, 'Credit Card', 'Complete'), 

(487, 15, '2023-02-01', 50.00, 'Debit Card', 'Complete'), 

(488, 15, '2023-03-01', 50.00, 'MBWay', 'Complete'), 

(489, 15, '2023-04-01', 50.00, 'PayPal', 'Complete'), 

(490, 15, '2023-05-01', 50.00, 'Cash', 'Complete'), 

(491, 15, '2023-06-01', 50.00, 'Credit Card', 'Complete'), 

(492, 15, '2023-07-01', 50.00, 'Debit Card', 'Complete'), 

(493, 15, '2023-08-01', 50.00, 'MBWay', 'Complete'), 

(494, 15, '2023-09-01', 50.00, 'PayPal', 'Complete'), 

(495, 15, '2023-10-01', 50.00, 'Cash', 'Complete'), 

(496, 15, '2023-11-01', 50.00, 'Credit Card', 'Complete'), 

(497, 15, '2023-12-01', 50.00, 'Debit Card', 'Complete'), 

(498, 16, '2022-03-14', 50.00, 'MBWay', 'Complete'), 

(499, 16, '2022-04-14', 50.00, 'PayPal', 'Complete'), 

(500, 16, '2022-05-14', 50.00, 'Cash', 'Complete'), 

(501, 16, '2022-06-14', 50.00, 'Credit Card', 'Complete'), 

(502, 16, '2022-07-14', 50.00, 'Debit Card', 'Complete'), 

(503, 16, '2022-08-14', 50.00, 'MBWay', 'Complete'), 

(504, 16, '2022-09-14', 50.00, 'PayPal', 'Complete'), 

(505, 16, '2022-10-14', 50.00, 'Cash', 'Complete'), 

(506, 16, '2022-11-14', 50.00, 'Credit Card', 'Complete'), 

(507, 16, '2022-12-14', 50.00, 'Debit Card', 'Complete'), 

(508, 16, '2023-01-14', 50.00, 'MBWay', 'Complete'), 

(509, 16, '2023-02-14', 50.00, 'PayPal', 'Complete'), 

(510, 16, '2023-03-14', 50.00, 'Cash', 'Complete'), 

(511, 16, '2023-04-14', 50.00, 'Credit Card', 'Complete'), 

(512, 16, '2023-05-14', 50.00, 'Debit Card', 'Complete'), 

(513, 16, '2023-06-14', 50.00, 'MBWay', 'Complete'), 

(514, 16, '2023-07-14', 50.00, 'PayPal', 'Complete'), 

(515, 16, '2023-08-14', 50.00, 'Cash', 'Complete'), 

(516, 16, '2023-09-14', 50.00, 'Credit Card', 'Complete'), 

(517, 16, '2023-10-14', 50.00, 'Debit Card', 'Complete'), 

(518, 16, '2023-11-14', 50.00, 'MBWay', 'Complete'), 

(519, 16, '2023-12-14', 50.00, 'PayPal', 'Complete'), 

(520, 17, '2021-06-28', 50.00, 'Cash', 'Complete'), 

(521, 17, '2021-07-28', 50.00, 'Credit Card', 'Complete'), 

(522, 17, '2021-08-28', 50.00, 'Debit Card', 'Complete'), 

(523, 17, '2021-09-28', 50.00, 'MBWay', 'Complete'), 

(524, 17, '2021-10-28', 50.00, 'PayPal', 'Complete'), 

(525, 17, '2021-11-28', 50.00, 'Cash', 'Complete'), 

(526, 17, '2021-12-28', 50.00, 'Credit Card', 'Complete'), 

(527, 17, '2022-01-28', 50.00, 'Debit Card', 'Complete'), 

(528, 17, '2022-02-28', 50.00, 'MBWay', 'Complete'), 

(529, 17, '2022-03-28', 50.00, 'PayPal', 'Complete'), 

(530, 17, '2022-04-28', 50.00, 'Cash', 'Complete'), 

(531, 17, '2022-05-28', 50.00, 'Credit Card', 'Complete'), 

(532, 17, '2022-06-28', 50.00, 'Debit Card', 'Complete'), 

(533, 17, '2022-07-28', 50.00, 'MBWay', 'Complete'), 

(534, 17, '2022-08-28', 50.00, 'PayPal', 'Complete'), 

(535, 17, '2022-09-28', 50.00, 'Cash', 'Complete'), 

(536, 17, '2022-10-28', 50.00, 'Credit Card', 'Complete'), 

(537, 17, '2022-11-28', 50.00, 'Debit Card', 'Complete'), 

(538, 17, '2022-12-28', 50.00, 'MBWay', 'Complete'), 

(539, 17, '2023-01-28', 50.00, 'PayPal', 'Complete'), 

(540, 17, '2023-02-28', 50.00, 'Cash', 'Complete'), 

(541, 17, '2023-03-28', 50.00, 'Credit Card', 'Complete'), 

(542, 17, '2023-04-28', 50.00, 'Debit Card', 'Complete'), 

(543, 17, '2023-05-28', 50.00, 'MBWay', 'Complete'), 

(544, 17, '2023-06-28', 50.00, 'PayPal', 'Complete'), 

(545, 17, '2023-07-28', 50.00, 'Cash', 'Complete'), 

(546, 17, '2023-08-28', 50.00, 'Credit Card', 'Complete'), 

(547, 17, '2023-09-28', 50.00, 'Debit Card', 'Complete'), 

(548, 17, '2023-10-28', 50.00, 'MBWay', 'Complete'), 

(549, 17, '2023-11-28', 50.00, 'PayPal', 'Complete'), 

(550, 17, '2023-12-28', 50.00, 'Cash', 'Not Complete'), 

(551, 18, '2019-10-05', 50.00, 'Credit Card', 'Complete'), 

(552, 18, '2019-11-05', 50.00, 'Debit Card', 'Complete'), 

(553, 18, '2019-12-05', 50.00, 'MBWay', 'Complete'), 

(554, 18, '2020-01-05', 50.00, 'PayPal', 'Complete'), 

(555, 18, '2020-02-05', 50.00, 'Cash', 'Complete'), 

(556, 18, '2020-03-05', 50.00, 'Credit Card', 'Complete'), 

(557, 18, '2020-04-05', 50.00, 'Debit Card', 'Complete'), 

(558, 18, '2020-05-05', 50.00, 'MBWay', 'Complete'), 

(559, 18, '2020-06-05', 50.00, 'PayPal', 'Complete'), 

(560, 18, '2020-07-05', 50.00, 'Cash', 'Complete'), 

(561, 18, '2020-08-05', 50.00, 'Credit Card', 'Complete'), 

(562, 18, '2020-09-05', 50.00, 'Debit Card', 'Complete'), 

(563, 18, '2020-10-05', 50.00, 'MBWay', 'Complete'), 

(564, 18, '2020-11-05', 50.00, 'PayPal', 'Complete'), 

(565, 18, '2020-12-05', 50.00, 'Cash', 'Complete'), 

(566, 18, '2021-01-05', 50.00, 'Credit Card', 'Complete'), 

(567, 18, '2021-02-05', 50.00, 'Debit Card', 'Complete'), 

(568, 18, '2021-03-05', 50.00, 'MBWay', 'Complete'), 

(569, 18, '2021-04-05', 50.00, 'PayPal', 'Complete'), 

(570, 18, '2021-05-05', 50.00, 'Cash', 'Complete'), 

(571, 18, '2021-06-05', 50.00, 'Credit Card', 'Complete'), 

(572, 18, '2021-07-05', 50.00, 'Debit Card', 'Complete'), 

(573, 18, '2021-08-05', 50.00, 'MBWay', 'Complete'), 

(574, 18, '2021-09-05', 50.00, 'PayPal', 'Complete'), 

(575, 18, '2021-10-05', 50.00, 'Cash', 'Complete'), 

(576, 18, '2021-11-05', 50.00, 'Credit Card', 'Complete'), 

(577, 18, '2021-12-05', 50.00, 'Debit Card', 'Complete'), 

(578, 18, '2022-01-05', 50.00, 'MBWay', 'Complete'), 

(579, 18, '2022-02-05', 50.00, 'PayPal', 'Complete'), 

(580, 18, '2022-03-05', 50.00, 'Cash', 'Complete'), 

(581, 18, '2022-04-05', 50.00, 'Credit Card', 'Complete'), 

(582, 18, '2022-05-05', 50.00, 'Debit Card', 'Complete'), 

(583, 18, '2022-06-05', 50.00, 'MBWay', 'Complete'), 

(584, 18, '2022-07-05', 50.00, 'PayPal', 'Complete'), 

(585, 18, '2022-08-05', 50.00, 'Cash', 'Complete'), 

(586, 18, '2022-09-05', 50.00, 'Credit Card', 'Complete'), 

(587, 18, '2022-10-05', 50.00, 'Debit Card', 'Complete'), 

(588, 18, '2022-11-05', 50.00, 'MBWay', 'Complete'), 

(589, 18, '2022-12-05', 50.00, 'PayPal', 'Complete'), 

(590, 18, '2023-01-05', 50.00, 'Cash', 'Complete'), 

(591, 18, '2023-02-05', 50.00, 'Credit Card', 'Complete'), 

(592, 18, '2023-03-05', 50.00, 'Debit Card', 'Complete'), 

(593, 18, '2023-04-05', 50.00, 'MBWay', 'Complete'), 

(594, 18, '2023-05-05', 50.00, 'PayPal', 'Complete'), 

(595, 18, '2023-06-05', 50.00, 'Cash', 'Complete'), 

(596, 18, '2023-07-05', 50.00, 'Credit Card', 'Complete'), 

(597, 18, '2023-08-05', 50.00, 'Debit Card', 'Complete'), 

(598, 18, '2023-09-05', 50.00, 'MBWay', 'Complete'), 

(599, 18, '2023-10-05', 50.00, 'PayPal', 'Complete'), 

(600, 18, '2023-11-05', 50.00, 'Cash', 'Complete'), 

(601, 18, '2023-12-05', 50.00, 'Credit Card', 'Complete'), 

(602, 19, '2021-04-12', 50.00, 'Debit Card', 'Complete'), 

(603, 19, '2021-05-12', 50.00, 'MBWay', 'Complete'), 

(604, 19, '2021-06-12', 50.00, 'PayPal', 'Complete'), 

(605, 19, '2021-07-12', 50.00, 'Cash', 'Complete'), 

(606, 19, '2021-08-12', 50.00, 'Credit Card', 'Complete'), 

(607, 19, '2021-09-12', 50.00, 'Debit Card', 'Complete'), 

(608, 19, '2021-10-12', 50.00, 'MBWay', 'Complete'), 

(609, 19, '2021-11-12', 50.00, 'PayPal', 'Complete'), 

(610, 19, '2021-12-12', 50.00, 'Cash', 'Complete'), 

(611, 19, '2022-01-12', 50.00, 'Credit Card', 'Complete'), 

(612, 19, '2022-02-12', 50.00, 'Debit Card', 'Complete'), 

(613, 19, '2022-03-12', 50.00, 'MBWay', 'Complete'), 

(614, 19, '2022-04-12', 50.00, 'PayPal', 'Complete'), 

(615, 19, '2022-05-12', 50.00, 'Cash', 'Complete'), 

(616, 19, '2022-06-12', 50.00, 'Credit Card', 'Complete'), 

(617, 19, '2022-07-12', 50.00, 'Debit Card', 'Complete'), 

(618, 19, '2022-08-12', 50.00, 'MBWay', 'Complete'), 

(619, 19, '2022-09-12', 50.00, 'PayPal', 'Complete'), 

(620, 19, '2022-10-12', 50.00, 'Cash', 'Complete'), 

(621, 19, '2022-11-12', 50.00, 'Credit Card', 'Complete'), 

(622, 19, '2022-12-12', 50.00, 'Debit Card', 'Complete'), 

(623, 19, '2023-01-12', 50.00, 'MBWay', 'Complete'), 

(624, 19, '2023-02-12', 50.00, 'PayPal', 'Complete'), 

(625, 19, '2023-03-12', 50.00, 'Cash', 'Complete'), 

(626, 19, '2023-04-12', 50.00, 'Credit Card', 'Complete'), 

(627, 19, '2023-05-12', 50.00, 'Debit Card', 'Complete'), 

(628, 19, '2023-06-12', 50.00, 'MBWay', 'Complete'), 

(629, 19, '2023-07-12', 50.00, 'PayPal', 'Complete'), 

(630, 19, '2023-08-12', 50.00, 'Cash', 'Complete'), 

(631, 19, '2023-09-12', 50.00, 'Credit Card', 'Complete'), 

(632, 19, '2023-10-12', 50.00, 'Debit Card', 'Complete'), 

(633, 19, '2023-11-12', 50.00, 'MBWay', 'Complete'), 

(634, 19, '2023-12-12', 50.00, 'PayPal', 'Complete'), 

(635, 20, '2019-01-25', 50.00, 'Cash', 'Complete'), 

(636, 20, '2019-02-25', 50.00, 'Credit Card', 'Complete'), 

(637, 20, '2019-03-25', 50.00, 'Debit Card', 'Complete'), 

(638, 20, '2019-04-25', 50.00, 'MBWay', 'Complete'), 

(639, 20, '2019-05-25', 50.00, 'PayPal', 'Complete'), 

(640, 20, '2019-06-25', 50.00, 'Cash', 'Complete'), 

(641, 20, '2019-07-25', 50.00, 'Credit Card', 'Complete'), 

(642, 20, '2019-08-25', 50.00, 'Debit Card', 'Complete'), 

(643, 20, '2019-09-25', 50.00, 'MBWay', 'Complete'), 

(644, 20, '2019-10-25', 50.00, 'PayPal', 'Complete'), 

(645, 20, '2019-11-25', 50.00, 'Cash', 'Complete'), 

(646, 20, '2019-12-25', 50.00, 'Credit Card', 'Complete'), 

(647, 20, '2020-01-25', 50.00, 'Debit Card', 'Complete'), 

(648, 20, '2020-02-25', 50.00, 'MBWay', 'Complete'), 

(649, 20, '2020-03-25', 50.00, 'PayPal', 'Complete'), 

(650, 20, '2020-04-25', 50.00, 'Cash', 'Complete'), 

(651, 20, '2020-05-25', 50.00, 'Credit Card', 'Complete'), 

(652, 20, '2020-06-25', 50.00, 'Debit Card', 'Complete'), 

(653, 20, '2020-07-25', 50.00, 'MBWay', 'Complete'), 

(654, 20, '2020-08-25', 50.00, 'PayPal', 'Complete'), 

(655, 20, '2020-09-25', 50.00, 'Cash', 'Complete'), 

(656, 20, '2020-10-25', 50.00, 'Credit Card', 'Complete'), 

(657, 20, '2020-11-25', 50.00, 'Debit Card', 'Complete'), 

(658, 20, '2020-12-25', 50.00, 'MBWay', 'Complete'), 

(659, 20, '2021-01-25', 50.00, 'PayPal', 'Complete'), 

(660, 20, '2021-02-25', 50.00, 'Cash', 'Complete'), 

(661, 20, '2021-03-25', 50.00, 'Credit Card', 'Complete'), 

(662, 20, '2021-04-25', 50.00, 'Debit Card', 'Complete'), 

(663, 20, '2021-05-25', 50.00, 'MBWay', 'Complete'), 

(664, 20, '2021-06-25', 50.00, 'PayPal', 'Complete'), 

(665, 20, '2021-07-25', 50.00, 'Cash', 'Complete'), 

(666, 20, '2021-08-25', 50.00, 'Credit Card', 'Complete'), 

(667, 20, '2021-09-25', 50.00, 'Debit Card', 'Complete'), 

(668, 20, '2021-10-25', 50.00, 'MBWay', 'Complete'), 

(669, 20, '2021-11-25', 50.00, 'PayPal', 'Complete'), 

(670, 20, '2021-12-25', 50.00, 'Cash', 'Complete'), 

(671, 20, '2022-01-25', 50.00, 'Credit Card', 'Complete'), 

(672, 20, '2022-02-25', 50.00, 'Debit Card', 'Complete'), 

(673, 20, '2022-03-25', 50.00, 'MBWay', 'Complete'), 

(674, 20, '2022-04-25', 50.00, 'PayPal', 'Complete'), 

(675, 20, '2022-05-25', 50.00, 'Cash', 'Complete'), 

(676, 20, '2022-06-25', 50.00, 'Credit Card', 'Complete'), 

(677, 20, '2022-07-25', 50.00, 'Debit Card', 'Complete'), 

(678, 20, '2022-08-25', 50.00, 'MBWay', 'Complete'), 

(679, 20, '2022-09-25', 50.00, 'PayPal', 'Complete'), 

(680, 20, '2022-10-25', 50.00, 'Cash', 'Complete'), 

(681, 20, '2022-11-25', 50.00, 'Credit Card', 'Complete'), 

(682, 20, '2022-12-25', 50.00, 'Debit Card', 'Complete'), 

(683, 20, '2023-01-25', 50.00, 'MBWay', 'Complete'), 

(684, 20, '2023-02-25', 50.00, 'PayPal', 'Complete'), 

(685, 20, '2023-03-25', 50.00, 'Cash', 'Complete'), 

(686, 20, '2023-04-25', 50.00, 'Credit Card', 'Complete'), 

(687, 20, '2023-05-25', 50.00, 'Debit Card', 'Complete'), 

(688, 20, '2023-06-25', 50.00, 'MBWay', 'Complete'), 

(689, 20, '2023-07-25', 50.00, 'PayPal', 'Complete'), 

(690, 20, '2023-08-25', 50.00, 'Cash', 'Complete'), 

(691, 20, '2023-09-25', 50.00, 'Credit Card', 'Complete'), 

(692, 20, '2023-10-25', 50.00, 'Debit Card', 'Complete'), 

(693, 20, '2023-11-25', 50.00, 'MBWay', 'Complete'), 

(694, 20, '2023-12-25', 50.00, 'PayPal', 'Not Complete'), 

(695, 21, '2021-08-25', 50.00, 'Cash', 'Complete'), 

(696, 21, '2021-09-25', 50.00, 'Credit Card', 'Complete'), 

(697, 21, '2021-10-25', 50.00, 'Debit Card', 'Complete'), 

(698, 21, '2021-11-25', 50.00, 'MBWay', 'Complete'), 

(699, 21, '2021-12-25', 50.00, 'PayPal', 'Complete'), 

(700, 21, '2022-01-25', 50.00, 'Cash', 'Complete'), 

(701, 21, '2022-02-25', 50.00, 'Credit Card', 'Complete'), 

(702, 21, '2022-03-25', 50.00, 'Debit Card', 'Complete'), 

(703, 21, '2022-04-25', 50.00, 'MBWay', 'Complete'), 

(704, 21, '2022-05-25', 50.00, 'PayPal', 'Complete'), 

(705, 21, '2022-06-25', 50.00, 'Cash', 'Complete'), 

(706, 21, '2022-07-25', 50.00, 'Credit Card', 'Complete'), 

(707, 21, '2022-08-25', 50.00, 'Debit Card', 'Complete'), 

(708, 21, '2022-09-25', 50.00, 'MBWay', 'Complete'), 

(709, 21, '2022-10-25', 50.00, 'PayPal', 'Complete'), 

(710, 21, '2022-11-25', 50.00, 'Cash', 'Complete'), 

(711, 21, '2022-12-25', 50.00, 'Credit Card', 'Complete'), 

(712, 21, '2023-01-25', 50.00, 'Debit Card', 'Complete'), 

(713, 21, '2023-02-25', 50.00, 'MBWay', 'Complete'), 

(714, 21, '2023-03-25', 50.00, 'PayPal', 'Complete'), 

(715, 21, '2023-04-25', 50.00, 'Cash', 'Complete'), 

(716, 21, '2023-05-25', 50.00, 'Credit Card', 'Complete'), 

(717, 21, '2023-06-25', 50.00, 'Debit Card', 'Complete'), 

(718, 21, '2023-07-25', 50.00, 'MBWay', 'Complete'), 

(719, 21, '2023-08-25', 50.00, 'PayPal', 'Complete'), 

(720, 21, '2023-09-25', 50.00, 'Cash', 'Complete'), 

(721, 21, '2023-10-25', 50.00, 'Credit Card', 'Complete'), 

(722, 21, '2023-11-25', 50.00, 'Debit Card', 'Complete'), 

(723, 21, '2023-12-25', 50.00, 'MBWay', 'Not Complete'), 

(724, 22, '2022-02-15', 50.00, 'PayPal', 'Complete'), 

(725, 22, '2022-03-15', 50.00, 'Cash', 'Complete'), 

(726, 22, '2022-04-15', 50.00, 'Credit Card', 'Complete'), 

(727, 22, '2022-05-15', 50.00, 'Debit Card', 'Complete'), 

(728, 22, '2022-06-15', 50.00, 'MBWay', 'Complete'), 

(729, 22, '2022-07-15', 50.00, 'PayPal', 'Complete'), 

(730, 22, '2022-08-15', 50.00, 'Cash', 'Complete'), 

(731, 22, '2022-09-15', 50.00, 'Credit Card', 'Complete'), 

(732, 22, '2022-10-15', 50.00, 'Debit Card', 'Complete'), 

(733, 22, '2022-11-15', 50.00, 'MBWay', 'Complete'), 

(734, 22, '2022-12-15', 50.00, 'PayPal', 'Complete'), 

(735, 22, '2023-01-15', 50.00, 'Cash', 'Complete'), 

(736, 22, '2023-02-15', 50.00, 'Credit Card', 'Complete'), 

(737, 22, '2023-03-15', 50.00, 'Debit Card', 'Complete'), 

(738, 22, '2023-04-15', 50.00, 'MBWay', 'Complete'), 

(739, 22, '2023-05-15', 50.00, 'PayPal', 'Complete'), 

(740, 22, '2023-06-15', 50.00, 'Cash', 'Complete'), 

(741, 22, '2023-07-15', 50.00, 'Credit Card', 'Complete'), 

(742, 22, '2023-08-15', 50.00, 'Debit Card', 'Complete'), 

(743, 22, '2023-09-15', 50.00, 'MBWay', 'Complete'), 

(744, 22, '2023-10-15', 50.00, 'PayPal', 'Complete'), 

(745, 22, '2023-11-15', 50.00, 'Cash', 'Complete'), 

(746, 22, '2023-12-15', 50.00, 'Credit Card', 'Complete'), 

(747, 23, '2022-07-05', 50.00, 'Debit Card', 'Complete'), 

(748, 23, '2022-08-05', 50.00, 'MBWay', 'Complete'), 

(749, 23, '2022-09-05', 50.00, 'PayPal', 'Complete'), 

(750, 23, '2022-10-05', 50.00, 'Cash', 'Complete'), 

(751, 23, '2022-11-05', 50.00, 'Credit Card', 'Complete'), 

(752, 23, '2022-12-05', 50.00, 'Debit Card', 'Complete'), 

(753, 23, '2023-01-05', 50.00, 'MBWay', 'Complete'), 

(754, 23, '2023-02-05', 50.00, 'PayPal', 'Complete'), 

(755, 23, '2023-03-05', 50.00, 'Cash', 'Complete'), 

(756, 23, '2023-04-05', 50.00, 'Credit Card', 'Complete'), 

(757, 23, '2023-05-05', 50.00, 'Debit Card', 'Complete'), 

(758, 23, '2023-06-05', 50.00, 'MBWay', 'Complete'), 

(759, 23, '2023-07-05', 50.00, 'PayPal', 'Complete'), 

(760, 23, '2023-08-05', 50.00, 'Cash', 'Complete'), 

(761, 23, '2023-09-05', 50.00, 'Credit Card', 'Complete'), 

(762, 23, '2023-10-05', 50.00, 'Debit Card', 'Complete'), 

(763, 23, '2023-11-05', 50.00, 'MBWay', 'Complete'), 

(764, 23, '2023-12-05', 50.00, 'PayPal', 'Complete'), 

(765, 24, '2019-10-12', 50.00, 'Cash', 'Complete'), 

(766, 24, '2019-11-12', 50.00, 'Credit Card', 'Complete'), 

(767, 24, '2019-12-12', 50.00, 'Debit Card', 'Complete'), 

(768, 24, '2020-01-12', 50.00, 'MBWay', 'Complete'), 

(769, 24, '2020-02-12', 50.00, 'PayPal', 'Complete'), 

(770, 24, '2020-03-12', 50.00, 'Cash', 'Complete'), 

(771, 24, '2020-04-12', 50.00, 'Credit Card', 'Complete'), 

(772, 24, '2020-05-12', 50.00, 'Debit Card', 'Complete'), 

(773, 24, '2020-06-12', 50.00, 'MBWay', 'Complete'), 

(774, 24, '2020-07-12', 50.00, 'PayPal', 'Complete'), 

(775, 24, '2020-08-12', 50.00, 'Cash', 'Complete'), 

(776, 24, '2020-09-12', 50.00, 'Credit Card', 'Complete'), 

(777, 24, '2020-10-12', 50.00, 'Debit Card', 'Complete'), 

(778, 24, '2020-11-12', 50.00, 'MBWay', 'Complete'), 

(779, 24, '2020-12-12', 50.00, 'PayPal', 'Complete'), 

(780, 24, '2021-01-12', 50.00, 'Cash', 'Complete'), 

(781, 24, '2021-02-12', 50.00, 'Credit Card', 'Complete'), 

(782, 24, '2021-03-12', 50.00, 'Debit Card', 'Complete'), 

(783, 24, '2021-04-12', 50.00, 'MBWay', 'Complete'), 

(784, 24, '2021-05-12', 50.00, 'PayPal', 'Complete'), 

(785, 24, '2021-06-12', 50.00, 'Cash', 'Complete'), 

(786, 24, '2021-07-12', 50.00, 'Credit Card', 'Complete'), 

(787, 24, '2021-08-12', 50.00, 'Debit Card', 'Complete'), 

(788, 24, '2021-09-12', 50.00, 'MBWay', 'Complete'), 

(789, 24, '2021-10-12', 50.00, 'PayPal', 'Complete'), 

(790, 24, '2021-11-12', 50.00, 'Cash', 'Complete'), 

(791, 24, '2021-12-12', 50.00, 'Credit Card', 'Complete'), 

(792, 24, '2022-01-12', 50.00, 'Debit Card', 'Complete'), 

(793, 24, '2022-02-12', 50.00, 'MBWay', 'Complete'), 

(794, 24, '2022-03-12', 50.00, 'PayPal', 'Complete'), 

(795, 24, '2022-04-12', 50.00, 'Cash', 'Complete'), 

(796, 24, '2022-05-12', 50.00, 'Credit Card', 'Complete'), 

(797, 24, '2022-06-12', 50.00, 'Debit Card', 'Complete'), 

(798, 24, '2022-07-12', 50.00, 'MBWay', 'Complete'), 

(799, 24, '2022-08-12', 50.00, 'PayPal', 'Complete'), 

(800, 24, '2022-09-12', 50.00, 'Cash', 'Complete'), 

(801, 24, '2022-10-12', 50.00, 'Credit Card', 'Complete'), 

(802, 24, '2022-11-12', 50.00, 'Debit Card', 'Complete'), 

(803, 24, '2022-12-12', 50.00, 'MBWay', 'Complete'), 

(804, 24, '2023-01-12', 50.00, 'PayPal', 'Complete'), 

(805, 24, '2023-02-12', 50.00, 'Cash', 'Complete'), 

(806, 24, '2023-03-12', 50.00, 'Credit Card', 'Complete'), 

(807, 24, '2023-04-12', 50.00, 'Debit Card', 'Complete'), 

(808, 24, '2023-05-12', 50.00, 'MBWay', 'Complete'), 

(809, 24, '2023-06-12', 50.00, 'PayPal', 'Complete'), 

(810, 24, '2023-07-12', 50.00, 'Cash', 'Complete'), 

(811, 24, '2023-08-12', 50.00, 'Credit Card', 'Complete'), 

(812, 24, '2023-09-12', 50.00, 'Debit Card', 'Complete'), 

(813, 24, '2023-10-12', 50.00, 'MBWay', 'Complete'), 

(814, 24, '2023-11-12', 50.00, 'PayPal', 'Complete'), 

(815, 24, '2023-12-12', 50.00, 'Cash', 'Complete'), 

(816, 25, '2019-04-01', 50.00, 'Credit Card', 'Complete'), 

(817, 25, '2019-05-01', 50.00, 'Debit Card', 'Complete'), 

(818, 25, '2019-06-01', 50.00, 'MBWay', 'Complete'), 

(819, 25, '2019-07-01', 50.00, 'PayPal', 'Complete'), 

(820, 25, '2019-08-01', 50.00, 'Cash', 'Complete'), 

(821, 25, '2019-09-01', 50.00, 'Credit Card', 'Complete'), 

(822, 25, '2019-10-01', 50.00, 'Debit Card', 'Complete'), 

(823, 25, '2019-11-01', 50.00, 'MBWay', 'Complete'), 

(824, 25, '2019-12-01', 50.00, 'PayPal', 'Complete'), 

(825, 25, '2020-01-01', 50.00, 'Cash', 'Complete'), 

(826, 25, '2020-02-01', 50.00, 'Credit Card', 'Complete'), 

(827, 25, '2020-03-01', 50.00, 'Debit Card', 'Complete'), 

(828, 25, '2020-04-01', 50.00, 'MBWay', 'Complete'), 

(829, 25, '2020-05-01', 50.00, 'PayPal', 'Complete'), 

(830, 25, '2020-06-01', 50.00, 'Cash', 'Complete'), 

(831, 25, '2020-07-01', 50.00, 'Credit Card', 'Complete'), 

(832, 25, '2020-08-01', 50.00, 'Debit Card', 'Complete'), 

(833, 25, '2020-09-01', 50.00, 'MBWay', 'Complete'), 

(834, 25, '2020-10-01', 50.00, 'PayPal', 'Complete'), 

(835, 25, '2020-11-01', 50.00, 'Cash', 'Complete'), 

(836, 25, '2020-12-01', 50.00, 'Credit Card', 'Complete'), 

(837, 25, '2021-01-01', 50.00, 'Debit Card', 'Complete'), 

(838, 25, '2021-02-01', 50.00, 'MBWay', 'Complete'), 

(839, 25, '2021-03-01', 50.00, 'PayPal', 'Complete'), 

(840, 25, '2021-04-01', 50.00, 'Cash', 'Complete'), 

(841, 25, '2021-05-01', 50.00, 'Credit Card', 'Complete'), 

(842, 25, '2021-06-01', 50.00, 'Debit Card', 'Complete'), 

(843, 25, '2021-07-01', 50.00, 'MBWay', 'Complete'), 

(844, 25, '2021-08-01', 50.00, 'PayPal', 'Complete'), 

(845, 25, '2021-09-01', 50.00, 'Cash', 'Complete'), 

(846, 25, '2021-10-01', 50.00, 'Credit Card', 'Complete'), 

(847, 25, '2021-11-01', 50.00, 'Debit Card', 'Complete'), 

(848, 25, '2021-12-01', 50.00, 'MBWay', 'Complete'), 

(849, 25, '2022-01-01', 50.00, 'PayPal', 'Complete'), 

(850, 25, '2022-02-01', 50.00, 'Cash', 'Complete'), 

(851, 25, '2022-03-01', 50.00, 'Credit Card', 'Complete'), 

(852, 25, '2022-04-01', 50.00, 'Debit Card', 'Complete'), 

(853, 25, '2022-05-01', 50.00, 'MBWay', 'Complete'), 

(854, 25, '2022-06-01', 50.00, 'PayPal', 'Complete'), 

(855, 25, '2022-07-01', 50.00, 'Cash', 'Complete'), 

(856, 25, '2022-08-01', 50.00, 'Credit Card', 'Complete'), 

(857, 25, '2022-09-01', 50.00, 'Debit Card', 'Complete'), 

(858, 25, '2022-10-01', 50.00, 'MBWay', 'Complete'), 

(859, 25, '2022-11-01', 50.00, 'PayPal', 'Complete'), 

(860, 25, '2022-12-01', 50.00, 'Cash', 'Complete'), 

(861, 25, '2023-01-01', 50.00, 'Credit Card', 'Complete'), 

(862, 25, '2023-02-01', 50.00, 'Debit Card', 'Complete'), 

(863, 25, '2023-03-01', 50.00, 'MBWay', 'Complete'), 

(864, 25, '2023-04-01', 50.00, 'PayPal', 'Complete'), 

(865, 25, '2023-05-01', 50.00, 'Cash', 'Complete'), 

(866, 25, '2023-06-01', 50.00, 'Credit Card', 'Complete'), 

(867, 25, '2023-07-01', 50.00, 'Debit Card', 'Complete'), 

(868, 25, '2023-08-01', 50.00, 'MBWay', 'Complete'), 

(869, 25, '2023-09-01', 50.00, 'PayPal', 'Complete'), 

(870, 25, '2023-10-01', 50.00, 'Cash', 'Complete'), 

(871, 25, '2023-11-01', 50.00, 'Credit Card', 'Complete'), 

(872, 25, '2023-12-01', 50.00, 'Debit Card', 'Complete'), 

(873, 26, '2021-05-14', 85.00, 'MBWay', 'Complete'), 

(874, 26, '2021-06-14', 85.00, 'PayPal', 'Complete'), 

(875, 26, '2021-07-14', 85.00, 'Cash', 'Complete'), 

(876, 26, '2021-08-14', 85.00, 'Credit Card', 'Complete'), 

(877, 26, '2021-09-14', 85.00, 'Debit Card', 'Complete'), 

(878, 26, '2021-10-14', 85.00, 'MBWay', 'Complete'), 

(879, 26, '2021-11-14', 85.00, 'PayPal', 'Complete'), 

(880, 26, '2021-12-14', 85.00, 'Cash', 'Complete'), 

(881, 26, '2022-01-14', 85.00, 'Credit Card', 'Complete'), 

(882, 26, '2022-02-14', 85.00, 'Debit Card', 'Complete'), 

(883, 26, '2022-03-14', 85.00, 'MBWay', 'Complete'), 

(884, 26, '2022-04-14', 85.00, 'PayPal', 'Complete'), 

(885, 26, '2022-05-14', 85.00, 'Cash', 'Complete'), 

(886, 26, '2022-06-14', 85.00, 'Credit Card', 'Complete'), 

(887, 26, '2022-07-14', 85.00, 'Debit Card', 'Complete'), 

(888, 26, '2022-08-14', 85.00, 'MBWay', 'Complete'), 

(889, 26, '2022-09-14', 85.00, 'PayPal', 'Complete'), 

(890, 26, '2022-10-14', 85.00, 'Cash', 'Complete'), 

(891, 26, '2022-11-14', 85.00, 'Credit Card', 'Complete'), 

(892, 26, '2022-12-14', 85.00, 'Debit Card', 'Complete'), 

(893, 26, '2023-01-14', 85.00, 'MBWay', 'Complete'), 

(894, 26, '2023-02-14', 85.00, 'PayPal', 'Complete'), 

(895, 26, '2023-03-14', 85.00, 'Cash', 'Complete'), 

(896, 26, '2023-04-14', 85.00, 'Credit Card', 'Complete'), 

(897, 26, '2023-05-14', 85.00, 'Debit Card', 'Complete'), 

(898, 26, '2023-06-14', 85.00, 'MBWay', 'Complete'), 

(899, 26, '2023-07-14', 85.00, 'PayPal', 'Complete'), 

(900, 26, '2023-08-14', 85.00, 'Cash', 'Complete'), 

(901, 26, '2023-09-14', 85.00, 'Credit Card', 'Complete'), 

(902, 26, '2023-10-14', 85.00, 'Debit Card', 'Complete'), 

(903, 26, '2023-11-14', 85.00, 'MBWay', 'Complete'), 

(904, 26, '2023-12-14', 85.00, 'PayPal', 'Complete'), 

(905, 27, '2022-09-28', 85.00, 'Cash', 'Complete'), 

(906, 27, '2022-10-28', 85.00, 'Credit Card', 'Complete'), 

(907, 27, '2022-11-28', 85.00, 'Debit Card', 'Complete'), 

(908, 27, '2022-12-28', 85.00, 'MBWay', 'Complete'), 

(909, 27, '2023-01-28', 85.00, 'PayPal', 'Complete'), 

(910, 27, '2023-02-28', 85.00, 'Cash', 'Complete'), 

(911, 27, '2023-03-28', 85.00, 'Credit Card', 'Complete'), 

(912, 27, '2023-04-28', 85.00, 'Debit Card', 'Complete'), 

(913, 27, '2023-05-28', 85.00, 'MBWay', 'Complete'), 

(914, 27, '2023-06-28', 85.00, 'PayPal', 'Complete'), 

(915, 27, '2023-07-28', 85.00, 'Cash', 'Complete'), 

(916, 27, '2023-08-28', 85.00, 'Credit Card', 'Complete'), 

(917, 27, '2023-09-28', 85.00, 'Debit Card', 'Complete'), 

(918, 27, '2023-10-28', 85.00, 'MBWay', 'Complete'), 

(919, 27, '2023-11-28', 85.00, 'PayPal', 'Complete'), 

(920, 27, '2023-12-28', 85.00, 'Cash', 'Not Complete'), 

(921, 28, '2022-01-15', 85.00, 'Credit Card', 'Complete'), 

(922, 28, '2022-02-15', 85.00, 'Debit Card', 'Complete'), 

(923, 28, '2022-03-15', 85.00, 'MBWay', 'Complete'), 

(924, 28, '2022-04-15', 85.00, 'PayPal', 'Complete'), 

(925, 28, '2022-05-15', 85.00, 'Cash', 'Complete'), 

(926, 28, '2022-06-15', 85.00, 'Credit Card', 'Complete'), 

(927, 28, '2022-07-15', 85.00, 'Debit Card', 'Complete'), 

(928, 28, '2022-08-15', 85.00, 'MBWay', 'Complete'), 

(929, 28, '2022-09-15', 85.00, 'PayPal', 'Complete'), 

(930, 28, '2022-10-15', 85.00, 'Cash', 'Complete'), 

(931, 28, '2022-11-15', 85.00, 'Credit Card', 'Complete'), 

(932, 28, '2022-12-15', 85.00, 'Debit Card', 'Complete'), 

(933, 28, '2023-01-15', 85.00, 'MBWay', 'Complete'), 

(934, 28, '2023-02-15', 85.00, 'PayPal', 'Complete'), 

(935, 28, '2023-03-15', 85.00, 'Cash', 'Complete'), 

(936, 28, '2023-04-15', 85.00, 'Credit Card', 'Complete'), 

(937, 28, '2023-05-15', 85.00, 'Debit Card', 'Complete'), 

(938, 28, '2023-06-15', 85.00, 'MBWay', 'Complete'), 

(939, 28, '2023-07-15', 85.00, 'PayPal', 'Complete'), 

(940, 28, '2023-08-15', 85.00, 'Cash', 'Complete'), 

(941, 28, '2023-09-15', 85.00, 'Credit Card', 'Complete'), 

(942, 28, '2023-10-15', 85.00, 'Debit Card', 'Complete'), 

(943, 28, '2023-11-15', 85.00, 'MBWay', 'Complete'), 

(944, 28, '2023-12-15', 85.00, 'PayPal', 'Complete'), 

(945, 29, '2021-04-22', 85.00, 'Cash', 'Complete'), 

(946, 29, '2021-05-22', 85.00, 'Credit Card', 'Complete'), 

(947, 29, '2021-06-22', 85.00, 'Debit Card', 'Complete'), 

(948, 29, '2021-07-22', 85.00, 'MBWay', 'Complete'), 

(949, 29, '2021-08-22', 85.00, 'PayPal', 'Complete'), 

(950, 29, '2021-09-22', 85.00, 'Cash', 'Complete'), 

(951, 29, '2021-10-22', 85.00, 'Credit Card', 'Complete'), 

(952, 29, '2021-11-22', 85.00, 'Debit Card', 'Complete'), 

(953, 29, '2021-12-22', 85.00, 'MBWay', 'Complete'), 

(954, 29, '2022-01-22', 85.00, 'PayPal', 'Complete'), 

(955, 29, '2022-02-22', 85.00, 'Cash', 'Complete'), 

(956, 29, '2022-03-22', 85.00, 'Credit Card', 'Complete'), 

(957, 29, '2022-04-22', 85.00, 'Debit Card', 'Complete'), 

(958, 29, '2022-05-22', 85.00, 'MBWay', 'Complete'), 

(959, 29, '2022-06-22', 85.00, 'PayPal', 'Complete'), 

(960, 29, '2022-07-22', 85.00, 'Cash', 'Complete'), 

(961, 29, '2022-08-22', 85.00, 'Credit Card', 'Complete'), 

(962, 29, '2022-09-22', 85.00, 'Debit Card', 'Complete'), 

(963, 29, '2022-10-22', 85.00, 'MBWay', 'Complete'), 

(964, 29, '2022-11-22', 85.00, 'PayPal', 'Complete'), 

(965, 29, '2022-12-22', 85.00, 'Cash', 'Complete'), 

(966, 29, '2023-01-22', 85.00, 'Credit Card', 'Complete'), 

(967, 29, '2023-02-22', 85.00, 'Debit Card', 'Complete'), 

(968, 29, '2023-03-22', 85.00, 'MBWay', 'Complete'), 

(969, 29, '2023-04-22', 85.00, 'PayPal', 'Complete'), 

(970, 29, '2023-05-22', 85.00, 'Cash', 'Complete'), 

(971, 29, '2023-06-22', 85.00, 'Credit Card', 'Complete'), 

(972, 29, '2023-07-22', 85.00, 'Debit Card', 'Complete'), 

(973, 29, '2023-08-22', 85.00, 'MBWay', 'Complete'), 

(974, 29, '2023-09-22', 85.00, 'PayPal', 'Complete'), 

(975, 29, '2023-10-22', 85.00, 'Cash', 'Complete'), 

(976, 29, '2023-11-22', 85.00, 'Credit Card', 'Complete'), 

(977, 29, '2023-12-22', 85.00, 'Debit Card', 'Not Complete'), 

(978, 30, '2022-02-05', 85.00, 'MBWay', 'Complete'), 

(979, 30, '2022-03-05', 85.00, 'PayPal', 'Complete'), 

(980, 30, '2022-04-05', 85.00, 'Cash', 'Complete'), 

(981, 30, '2022-05-05', 85.00, 'Credit Card', 'Complete'), 

(982, 30, '2022-06-05', 85.00, 'Debit Card', 'Complete'), 

(983, 30, '2022-07-05', 85.00, 'MBWay', 'Complete'), 

(984, 30, '2022-08-05', 85.00, 'PayPal', 'Complete'), 

(985, 30, '2022-09-05', 85.00, 'Cash', 'Complete'), 

(986, 30, '2022-10-05', 85.00, 'Credit Card', 'Complete'), 

(987, 30, '2022-11-05', 85.00, 'Debit Card', 'Complete'), 

(988, 30, '2022-12-05', 85.00, 'MBWay', 'Complete'), 

(989, 30, '2023-01-05', 85.00, 'PayPal', 'Complete'), 

(990, 30, '2023-02-05', 85.00, 'Cash', 'Complete'), 

(991, 30, '2023-03-05', 85.00, 'Credit Card', 'Complete'), 

(992, 30, '2023-04-05', 85.00, 'Debit Card', 'Complete'), 

(993, 30, '2023-05-05', 85.00, 'MBWay', 'Complete'), 

(994, 30, '2023-06-05', 85.00, 'PayPal', 'Complete'), 

(995, 30, '2023-07-05', 85.00, 'Cash', 'Complete'), 

(996, 30, '2023-08-05', 85.00, 'Credit Card', 'Complete'), 

(997, 30, '2023-09-05', 85.00, 'Debit Card', 'Complete'), 

(998, 30, '2023-10-05', 85.00, 'MBWay', 'Complete'), 

(999, 30, '2023-11-05', 85.00, 'PayPal', 'Complete'), 

(1000, 30, '2023-12-05', 85.00, 'Cash', 'Complete'), 

(1001, 31, '2019-08-30', 85.00, 'Credit Card', 'Complete'), 

(1002, 31, '2019-09-30', 85.00, 'Debit Card', 'Complete'), 

(1003, 31, '2019-10-30', 85.00, 'MBWay', 'Complete'), 

(1004, 31, '2019-11-30', 85.00, 'PayPal', 'Complete'), 

(1005, 31, '2019-12-30', 85.00, 'Cash', 'Complete'), 

(1006, 31, '2020-01-30', 85.00, 'Credit Card', 'Complete'), 

(1007, 31, '2020-02-29', 85.00, 'Debit Card', 'Complete'), 

(1008, 31, '2020-03-30', 85.00, 'MBWay', 'Complete'), 

(1009, 31, '2020-04-30', 85.00, 'PayPal', 'Complete'), 

(1010, 31, '2020-05-30', 85.00, 'Cash', 'Complete'), 

(1011, 31, '2020-06-30', 85.00, 'Credit Card', 'Complete'), 

(1012, 31, '2020-07-30', 85.00, 'Debit Card', 'Complete'), 

(1013, 31, '2020-08-30', 85.00, 'MBWay', 'Complete'), 

(1014, 31, '2020-09-30', 85.00, 'PayPal', 'Complete'), 

(1015, 31, '2020-10-30', 85.00, 'Cash', 'Complete'), 

(1016, 31, '2020-11-30', 85.00, 'Credit Card', 'Complete'), 

(1017, 31, '2020-12-30', 85.00, 'Debit Card', 'Complete'), 

(1018, 31, '2021-01-30', 85.00, 'MBWay', 'Complete'), 

(1019, 31, '2021-02-28', 85.00, 'PayPal', 'Complete'), 

(1020, 31, '2021-03-30', 85.00, 'Cash', 'Complete'), 

(1021, 31, '2021-04-30', 85.00, 'Credit Card', 'Complete'), 

(1022, 31, '2021-05-30', 85.00, 'Debit Card', 'Complete'), 

(1023, 31, '2021-06-30', 85.00, 'MBWay', 'Complete'), 

(1024, 31, '2021-07-30', 85.00, 'PayPal', 'Complete'), 

(1025, 31, '2021-08-30', 85.00, 'Cash', 'Complete'), 

(1026, 31, '2021-09-30', 85.00, 'Credit Card', 'Complete'), 

(1027, 31, '2021-10-30', 85.00, 'Debit Card', 'Complete'), 

(1028, 31, '2021-11-30', 85.00, 'MBWay', 'Complete'), 

(1029, 31, '2021-12-30', 85.00, 'PayPal', 'Complete'), 

(1030, 31, '2022-01-30', 85.00, 'Cash', 'Complete'), 

(1031, 31, '2022-02-28', 85.00, 'Credit Card', 'Complete'), 

(1032, 31, '2022-03-30', 85.00, 'Debit Card', 'Complete'), 

(1033, 31, '2022-04-30', 85.00, 'MBWay', 'Complete'), 

(1034, 31, '2022-05-30', 85.00, 'PayPal', 'Complete'), 

(1035, 31, '2022-06-30', 85.00, 'Cash', 'Complete'), 

(1036, 31, '2022-07-30', 85.00, 'Credit Card', 'Complete'), 

(1037, 31, '2022-08-30', 85.00, 'Debit Card', 'Complete'), 

(1038, 31, '2022-09-30', 85.00, 'MBWay', 'Complete'), 

(1039, 31, '2022-10-30', 85.00, 'PayPal', 'Complete'), 

(1040, 31, '2022-11-30', 85.00, 'Cash', 'Complete'), 

(1041, 31, '2022-12-30', 85.00, 'Credit Card', 'Complete'), 

(1042, 31, '2023-01-30', 85.00, 'Debit Card', 'Complete'), 

(1043, 31, '2023-02-28', 85.00, 'MBWay', 'Complete'), 

(1044, 31, '2023-03-30', 85.00, 'PayPal', 'Complete'), 

(1045, 31, '2023-04-30', 85.00, 'Cash', 'Complete'), 

(1046, 31, '2023-05-30', 85.00, 'Credit Card', 'Complete'), 

(1047, 31, '2023-06-30', 85.00, 'Debit Card', 'Complete'), 

(1048, 31, '2023-07-30', 85.00, 'MBWay', 'Complete'), 

(1049, 31, '2023-08-30', 85.00, 'PayPal', 'Complete'), 

(1050, 31, '2023-09-30', 85.00, 'Cash', 'Complete'), 

(1051, 31, '2023-10-30', 85.00, 'Credit Card', 'Complete'), 

(1052, 31, '2023-11-30', 85.00, 'Debit Card', 'Complete'), 

(1053, 31, '2023-12-30', 85.00, 'MBWay', 'Not Complete'), 

(1054, 32, '2022-03-15', 85.00, 'PayPal', 'Complete'), 

(1055, 32, '2022-04-15', 85.00, 'Cash', 'Complete'), 

(1056, 32, '2022-05-15', 85.00, 'Credit Card', 'Complete'), 

(1057, 32, '2022-06-15', 85.00, 'Debit Card', 'Complete'), 

(1058, 32, '2022-07-15', 85.00, 'MBWay', 'Complete'), 

(1059, 32, '2022-08-15', 85.00, 'PayPal', 'Complete'), 

(1060, 32, '2022-09-15', 85.00, 'Cash', 'Complete'), 

(1061, 32, '2022-10-15', 85.00, 'Credit Card', 'Complete'), 

(1062, 32, '2022-11-15', 85.00, 'Debit Card', 'Complete'), 

(1063, 32, '2022-12-15', 85.00, 'MBWay', 'Complete'), 

(1064, 32, '2023-01-15', 85.00, 'PayPal', 'Complete'), 

(1065, 32, '2023-02-15', 85.00, 'Cash', 'Complete'), 

(1066, 32, '2023-03-15', 85.00, 'Credit Card', 'Complete'), 

(1067, 32, '2023-04-15', 85.00, 'Debit Card', 'Complete'), 

(1068, 32, '2023-05-15', 85.00, 'MBWay', 'Complete'), 

(1069, 32, '2023-06-15', 85.00, 'PayPal', 'Complete'), 

(1070, 32, '2023-07-15', 85.00, 'Cash', 'Complete'), 

(1071, 32, '2023-08-15', 85.00, 'Credit Card', 'Complete'), 

(1072, 32, '2023-09-15', 85.00, 'Debit Card', 'Complete'), 

(1073, 32, '2023-10-15', 85.00, 'MBWay', 'Complete'), 

(1074, 32, '2023-11-15', 85.00, 'PayPal', 'Complete'), 

(1075, 32, '2023-12-15', 85.00, 'Cash', 'Complete'), 

(1076, 33, '2019-07-08', 85.00, 'Credit Card', 'Complete'), 

(1077, 33, '2019-08-08', 85.00, 'Debit Card', 'Complete'), 

(1078, 33, '2019-09-08', 85.00, 'MBWay', 'Complete'), 

(1079, 33, '2019-10-08', 85.00, 'PayPal', 'Complete'), 

(1080, 33, '2019-11-08', 85.00, 'Cash', 'Complete'), 

(1081, 33, '2019-12-08', 85.00, 'Credit Card', 'Complete'), 

(1082, 33, '2020-01-08', 85.00, 'Debit Card', 'Complete'), 

(1083, 33, '2020-02-08', 85.00, 'MBWay', 'Complete'), 

(1084, 33, '2020-03-08', 85.00, 'PayPal', 'Complete'), 

(1085, 33, '2020-04-08', 85.00, 'Cash', 'Complete'), 

(1086, 33, '2020-05-08', 85.00, 'Credit Card', 'Complete'), 

(1087, 33, '2020-06-08', 85.00, 'Debit Card', 'Complete'), 

(1088, 33, '2020-07-08', 85.00, 'MBWay', 'Complete'), 

(1089, 33, '2020-08-08', 85.00, 'PayPal', 'Complete'), 

(1090, 33, '2020-09-08', 85.00, 'Cash', 'Complete'), 

(1091, 33, '2020-10-08', 85.00, 'Credit Card', 'Complete'), 

(1092, 33, '2020-11-08', 85.00, 'Debit Card', 'Complete'), 

(1093, 33, '2020-12-08', 85.00, 'MBWay', 'Complete'), 

(1094, 33, '2021-01-08', 85.00, 'PayPal', 'Complete'), 

(1095, 33, '2021-02-08', 85.00, 'Cash', 'Complete'), 

(1096, 33, '2021-03-08', 85.00, 'Credit Card', 'Complete'), 

(1097, 33, '2021-04-08', 85.00, 'Debit Card', 'Complete'), 

(1098, 33, '2021-05-08', 85.00, 'MBWay', 'Complete'), 

(1099, 33, '2021-06-08', 85.00, 'PayPal', 'Complete'), 

(1100, 33, '2021-07-08', 85.00, 'Cash', 'Complete'), 

(1101, 33, '2021-08-08', 85.00, 'Credit Card', 'Complete'), 

(1102, 33, '2021-09-08', 85.00, 'Debit Card', 'Complete'), 

(1103, 33, '2021-10-08', 85.00, 'MBWay', 'Complete'), 

(1104, 33, '2021-11-08', 85.00, 'PayPal', 'Complete'), 

(1105, 33, '2021-12-08', 85.00, 'Cash', 'Complete'), 

(1106, 33, '2022-01-08', 85.00, 'Credit Card', 'Complete'), 

(1107, 33, '2022-02-08', 85.00, 'Debit Card', 'Complete'), 

(1108, 33, '2022-03-08', 85.00, 'MBWay', 'Complete'), 

(1109, 33, '2022-04-08', 85.00, 'PayPal', 'Complete'), 

(1110, 33, '2022-05-08', 85.00, 'Cash', 'Complete'), 

(1111, 33, '2022-06-08', 85.00, 'Credit Card', 'Complete'), 

(1112, 33, '2022-07-08', 85.00, 'Debit Card', 'Complete'), 

(1113, 33, '2022-08-08', 85.00, 'MBWay', 'Complete'), 

(1114, 33, '2022-09-08', 85.00, 'PayPal', 'Complete'), 

(1115, 33, '2022-10-08', 85.00, 'Cash', 'Complete'), 

(1116, 33, '2022-11-08', 85.00, 'Credit Card', 'Complete'), 

(1117, 33, '2022-12-08', 85.00, 'Debit Card', 'Complete'), 

(1118, 33, '2023-01-08', 85.00, 'MBWay', 'Complete'), 

(1119, 33, '2023-02-08', 85.00, 'PayPal', 'Complete'), 

(1120, 33, '2023-03-08', 85.00, 'Cash', 'Complete'), 

(1121, 33, '2023-04-08', 85.00, 'Credit Card', 'Complete'), 

(1122, 33, '2023-05-08', 85.00, 'Debit Card', 'Complete'), 

(1123, 33, '2023-06-08', 85.00, 'MBWay', 'Complete'), 

(1124, 33, '2023-07-08', 85.00, 'PayPal', 'Complete'), 

(1125, 33, '2023-08-08', 85.00, 'Cash', 'Complete'), 

(1126, 33, '2023-09-08', 85.00, 'Credit Card', 'Complete'), 

(1127, 33, '2023-10-08', 85.00, 'Debit Card', 'Complete'), 

(1128, 33, '2023-11-08', 85.00, 'MBWay', 'Complete'), 

(1129, 33, '2023-12-08', 85.00, 'PayPal', 'Complete'), 

(1130, 34, '2019-11-15', 85.00, 'Cash', 'Complete'), 

(1131, 34, '2019-12-15', 85.00, 'Credit Card', 'Complete'), 

(1132, 34, '2020-01-15', 85.00, 'Debit Card', 'Complete'), 

(1133, 34, '2020-02-15', 85.00, 'MBWay', 'Complete'), 

(1134, 34, '2020-03-15', 85.00, 'PayPal', 'Complete'), 

(1135, 34, '2020-04-15', 85.00, 'Cash', 'Complete'), 

(1136, 34, '2020-05-15', 85.00, 'Credit Card', 'Complete'), 

(1137, 34, '2020-06-15', 85.00, 'Debit Card', 'Complete'), 

(1138, 34, '2020-07-15', 85.00, 'MBWay', 'Complete'), 

(1139, 34, '2020-08-15', 85.00, 'PayPal', 'Complete'), 

(1140, 34, '2020-09-15', 85.00, 'Cash', 'Complete'), 

(1141, 34, '2020-10-15', 85.00, 'Credit Card', 'Complete'), 

(1142, 34, '2020-11-15', 85.00, 'Debit Card', 'Complete'), 

(1143, 34, '2020-12-15', 85.00, 'MBWay', 'Complete'), 

(1144, 34, '2021-01-15', 85.00, 'PayPal', 'Complete'), 

(1145, 34, '2021-02-15', 85.00, 'Cash', 'Complete'), 

(1146, 34, '2021-03-15', 85.00, 'Credit Card', 'Complete'), 

(1147, 34, '2021-04-15', 85.00, 'Debit Card', 'Complete'), 

(1148, 34, '2021-05-15', 85.00, 'MBWay', 'Complete'), 

(1149, 34, '2021-06-15', 85.00, 'PayPal', 'Complete'), 

(1150, 34, '2021-07-15', 85.00, 'Cash', 'Complete'), 

(1151, 34, '2021-08-15', 85.00, 'Credit Card', 'Complete'), 

(1152, 34, '2021-09-15', 85.00, 'Debit Card', 'Complete'), 

(1153, 34, '2021-10-15', 85.00, 'MBWay', 'Complete'), 

(1154, 34, '2021-11-15', 85.00, 'PayPal', 'Complete'), 

(1155, 34, '2021-12-15', 85.00, 'Cash', 'Complete'), 

(1156, 34, '2022-01-15', 85.00, 'Credit Card', 'Complete'), 

(1157, 34, '2022-02-15', 85.00, 'Debit Card', 'Complete'), 

(1158, 34, '2022-03-15', 85.00, 'MBWay', 'Complete'), 

(1159, 34, '2022-04-15', 85.00, 'PayPal', 'Complete'), 

(1160, 34, '2022-05-15', 85.00, 'Cash', 'Complete'), 

(1161, 34, '2022-06-15', 85.00, 'Credit Card', 'Complete'), 

(1162, 34, '2022-07-15', 85.00, 'Debit Card', 'Complete'), 

(1163, 34, '2022-08-15', 85.00, 'MBWay', 'Complete'), 

(1164, 34, '2022-09-15', 85.00, 'PayPal', 'Complete'), 

(1165, 34, '2022-10-15', 85.00, 'Cash', 'Complete'), 

(1166, 34, '2022-11-15', 85.00, 'Credit Card', 'Complete'), 

(1167, 34, '2022-12-15', 85.00, 'Debit Card', 'Complete'), 

(1168, 34, '2023-01-15', 85.00, 'MBWay', 'Complete'), 

(1169, 34, '2023-02-15', 85.00, 'PayPal', 'Complete'), 

(1170, 34, '2023-03-15', 85.00, 'Cash', 'Complete'), 

(1171, 34, '2023-04-15', 85.00, 'Credit Card', 'Complete'), 

(1172, 34, '2023-05-15', 85.00, 'Debit Card', 'Complete'), 

(1173, 34, '2023-06-15', 85.00, 'MBWay', 'Complete'), 

(1174, 34, '2023-07-15', 85.00, 'PayPal', 'Complete'), 

(1175, 34, '2023-08-15', 85.00, 'Cash', 'Complete'), 

(1176, 34, '2023-09-15', 85.00, 'Credit Card', 'Complete'), 

(1177, 34, '2023-10-15', 85.00, 'Debit Card', 'Complete'), 

(1178, 34, '2023-11-15', 85.00, 'MBWay', 'Complete'), 

(1179, 34, '2023-12-15', 85.00, 'PayPal', 'Complete'), 

(1180, 35, '2019-05-01', 85.00, 'Cash', 'Complete'), 

(1181, 35, '2019-06-01', 85.00, 'Credit Card', 'Complete'), 

(1182, 35, '2019-07-01', 85.00, 'Debit Card', 'Complete'), 

(1183, 35, '2019-08-01', 85.00, 'MBWay', 'Complete'), 

(1184, 35, '2019-09-01', 85.00, 'PayPal', 'Complete'), 

(1185, 35, '2019-10-01', 85.00, 'Cash', 'Complete'), 

(1186, 35, '2019-11-01', 85.00, 'Credit Card', 'Complete'), 

(1187, 35, '2019-12-01', 85.00, 'Debit Card', 'Complete'), 

(1188, 35, '2020-01-01', 85.00, 'MBWay', 'Complete'), 

(1189, 35, '2020-02-01', 85.00, 'PayPal', 'Complete'), 

(1190, 35, '2020-03-01', 85.00, 'Cash', 'Complete'), 

(1191, 35, '2020-04-01', 85.00, 'Credit Card', 'Complete'), 

(1192, 35, '2020-05-01', 85.00, 'Debit Card', 'Complete'), 

(1193, 35, '2020-06-01', 85.00, 'MBWay', 'Complete'), 

(1194, 35, '2020-07-01', 85.00, 'PayPal', 'Complete'), 

(1195, 35, '2020-08-01', 85.00, 'Cash', 'Complete'), 

(1196, 35, '2020-09-01', 85.00, 'Credit Card', 'Complete'), 

(1197, 35, '2020-10-01', 85.00, 'Debit Card', 'Complete'), 

(1198, 35, '2020-11-01', 85.00, 'MBWay', 'Complete'), 

(1199, 35, '2020-12-01', 85.00, 'PayPal', 'Complete'), 

(1200, 35, '2021-01-01', 85.00, 'Cash', 'Complete'), 

(1201, 35, '2021-02-01', 85.00, 'Credit Card', 'Complete'), 

(1202, 35, '2021-03-01', 85.00, 'Debit Card', 'Complete'), 

(1203, 35, '2021-04-01', 85.00, 'MBWay', 'Complete'), 

(1204, 35, '2021-05-01', 85.00, 'PayPal', 'Complete'), 

(1205, 35, '2021-06-01', 85.00, 'Cash', 'Complete'), 

(1206, 35, '2021-07-01', 85.00, 'Credit Card', 'Complete'), 

(1207, 35, '2021-08-01', 85.00, 'Debit Card', 'Complete'), 

(1208, 35, '2021-09-01', 85.00, 'MBWay', 'Complete'), 

(1209, 35, '2021-10-01', 85.00, 'PayPal', 'Complete'), 

(1210, 35, '2021-11-01', 85.00, 'Cash', 'Complete'), 

(1211, 35, '2021-12-01', 85.00, 'Credit Card', 'Complete'), 

(1212, 35, '2022-01-01', 85.00, 'Debit Card', 'Complete'), 

(1213, 35, '2022-02-01', 85.00, 'MBWay', 'Complete'), 

(1214, 35, '2022-03-01', 85.00, 'PayPal', 'Complete'), 

(1215, 35, '2022-04-01', 85.00, 'Cash', 'Complete'), 

(1216, 35, '2022-05-01', 85.00, 'Credit Card', 'Complete'), 

(1217, 35, '2022-06-01', 85.00, 'Debit Card', 'Complete'), 

(1218, 35, '2022-07-01', 85.00, 'MBWay', 'Complete'), 

(1219, 35, '2022-08-01', 85.00, 'PayPal', 'Complete'), 

(1220, 35, '2022-09-01', 85.00, 'Cash', 'Complete'), 

(1221, 35, '2022-10-01', 85.00, 'Credit Card', 'Complete'), 

(1222, 35, '2022-11-01', 85.00, 'Debit Card', 'Complete'), 

(1223, 35, '2022-12-01', 85.00, 'MBWay', 'Complete'), 

(1224, 35, '2023-01-01', 85.00, 'PayPal', 'Complete'), 

(1225, 35, '2023-02-01', 85.00, 'Cash', 'Complete'), 

(1226, 35, '2023-03-01', 85.00, 'Credit Card', 'Complete'), 

(1227, 35, '2023-04-01', 85.00, 'Debit Card', 'Complete'), 

(1228, 35, '2023-05-01', 85.00, 'MBWay', 'Complete'), 

(1229, 35, '2023-06-01', 85.00, 'PayPal', 'Complete'), 

(1230, 35, '2023-07-01', 85.00, 'Cash', 'Complete'), 

(1231, 35, '2023-08-01', 85.00, 'Credit Card', 'Complete'), 

(1232, 35, '2023-09-01', 85.00, 'Debit Card', 'Complete'), 

(1233, 35, '2023-10-01', 85.00, 'MBWay', 'Complete'), 

(1234, 35, '2023-11-01', 85.00, 'PayPal', 'Complete'), 

(1235, 35, '2023-12-01', 85.00, 'Cash', 'Complete'), 

(1236, 36, '2021-06-14', 80.00, 'Credit Card', 'Complete'), 

(1237, 36, '2021-07-14', 80.00, 'Debit Card', 'Complete'), 

(1238, 36, '2021-08-14', 80.00, 'MBWay', 'Complete'), 

(1239, 36, '2021-09-14', 80.00, 'PayPal', 'Complete'), 

(1240, 36, '2021-10-14', 80.00, 'Cash', 'Complete'), 

(1241, 36, '2021-11-14', 80.00, 'Credit Card', 'Complete'), 

(1242, 36, '2021-12-14', 80.00, 'Debit Card', 'Complete'), 

(1243, 36, '2022-01-14', 80.00, 'MBWay', 'Complete'), 

(1244, 36, '2022-02-14', 80.00, 'PayPal', 'Complete'), 

(1245, 36, '2022-03-14', 80.00, 'Cash', 'Complete'), 

(1246, 36, '2022-04-14', 80.00, 'Credit Card', 'Complete'), 

(1247, 36, '2022-05-14', 80.00, 'Debit Card', 'Complete'), 

(1248, 36, '2022-06-14', 80.00, 'MBWay', 'Complete'), 

(1249, 36, '2022-07-14', 80.00, 'PayPal', 'Complete'), 

(1250, 36, '2022-08-14', 80.00, 'Cash', 'Complete'), 

(1251, 36, '2022-09-14', 80.00, 'Credit Card', 'Complete'), 

(1252, 36, '2022-10-14', 80.00, 'Debit Card', 'Complete'), 

(1253, 36, '2022-11-14', 80.00, 'MBWay', 'Complete'), 

(1254, 36, '2022-12-14', 80.00, 'PayPal', 'Complete'), 

(1255, 36, '2023-01-14', 80.00, 'Cash', 'Complete'), 

(1256, 36, '2023-02-14', 80.00, 'Credit Card', 'Complete'), 

(1257, 36, '2023-03-14', 80.00, 'Debit Card', 'Complete'), 

(1258, 36, '2023-04-14', 80.00, 'MBWay', 'Complete'), 

(1259, 36, '2023-05-14', 80.00, 'PayPal', 'Complete'), 

(1260, 36, '2023-06-14', 80.00, 'Cash', 'Complete'), 

(1261, 36, '2023-07-14', 80.00, 'Credit Card', 'Complete'), 

(1262, 36, '2023-08-14', 80.00, 'Debit Card', 'Complete'), 

(1263, 36, '2023-09-14', 80.00, 'MBWay', 'Complete'), 

(1264, 36, '2023-10-14', 80.00, 'PayPal', 'Complete'), 

(1265, 36, '2023-11-14', 80.00, 'Cash', 'Complete'), 

(1266, 36, '2023-12-14', 80.00, 'Credit Card', 'Complete'), 

(1267, 37, '2022-10-18', 80.00, 'Debit Card', 'Complete'), 

(1268, 37, '2022-11-18', 80.00, 'MBWay', 'Complete'), 

(1269, 37, '2022-12-18', 80.00, 'PayPal', 'Complete'), 

(1270, 37, '2023-01-18', 80.00, 'Cash', 'Complete'), 

(1271, 37, '2023-02-18', 80.00, 'Credit Card', 'Complete'), 

(1272, 37, '2023-03-18', 80.00, 'Debit Card', 'Complete'), 

(1273, 37, '2023-04-18', 80.00, 'MBWay', 'Complete'), 

(1274, 37, '2023-05-18', 80.00, 'PayPal', 'Complete'), 

(1275, 37, '2023-06-18', 80.00, 'Cash', 'Complete'), 

(1276, 37, '2023-07-18', 80.00, 'Credit Card', 'Complete'), 

(1277, 37, '2023-08-18', 80.00, 'Debit Card', 'Complete'), 

(1278, 37, '2023-09-18', 80.00, 'MBWay', 'Complete'), 

(1279, 37, '2023-10-18', 80.00, 'PayPal', 'Complete'), 

(1280, 37, '2023-11-18', 80.00, 'Cash', 'Complete'), 

(1281, 37, '2023-12-18', 80.00, 'Credit Card', 'Not Complete'), 

(1282, 38, '2022-02-15', 80.00, 'Debit Card', 'Complete'), 

(1283, 38, '2022-03-15', 80.00, 'MBWay', 'Complete'), 

(1284, 38, '2022-04-15', 80.00, 'PayPal', 'Complete'), 

(1285, 38, '2022-05-15', 80.00, 'Cash', 'Complete'), 

(1286, 38, '2022-06-15', 80.00, 'Credit Card', 'Complete'), 

(1287, 38, '2022-07-15', 80.00, 'Debit Card', 'Complete'), 

(1288, 38, '2022-08-15', 80.00, 'MBWay', 'Complete'), 

(1289, 38, '2022-09-15', 80.00, 'PayPal', 'Complete'), 

(1290, 38, '2022-10-15', 80.00, 'Cash', 'Complete'), 

(1291, 38, '2022-11-15', 80.00, 'Credit Card', 'Complete'), 

(1292, 38, '2022-12-15', 80.00, 'Debit Card', 'Complete'), 

(1293, 38, '2023-01-15', 80.00, 'MBWay', 'Complete'), 

(1294, 38, '2023-02-15', 80.00, 'PayPal', 'Complete'), 

(1295, 38, '2023-03-15', 80.00, 'Cash', 'Complete'), 

(1296, 38, '2023-04-15', 80.00, 'Credit Card', 'Complete'), 

(1297, 38, '2023-05-15', 80.00, 'Debit Card', 'Complete'), 

(1298, 38, '2023-06-15', 80.00, 'MBWay', 'Complete'), 

(1299, 38, '2023-07-15', 80.00, 'PayPal', 'Complete'), 

(1300, 38, '2023-08-15', 80.00, 'Cash', 'Complete'), 

(1301, 38, '2023-09-15', 80.00, 'Credit Card', 'Complete'), 

(1302, 38, '2023-10-15', 80.00, 'Debit Card', 'Complete'), 

(1303, 38, '2023-11-15', 80.00, 'MBWay', 'Complete'), 

(1304, 38, '2023-12-15', 80.00, 'PayPal', 'Complete'), 

(1305, 39, '2021-05-22', 80.00, 'Cash', 'Complete'), 

(1306, 39, '2021-06-22', 80.00, 'Credit Card', 'Complete'), 

(1307, 39, '2021-07-22', 80.00, 'Debit Card', 'Complete'), 

(1308, 39, '2021-08-22', 80.00, 'MBWay', 'Complete'), 

(1309, 39, '2021-09-22', 80.00, 'PayPal', 'Complete'), 

(1310, 39, '2021-10-22', 80.00, 'Cash', 'Complete'), 

(1311, 39, '2021-11-22', 80.00, 'Credit Card', 'Complete'), 

(1312, 39, '2021-12-22', 80.00, 'Debit Card', 'Complete'), 

(1313, 39, '2022-01-22', 80.00, 'MBWay', 'Complete'), 

(1314, 39, '2022-02-22', 80.00, 'PayPal', 'Complete'), 

(1315, 39, '2022-03-22', 80.00, 'Cash', 'Complete'), 

(1316, 39, '2022-04-22', 80.00, 'Credit Card', 'Complete'), 

(1317, 39, '2022-05-22', 80.00, 'Debit Card', 'Complete'), 

(1318, 39, '2022-06-22', 80.00, 'MBWay', 'Complete'), 

(1319, 39, '2022-07-22', 80.00, 'PayPal', 'Complete'), 

(1320, 39, '2022-08-22', 80.00, 'Cash', 'Complete'), 

(1321, 39, '2022-09-22', 80.00, 'Credit Card', 'Complete'), 

(1322, 39, '2022-10-22', 80.00, 'Debit Card', 'Complete'), 

(1323, 39, '2022-11-22', 80.00, 'MBWay', 'Complete'), 

(1324, 39, '2022-12-22', 80.00, 'PayPal', 'Complete'), 

(1325, 39, '2023-01-22', 80.00, 'Cash', 'Complete'), 

(1326, 39, '2023-02-22', 80.00, 'Credit Card', 'Complete'), 

(1327, 39, '2023-03-22', 80.00, 'Debit Card', 'Complete'), 

(1328, 39, '2023-04-22', 80.00, 'MBWay', 'Complete'), 

(1329, 39, '2023-05-22', 80.00, 'PayPal', 'Complete'), 

(1330, 39, '2023-06-22', 80.00, 'Cash', 'Complete'), 

(1331, 39, '2023-07-22', 80.00, 'Credit Card', 'Complete'), 

(1332, 39, '2023-08-22', 80.00, 'Debit Card', 'Complete'), 

(1333, 39, '2023-09-22', 80.00, 'MBWay', 'Complete'), 

(1334, 39, '2023-10-22', 80.00, 'PayPal', 'Complete'), 

(1335, 39, '2023-11-22', 80.00, 'Cash', 'Complete'), 

(1336, 39, '2023-12-22', 80.00, 'Credit Card', 'Not Complete'), 

(1337, 40, '2022-02-05', 80.00, 'Debit Card', 'Complete'), 

(1338, 40, '2022-03-05', 80.00, 'MBWay', 'Complete'), 

(1339, 40, '2022-04-05', 80.00, 'PayPal', 'Complete'), 

(1340, 40, '2022-05-05', 80.00, 'Cash', 'Complete'), 

(1341, 40, '2022-06-05', 80.00, 'Credit Card', 'Complete'), 

(1342, 40, '2022-07-05', 80.00, 'Debit Card', 'Complete'), 

(1343, 40, '2022-08-05', 80.00, 'MBWay', 'Complete'), 

(1344, 40, '2022-09-05', 80.00, 'PayPal', 'Complete'), 

(1345, 40, '2022-10-05', 80.00, 'Cash', 'Complete'), 

(1346, 40, '2022-11-05', 80.00, 'Credit Card', 'Complete'), 

(1347, 40, '2022-12-05', 80.00, 'Debit Card', 'Complete'), 

(1348, 40, '2023-01-05', 80.00, 'MBWay', 'Complete'), 

(1349, 40, '2023-02-05', 80.00, 'PayPal', 'Complete'), 

(1350, 40, '2023-03-05', 80.00, 'Cash', 'Complete'), 

(1351, 40, '2023-04-05', 80.00, 'Credit Card', 'Complete'), 

(1352, 40, '2023-05-05', 80.00, 'Debit Card', 'Complete'), 

(1353, 40, '2023-06-05', 80.00, 'MBWay', 'Complete'), 

(1354, 40, '2023-07-05', 80.00, 'PayPal', 'Complete'), 

(1355, 40, '2023-08-05', 80.00, 'Cash', 'Complete'), 

(1356, 40, '2023-09-05', 80.00, 'Credit Card', 'Complete'), 

(1357, 40, '2023-10-05', 80.00, 'Debit Card', 'Complete'), 

(1358, 40, '2023-11-05', 80.00, 'MBWay', 'Complete'), 

(1359, 40, '2023-12-05', 80.00, 'PayPal', 'Complete'), 

(1360, 41, '2021-08-30', 80.00, 'Cash', 'Complete'), 

(1361, 41, '2021-09-30', 80.00, 'Credit Card', 'Complete'), 

(1362, 41, '2021-10-30', 80.00, 'Debit Card', 'Complete'), 

(1363, 41, '2021-11-30', 80.00, 'MBWay', 'Complete'), 

(1364, 41, '2021-12-30', 80.00, 'PayPal', 'Complete'), 

(1365, 41, '2022-01-30', 80.00, 'Cash', 'Complete'), 

(1366, 41, '2022-02-28', 80.00, 'Credit Card', 'Complete'), 

(1367, 41, '2022-03-30', 80.00, 'Debit Card', 'Complete'), 

(1368, 41, '2022-04-30', 80.00, 'MBWay', 'Complete'), 

(1369, 41, '2022-05-30', 80.00, 'PayPal', 'Complete'), 

(1370, 41, '2022-06-30', 80.00, 'Cash', 'Complete'), 

(1371, 41, '2022-07-30', 80.00, 'Credit Card', 'Complete'), 

(1372, 41, '2022-08-30', 80.00, 'Debit Card', 'Complete'), 

(1373, 41, '2022-09-30', 80.00, 'MBWay', 'Complete'), 

(1374, 41, '2022-10-30', 80.00, 'PayPal', 'Complete'), 

(1375, 41, '2022-11-30', 80.00, 'Cash', 'Complete'), 

(1376, 41, '2022-12-30', 80.00, 'Credit Card', 'Complete'), 

(1377, 41, '2023-01-30', 80.00, 'Debit Card', 'Complete'), 

(1378, 41, '2023-02-28', 80.00, 'MBWay', 'Complete'), 

(1379, 41, '2023-03-30', 80.00, 'PayPal', 'Complete'), 

(1380, 41, '2023-04-30', 80.00, 'Cash', 'Complete'), 

(1381, 41, '2023-05-30', 80.00, 'Credit Card', 'Complete'), 

(1382, 41, '2023-06-30', 80.00, 'Debit Card', 'Complete'), 

(1383, 41, '2023-07-30', 80.00, 'MBWay', 'Complete'), 

(1384, 41, '2023-08-30', 80.00, 'PayPal', 'Complete'), 

(1385, 41, '2023-09-30', 80.00, 'Cash', 'Complete'), 

(1386, 41, '2023-10-30', 80.00, 'Credit Card', 'Complete'), 

(1387, 41, '2023-11-30', 80.00, 'Debit Card', 'Complete'), 

(1388, 41, '2023-12-30', 80.00, 'MBWay', 'Not Complete'), 

(1389, 42, '2022-03-15', 80.00, 'PayPal', 'Complete'), 

(1390, 42, '2022-04-15', 80.00, 'Cash', 'Complete'), 

(1391, 42, '2022-05-15', 80.00, 'Credit Card', 'Complete'), 

(1392, 42, '2022-06-15', 80.00, 'Debit Card', 'Complete'), 

(1393, 42, '2022-07-15', 80.00, 'MBWay', 'Complete'), 

(1394, 42, '2022-08-15', 80.00, 'PayPal', 'Complete'), 

(1395, 42, '2022-09-15', 80.00, 'Cash', 'Complete'), 

(1396, 42, '2022-10-15', 80.00, 'Credit Card', 'Complete'), 

(1397, 42, '2022-11-15', 80.00, 'Debit Card', 'Complete'), 

(1398, 42, '2022-12-15', 80.00, 'MBWay', 'Complete'), 

(1399, 42, '2023-01-15', 80.00, 'PayPal', 'Complete'), 

(1400, 42, '2023-02-15', 80.00, 'Cash', 'Complete'), 

(1401, 42, '2023-03-15', 80.00, 'Credit Card', 'Complete'), 

(1402, 42, '2023-04-15', 80.00, 'Debit Card', 'Complete'), 

(1403, 42, '2023-05-15', 80.00, 'MBWay', 'Complete'), 

(1404, 42, '2023-06-15', 80.00, 'PayPal', 'Complete'), 

(1405, 42, '2023-07-15', 80.00, 'Cash', 'Complete'), 

(1406, 42, '2023-08-15', 80.00, 'Credit Card', 'Complete'), 

(1407, 42, '2023-09-15', 80.00, 'Debit Card', 'Complete'), 

(1408, 42, '2023-10-15', 80.00, 'MBWay', 'Complete'), 

(1409, 42, '2023-11-15', 80.00, 'PayPal', 'Complete'), 

(1410, 42, '2023-12-15', 80.00, 'Cash', 'Complete'), 

(1411, 43, '2022-07-08', 80.00, 'Credit Card', 'Complete'), 

(1412, 43, '2022-08-08', 80.00, 'Debit Card', 'Complete'), 

(1413, 43, '2022-09-08', 80.00, 'MBWay', 'Complete'), 

(1414, 43, '2022-10-08', 80.00, 'PayPal', 'Complete'), 

(1415, 43, '2022-11-08', 80.00, 'Cash', 'Complete'), 

(1416, 43, '2022-12-08', 80.00, 'Credit Card', 'Complete'), 

(1417, 43, '2023-01-08', 80.00, 'Debit Card', 'Complete'), 

(1418, 43, '2023-02-08', 80.00, 'MBWay', 'Complete'), 

(1419, 43, '2023-03-08', 80.00, 'PayPal', 'Complete'), 

(1420, 43, '2023-04-08', 80.00, 'Cash', 'Complete'), 

(1421, 43, '2023-05-08', 80.00, 'Credit Card', 'Complete'), 

(1422, 43, '2023-06-08', 80.00, 'Debit Card', 'Complete'), 

(1423, 43, '2023-07-08', 80.00, 'MBWay', 'Complete'), 

(1424, 43, '2023-08-08', 80.00, 'PayPal', 'Complete'), 

(1425, 43, '2023-09-08', 80.00, 'Cash', 'Complete'), 

(1426, 43, '2023-10-08', 80.00, 'Credit Card', 'Complete'), 

(1427, 43, '2023-11-08', 80.00, 'Debit Card', 'Complete'), 

(1428, 43, '2023-12-08', 80.00, 'MBWay', 'Complete'), 

(1429, 44, '2021-11-15', 80.00, 'PayPal', 'Complete'), 

(1430, 44, '2021-12-15', 80.00, 'Cash', 'Complete'), 

(1431, 44, '2022-01-15', 80.00, 'Credit Card', 'Complete'), 

(1432, 44, '2022-02-15', 80.00, 'Debit Card', 'Complete'), 

(1433, 44, '2022-03-15', 80.00, 'MBWay', 'Complete'), 

(1434, 44, '2022-04-15', 80.00, 'PayPal', 'Complete'), 

(1435, 44, '2022-05-15', 80.00, 'Cash', 'Complete'), 

(1436, 44, '2022-06-15', 80.00, 'Credit Card', 'Complete'), 

(1437, 44, '2022-07-15', 80.00, 'Debit Card', 'Complete'), 

(1438, 44, '2022-08-15', 80.00, 'MBWay', 'Complete'), 

(1439, 44, '2022-09-15', 80.00, 'PayPal', 'Complete'), 

(1440, 44, '2022-10-15', 80.00, 'Cash', 'Complete'), 

(1441, 44, '2022-11-15', 80.00, 'Credit Card', 'Complete'), 

(1442, 44, '2022-12-15', 80.00, 'Debit Card', 'Complete'), 

(1443, 44, '2023-01-15', 80.00, 'MBWay', 'Complete'), 

(1444, 44, '2023-02-15', 80.00, 'PayPal', 'Complete'), 

(1445, 44, '2023-03-15', 80.00, 'Cash', 'Complete'), 

(1446, 44, '2023-04-15', 80.00, 'Credit Card', 'Complete'), 

(1447, 44, '2023-05-15', 80.00, 'Debit Card', 'Complete'), 

(1448, 44, '2023-06-15', 80.00, 'MBWay', 'Complete'), 

(1449, 44, '2023-07-15', 80.00, 'PayPal', 'Complete'), 

(1450, 44, '2023-08-15', 80.00, 'Cash', 'Complete'), 

(1451, 44, '2023-09-15', 80.00, 'Credit Card', 'Complete'), 

(1452, 44, '2023-10-15', 80.00, 'Debit Card', 'Complete'), 

(1453, 44, '2023-11-15', 80.00, 'MBWay', 'Complete'), 

(1454, 44, '2023-12-15', 80.00, 'PayPal', 'Complete'), 

(1455, 45, '2022-05-01', 80.00, 'Cash', 'Complete'), 

(1456, 45, '2022-06-01', 80.00, 'Credit Card', 'Complete'), 

(1457, 45, '2022-07-01', 80.00, 'Debit Card', 'Complete'), 

(1458, 45, '2022-08-01', 80.00, 'MBWay', 'Complete'), 

(1459, 45, '2022-09-01', 80.00, 'PayPal', 'Complete'), 

(1460, 45, '2022-10-01', 80.00, 'Cash', 'Complete'), 

(1461, 45, '2022-11-01', 80.00, 'Credit Card', 'Complete'), 

(1462, 45, '2022-12-01', 80.00, 'Debit Card', 'Complete'), 

(1463, 45, '2023-01-01', 80.00, 'MBWay', 'Complete'), 

(1464, 45, '2023-02-01', 80.00, 'PayPal', 'Complete'), 

(1465, 45, '2023-03-01', 80.00, 'Cash', 'Complete'), 

(1466, 45, '2023-04-01', 80.00, 'Credit Card', 'Complete'), 

(1467, 45, '2023-05-01', 80.00, 'Debit Card', 'Complete'), 

(1468, 45, '2023-06-01', 80.00, 'MBWay', 'Complete'), 

(1469, 45, '2023-07-01', 80.00, 'PayPal', 'Complete'), 

(1470, 45, '2023-08-01', 80.00, 'Cash', 'Complete'), 

(1471, 45, '2023-09-01', 80.00, 'Credit Card', 'Complete'), 

(1472, 45, '2023-10-01', 80.00, 'Debit Card', 'Complete'), 

(1473, 45, '2023-11-01', 80.00, 'MBWay', 'Complete'), 

(1474, 45, '2023-12-01', 80.00, 'PayPal', 'Complete'), 

(1475, 46, '2021-06-14', 80.00, 'Cash', 'Complete'), 

(1476, 46, '2021-07-14', 80.00, 'Credit Card', 'Complete'), 

(1477, 46, '2021-08-14', 80.00, 'Debit Card', 'Complete'), 

(1478, 46, '2021-09-14', 80.00, 'MBWay', 'Complete'), 

(1479, 46, '2021-10-14', 80.00, 'PayPal', 'Complete'), 

(1480, 46, '2021-11-14', 80.00, 'Cash', 'Complete'), 

(1481, 46, '2021-12-14', 80.00, 'Credit Card', 'Complete'), 

(1482, 46, '2022-01-14', 80.00, 'Debit Card', 'Complete'), 

(1483, 46, '2022-02-14', 80.00, 'MBWay', 'Complete'), 

(1484, 46, '2022-03-14', 80.00, 'PayPal', 'Complete'), 

(1485, 46, '2022-04-14', 80.00, 'Cash', 'Complete'), 

(1486, 46, '2022-05-14', 80.00, 'Credit Card', 'Complete'), 

(1487, 46, '2022-06-14', 80.00, 'Debit Card', 'Complete'), 

(1488, 46, '2022-07-14', 80.00, 'MBWay', 'Complete'), 

(1489, 46, '2022-08-14', 80.00, 'PayPal', 'Complete'), 

(1490, 46, '2022-09-14', 80.00, 'Cash', 'Complete'), 

(1491, 46, '2022-10-14', 80.00, 'Credit Card', 'Complete'), 

(1492, 46, '2022-11-14', 80.00, 'Debit Card', 'Complete'), 

(1493, 46, '2022-12-14', 80.00, 'MBWay', 'Complete'), 

(1494, 46, '2023-01-14', 80.00, 'PayPal', 'Complete'), 

(1495, 46, '2023-02-14', 80.00, 'Cash', 'Complete'), 

(1496, 46, '2023-03-14', 80.00, 'Credit Card', 'Complete'), 

(1497, 46, '2023-04-14', 80.00, 'Debit Card', 'Complete'), 

(1498, 46, '2023-05-14', 80.00, 'MBWay', 'Complete'), 

(1499, 46, '2023-06-14', 80.00, 'PayPal', 'Complete'), 

(1500, 46, '2023-07-14', 80.00, 'Cash', 'Complete'), 

(1501, 46, '2023-08-14', 80.00, 'Credit Card', 'Complete'), 

(1502, 46, '2023-09-14', 80.00, 'Debit Card', 'Complete'), 

(1503, 46, '2023-10-14', 80.00, 'MBWay', 'Complete'), 

(1504, 46, '2023-11-14', 80.00, 'PayPal', 'Complete'), 

(1505, 46, '2023-12-14', 80.00, 'Cash', 'Complete'), 

(1506, 47, '2022-10-28', 80.00, 'Credit Card', 'Complete'), 

(1507, 47, '2022-11-28', 80.00, 'Debit Card', 'Complete'), 

(1508, 47, '2022-12-28', 80.00, 'MBWay', 'Complete'), 

(1509, 47, '2023-01-28', 80.00, 'PayPal', 'Complete'), 

(1510, 47, '2023-02-28', 80.00, 'Cash', 'Complete'), 

(1511, 47, '2023-03-28', 80.00, 'Credit Card', 'Complete'), 

(1512, 47, '2023-04-28', 80.00, 'Debit Card', 'Complete'), 

(1513, 47, '2023-05-28', 80.00, 'MBWay', 'Complete'), 

(1514, 47, '2023-06-28', 80.00, 'PayPal', 'Complete'), 

(1515, 47, '2023-07-28', 80.00, 'Cash', 'Complete'), 

(1516, 47, '2023-08-28', 80.00, 'Credit Card', 'Complete'), 

(1517, 47, '2023-09-28', 80.00, 'Debit Card', 'Complete'), 

(1518, 47, '2023-10-28', 80.00, 'MBWay', 'Complete'), 

(1519, 47, '2023-11-28', 80.00, 'PayPal', 'Complete'), 

(1520, 47, '2023-12-28', 80.00, 'Cash', 'Not Complete'), 

(1521, 48, '2022-02-15', 80.00, 'Credit Card', 'Complete'), 

(1522, 48, '2022-03-15', 80.00, 'Debit Card', 'Complete'), 

(1523, 48, '2022-04-15', 80.00, 'MBWay', 'Complete'), 

(1524, 48, '2022-05-15', 80.00, 'PayPal', 'Complete'), 

(1525, 48, '2022-06-15', 80.00, 'Cash', 'Complete'), 

(1526, 48, '2022-07-15', 80.00, 'Credit Card', 'Complete'), 

(1527, 48, '2022-08-15', 80.00, 'Debit Card', 'Complete'), 

(1528, 48, '2022-09-15', 80.00, 'MBWay', 'Complete'), 

(1529, 48, '2022-10-15', 80.00, 'PayPal', 'Complete'), 

(1530, 48, '2022-11-15', 80.00, 'Cash', 'Complete'), 

(1531, 48, '2022-12-15', 80.00, 'Credit Card', 'Complete'), 

(1532, 48, '2023-01-15', 80.00, 'Debit Card', 'Complete'), 

(1533, 48, '2023-02-15', 80.00, 'MBWay', 'Complete'), 

(1534, 48, '2023-03-15', 80.00, 'PayPal', 'Complete'), 

(1535, 48, '2023-04-15', 80.00, 'Cash', 'Complete'), 

(1536, 48, '2023-05-15', 80.00, 'Credit Card', 'Complete'), 

(1537, 48, '2023-06-15', 80.00, 'Debit Card', 'Complete'), 

(1538, 48, '2023-07-15', 80.00, 'MBWay', 'Complete'), 

(1539, 48, '2023-08-15', 80.00, 'PayPal', 'Complete'), 

(1540, 48, '2023-09-15', 80.00, 'Cash', 'Complete'), 

(1541, 48, '2023-10-15', 80.00, 'Credit Card', 'Complete'), 

(1542, 48, '2023-11-15', 80.00, 'Debit Card', 'Complete'), 

(1543, 48, '2023-12-15', 80.00, 'MBWay', 'Complete'), 

(1544, 49, '2021-05-22', 80.00, 'PayPal', 'Complete'), 

(1545, 49, '2021-06-22', 80.00, 'Cash', 'Complete'), 

(1546, 49, '2021-07-22', 80.00, 'Credit Card', 'Complete'), 

(1547, 49, '2021-08-22', 80.00, 'Debit Card', 'Complete'), 

(1548, 49, '2021-09-22', 80.00, 'MBWay', 'Complete'), 

(1549, 49, '2021-10-22', 80.00, 'PayPal', 'Complete'), 

(1550, 49, '2021-11-22', 80.00, 'Cash', 'Complete'), 

(1551, 49, '2021-12-22', 80.00, 'Credit Card', 'Complete'), 

(1552, 49, '2022-01-22', 80.00, 'Debit Card', 'Complete'), 

(1553, 49, '2022-02-22', 80.00, 'MBWay', 'Complete'), 

(1554, 49, '2022-03-22', 80.00, 'PayPal', 'Complete'), 

(1555, 49, '2022-04-22', 80.00, 'Cash', 'Complete'), 

(1556, 49, '2022-05-22', 80.00, 'Credit Card', 'Complete'), 

(1557, 49, '2022-06-22', 80.00, 'Debit Card', 'Complete'), 

(1558, 49, '2022-07-22', 80.00, 'MBWay', 'Complete'), 

(1559, 49, '2022-08-22', 80.00, 'PayPal', 'Complete'), 

(1560, 49, '2022-09-22', 80.00, 'Cash', 'Complete'), 

(1561, 49, '2022-10-22', 80.00, 'Credit Card', 'Complete'), 

(1562, 49, '2022-11-22', 80.00, 'Debit Card', 'Complete'), 

(1563, 49, '2022-12-22', 80.00, 'MBWay', 'Complete'), 

(1564, 49, '2023-01-22', 80.00, 'PayPal', 'Complete'), 

(1565, 49, '2023-02-22', 80.00, 'Cash', 'Complete'), 

(1566, 49, '2023-03-22', 80.00, 'Credit Card', 'Complete'), 

(1567, 49, '2023-04-22', 80.00, 'Debit Card', 'Complete'), 

(1568, 49, '2023-05-22', 80.00, 'MBWay', 'Complete'), 

(1569, 49, '2023-06-22', 80.00, 'PayPal', 'Complete'), 

(1570, 49, '2023-07-22', 80.00, 'Cash', 'Complete'), 

(1571, 49, '2023-08-22', 80.00, 'Credit Card', 'Complete'), 

(1572, 49, '2023-09-22', 80.00, 'Debit Card', 'Complete'), 

(1573, 49, '2023-10-22', 80.00, 'MBWay', 'Complete'), 

(1574, 49, '2023-11-22', 80.00, 'PayPal', 'Complete'), 

(1575, 49, '2023-12-22', 80.00, 'Cash', 'Not Complete'), 

(1576, 50, '2022-02-05', 80.00, 'Credit Card', 'Complete'), 

(1577, 50, '2022-03-05', 80.00, 'Debit Card', 'Complete'), 

(1578, 50, '2022-04-05', 80.00, 'MBWay', 'Complete'), 

(1579, 50, '2022-05-05', 80.00, 'PayPal', 'Complete'), 

(1580, 50, '2022-06-05', 80.00, 'Cash', 'Complete'), 

(1581, 50, '2022-07-05', 80.00, 'Credit Card', 'Complete'), 

(1582, 50, '2022-08-05', 80.00, 'Debit Card', 'Complete'), 

(1583, 50, '2022-09-05', 80.00, 'MBWay', 'Complete'), 

(1584, 50, '2022-10-05', 80.00, 'PayPal', 'Complete'), 

(1585, 50, '2022-11-05', 80.00, 'Cash', 'Complete'), 

(1586, 50, '2022-12-05', 80.00, 'Credit Card', 'Complete'), 

(1587, 50, '2023-01-05', 80.00, 'Debit Card', 'Complete'), 

(1588, 50, '2023-02-05', 80.00, 'MBWay', 'Complete'), 

(1589, 50, '2023-03-05', 80.00, 'PayPal', 'Complete'), 

(1590, 50, '2023-04-05', 80.00, 'Cash', 'Complete'), 

(1591, 50, '2023-05-05', 80.00, 'Credit Card', 'Complete'), 

(1592, 50, '2023-06-05', 80.00, 'Debit Card', 'Complete'), 

(1593, 50, '2023-07-05', 80.00, 'MBWay', 'Complete'), 

(1594, 50, '2023-08-05', 80.00, 'PayPal', 'Complete'), 

(1595, 50, '2023-09-05', 80.00, 'Cash', 'Complete'), 

(1596, 50, '2023-10-05', 80.00, 'Credit Card', 'Complete'), 

(1597, 50, '2023-11-05', 80.00, 'Debit Card', 'Complete'), 

(1598, 50, '2023-12-05', 80.00, 'MBWay', 'Complete'), 

(1599, 51, '2019-08-30', 130.00, 'PayPal', 'Complete'), 

(1600, 51, '2019-09-30', 130.00, 'Cash', 'Complete'), 

(1601, 51, '2019-10-30', 130.00, 'Credit Card', 'Complete'), 

(1602, 51, '2019-11-30', 130.00, 'Debit Card', 'Complete'), 

(1603, 51, '2019-12-30', 130.00, 'MBWay', 'Complete'), 

(1604, 51, '2020-01-30', 130.00, 'PayPal', 'Complete'), 

(1605, 51, '2020-02-29', 130.00, 'Cash', 'Complete'), 

(1606, 51, '2020-03-30', 130.00, 'Credit Card', 'Complete'), 

(1607, 51, '2020-04-30', 130.00, 'Debit Card', 'Complete'), 

(1608, 51, '2020-05-30', 130.00, 'MBWay', 'Complete'), 

(1609, 51, '2020-06-30', 130.00, 'PayPal', 'Complete'), 

(1610, 51, '2020-07-30', 130.00, 'Cash', 'Complete'), 

(1611, 51, '2020-08-30', 130.00, 'Credit Card', 'Complete'), 

(1612, 51, '2020-09-30', 130.00, 'Debit Card', 'Complete'), 

(1613, 51, '2020-10-30', 130.00, 'MBWay', 'Complete'), 

(1614, 51, '2020-11-30', 130.00, 'PayPal', 'Complete'), 

(1615, 51, '2020-12-30', 130.00, 'Cash', 'Complete'), 

(1616, 51, '2021-01-30', 130.00, 'Credit Card', 'Complete'), 

(1617, 51, '2021-02-28', 130.00, 'Debit Card', 'Complete'), 

(1618, 51, '2021-03-30', 130.00, 'MBWay', 'Complete'), 

(1619, 51, '2021-04-30', 130.00, 'PayPal', 'Complete'), 

(1620, 51, '2021-05-30', 130.00, 'Cash', 'Complete'), 

(1621, 51, '2021-06-30', 130.00, 'Credit Card', 'Complete'), 

(1622, 51, '2021-07-30', 130.00, 'Debit Card', 'Complete'), 

(1623, 51, '2021-08-30', 130.00, 'MBWay', 'Complete'), 

(1624, 51, '2021-09-30', 130.00, 'PayPal', 'Complete'), 

(1625, 51, '2021-10-30', 130.00, 'Cash', 'Complete'), 

(1626, 51, '2021-11-30', 130.00, 'Credit Card', 'Complete'), 

(1627, 51, '2021-12-30', 130.00, 'Debit Card', 'Complete'), 

(1628, 51, '2022-01-30', 130.00, 'MBWay', 'Complete'), 

(1629, 51, '2022-02-28', 130.00, 'PayPal', 'Complete'), 

(1630, 51, '2022-03-30', 130.00, 'Cash', 'Complete'), 

(1631, 51, '2022-04-30', 130.00, 'Credit Card', 'Complete'), 

(1632, 51, '2022-05-30', 130.00, 'Debit Card', 'Complete'), 

(1633, 51, '2022-06-30', 130.00, 'MBWay', 'Complete'), 

(1634, 51, '2022-07-30', 130.00, 'PayPal', 'Complete'), 

(1635, 51, '2022-08-30', 130.00, 'Cash', 'Complete'), 

(1636, 51, '2022-09-30', 130.00, 'Credit Card', 'Complete'), 

(1637, 51, '2022-10-30', 130.00, 'Debit Card', 'Complete'), 

(1638, 51, '2022-11-30', 130.00, 'MBWay', 'Complete'), 

(1639, 51, '2022-12-30', 130.00, 'PayPal', 'Complete'), 

(1640, 51, '2023-01-30', 130.00, 'Cash', 'Complete'), 

(1641, 51, '2023-02-28', 130.00, 'Credit Card', 'Complete'), 

(1642, 51, '2023-03-30', 130.00, 'Debit Card', 'Complete'), 

(1643, 51, '2023-04-30', 130.00, 'MBWay', 'Complete'), 

(1644, 51, '2023-05-30', 130.00, 'PayPal', 'Complete'), 

(1645, 51, '2023-06-30', 130.00, 'Cash', 'Complete'), 

(1646, 51, '2023-07-30', 130.00, 'Credit Card', 'Complete'), 

(1647, 51, '2023-08-30', 130.00, 'Debit Card', 'Complete'), 

(1648, 51, '2023-09-30', 130.00, 'MBWay', 'Complete'), 

(1649, 51, '2023-10-30', 130.00, 'PayPal', 'Complete'), 

(1650, 51, '2023-11-30', 130.00, 'Cash', 'Complete'), 

(1651, 51, '2023-12-30', 130.00, 'Credit Card', 'Not Complete'), 

(1652, 52, '2022-03-15', 130.00, 'Debit Card', 'Complete'), 

(1653, 52, '2022-04-15', 130.00, 'MBWay', 'Complete'), 

(1654, 52, '2022-05-15', 130.00, 'PayPal', 'Complete'), 

(1655, 52, '2022-06-15', 130.00, 'Cash', 'Complete'), 

(1656, 52, '2022-07-15', 130.00, 'Credit Card', 'Complete'), 

(1657, 52, '2022-08-15', 130.00, 'Debit Card', 'Complete'), 

(1658, 52, '2022-09-15', 130.00, 'MBWay', 'Complete'), 

(1659, 52, '2022-10-15', 130.00, 'PayPal', 'Complete'), 

(1660, 52, '2022-11-15', 130.00, 'Cash', 'Complete'), 

(1661, 52, '2022-12-15', 130.00, 'Credit Card', 'Complete'), 

(1662, 52, '2023-01-15', 130.00, 'Debit Card', 'Complete'), 

(1663, 52, '2023-02-15', 130.00, 'MBWay', 'Complete'), 

(1664, 52, '2023-03-15', 130.00, 'PayPal', 'Complete'), 

(1665, 52, '2023-04-15', 130.00, 'Cash', 'Complete'), 

(1666, 52, '2023-05-15', 130.00, 'Credit Card', 'Complete'), 

(1667, 52, '2023-06-15', 130.00, 'Debit Card', 'Complete'), 

(1668, 52, '2023-07-15', 130.00, 'MBWay', 'Complete'), 

(1669, 52, '2023-08-15', 130.00, 'PayPal', 'Complete'), 

(1670, 52, '2023-09-15', 130.00, 'Cash', 'Complete'), 

(1671, 52, '2023-10-15', 130.00, 'Credit Card', 'Complete'), 

(1672, 52, '2023-11-15', 130.00, 'Debit Card', 'Complete'), 

(1673, 52, '2023-12-15', 130.00, 'MBWay', 'Complete'), 

(1674, 53, '2019-07-08', 130.00, 'PayPal', 'Complete'), 

(1675, 53, '2019-08-08', 130.00, 'Cash', 'Complete'), 

(1676, 53, '2019-09-08', 130.00, 'Credit Card', 'Complete'), 

(1677, 53, '2019-10-08', 130.00, 'Debit Card', 'Complete'), 

(1678, 53, '2019-11-08', 130.00, 'MBWay', 'Complete'), 

(1679, 53, '2019-12-08', 130.00, 'PayPal', 'Complete'), 

(1680, 53, '2020-01-08', 130.00, 'Cash', 'Complete'), 

(1681, 53, '2020-02-08', 130.00, 'Credit Card', 'Complete'), 

(1682, 53, '2020-03-08', 130.00, 'Debit Card', 'Complete'), 

(1683, 53, '2020-04-08', 130.00, 'MBWay', 'Complete'), 

(1684, 53, '2020-05-08', 130.00, 'PayPal', 'Complete'), 

(1685, 53, '2020-06-08', 130.00, 'Cash', 'Complete'), 

(1686, 53, '2020-07-08', 130.00, 'Credit Card', 'Complete'), 

(1687, 53, '2020-08-08', 130.00, 'Debit Card', 'Complete'), 

(1688, 53, '2020-09-08', 130.00, 'MBWay', 'Complete'), 

(1689, 53, '2020-10-08', 130.00, 'PayPal', 'Complete'), 

(1690, 53, '2020-11-08', 130.00, 'Cash', 'Complete'), 

(1691, 53, '2020-12-08', 130.00, 'Credit Card', 'Complete'), 

(1692, 53, '2021-01-08', 130.00, 'Debit Card', 'Complete'), 

(1693, 53, '2021-02-08', 130.00, 'MBWay', 'Complete'), 

(1694, 53, '2021-03-08', 130.00, 'PayPal', 'Complete'), 

(1695, 53, '2021-04-08', 130.00, 'Cash', 'Complete'), 

(1696, 53, '2021-05-08', 130.00, 'Credit Card', 'Complete'), 

(1697, 53, '2021-06-08', 130.00, 'Debit Card', 'Complete'), 

(1698, 53, '2021-07-08', 130.00, 'MBWay', 'Complete'), 

(1699, 53, '2021-08-08', 130.00, 'PayPal', 'Complete'), 

(1700, 53, '2021-09-08', 130.00, 'Cash', 'Complete'), 

(1701, 53, '2021-10-08', 130.00, 'Credit Card', 'Complete'), 

(1702, 53, '2021-11-08', 130.00, 'Debit Card', 'Complete'), 

(1703, 53, '2021-12-08', 130.00, 'MBWay', 'Complete'), 

(1704, 53, '2022-01-08', 130.00, 'PayPal', 'Complete'), 

(1705, 53, '2022-02-08', 130.00, 'Cash', 'Complete'), 

(1706, 53, '2022-03-08', 130.00, 'Credit Card', 'Complete'), 

(1707, 53, '2022-04-08', 130.00, 'Debit Card', 'Complete'), 

(1708, 53, '2022-05-08', 130.00, 'MBWay', 'Complete'), 

(1709, 53, '2022-06-08', 130.00, 'PayPal', 'Complete'), 

(1710, 53, '2022-07-08', 130.00, 'Cash', 'Complete'), 

(1711, 53, '2022-08-08', 130.00, 'Credit Card', 'Complete'), 

(1712, 53, '2022-09-08', 130.00, 'Debit Card', 'Complete'), 

(1713, 53, '2022-10-08', 130.00, 'MBWay', 'Complete'), 

(1714, 53, '2022-11-08', 130.00, 'PayPal', 'Complete'), 

(1715, 53, '2022-12-08', 130.00, 'Cash', 'Complete'), 

(1716, 53, '2023-01-08', 130.00, 'Credit Card', 'Complete'), 

(1717, 53, '2023-02-08', 130.00, 'Debit Card', 'Complete'), 

(1718, 53, '2023-03-08', 130.00, 'MBWay', 'Complete'), 

(1719, 53, '2023-04-08', 130.00, 'PayPal', 'Complete'), 

(1720, 53, '2023-05-08', 130.00, 'Cash', 'Complete'), 

(1721, 53, '2023-06-08', 130.00, 'Credit Card', 'Complete'), 

(1722, 53, '2023-07-08', 130.00, 'Debit Card', 'Complete'), 

(1723, 53, '2023-08-08', 130.00, 'MBWay', 'Complete'), 

(1724, 53, '2023-09-08', 130.00, 'PayPal', 'Complete'), 

(1725, 53, '2023-10-08', 130.00, 'Cash', 'Complete'), 

(1726, 53, '2023-11-08', 130.00, 'Credit Card', 'Complete'), 

(1727, 53, '2023-12-08', 130.00, 'Debit Card', 'Complete'), 

(1728, 54, '2019-11-15', 130.00, 'MBWay', 'Complete'), 

(1729, 54, '2019-12-15', 130.00, 'PayPal', 'Complete'), 

(1730, 54, '2020-01-15', 130.00, 'Cash', 'Complete'), 

(1731, 54, '2020-02-15', 130.00, 'Credit Card', 'Complete'), 

(1732, 54, '2020-03-15', 130.00, 'Debit Card', 'Complete'), 

(1733, 54, '2020-04-15', 130.00, 'MBWay', 'Complete'), 

(1734, 54, '2020-05-15', 130.00, 'PayPal', 'Complete'), 

(1735, 54, '2020-06-15', 130.00, 'Cash', 'Complete'), 

(1736, 54, '2020-07-15', 130.00, 'Credit Card', 'Complete'), 

(1737, 54, '2020-08-15', 130.00, 'Debit Card', 'Complete'), 

(1738, 54, '2020-09-15', 130.00, 'MBWay', 'Complete'), 

(1739, 54, '2020-10-15', 130.00, 'PayPal', 'Complete'), 

(1740, 54, '2020-11-15', 130.00, 'Cash', 'Complete'), 

(1741, 54, '2020-12-15', 130.00, 'Credit Card', 'Complete'), 

(1742, 54, '2021-01-15', 130.00, 'Debit Card', 'Complete'), 

(1743, 54, '2021-02-15', 130.00, 'MBWay', 'Complete'), 

(1744, 54, '2021-03-15', 130.00, 'PayPal', 'Complete'), 

(1745, 54, '2021-04-15', 130.00, 'Cash', 'Complete'), 

(1746, 54, '2021-05-15', 130.00, 'Credit Card', 'Complete'), 

(1747, 54, '2021-06-15', 130.00, 'Debit Card', 'Complete'), 

(1748, 54, '2021-07-15', 130.00, 'MBWay', 'Complete'), 

(1749, 54, '2021-08-15', 130.00, 'PayPal', 'Complete'), 

(1750, 54, '2021-09-15', 130.00, 'Cash', 'Complete'), 

(1751, 54, '2021-10-15', 130.00, 'Credit Card', 'Complete'), 

(1752, 54, '2021-11-15', 130.00, 'Debit Card', 'Complete'), 

(1753, 54, '2021-12-15', 130.00, 'MBWay', 'Complete'), 

(1754, 54, '2022-01-15', 130.00, 'PayPal', 'Complete'), 

(1755, 54, '2022-02-15', 130.00, 'Cash', 'Complete'), 

(1756, 54, '2022-03-15', 130.00, 'Credit Card', 'Complete'), 

(1757, 54, '2022-04-15', 130.00, 'Debit Card', 'Complete'), 

(1758, 54, '2022-05-15', 130.00, 'MBWay', 'Complete'), 

(1759, 54, '2022-06-15', 130.00, 'PayPal', 'Complete'), 

(1760, 54, '2022-07-15', 130.00, 'Cash', 'Complete'), 

(1761, 54, '2022-08-15', 130.00, 'Credit Card', 'Complete'), 

(1762, 54, '2022-09-15', 130.00, 'Debit Card', 'Complete'), 

(1763, 54, '2022-10-15', 130.00, 'MBWay', 'Complete'), 

(1764, 54, '2022-11-15', 130.00, 'PayPal', 'Complete'), 

(1765, 54, '2022-12-15', 130.00, 'Cash', 'Complete'), 

(1766, 54, '2023-01-15', 130.00, 'Credit Card', 'Complete'), 

(1767, 54, '2023-02-15', 130.00, 'Debit Card', 'Complete'), 

(1768, 54, '2023-03-15', 130.00, 'MBWay', 'Complete'), 

(1769, 54, '2023-04-15', 130.00, 'PayPal', 'Complete'), 

(1770, 54, '2023-05-15', 130.00, 'Cash', 'Complete'), 

(1771, 54, '2023-06-15', 130.00, 'Credit Card', 'Complete'), 

(1772, 54, '2023-07-15', 130.00, 'Debit Card', 'Complete'), 

(1773, 54, '2023-08-15', 130.00, 'MBWay', 'Complete'), 

(1774, 54, '2023-09-15', 130.00, 'PayPal', 'Complete'), 

(1775, 54, '2023-10-15', 130.00, 'Cash', 'Complete'), 

(1776, 54, '2023-11-15', 130.00, 'Credit Card', 'Complete'), 

(1777, 54, '2023-12-15', 130.00, 'Debit Card', 'Complete'), 

(1778, 55, '2020-05-01', 130.00, 'MBWay', 'Complete'), 

(1779, 55, '2020-06-01', 130.00, 'PayPal', 'Complete'), 

(1780, 55, '2020-07-01', 130.00, 'Cash', 'Complete'), 

(1781, 55, '2020-08-01', 130.00, 'Credit Card', 'Complete'), 

(1782, 55, '2020-09-01', 130.00, 'Debit Card', 'Complete'), 

(1783, 55, '2020-10-01', 130.00, 'MBWay', 'Complete'), 

(1784, 55, '2020-11-01', 130.00, 'PayPal', 'Complete'), 

(1785, 55, '2020-12-01', 130.00, 'Cash', 'Complete'), 

(1786, 55, '2021-01-01', 130.00, 'Credit Card', 'Complete'), 

(1787, 55, '2021-02-01', 130.00, 'Debit Card', 'Complete'), 

(1788, 55, '2021-03-01', 130.00, 'MBWay', 'Complete'), 

(1789, 55, '2021-04-01', 130.00, 'PayPal', 'Complete'), 

(1790, 55, '2021-05-01', 130.00, 'Cash', 'Complete'), 

(1791, 55, '2021-06-01', 130.00, 'Credit Card', 'Complete'), 

(1792, 55, '2021-07-01', 130.00, 'Debit Card', 'Complete'), 

(1793, 55, '2021-08-01', 130.00, 'MBWay', 'Complete'), 

(1794, 55, '2021-09-01', 130.00, 'PayPal', 'Complete'), 

(1795, 55, '2021-10-01', 130.00, 'Cash', 'Complete'), 

(1796, 55, '2021-11-01', 130.00, 'Credit Card', 'Complete'), 

(1797, 55, '2021-12-01', 130.00, 'Debit Card', 'Complete'), 

(1798, 55, '2022-01-01', 130.00, 'MBWay', 'Complete'), 

(1799, 55, '2022-02-01', 130.00, 'PayPal', 'Complete'), 

(1800, 55, '2022-03-01', 130.00, 'Cash', 'Complete'), 

(1801, 55, '2022-04-01', 130.00, 'Credit Card', 'Complete'), 

(1802, 55, '2022-05-01', 130.00, 'Debit Card', 'Complete'), 

(1803, 55, '2022-06-01', 130.00, 'MBWay', 'Complete'), 

(1804, 55, '2022-07-01', 130.00, 'PayPal', 'Complete'), 

(1805, 55, '2022-08-01', 130.00, 'Cash', 'Complete'), 

(1806, 55, '2022-09-01', 130.00, 'Credit Card', 'Complete'), 

(1807, 55, '2022-10-01', 130.00, 'Debit Card', 'Complete'), 

(1808, 55, '2022-11-01', 130.00, 'MBWay', 'Complete'), 

(1809, 55, '2022-12-01', 130.00, 'PayPal', 'Complete'), 

(1810, 55, '2023-01-01', 130.00, 'Cash', 'Complete'), 

(1811, 55, '2023-02-01', 130.00, 'Credit Card', 'Complete'), 

(1812, 55, '2023-03-01', 130.00, 'Debit Card', 'Complete'), 

(1813, 55, '2023-04-01', 130.00, 'MBWay', 'Complete'), 

(1814, 55, '2023-05-01', 130.00, 'PayPal', 'Complete'), 

(1815, 55, '2023-06-01', 130.00, 'Cash', 'Complete'), 

(1816, 55, '2023-07-01', 130.00, 'Credit Card', 'Complete'), 

(1817, 55, '2023-08-01', 130.00, 'Debit Card', 'Complete'), 

(1818, 55, '2023-09-01', 130.00, 'MBWay', 'Complete'), 

(1819, 55, '2023-10-01', 130.00, 'PayPal', 'Complete'), 

(1820, 55, '2023-11-01', 130.00, 'Cash', 'Complete'), 

(1821, 55, '2023-12-01', 130.00, 'Credit Card', 'Complete'), 

(1822, 56, '2019-06-14', 130.00, 'Debit Card', 'Complete'), 

(1823, 56, '2019-07-14', 130.00, 'MBWay', 'Complete'), 

(1824, 56, '2019-08-14', 130.00, 'PayPal', 'Complete'), 

(1825, 56, '2019-09-14', 130.00, 'Cash', 'Complete'), 

(1826, 56, '2019-10-14', 130.00, 'Credit Card', 'Complete'), 

(1827, 56, '2019-11-14', 130.00, 'Debit Card', 'Complete'), 

(1828, 56, '2019-12-14', 130.00, 'MBWay', 'Complete'), 

(1829, 56, '2020-01-14', 130.00, 'PayPal', 'Complete'), 

(1830, 56, '2020-02-14', 130.00, 'Cash', 'Complete'), 

(1831, 56, '2020-03-14', 130.00, 'Credit Card', 'Complete'), 

(1832, 56, '2020-04-14', 130.00, 'Debit Card', 'Complete'), 

(1833, 56, '2020-05-14', 130.00, 'MBWay', 'Complete'), 

(1834, 56, '2020-06-14', 130.00, 'PayPal', 'Complete'), 

(1835, 56, '2020-07-14', 130.00, 'Cash', 'Complete'), 

(1836, 56, '2020-08-14', 130.00, 'Credit Card', 'Complete'), 

(1837, 56, '2020-09-14', 130.00, 'Debit Card', 'Complete'), 

(1838, 56, '2020-10-14', 130.00, 'MBWay', 'Complete'), 

(1839, 56, '2020-11-14', 130.00, 'PayPal', 'Complete'), 

(1840, 56, '2020-12-14', 130.00, 'Cash', 'Complete'), 

(1841, 56, '2021-01-14', 130.00, 'Credit Card', 'Complete'), 

(1842, 56, '2021-02-14', 130.00, 'Debit Card', 'Complete'), 

(1843, 56, '2021-03-14', 130.00, 'MBWay', 'Complete'), 

(1844, 56, '2021-04-14', 130.00, 'PayPal', 'Complete'), 

(1845, 56, '2021-05-14', 130.00, 'Cash', 'Complete'), 

(1846, 56, '2021-06-14', 130.00, 'Credit Card', 'Complete'), 

(1847, 56, '2021-07-14', 130.00, 'Debit Card', 'Complete'), 

(1848, 56, '2021-08-14', 130.00, 'MBWay', 'Complete'), 

(1849, 56, '2021-09-14', 130.00, 'PayPal', 'Complete'), 

(1850, 56, '2021-10-14', 130.00, 'Cash', 'Complete'), 

(1851, 56, '2021-11-14', 130.00, 'Credit Card', 'Complete'), 

(1852, 56, '2021-12-14', 130.00, 'Debit Card', 'Complete'), 

(1853, 56, '2022-01-14', 130.00, 'MBWay', 'Complete'), 

(1854, 56, '2022-02-14', 130.00, 'PayPal', 'Complete'), 

(1855, 56, '2022-03-14', 130.00, 'Cash', 'Complete'), 

(1856, 56, '2022-04-14', 130.00, 'Credit Card', 'Complete'), 

(1857, 56, '2022-05-14', 130.00, 'Debit Card', 'Complete'), 

(1858, 56, '2022-06-14', 130.00, 'MBWay', 'Complete'), 

(1859, 56, '2022-07-14', 130.00, 'PayPal', 'Complete'), 

(1860, 56, '2022-08-14', 130.00, 'Cash', 'Complete'), 

(1861, 56, '2022-09-14', 130.00, 'Credit Card', 'Complete'), 

(1862, 56, '2022-10-14', 130.00, 'Debit Card', 'Complete'), 

(1863, 56, '2022-11-14', 130.00, 'MBWay', 'Complete'), 

(1864, 56, '2022-12-14', 130.00, 'PayPal', 'Complete'), 

(1865, 56, '2023-01-14', 130.00, 'Cash', 'Complete'), 

(1866, 56, '2023-02-14', 130.00, 'Credit Card', 'Complete'), 

(1867, 56, '2023-03-14', 130.00, 'Debit Card', 'Complete'), 

(1868, 56, '2023-04-14', 130.00, 'MBWay', 'Complete'), 

(1869, 56, '2023-05-14', 130.00, 'PayPal', 'Complete'), 

(1870, 56, '2023-06-14', 130.00, 'Cash', 'Complete'), 

(1871, 56, '2023-07-14', 130.00, 'Credit Card', 'Complete'), 

(1872, 56, '2023-08-14', 130.00, 'Debit Card', 'Complete'), 

(1873, 56, '2023-09-14', 130.00, 'MBWay', 'Complete'), 

(1874, 56, '2023-10-14', 130.00, 'PayPal', 'Complete'), 

(1875, 56, '2023-11-14', 130.00, 'Cash', 'Complete'), 

(1876, 56, '2023-12-14', 130.00, 'Credit Card', 'Complete'), 

(1877, 57, '2019-10-28', 130.00, 'Debit Card', 'Complete'), 

(1878, 57, '2019-11-28', 130.00, 'MBWay', 'Complete'), 

(1879, 57, '2019-12-28', 130.00, 'PayPal', 'Complete'), 

(1880, 57, '2020-01-28', 130.00, 'Cash', 'Complete'), 

(1881, 57, '2020-02-28', 130.00, 'Credit Card', 'Complete'), 

(1882, 57, '2020-03-28', 130.00, 'Debit Card', 'Complete'), 

(1883, 57, '2020-04-28', 130.00, 'MBWay', 'Complete'), 

(1884, 57, '2020-05-28', 130.00, 'PayPal', 'Complete'), 

(1885, 57, '2020-06-28', 130.00, 'Cash', 'Complete'), 

(1886, 57, '2020-07-28', 130.00, 'Credit Card', 'Complete'), 

(1887, 57, '2020-08-28', 130.00, 'Debit Card', 'Complete'), 

(1888, 57, '2020-09-28', 130.00, 'MBWay', 'Complete'), 

(1889, 57, '2020-10-28', 130.00, 'PayPal', 'Complete'), 

(1890, 57, '2020-11-28', 130.00, 'Cash', 'Complete'), 

(1891, 57, '2020-12-28', 130.00, 'Credit Card', 'Complete'), 

(1892, 57, '2021-01-28', 130.00, 'Debit Card', 'Complete'), 

(1893, 57, '2021-02-28', 130.00, 'MBWay', 'Complete'), 

(1894, 57, '2021-03-28', 130.00, 'PayPal', 'Complete'), 

(1895, 57, '2021-04-28', 130.00, 'Cash', 'Complete'), 

(1896, 57, '2021-05-28', 130.00, 'Credit Card', 'Complete'), 

(1897, 57, '2021-06-28', 130.00, 'Debit Card', 'Complete'), 

(1898, 57, '2021-07-28', 130.00, 'MBWay', 'Complete'), 

(1899, 57, '2021-08-28', 130.00, 'PayPal', 'Complete'), 

(1900, 57, '2021-09-28', 130.00, 'Cash', 'Complete'), 

(1901, 57, '2021-10-28', 130.00, 'Credit Card', 'Complete'), 

(1902, 57, '2021-11-28', 130.00, 'Debit Card', 'Complete'), 

(1903, 57, '2021-12-28', 130.00, 'MBWay', 'Complete'), 

(1904, 57, '2022-01-28', 130.00, 'PayPal', 'Complete'), 

(1905, 57, '2022-02-28', 130.00, 'Cash', 'Complete'), 

(1906, 57, '2022-03-28', 130.00, 'Credit Card', 'Complete'), 

(1907, 57, '2022-04-28', 130.00, 'Debit Card', 'Complete'), 

(1908, 57, '2022-05-28', 130.00, 'MBWay', 'Complete'), 

(1909, 57, '2022-06-28', 130.00, 'PayPal', 'Complete'), 

(1910, 57, '2022-07-28', 130.00, 'Cash', 'Complete'), 

(1911, 57, '2022-08-28', 130.00, 'Credit Card', 'Complete'), 

(1912, 57, '2022-09-28', 130.00, 'Debit Card', 'Complete'), 

(1913, 57, '2022-10-28', 130.00, 'MBWay', 'Complete'), 

(1914, 57, '2022-11-28', 130.00, 'PayPal', 'Complete'), 

(1915, 57, '2022-12-28', 130.00, 'Cash', 'Complete'), 

(1916, 57, '2023-01-28', 130.00, 'Credit Card', 'Complete'), 

(1917, 57, '2023-02-28', 130.00, 'Debit Card', 'Complete'), 

(1918, 57, '2023-03-28', 130.00, 'MBWay', 'Complete'), 

(1919, 57, '2023-04-28', 130.00, 'PayPal', 'Complete'), 

(1920, 57, '2023-05-28', 130.00, 'Cash', 'Complete'), 

(1921, 57, '2023-06-28', 130.00, 'Credit Card', 'Complete'), 

(1922, 57, '2023-07-28', 130.00, 'Debit Card', 'Complete'), 

(1923, 57, '2023-08-28', 130.00, 'MBWay', 'Complete'), 

(1924, 57, '2023-09-28', 130.00, 'PayPal', 'Complete'), 

(1925, 57, '2023-10-28', 130.00, 'Cash', 'Complete'), 

(1926, 57, '2023-11-28', 130.00, 'Credit Card', 'Complete'), 

(1927, 57, '2023-12-28', 130.00, 'Debit Card', 'Not Complete'), 

(1928, 58, '2019-02-15', 130.00, 'MBWay', 'Complete'), 

(1929, 58, '2019-03-15', 130.00, 'PayPal', 'Complete'), 

(1930, 58, '2019-04-15', 130.00, 'Cash', 'Complete'), 

(1931, 58, '2019-05-15', 130.00, 'Credit Card', 'Complete'), 

(1932, 58, '2019-06-15', 130.00, 'Debit Card', 'Complete'), 

(1933, 58, '2019-07-15', 130.00, 'MBWay', 'Complete'), 

(1934, 58, '2019-08-15', 130.00, 'PayPal', 'Complete'), 

(1935, 58, '2019-09-15', 130.00, 'Cash', 'Complete'), 

(1936, 58, '2019-10-15', 130.00, 'Credit Card', 'Complete'), 

(1937, 58, '2019-11-15', 130.00, 'Debit Card', 'Complete'), 

(1938, 58, '2019-12-15', 130.00, 'MBWay', 'Complete'), 

(1939, 58, '2020-01-15', 130.00, 'PayPal', 'Complete'), 

(1940, 58, '2020-02-15', 130.00, 'Cash', 'Complete'), 

(1941, 58, '2020-03-15', 130.00, 'Credit Card', 'Complete'), 

(1942, 58, '2020-04-15', 130.00, 'Debit Card', 'Complete'), 

(1943, 58, '2020-05-15', 130.00, 'MBWay', 'Complete'), 

(1944, 58, '2020-06-15', 130.00, 'PayPal', 'Complete'), 

(1945, 58, '2020-07-15', 130.00, 'Cash', 'Complete'), 

(1946, 58, '2020-08-15', 130.00, 'Credit Card', 'Complete'), 

(1947, 58, '2020-09-15', 130.00, 'Debit Card', 'Complete'), 

(1948, 58, '2020-10-15', 130.00, 'MBWay', 'Complete'), 

(1949, 58, '2020-11-15', 130.00, 'PayPal', 'Complete'), 

(1950, 58, '2020-12-15', 130.00, 'Cash', 'Complete'), 

(1951, 58, '2021-01-15', 130.00, 'Credit Card', 'Complete'), 

(1952, 58, '2021-02-15', 130.00, 'Debit Card', 'Complete'), 

(1953, 58, '2021-03-15', 130.00, 'MBWay', 'Complete'), 

(1954, 58, '2021-04-15', 130.00, 'PayPal', 'Complete'), 

(1955, 58, '2021-05-15', 130.00, 'Cash', 'Complete'), 

(1956, 58, '2021-06-15', 130.00, 'Credit Card', 'Complete'), 

(1957, 58, '2021-07-15', 130.00, 'Debit Card', 'Complete'), 

(1958, 58, '2021-08-15', 130.00, 'MBWay', 'Complete'), 

(1959, 58, '2021-09-15', 130.00, 'PayPal', 'Complete'), 

(1960, 58, '2021-10-15', 130.00, 'Cash', 'Complete'), 

(1961, 58, '2021-11-15', 130.00, 'Credit Card', 'Complete'), 

(1962, 58, '2021-12-15', 130.00, 'Debit Card', 'Complete'), 

(1963, 58, '2022-01-15', 130.00, 'MBWay', 'Complete'), 

(1964, 58, '2022-02-15', 130.00, 'PayPal', 'Complete'), 

(1965, 58, '2022-03-15', 130.00, 'Cash', 'Complete'), 

(1966, 58, '2022-04-15', 130.00, 'Credit Card', 'Complete'), 

(1967, 58, '2022-05-15', 130.00, 'Debit Card', 'Complete'), 

(1968, 58, '2022-06-15', 130.00, 'MBWay', 'Complete'), 

(1969, 58, '2022-07-15', 130.00, 'PayPal', 'Complete'), 

(1970, 58, '2022-08-15', 130.00, 'Cash', 'Complete'), 

(1971, 58, '2022-09-15', 130.00, 'Credit Card', 'Complete'), 

(1972, 58, '2022-10-15', 130.00, 'Debit Card', 'Complete'), 

(1973, 58, '2022-11-15', 130.00, 'MBWay', 'Complete'), 

(1974, 58, '2022-12-15', 130.00, 'PayPal', 'Complete'), 

(1975, 58, '2023-01-15', 130.00, 'Cash', 'Complete'), 

(1976, 58, '2023-02-15', 130.00, 'Credit Card', 'Complete'), 

(1977, 58, '2023-03-15', 130.00, 'Debit Card', 'Complete'), 

(1978, 58, '2023-04-15', 130.00, 'MBWay', 'Complete'), 

(1979, 58, '2023-05-15', 130.00, 'PayPal', 'Complete'), 

(1980, 58, '2023-06-15', 130.00, 'Cash', 'Complete'), 

(1981, 58, '2023-07-15', 130.00, 'Credit Card', 'Complete'), 

(1982, 58, '2023-08-15', 130.00, 'Debit Card', 'Complete'), 

(1983, 58, '2023-09-15', 130.00, 'MBWay', 'Complete'), 

(1984, 58, '2023-10-15', 130.00, 'PayPal', 'Complete'), 

(1985, 58, '2023-11-15', 130.00, 'Cash', 'Complete'), 

(1986, 58, '2023-12-15', 130.00, 'Credit Card', 'Complete'), 

(1987, 59, '2021-05-22', 130.00, 'Debit Card', 'Complete'), 

(1988, 59, '2021-06-22', 130.00, 'MBWay', 'Complete'), 

(1989, 59, '2021-07-22', 130.00, 'PayPal', 'Complete'), 

(1990, 59, '2021-08-22', 130.00, 'Cash', 'Complete'), 

(1991, 59, '2021-09-22', 130.00, 'Credit Card', 'Complete'), 

(1992, 59, '2021-10-22', 130.00, 'Debit Card', 'Complete'), 

(1993, 59, '2021-11-22', 130.00, 'MBWay', 'Complete'), 

(1994, 59, '2021-12-22', 130.00, 'PayPal', 'Complete'), 

(1995, 59, '2022-01-22', 130.00, 'Cash', 'Complete'), 

(1996, 59, '2022-02-22', 130.00, 'Credit Card', 'Complete'), 

(1997, 59, '2022-03-22', 130.00, 'Debit Card', 'Complete'), 

(1998, 59, '2022-04-22', 130.00, 'MBWay', 'Complete'), 

(1999, 59, '2022-05-22', 130.00, 'PayPal', 'Complete'), 

(2000, 59, '2022-06-22', 130.00, 'Cash', 'Complete'), 

(2001, 59, '2022-07-22', 130.00, 'Credit Card', 'Complete'), 

(2002, 59, '2022-08-22', 130.00, 'Debit Card', 'Complete'), 

(2003, 59, '2022-09-22', 130.00, 'MBWay', 'Complete'), 

(2004, 59, '2022-10-22', 130.00, 'PayPal', 'Complete'), 

(2005, 59, '2022-11-22', 130.00, 'Cash', 'Complete'), 

(2006, 59, '2022-12-22', 130.00, 'Credit Card', 'Complete'), 

(2007, 59, '2023-01-22', 130.00, 'Debit Card', 'Complete'), 

(2008, 59, '2023-02-22', 130.00, 'MBWay', 'Complete'), 

(2009, 59, '2023-03-22', 130.00, 'PayPal', 'Complete'), 

(2010, 59, '2023-04-22', 130.00, 'Cash', 'Complete'), 

(2011, 59, '2023-05-22', 130.00, 'Credit Card', 'Complete'), 

(2012, 59, '2023-06-22', 130.00, 'Debit Card', 'Complete'), 

(2013, 59, '2023-07-22', 130.00, 'MBWay', 'Complete'), 

(2014, 59, '2023-08-22', 130.00, 'PayPal', 'Complete'), 

(2015, 59, '2023-09-22', 130.00, 'Cash', 'Complete'), 

(2016, 59, '2023-10-22', 130.00, 'Credit Card', 'Complete'), 

(2017, 59, '2023-11-22', 130.00, 'Debit Card', 'Complete'), 

(2018, 59, '2023-12-22', 130.00, 'MBWay', 'Not Complete'), 

(2019, 60, '2022-02-05', 130.00, 'PayPal', 'Complete'), 

(2020, 60, '2022-03-05', 130.00, 'Cash', 'Complete'), 

(2021, 60, '2022-04-05', 130.00, 'Credit Card', 'Complete'), 

(2022, 60, '2022-05-05', 130.00, 'Debit Card', 'Complete'), 

(2023, 60, '2022-06-05', 130.00, 'MBWay', 'Complete'), 

(2024, 60, '2022-07-05', 130.00, 'PayPal', 'Complete'), 

(2025, 60, '2022-08-05', 130.00, 'Cash', 'Complete'), 

(2026, 60, '2022-09-05', 130.00, 'Credit Card', 'Complete'), 

(2027, 60, '2022-10-05', 130.00, 'Debit Card', 'Complete'), 

(2028, 60, '2022-11-05', 130.00, 'MBWay', 'Complete'), 

(2029, 60, '2022-12-05', 130.00, 'PayPal', 'Complete'), 

(2030, 60, '2023-01-05', 130.00, 'Cash', 'Complete'), 

(2031, 60, '2023-02-05', 130.00, 'Credit Card', 'Complete'), 

(2032, 60, '2023-03-05', 130.00, 'Debit Card', 'Complete'), 

(2033, 60, '2023-04-05', 130.00, 'MBWay', 'Complete'), 

(2034, 60, '2023-05-05', 130.00, 'PayPal', 'Complete'), 

(2035, 60, '2023-06-05', 130.00, 'Cash', 'Complete'), 

(2036, 60, '2023-07-05', 130.00, 'Credit Card', 'Complete'), 

(2037, 60, '2023-08-05', 130.00, 'Debit Card', 'Complete'), 

(2038, 60, '2023-09-05', 130.00, 'MBWay', 'Complete'), 

(2039, 60, '2023-10-05', 130.00, 'PayPal', 'Complete'), 

(2040, 60, '2023-11-05', 130.00, 'Cash', 'Complete'), 

(2041, 60, '2023-12-05', 130.00, 'Credit Card', 'Complete'), 

(2042, 61, '2021-08-30', 120.00, 'Debit Card', 'Complete'), 

(2043, 61, '2021-09-30', 120.00, 'MBWay', 'Complete'), 

(2044, 61, '2021-10-30', 120.00, 'PayPal', 'Complete'), 

(2045, 61, '2021-11-30', 120.00, 'Cash', 'Complete'), 

(2046, 61, '2021-12-30', 120.00, 'Credit Card', 'Complete'), 

(2047, 61, '2022-01-30', 120.00, 'Debit Card', 'Complete'), 

(2048, 61, '2022-02-28', 120.00, 'MBWay', 'Complete'), 

(2049, 61, '2022-03-30', 120.00, 'PayPal', 'Complete'), 

(2050, 61, '2022-04-30', 120.00, 'Cash', 'Complete'), 

(2051, 61, '2022-05-30', 120.00, 'Credit Card', 'Complete'), 

(2052, 61, '2022-06-30', 120.00, 'Debit Card', 'Complete'), 

(2053, 61, '2022-07-30', 120.00, 'MBWay', 'Complete'), 

(2054, 61, '2022-08-30', 120.00, 'PayPal', 'Complete'), 

(2055, 61, '2022-09-30', 120.00, 'Cash', 'Complete'), 

(2056, 61, '2022-10-30', 120.00, 'Credit Card', 'Complete'), 

(2057, 61, '2022-11-30', 120.00, 'Debit Card', 'Complete'), 

(2058, 61, '2022-12-30', 120.00, 'MBWay', 'Complete'), 

(2059, 61, '2023-01-30', 120.00, 'PayPal', 'Complete'), 

(2060, 61, '2023-02-28', 120.00, 'Cash', 'Complete'), 

(2061, 61, '2023-03-30', 120.00, 'Credit Card', 'Complete'), 

(2062, 61, '2023-04-30', 120.00, 'Debit Card', 'Complete'), 

(2063, 61, '2023-05-30', 120.00, 'MBWay', 'Complete'), 

(2064, 61, '2023-06-30', 120.00, 'PayPal', 'Complete'), 

(2065, 61, '2023-07-30', 120.00, 'Cash', 'Complete'), 

(2066, 61, '2023-08-30', 120.00, 'Credit Card', 'Complete'), 

(2067, 61, '2023-09-30', 120.00, 'Debit Card', 'Complete'), 

(2068, 61, '2023-10-30', 120.00, 'MBWay', 'Complete'), 

(2069, 61, '2023-11-30', 120.00, 'PayPal', 'Complete'), 

(2070, 61, '2023-12-30', 120.00, 'Cash', 'Not Complete'), 

(2071, 62, '2022-03-15', 120.00, 'Credit Card', 'Complete'), 

(2072, 62, '2022-04-15', 120.00, 'Debit Card', 'Complete'), 

(2073, 62, '2022-05-15', 120.00, 'MBWay', 'Complete'), 

(2074, 62, '2022-06-15', 120.00, 'PayPal', 'Complete'), 

(2075, 62, '2022-07-15', 120.00, 'Cash', 'Complete'), 

(2076, 62, '2022-08-15', 120.00, 'Credit Card', 'Complete'), 

(2077, 62, '2022-09-15', 120.00, 'Debit Card', 'Complete'), 

(2078, 62, '2022-10-15', 120.00, 'MBWay', 'Complete'), 

(2079, 62, '2022-11-15', 120.00, 'PayPal', 'Complete'), 

(2080, 62, '2022-12-15', 120.00, 'Cash', 'Complete'), 

(2081, 62, '2023-01-15', 120.00, 'Credit Card', 'Complete'), 

(2082, 62, '2023-02-15', 120.00, 'Debit Card', 'Complete'), 

(2083, 62, '2023-03-15', 120.00, 'MBWay', 'Complete'), 

(2084, 62, '2023-04-15', 120.00, 'PayPal', 'Complete'), 

(2085, 62, '2023-05-15', 120.00, 'Cash', 'Complete'), 

(2086, 62, '2023-06-15', 120.00, 'Credit Card', 'Complete'), 

(2087, 62, '2023-07-15', 120.00, 'Debit Card', 'Complete'), 

(2088, 62, '2023-08-15', 120.00, 'MBWay', 'Complete'), 

(2089, 62, '2023-09-15', 120.00, 'PayPal', 'Complete'), 

(2090, 62, '2023-10-15', 120.00, 'Cash', 'Complete'), 

(2091, 62, '2023-11-15', 120.00, 'Credit Card', 'Complete'), 

(2092, 62, '2023-12-15', 120.00, 'Debit Card', 'Complete'), 

(2093, 63, '2019-07-08', 120.00, 'MBWay', 'Complete'), 

(2094, 63, '2019-08-08', 120.00, 'PayPal', 'Complete'), 

(2095, 63, '2019-09-08', 120.00, 'Cash', 'Complete'), 

(2096, 63, '2019-10-08', 120.00, 'Credit Card', 'Complete'), 

(2097, 63, '2019-11-08', 120.00, 'Debit Card', 'Complete'), 

(2098, 63, '2019-12-08', 120.00, 'MBWay', 'Complete'), 

(2099, 63, '2020-01-08', 120.00, 'PayPal', 'Complete'), 

(2100, 63, '2020-02-08', 120.00, 'Cash', 'Complete'), 

(2101, 63, '2020-03-08', 120.00, 'Credit Card', 'Complete'), 

(2102, 63, '2020-04-08', 120.00, 'Debit Card', 'Complete'), 

(2103, 63, '2020-05-08', 120.00, 'MBWay', 'Complete'), 

(2104, 63, '2020-06-08', 120.00, 'PayPal', 'Complete'), 

(2105, 63, '2020-07-08', 120.00, 'Cash', 'Complete'), 

(2106, 63, '2020-08-08', 120.00, 'Credit Card', 'Complete'), 

(2107, 63, '2020-09-08', 120.00, 'Debit Card', 'Complete'), 

(2108, 63, '2020-10-08', 120.00, 'MBWay', 'Complete'), 

(2109, 63, '2020-11-08', 120.00, 'PayPal', 'Complete'), 

(2110, 63, '2020-12-08', 120.00, 'Cash', 'Complete'), 

(2111, 63, '2021-01-08', 120.00, 'Credit Card', 'Complete'), 

(2112, 63, '2021-02-08', 120.00, 'Debit Card', 'Complete'), 

(2113, 63, '2021-03-08', 120.00, 'MBWay', 'Complete'), 

(2114, 63, '2021-04-08', 120.00, 'PayPal', 'Complete'), 

(2115, 63, '2021-05-08', 120.00, 'Cash', 'Complete'), 

(2116, 63, '2021-06-08', 120.00, 'Credit Card', 'Complete'), 

(2117, 63, '2021-07-08', 120.00, 'Debit Card', 'Complete'), 

(2118, 63, '2021-08-08', 120.00, 'MBWay', 'Complete'), 

(2119, 63, '2021-09-08', 120.00, 'PayPal', 'Complete'), 

(2120, 63, '2021-10-08', 120.00, 'Cash', 'Complete'), 

(2121, 63, '2021-11-08', 120.00, 'Credit Card', 'Complete'), 

(2122, 63, '2021-12-08', 120.00, 'Debit Card', 'Complete'), 

(2123, 63, '2022-01-08', 120.00, 'MBWay', 'Complete'), 

(2124, 63, '2022-02-08', 120.00, 'PayPal', 'Complete'), 

(2125, 63, '2022-03-08', 120.00, 'Cash', 'Complete'), 

(2126, 63, '2022-04-08', 120.00, 'Credit Card', 'Complete'), 

(2127, 63, '2022-05-08', 120.00, 'Debit Card', 'Complete'), 

(2128, 63, '2022-06-08', 120.00, 'MBWay', 'Complete'), 

(2129, 63, '2022-07-08', 120.00, 'PayPal', 'Complete'), 

(2130, 63, '2022-08-08', 120.00, 'Cash', 'Complete'), 

(2131, 63, '2022-09-08', 120.00, 'Credit Card', 'Complete'), 

(2132, 63, '2022-10-08', 120.00, 'Debit Card', 'Complete'), 

(2133, 63, '2022-11-08', 120.00, 'MBWay', 'Complete'), 

(2134, 63, '2022-12-08', 120.00, 'PayPal', 'Complete'), 

(2135, 63, '2023-01-08', 120.00, 'Cash', 'Complete'), 

(2136, 63, '2023-02-08', 120.00, 'Credit Card', 'Complete'), 

(2137, 63, '2023-03-08', 120.00, 'Debit Card', 'Complete'), 

(2138, 63, '2023-04-08', 120.00, 'MBWay', 'Complete'), 

(2139, 63, '2023-05-08', 120.00, 'PayPal', 'Complete'), 

(2140, 63, '2023-06-08', 120.00, 'Cash', 'Complete'), 

(2141, 63, '2023-07-08', 120.00, 'Credit Card', 'Complete'), 

(2142, 63, '2023-08-08', 120.00, 'Debit Card', 'Complete'), 

(2143, 63, '2023-09-08', 120.00, 'MBWay', 'Complete'), 

(2144, 63, '2023-10-08', 120.00, 'PayPal', 'Complete'), 

(2145, 63, '2023-11-08', 120.00, 'Cash', 'Complete'), 

(2146, 63, '2023-12-08', 120.00, 'Credit Card', 'Complete'), 

(2147, 64, '2019-11-15', 120.00, 'Debit Card', 'Complete'), 

(2148, 64, '2019-12-15', 120.00, 'MBWay', 'Complete'), 

(2149, 64, '2020-01-15', 120.00, 'PayPal', 'Complete'), 

(2150, 64, '2020-02-15', 120.00, 'Cash', 'Complete'), 

(2151, 64, '2020-03-15', 120.00, 'Credit Card', 'Complete'), 

(2152, 64, '2020-04-15', 120.00, 'Debit Card', 'Complete'), 

(2153, 64, '2020-05-15', 120.00, 'MBWay', 'Complete'), 

(2154, 64, '2020-06-15', 120.00, 'PayPal', 'Complete'), 

(2155, 64, '2020-07-15', 120.00, 'Cash', 'Complete'), 

(2156, 64, '2020-08-15', 120.00, 'Credit Card', 'Complete'), 

(2157, 64, '2020-09-15', 120.00, 'Debit Card', 'Complete'), 

(2158, 64, '2020-10-15', 120.00, 'MBWay', 'Complete'), 

(2159, 64, '2020-11-15', 120.00, 'PayPal', 'Complete'), 

(2160, 64, '2020-12-15', 120.00, 'Cash', 'Complete'), 

(2161, 64, '2021-01-15', 120.00, 'Credit Card', 'Complete'), 

(2162, 64, '2021-02-15', 120.00, 'Debit Card', 'Complete'), 

(2163, 64, '2021-03-15', 120.00, 'MBWay', 'Complete'), 

(2164, 64, '2021-04-15', 120.00, 'PayPal', 'Complete'), 

(2165, 64, '2021-05-15', 120.00, 'Cash', 'Complete'), 

(2166, 64, '2021-06-15', 120.00, 'Credit Card', 'Complete'), 

(2167, 64, '2021-07-15', 120.00, 'Debit Card', 'Complete'), 

(2168, 64, '2021-08-15', 120.00, 'MBWay', 'Complete'), 

(2169, 64, '2021-09-15', 120.00, 'PayPal', 'Complete'), 

(2170, 64, '2021-10-15', 120.00, 'Cash', 'Complete'), 

(2171, 64, '2021-11-15', 120.00, 'Credit Card', 'Complete'), 

(2172, 64, '2021-12-15', 120.00, 'Debit Card', 'Complete'), 

(2173, 64, '2022-01-15', 120.00, 'MBWay', 'Complete'), 

(2174, 64, '2022-02-15', 120.00, 'PayPal', 'Complete'), 

(2175, 64, '2022-03-15', 120.00, 'Cash', 'Complete'), 

(2176, 64, '2022-04-15', 120.00, 'Credit Card', 'Complete'), 

(2177, 64, '2022-05-15', 120.00, 'Debit Card', 'Complete'), 

(2178, 64, '2022-06-15', 120.00, 'MBWay', 'Complete'), 

(2179, 64, '2022-07-15', 120.00, 'PayPal', 'Complete'), 

(2180, 64, '2022-08-15', 120.00, 'Cash', 'Complete'), 

(2181, 64, '2022-09-15', 120.00, 'Credit Card', 'Complete'), 

(2182, 64, '2022-10-15', 120.00, 'Debit Card', 'Complete'), 

(2183, 64, '2022-11-15', 120.00, 'MBWay', 'Complete'), 

(2184, 64, '2022-12-15', 120.00, 'PayPal', 'Complete'), 

(2185, 64, '2023-01-15', 120.00, 'Cash', 'Complete'), 

(2186, 64, '2023-02-15', 120.00, 'Credit Card', 'Complete'), 

(2187, 64, '2023-03-15', 120.00, 'Debit Card', 'Complete'), 

(2188, 64, '2023-04-15', 120.00, 'MBWay', 'Complete'), 

(2189, 64, '2023-05-15', 120.00, 'PayPal', 'Complete'), 

(2190, 64, '2023-06-15', 120.00, 'Cash', 'Complete'), 

(2191, 64, '2023-07-15', 120.00, 'Credit Card', 'Complete'), 

(2192, 64, '2023-08-15', 120.00, 'Debit Card', 'Complete'), 

(2193, 64, '2023-09-15', 120.00, 'MBWay', 'Complete'), 

(2194, 64, '2023-10-15', 120.00, 'PayPal', 'Complete'), 

(2195, 64, '2023-11-15', 120.00, 'Cash', 'Complete'), 

(2196, 64, '2023-12-15', 120.00, 'Credit Card', 'Complete'), 

(2197, 65, '2019-05-01', 120.00, 'Debit Card', 'Complete'), 

(2198, 65, '2019-06-01', 120.00, 'MBWay', 'Complete'), 

(2199, 65, '2019-07-01', 120.00, 'PayPal', 'Complete'), 

(2200, 65, '2019-08-01', 120.00, 'Cash', 'Complete'), 

(2201, 65, '2019-09-01', 120.00, 'Credit Card', 'Complete'), 

(2202, 65, '2019-10-01', 120.00, 'Debit Card', 'Complete'), 

(2203, 65, '2019-11-01', 120.00, 'MBWay', 'Complete'), 

(2204, 65, '2019-12-01', 120.00, 'PayPal', 'Complete'), 

(2205, 65, '2020-01-01', 120.00, 'Cash', 'Complete'), 

(2206, 65, '2020-02-01', 120.00, 'Credit Card', 'Complete'), 

(2207, 65, '2020-03-01', 120.00, 'Debit Card', 'Complete'), 

(2208, 65, '2020-04-01', 120.00, 'MBWay', 'Complete'), 

(2209, 65, '2020-05-01', 120.00, 'PayPal', 'Complete'), 

(2210, 65, '2020-06-01', 120.00, 'Cash', 'Complete'), 

(2211, 65, '2020-07-01', 120.00, 'Credit Card', 'Complete'), 

(2212, 65, '2020-08-01', 120.00, 'Debit Card', 'Complete'), 

(2213, 65, '2020-09-01', 120.00, 'MBWay', 'Complete'), 

(2214, 65, '2020-10-01', 120.00, 'PayPal', 'Complete'), 

(2215, 65, '2020-11-01', 120.00, 'Cash', 'Complete'), 

(2216, 65, '2020-12-01', 120.00, 'Credit Card', 'Complete'), 

(2217, 65, '2021-01-01', 120.00, 'Debit Card', 'Complete'), 

(2218, 65, '2021-02-01', 120.00, 'MBWay', 'Complete'), 

(2219, 65, '2021-03-01', 120.00, 'PayPal', 'Complete'), 

(2220, 65, '2021-04-01', 120.00, 'Cash', 'Complete'), 

(2221, 65, '2021-05-01', 120.00, 'Credit Card', 'Complete'), 

(2222, 65, '2021-06-01', 120.00, 'Debit Card', 'Complete'), 

(2223, 65, '2021-07-01', 120.00, 'MBWay', 'Complete'), 

(2224, 65, '2021-08-01', 120.00, 'PayPal', 'Complete'), 

(2225, 65, '2021-09-01', 120.00, 'Cash', 'Complete'), 

(2226, 65, '2021-10-01', 120.00, 'Credit Card', 'Complete'), 

(2227, 65, '2021-11-01', 120.00, 'Debit Card', 'Complete'), 

(2228, 65, '2021-12-01', 120.00, 'MBWay', 'Complete'), 

(2229, 65, '2022-01-01', 120.00, 'PayPal', 'Complete'), 

(2230, 65, '2022-02-01', 120.00, 'Cash', 'Complete'), 

(2231, 65, '2022-03-01', 120.00, 'Credit Card', 'Complete'), 

(2232, 65, '2022-04-01', 120.00, 'Debit Card', 'Complete'), 

(2233, 65, '2022-05-01', 120.00, 'MBWay', 'Complete'), 

(2234, 65, '2022-06-01', 120.00, 'PayPal', 'Complete'), 

(2235, 65, '2022-07-01', 120.00, 'Cash', 'Complete'), 

(2236, 65, '2022-08-01', 120.00, 'Credit Card', 'Complete'), 

(2237, 65, '2022-09-01', 120.00, 'Debit Card', 'Complete'), 

(2238, 65, '2022-10-01', 120.00, 'MBWay', 'Complete'), 

(2239, 65, '2022-11-01', 120.00, 'PayPal', 'Complete'), 

(2240, 65, '2022-12-01', 120.00, 'Cash', 'Complete'), 

(2241, 65, '2023-01-01', 120.00, 'Credit Card', 'Complete'), 

(2242, 65, '2023-02-01', 120.00, 'Debit Card', 'Complete'), 

(2243, 65, '2023-03-01', 120.00, 'MBWay', 'Complete'), 

(2244, 65, '2023-04-01', 120.00, 'PayPal', 'Complete'), 

(2245, 65, '2023-05-01', 120.00, 'Cash', 'Complete'), 

(2246, 65, '2023-06-01', 120.00, 'Credit Card', 'Complete'), 

(2247, 65, '2023-07-01', 120.00, 'Debit Card', 'Complete'), 

(2248, 65, '2023-08-01', 120.00, 'MBWay', 'Complete'), 

(2249, 65, '2023-09-01', 120.00, 'PayPal', 'Complete'), 

(2250, 65, '2023-10-01', 120.00, 'Cash', 'Complete'), 

(2251, 65, '2023-11-01', 120.00, 'Credit Card', 'Complete'), 

(2252, 65, '2023-12-01', 120.00, 'Debit Card', 'Complete');

-- Triggers
-- Update trigger for status payment: 
DELIMITER $$
CREATE TRIGGER update_payment_status
BEFORE UPDATE ON payment
FOR EACH ROW
BEGIN
    IF NEW.Status = 'Not Complete' THEN
        SET NEW.Status = 'Complete';
    END IF;
END$$

DELIMITER $$
CREATE TRIGGER insert_member_row
AFTER INSERT ON members
FOR EACH ROW
BEGIN
    -- Insert a new row into the "members" table
    IF NEW.LevelID = 1 THEN
        INSERT INTO members (memberFName, memberLName, DateOfBirth, Gender, email, Address, PhoneNumber, LevelID, SubscriptionDate, RateSatisfaction)
        VALUES ('NewMember', 'Default', '2000-01-01', 'M', 'newmember@example.com', 'Default Address', '1234567890', 2, NOW(), 5);
        
        -- Insert a log entry for the new member
        INSERT INTO log (EventType, Details)
        VALUES ('Member Insert', CONCAT('New member with ID ', LAST_INSERT_ID(), ' inserted.'));
    END IF;
END $$



-- Queries

-- Query 1
SELECT
    m.memberID,
    m.memberFName,
    p.InvoiceID,
    p.PaymentDate
FROM
    members m
JOIN
    payment p ON m.memberID = p.memberID #inner join with payment
WHERE
    p.PaymentDate BETWEEN '2023-03-22' AND '2023-05-22'; #--manual inserted dates
    
-- Query 2
SELECT
    CONCAT(memberFName, ' ', memberLName) AS FullName,
    SubscriptionDate,
    DATEDIFF(CURDATE(), SubscriptionDate) AS MembershipDuration 
FROM Members                                               
ORDER BY SubscriptionDate ASC
LIMIT 3;

-- Query 3
SELECT
  CONCAT(MIN(PaymentDate),' - ', MAX(PaymentDate)) AS PeriodOfSales,
  SUM(Amount) AS TotalSales,
  SUM(Amount)/TIMESTAMPDIFF(YEAR, MIN(PaymentDate), MAX(PaymentDate)) AS YearlyAverage,
  SUM(Amount)/TIMESTAMPDIFF(MONTH, MIN(PaymentDate), MAX(PaymentDate)) AS MonthlyAverage
FROM
  payment
WHERE 
   Status = 'Complete'
ORDER BY
  PeriodOfSales;
  
 -- Query 4
 SELECT
    c.CITY_NAME AS City,
    COUNT(m.memberID) AS TotalSubscriptions
FROM
    members m
    JOIN Level lv ON m.LevelID = lv.LevelID
    JOIN location l ON lv.LocationID = l.LOCATION_ID
    JOIN city c ON l.CITY_ID = c.CITY_ID
GROUP BY
    c.CITY_NAME, l.CITY_ID;
  
  -- Query 5
  SELECT DISTINCT
   l.LOCATION_ID,
   c.CITY_NAME,
   lv.LevelName,
   p.memberID,
   p.RateSatisfaction
FROM
   location l
JOIN Level lv ON l.LOCATION_ID = lv.LocationID
JOIN members p ON lv.LevelID = p.LevelID
JOIN city c ON l.CITY_ID = c.CITY_ID
WHERE
   p.RateSatisfaction IS NOT NULL;


-- VIEWS
-- view 1
CREATE VIEW head_view AS
SELECT
    m.memberID,
    m.memberFName,
    m.memberLName,
    m.Address,
    m.PhoneNumber,
    l.Location_Name,
    l.STREET_ADDRESS,
    l.POSTAL_CODE,
    MAX(p.InvoiceID) AS TotalInvoiceID,
    MAX(p.PaymentDate) AS TotalPaymentDate,
    SUM(p.Amount) AS InvoiceTotal
FROM
    payment p
JOIN
    members m ON p.memberID = m.memberID
JOIN
    Level lv ON m.LevelID = lv.LevelID
JOIN
    location l ON lv.LocationID = l.LOCATION_ID
WHERE
	YEAR(p.PaymentDate) IN (2022, 2023)
GROUP BY
    m.memberID, m.memberFName, m.memberLName, m.Address, m.PhoneNumber, l.Location_Name, l.STREET_ADDRESS, l.POSTAL_CODE;


SELECT * FROM head_view;

-- view 2
CREATE VIEW invoice_details AS
SELECT
	p.InvoiceID,
    p.Amount,
    p.Status,
    l.LevelName
FROM
    payment p
JOIN
    members m ON p.memberID = m.memberID
JOIN
    level l ON m.LevelID = l.LevelID
WHERE
    YEAR(p.PaymentDate) IN (2022, 2023)
GROUP BY
    p.InvoiceID;
    
Select * from invoice_details;