-- Houses Table

CREATE TABLE Houses (
  House_id INT primary key,
  House_name VARCHAR(20),
  Land VARCHAR(20)
);

SELECT * FROM Houses;

INSERT INTO Houses VALUES (000,'Snow','No Land');
INSERT INTO Houses VALUES (100,'Targaryen','Valyrian');
INSERT INTO Houses VALUES (200,'Baratheon','Stormlands');
INSERT INTO Houses VALUES (300,'Lannister','Westerland');
INSERT INTO Houses VALUES (400,'Tyrell','The Reach');
INSERT INTO Houses VALUES (500,'Martell','Dorne');
INSERT INTO Houses VALUES (600,'Arryn','The Vale');
INSERT INTO Houses VALUES (700,'Tully','The Riverlands');
INSERT INTO Houses VALUES (800,'Stark','The North');

-- Marriage Table

SELECT * FROM Marriage;

CREATE TABLE Marriage (
Husband_house VARCHAR(20),
Husband_name VARCHAR(20),
Wife_house VARCHAR(20),
Wife_name VARCHAR(20),
Marriage_id INT PRIMARY KEY AUTO_INCREMENT
);

-- Gen1 Marriage
INSERT INTO Marriage VALUES ('Not Know','Not Know','Not Know','Not Know',NULL);

INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name) VALUES ('Targaryen','Aerys II','Targaryen','Rhaelle');
INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name)VALUES ('Baratheon','Steffon','Estermont','Cassana');
INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name)VALUES ('Lannister','Tywin','Lannister','Joanna');
INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name)VALUES ('Tyrell','Luthor','Redwyne','Olenna');
INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name)VALUES ('Arryn','Jon','Tully','Lysa');
INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name)VALUES ('Tully','Hoster','Whent','Minisa');
INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name)VALUES ('Stark','Rickard','Stark','Lyarra');

-- Gen2 Marriage
INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name)VALUES ('Targaryen','Rhaegar','Martell','Elia');
INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name)VALUES ('Baratheon','Robert','Lannister','Cercei');
INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name)VALUES ('Baratheon','Stannis','Baratheon','Selyse');
INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name)VALUES ('Baratheon','Renly','Tyrell','Margaery');
INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name)VALUES ('Tyrell','Mace','Hightower','Alerie');
INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name)VALUES ('Hoster','Edmure','Frey','Roslin');
INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name)VALUES ('Stark','Eddard','Hoster','Catelyn');
INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name)VALUES ('Bolton','Ramsay','Stark','Sansa');

-- Gen3 Marriage
INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name)VALUES ('Stark','Robb','Maegyr','Talisa');
INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name)VALUES ('Lannister','Joffrey','Tyrell','Margaery');
INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name)VALUES ('Lannister','Myrcella','Tyrell','Margaery');
INSERT INTO Marriage (Husband_house,Husband_name,Wife_house,Wife_name)VALUES ('Lannister','Tommen','Tyrell','Margaery');

UPDATE Marriage 
SET Husband_house = 'Baelish', Husband_name = 'Petyr', Wife_house = 'Tully', Wife_name = 'Lysa' 
WHERE Husband_name = 'Myrcella';

-- Gen1 Table

CREATE TABLE Gen1 (
  member_id INT PRIMARY KEY,
  House_born VARCHAR(20),
  Firstname VARCHAR(20),
  Gender VARCHAR(20),
  Father_name VARCHAR(20),
  Mother_name VARCHAR(20)
);
ALTER TABLE Gen1 CHANGE member_id House_id INT;
ALTER TABLE Gen1 DROP PRIMARY KEY;
ALTER TABLE Gen1 ADD COLUMN Surname VARCHAR(20);
ALTER TABLE Gen1 DROP COLUMN Father_name;
ALTER TABLE Gen1 DROP COLUMN Mother_name;

TRUNCATE TABLE Gen1;

SELECT * FROM Gen1;

INSERT INTO Gen1 VALUES (100,'Targaryen','Aerys II','Male','Targaryen');
INSERT INTO Gen1 VALUES (100,'Targaryen','Rhaelle','Female','Targaryen');
INSERT INTO Gen1 VALUES (200,'Baratheon','Steffon','Male','Baratheon');
INSERT INTO Gen1 VALUES (200,'Estermont','Cassana','Female','Baratheon');
INSERT INTO Gen1 VALUES (300,'Lannister','Tywin','Male','Lannister');
INSERT INTO Gen1 VALUES (300,'Lannister','Joanna','Female','Lannister');
INSERT INTO Gen1 VALUES (400,'Tyrell','Luthor','Male','Tyrell');
INSERT INTO Gen1 VALUES (400,'Redwyne','Olenna','Female','Tyrell');
INSERT INTO Gen1 VALUES (600,'Arryn','Jon','Male','Arryn');
INSERT INTO Gen1 VALUES (700,'Tully','Hoster','Male','Tully');
INSERT INTO Gen1 VALUES (700,'Whent','Minisa','Female','Tully');
INSERT INTO Gen1 VALUES (800,'Stark','Rickard','Male','Stark');
INSERT INTO Gen1 VALUES (800,'Stark','Lyarra','Female','Stark');

UPDATE Gen1 SET House_id = 100 WHERE House_id LIKE '%10%';
UPDATE Gen1 SET House_id = 200 WHERE House_id LIKE '%20%';
UPDATE Gen1 SET House_id = 300 WHERE House_id LIKE '%30%';
UPDATE Gen1 SET House_id = 400 WHERE House_id LIKE '%40%';
UPDATE Gen1 SET House_id = 500 WHERE House_id LIKE '%50%';
UPDATE Gen1 SET House_id = 600 WHERE House_id LIKE '%60%';
UPDATE Gen1 SET House_id = 700 WHERE House_id LIKE '%70%';
UPDATE Gen1 SET House_id = 800 WHERE House_id LIKE '%80%';

ALTER TABLE Gen1 
ADD FOREIGN KEY(House_id) 
REFERENCES Houses(House_id) 
ON DELETE CASCADE;

-- Gen2 Table

CREATE TABLE Gen2 (
  House_id INT,
  House_born VARCHAR(20),
  Firstname VARCHAR(20),
  Gender VARCHAR(20),
  Surname VARCHAR(20),
  Born_by INT
);	
ALTER TABLE Gen2 ALTER COLUMN By_Family SET DEFAULT 1;
ALTER TABLE Gen2 MODIFY House_id INT NULL;
DESCRIBE Gen2;
SELECT * FROM Gen2;

INSERT INTO Gen2 VALUES (100,'Targaryen','Rhaegar','Male','Targaryen',2);
INSERT INTO Gen2 VALUES (100,'Targaryen','Viserys','Male','Targaryen',2);
INSERT INTO Gen2 VALUES (100,'Targaryen','Daenerys','Female','Targaryen',2);
INSERT INTO Gen2 VALUES (200,'Baratheon','Robert','Male','Baratheon',3);
INSERT INTO Gen2 VALUES (200,'Baratheon','Stannis','Male','Baratheon',3);
INSERT INTO Gen2 VALUES (200,'Baratheon','Renly','Male','Baratheon',3);
INSERT INTO Gen2 VALUES (300,'Lannister','Jaime','Male','Lannister',4);
INSERT INTO Gen2 VALUES (300,'Lannister','Tyrion','Male','Lannister',4);
INSERT INTO Gen2 VALUES (300,'Lannister','Cersei','Female','Lannister',4);
INSERT INTO Gen2 VALUES (400,'Tyrell','Mace','Male','Tyrell',5);
INSERT INTO Gen2 VALUES (500,'Martell','Doran','Male','Martell',1);
INSERT INTO Gen2 VALUES (500,'Martell','Oberyn','Male','Martell',1);
INSERT INTO Gen2 VALUES (500,'Martell','Elia','Female','Targaryen',1);
INSERT INTO Gen2 VALUES (600,'Tully','Lysa','Female','Arryn',7);
INSERT INTO Gen2 VALUES (700,'Tully','Edmure','Male','Tully',7);
INSERT INTO Gen2 VALUES (800,'Tully','Catelyn','Female','Stark',7);
INSERT INTO Gen2 VALUES (800,'Stark','Lyanna','Female','Stark',8);
INSERT INTO Gen2 VALUES (800,'Stark','Benjen','Male','Stark',8);
INSERT INTO Gen2 VALUES (800,'Stark','Brandon','Male','Stark',8);
INSERT INTO Gen2 VALUES (800,'Stark','Eddard','Male','Stark',8);

ALTER TABLE Gen2
ADD FOREIGN KEY (By_Family)
REFERENCES Marriage(Marriage_id)
ON DELETE CASCADE;
ALTER TABLE Gen2 
ADD FOREIGN KEY(House_id) 
REFERENCES Houses(House_id) 
ON DELETE SET NULL;

-- Gen3
CREATE TABLE Gen3 (
  House_id INT,
  House_born VARCHAR(20),
  Firstname VARCHAR(20),
  Gender VARCHAR(20),
  Surname VARCHAR(20),
  Born_by INT DEFAULT 1
);

SELECT * FROM Gen3;

INSERT INTO Gen3 VALUES (100,'Targaryen','Aegon','Female','Targaryen',9);
INSERT INTO Gen3 VALUES (100,'Baratheon','Rhaenys','Female','Targaryen',9);
INSERT INTO Gen3 VALUES (200,'Baratheon','Joffrey','Male','Baratheon',10);
INSERT INTO Gen3 VALUES (200,'Baratheon','Myrcella','Female','Baratheon',10);
INSERT INTO Gen3 VALUES (200,'Baratheon','Tommen','Male','Baratheon',10);
INSERT INTO Gen3 VALUES (200,'Baratheon','Shireen','Female','Baratheon',11);
INSERT INTO Gen3 VALUES (400,'Tyrell','Loras','Male','Tyrell',12);
INSERT INTO Gen3 VALUES (400,'Tyrell','Margaery','Female','Tyrell',12);
INSERT INTO Gen3 VALUES (500,'Martell','Trystane','Male','Martell',1);
INSERT INTO Gen3 VALUES (600,'Arryn','Robin','Male','Arryn',6);
INSERT INTO Gen3 VALUES (800,'Stark','Robb','Male','Stark',15);
INSERT INTO Gen3 VALUES (800,'Stark','Brandon','Male','Stark',15);
INSERT INTO Gen3 VALUES (800,'Stark','Rickon','Male','Stark',15);
INSERT INTO Gen3 VALUES (800,'Stark','Sansa','Female','Stark',15);
INSERT INTO Gen3 VALUES (800,'Stark','Arya','Female','Stark',15);
INSERT INTO Gen3 VALUES (000,'Snow','John','Male','Snow',1);

ALTER TABLE Gen3
ADD FOREIGN KEY (By_Family)
REFERENCES Marriage(Marriage_id)
ON DELETE CASCADE;
ALTER TABLE Gen3
ADD FOREIGN KEY(House_id) 
REFERENCES Houses(House_id) 
ON DELETE SET NULL;

ALTER TABLE Gen3 CHANGE By_Family Born_by INT;