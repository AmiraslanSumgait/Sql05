--1. Create a database "Teachers" and add two tables to it.


CREATE DATABASE Teachers

CREATE TABLE Posts(
Id INT PRIMARY KEY ,
[Name] NVARCHAR(20)
)
CREATE TABLE Teachers(
Id INT PRIMARY KEY ,
[Name] NVARCHAR(15),
Code CHAR(10),
IdPost INT  ,
 CONSTRAINT FK_Teachers_IdPost  FOREIGN KEY (IdPost) REFERENCES Posts(Id),
Tel CHAR(7),
Salary INT ,
Rise NUMERIC(6,2),
HireDate DATETIME 
)

--2. Delete the "POSTS" table.
DROP TABLE Posts
--3. In the "TEACHERS" table, delete the "IdPost" column.
ALTER TABLE Teachers DROP CONSTRAINT FK_Teachers_IdPost
ALTER TABLE Teachers DROP COLUMN IdPost

--4. For the "HireDate" column, create a limit: the date of hiring must be at least 01/01/1990.
ALTER TABLE Teachers
ADD CHECK (HireDate>'01-01-1990')
--5. Create a unique constraint for the "Code" colum00.n.
ALTER TABLE Teachers
ADD CONSTRAINT Constraint_Code  UNIQUE (Code)
--6. Change the data type In the Salary field from INTEGER to NUMERIC (6,2)
ALTER TABLE Teachers
ALTER COLUMN Salary NUMERIC(6,2)
--7. Add to the table "TEACHERS" the following restriction: the salary should not be less than
--1000, but also should not Exceed 5000.
ALTER TABLE Teachers
ADD CONSTRAINT CHK_TeacherAge CHECK(Salary>1000 AND Salary<5000)
--8. Rename Tel column to Phone.
 EXEC sp_rename 'Teachers.Tel', 'Phone', 'COLUMN'; 
--9. Change the data type in the Phone field from CHAR (7) to CHAR (11).
ALTER TABLE Teachers
ALTER COLUMN Phone CHAR(11)
--10. Create again the "POSTS" table.
CREATE TABLE Posts(
Id INT PRIMARY KEY ,
[Name] NVARCHAR(20)
)
--11. For the Name field of the "POSTS" table, you must set a limit on the position (professor,
--assistant professor, teacher or assistant).
ALTER TABLE Posts
ADD CONSTRAINT CHK_PostName CHECK([Name]='Assistant professor'OR[Name]='Assistant' OR [Name]='Professor' OR[Name]='Teacher' OR[Name]='Docent')
--12. For the Name field of the "TEACHERS" table, specify a restriction in which to prohibit the
--presence of figures in the teacher's surname.
ALTER TABLE Teachers
ADD Surname NVARCHAR(20);
ALTER TABLE Teachers
ADD CONSTRAINT CK_Teachers_Surname CHECK(Surname NOT LIKE '%[^A-Z]%')
--13. Add the IdPost (int) column to the "TEACHERS" table.
 ALTER TABLE Teachers
ADD IdPost INT
--14. Associate the field IdPost table "TEACHERS" with the field Id of the table "POSTS".
ALTER TABLE Teachers
ADD CONSTRAINT FK_Teachers_IdPost FOREIGN KEY (IdPost)REFERENCES Posts(Id)
TRUNCATE TABLE Posts
INSERT INTO Posts(Id, Name)
VALUES (1, N'Professor');
INSERT INTO Posts (Id, Name)
VALUES (2, N'Teacher');
INSERT INTO Posts (Id, Name)
VALUES (3, N'Teacher');
INSERT INTO Posts (Id, Name)
VALUES (4, N'Assistant');

INSERT INTO Teachers(Id, [Name], Code, IdPost,Phone, Salary, Rise, HireDate)
VALUES 
 (1, N'Sidorov ','0123456789', 1, NULL, 1070, 470, '01.09.1992')
,(2, N'Ramishevsky ','4567890123', 2,' 4567890 ', 1110, 370, '09.09.1998')
,(3, N'Horenko ','1234567890', 3, NULL, 2000, 230, '10.10.2001')
,(4, N'Vibrovsky ','2345678901', 4, NULL, 4000, 170, '01 .09.2003')
,(5, N'Voropaev ', NULL, 4, NULL, 1500, 150, '02.09.2002')
,(6, N'Kuzintsev ','5678901234', 3,' 4567890 ', 3000, 270, '01.01.1991');
--16.1. All job titles.
CREATE VIEW [All Job titles]
AS
SELECT [Name] FROM Posts
SELECT *FROM  [All Job titles]
--16.2. All the names of teachers.
CREATE VIEW [All ts.[Name]AS Job    FROM Teachers
 JOIN Posts ON Posts.Id=Teachers.IdPostthe names of teachers]
AS
SELECT [Name] FROM Teachers
SELECT *FROM [All the names of teachers]

--16.3. The identifier, the name of the teacher, his position, the general s / n (sort by s \ n).

CREATE VIEW [Sort]
AS
SELECT Teachers.Id ,Teachers.[Name]AS TeachersName,Pos
 SELECT *FROM [Sort]
 

 --16.4. Identification number, surname, telephone number (only those who have a phone number)
	
CREATE VIEW [ShowTeacherFields]
AS
SELECT Teachers.Id AS Identifier, Teachers.[Name]AS [Teacher Name],Teachers.Phone FROM Teachers
JOIN Posts ON Posts.Id=Teachers.IdPost
WHERE Teachers.Phone IS NOT NULL
SELECT *FROM ShowTeacherFields

--16.5. Surname, position, date of admission in the format [dd/mm/yy]
CREATE VIEW [ShowTeacherFields1]
AS
SELECT Teachers.[Name]AS TeachersName,Posts.[Name]AS Job,FORMAT(Teachers.HireDate,'dd-MM-yy') AS HireDate FROM Teachers 
JOIN Posts ON Posts.Id=Teachers.IdPost
SELECT * FROM [ShowTeacherFields1]
	
