-- --------------------------------------------------------------------------------
-- Name: Tom Lytle
-- Class: IT-111
-- Abstract: Fixinyerleaks final project 
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1;   -- Get out of the master database
SET NOCOUNT ON;		-- Report only errors

-- uspCleanDatabase

-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------

IF OBJECT_ID ('TJobEmployees')				IS NOT NULL DROP TABLE TJobEmployees
IF OBJECT_ID ('TJobMaterials')				IS NOT NULL DROP TABLE TJobMaterials
IF OBJECT_ID ('TJobs')						IS NOT NULL DROP TABLE TJobs
IF OBJECT_ID ('TJobStatus')					IS NOT NULL DROP TABLE TJobStatus
IF OBJECT_ID ('TMaterials')					IS NOT NULL DROP TABLE TMaterials
IF OBJECT_ID ('TVendors')					IS NOT NULL DROP TABLE TVendors
IF OBJECT_ID ('TSkillSkillLevelEmployees')	IS NOT NULL DROP TABLE TSkillSkillLevelEmployees
IF OBJECT_ID ('TSkills')					IS NOT NULL DROP TABLE TSkills
IF OBJECT_ID ('TSkillLevels')				IS NOT NULL DROP TABLE TSkillLevels
IF OBJECT_ID ('TCustomers')					IS NOT NULL DROP TABLE TCustomers
IF OBJECT_ID ('TStates')					IS NOT NULL DROP TABLE TStates
IF OBJECT_ID ('TZips')						IS NOT NULL DROP TABLE TZips
IF OBJECT_ID ('TEmployees')					IS NOT NULL DROP TABLE TEmployees


-- --------------------------------------------------------------------------------
-- Step #1.1: Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TStates
(
		intStateID					INTEGER				NOT NULL
		,strState					VARCHAR(25)			NOT NULL
		,CONSTRAINT TStates_PK PRIMARY KEY ( intStateID)
)

CREATE TABLE TZips
(
		intZipID					INTEGER				NOT NULL
		,strZip						VARCHAR(25)			NOT NULL
		,CONSTRAINT TZips_PK PRIMARY KEY ( intZipID )
)

CREATE TABLE TCustomers
(
		intCustomerID				INTEGER				NOT NULL
		,strFirstNAme				VARCHAR(25)			NOT NULL
		,strLastName				VARCHAR(25)			NOT NULL
		,strAddress					VARCHAR(25)			NOT NULL
		,strCity					VARCHAR(25)			NOT NULL
		,intStateID					INTEGER				NOT NULL
		,intZipID					INTEGER				NOT NULL
		,strPhoneNumber				VARCHAR(25)			NOT NULL
		,strEmail					VARCHAR(50)			NOT NULL
		,CONSTRAINT TCustomer_PK PRIMARY KEY ( intCustomerID )
)

CREATE TABLE TJobStatus
(
		intJobStatusID				INTEGER				NOT NULL
		,strJobStatus				VARCHAR(25)			NOT NULL
		,CONSTRAINT TJobStatus_PK PRIMARY KEY ( intJobStatusID )
)

CREATE Table TJobs
(
		intJobID					INTEGER				NOT NULL
		,strJobDesc					VARCHAR(2000)		NOT NULL
		,dtmStartDate				DATETIME			NOT NULL
		,dtmEndDate					DATETIME			NOT NULL
		,intJobStatusID				INTEGER				NOT NULL
		,intCustomerID				INTEGER				NOT NULL
		,CONSTRAINT TJobs_PK PRIMARY KEY	( intJobID )
)

CREATE TABLE TVendors
(
		intVendorID					INTEGER				NOT NULL
		,strVendorName				VARCHAR(50)			NOT NULL
		,strAddress					VARCHAR(25)			NOT NULL
		,strCity					VARCHAR(25)			NOT NULL
		,intStateID					INTEGER				NOT NULL
		,intZipID					INTEGER				NOT NULL
		,strPhone					VARCHAR(25)			NOT NULL
		,strEmail					VARCHAR(50)			NOT NULL
		,strContactFirstName		VARCHAR(25)			NOT NULL
		,strContactLastName			VARCHAR(25)			NOT NULL
		,CONSTRAINT TVendors_PK PRIMARY KEY ( intVendorID )
)

CREATE TABLE TMaterials
(
		intMaterialID				INTEGER				NOT NULL
		,strMaterialDesc			VARCHAR(50)			NOT NULL
		,monCostOfMaterial			MONEY				NOT NULL
		,intVendorID				INTEGER				NOT NULL
		,CONSTRAINT TMaterials_PK PRIMARY KEY ( intMAterialID )
)

CREATE TABLE TJobMaterials
(
		intJobMaterialID			INTEGER				NOT NULL
		,intJobID					INTEGER				NOT NULL
		,intMaterialID				INTEGER				NOT NULL
		,intNumberofMaterialUsed	INTEGER				NOT NULL
		,CONSTRAINT TJobMaterials_PK Primary Key	( intJobMaterialID )
)

CREATE TABLE TEmployees
(
		intEmployeeID				INTEGER				NOT NULL
		,strFirstName				VARCHAR(25)			NOT NULL
		,strLastName				VARCHAR(25)			NOT NULL
		,dtmHireDate				DATETIME			NOT NULL
		,monPayRate					MONEY				NOT NULL
		,CONSTRAINT TEmployees_PK PRIMARY KEY ( intEmployeeID )
)

CREATE TABLE TJobEmployees
(
		intJobEmployeeID			INTEGER				NOT NULL
		,intJobID					INTEGER				NOT NULL
		,intEmployeeID				INTEGER				NOT NULL
		,intHoursWorked				INTEGER				NULL
		,CONSTRAINT TJobEmployees_PK PRIMARY KEY ( intJobEmployeeID )
)

CREATE TABLE TSkills
(
		intSkillID					INTEGER				NOT NULL
		,strSkillDesc				VARCHAR(25)			NOT NULL
		,CONSTRAINT TSkills_PK Primary KEY ( intSkillID )
)

CREATE TABLE TSkillLevels
(
		intSkillLevelID					INTEGER					NOT NULL
		,strSkillLevel					VARCHAR(25)				NOT NULL
		,CONSTRAINT TSkillLevels_PK PRIMARY KEY ( intSkillLevelID )
)

CREATE TABLE TSkillSkillLevelEmployees
(
		intSkillSkillLevelEmployeeID		INTEGER			NOT NULL
		,intSkillID						INTEGER			    NULL
		,intSkillLevelID				INTEGER				NOT NULL
		,intEmployeeID					INTEGER				NOT NULL
		,CONSTRAINT TSkillSkilllevelEmployees_PK PRIMARY KEY ( intSkillSkillLevelEmployeeID )
)
-- --------------------------------------------------------------------------------
-- Step #1.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child										Parent							Column(s)
-- -	-----										------							---------
-- 1	TCustomers									TStates							intStateID
-- 2	TCustomers									TZips							intZipID
-- 3	TJobs										TCustomers						intCustomerID
-- 4	TJobs										TJobStatus						intJobStatusID
-- 5	TJobEmployees								TJobs							intJobID
-- 6    TJobMaterials								TJobs							intJobID
-- 7	TJobMaterials								TMaterials						intMaterialID
-- 8	TMaterials									TVendors						intVendorID
-- 9	TVendors									TStates							intStateID
-- 10	TVendors									TZips							intZipID
-- 11	TJobEmployees								TEmployees						intEmployeeID
-- 12   TSkillSKillLevelEmployees					TEmployees						intEmployeeID
-- 13	TSkillSKillLevelEmployees					TSkills							intSkillID
-- 14	TSkillSKillLevelEmployees					TSkillLevel						intSkillLevelID
		

-- 1
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )

-- 2
ALTER TABLE TCustomers ADD CONSTRAINT TCustomers_TZips_FK
FOREIGN KEY ( intZipID ) REFERENCES TZips ( intZipID )

-- 3
ALTER TABLE TJobs ADD CONSTRAINT TJobs_TCustomers_FK
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers ( intCustomerID )

-- 4
ALTER TABLE TJobs ADD CONSTRAINT TJobs_TJobStatus_FK
FOREIGN KEY ( intJobStatusID ) REFERENCES TJobStatus ( intJobStatusID )

-- 5

ALTER TABLE TJobEmployees ADD CONSTRAINT TJobEmployees_TJobs_FK
FOREIGN KEY ( intJobID ) REFERENCES TJobs ( intJobID )

-- 6
ALTER TABLE TJobMaterials ADD CONSTRAINT TJobMaterials_TJobs_FK
FOREIGN KEY ( intJobId ) REFERENCES TJobs ( intJobID )

-- 7
ALTER TABLE TJobMaterials ADD CONSTRAINT TJobMaterials_TMaterials_FK
FOREIGN KEY ( intMaterialID ) REFERENCES TMaterials ( intMaterialID )

-- 8
ALTER TABLE TMaterials ADD CONSTRAINT TMaterials_TVendors_FK
FOREIGN KEY ( intVendorID ) REFERENCES TVendors ( intVendorID )

-- 9
ALTER TABLE TVendors ADD CONSTRAINT TVendors_TStates_FK
FOREIGN KEY ( intStateID ) REFERENCES TStates ( intStateID )

-- 10
ALTER TABLE TVendors ADD CONSTRAINT TVendors_TZips_FK
FOREIGN KEY ( intZipID ) REFERENCES TZips ( intZipID )

-- 11
ALTER TABLE TJobEmployees ADD CONSTRAINT TJobEmployees_TEmployees_FK
FOREIGN KEY ( intEmployeeID ) REFERENCES TEmployees ( intEmployeeID )

-- 12
ALTER TABLE TSkillSKillLevelEmployees ADD CONSTRAINT TSkillSKillLevelEmployees_TEmployees_FK
FOREIGN KEY ( intEmployeeID ) REFERENCES TEmployees ( intEmployeeID )

-- 13
ALTER TABLE TSkillSKillLevelEmployees ADD CONSTRAINT TSkillSKillLevelEmployees_TSkills_FK
FOREIGN KEY ( intSkillID) REFERENCES TSkills ( intSkillId )

-- 14
ALTER TABLE TSkillSKillLevelEmployees ADD CONSTRAINT TSkillSKillLevelEmployees_TSkillLevel_FK
FOREIGN KEY ( intSkillLevelID ) REFERENCES TSKillLevels ( intSkillLevelID )



-- --------------------------------------------------------------------------------
-- Add Records into States
-- --------------------------------------------------------------------------------
INSERT INTO TStates ( intStateID, strState)
VALUES				 ( 1, 'Ohio')
					,( 2, 'Kentucky')
					,( 3, 'Indiana')

-- --------------------------------------------------------------------------------
-- Add Records into Zips
-- --------------------------------------------------------------------------------					
INSERT INTO TZips  ( intZipID, strZip)
VALUES				( 1, '45069')
				   ,( 2, '45054')
				   ,( 3, ' 65874')
				   ,( 4, '12365')
				   ,( 5, '85465')

-- --------------------------------------------------------------------------------
-- Add Records into Customers
-- --------------------------------------------------------------------------------
INSERT INTO TCustomers ( intCustomerID, strFirstName, strLastName, strAddress, strCity, intStateID, intZipID, strPhoneNumber, strEmail)
VALUES					( 1, 'Bill', 'Nye', '8500 Mason-Montgomery Rd', 'Mason', 1, 1, '513-875-5412', 'bnye@gmail.com')
					   ,( 2, 'Nancy', 'Drew', '8745 Hummingbird Lane', 'Birdville', 2, 2, '513-987-5221', 'birdlady@yahoo.com')
					   ,( 3, 'Laura', 'Lee', '4323 Oak Tree Court', 'Mainville', 3, 3, '541-855-9874', 'll762@icloud.com')
					   ,( 4, 'Tim', 'McDaniels', '4342 Main Street', 'Hebron', 3, 4, '859-541-8854', 'tdog@aol.com')
					   ,( 5, 'Julie', 'Sharp', '5832 Main Street', 'Rising Run', 2, 5, '541-987-5210' ,' krazykats@gmail.com')
					   ,( 6, 'Megan', 'Moore', '543 Main Street', 'Mason' , 1, 1, '513-987-5612', 'mm@gmail.com')

-- --------------------------------------------------------------------------------
-- Add Records into JobStatus
-- --------------------------------------------------------------------------------	
INSERT INTO TJobStatus ( intJobStatusID, strJobStatus)
VALUES					( 1, 'Open')
					   ,( 2, 'In Process')
					   ,( 3, 'Complete')
					   


-- --------------------------------------------------------------------------------
-- Add Records into Jobs
-- --------------------------------------------------------------------------------
INSERT INTO TJobs ( intJobID, strJobDesc, dtmStartDate, dtmEndDate, intJobStatusID, intCustomerID)
VALUES				( 1, 'Leaking water main', '01/01/2010', '02/01/2010', 1, 1)
				   ,( 2, 'frozen pipes, clogged drains', '06/01/2021', '06/03/2021', 2, 2)
				   ,( 3, 'need to install water irrigation system', '08/01/2021', '08/03/2021', 3, 3)
				   ,( 4, 'installing water lines in new build', '07/02/2019', '09/01/2016', 1, 4)
				   ,( 5, 'leaking pipes in second story master bath', '06/01/2008', '06/05/2008', 2, 5)
				   ,( 6, 'replacing lead pipes', '09/02/2015', '10/01/2015', 3, 4)
				   ,( 7, 'installing outdoor water spicket', '08/05/2020', '11/01/2020', 3, 1)
				   ,( 8, 'replacing water main shut off valve', '08/15/2021', '08/16/2021', 1 ,1)
				   ,( 9, 'water leak', '07/01/2015', '07/02/2015', 3, 1)
				   ,( 10, 'replace bath tub', '08/01/2021', '08/03/2021', 3, 1)
				   ,( 11, 'install sink', '08/02/2021', '08/05/2021', 3, 1)
				   ,( 12, 'install rough in bathroom in basement', '08/01/2020', '08/20/2020', 2, 1)
				   ,( 13, 'test water for lead', '02/05/2020', '02/06/2020', 1, 4)
				
-- --------------------------------------------------------------------------------
-- Add Records into Vendors
-- --------------------------------------------------------------------------------
INSERT INTO TVendors ( intVendorID, strVendorName, strAddress, strCity, intStateID, intZipID, strPhone, strEmail, strContactFirstName, strContactLastName) 
VALUES				( 1, 'Bills Pipes', '4321Plumbing Drive', 'Owensville', 1, 1, '513-854-8852', 'sales@billspipes.com', 'Bill', 'Newmann')
				   ,( 2, 'Menards', '4577 Lumberway', 'Mason', 2, 2, '513-874-8854', 'plumbing@menards.com', 'Janrt', 'Smokes')
				   ,( 3, 'PVC R US', '532 Plastic', 'Dayton', 3, 3, '541-987-5541', 'orders@pcvrus.com', 'Spike', 'Lee')
				   ,( 4, 'Avaya', '432 Bikini Bottom', 'Spongebob', 2, 3, '541-985-1235', 'crabypatty@gmail.com', 'Patrick', 'Star')
				   ,( 5, 'Aero Armor', '44732 Run Mills Road', 'Hebron', 1, 2, '859-874-8856', 'order@aero.com','Susan', 'Clayton')

-- --------------------------------------------------------------------------------
-- Add Records into Materials
-- --------------------------------------------------------------------------------
INSERT INTO TMaterials ( intMaterialID, strMaterialDesc, monCostofMaterial, intVendorID)
VALUES					( 1, 'PVC SCh 40', 0.25, 1)
					   ,( 2, 'Sealant', 5.50, 2)
					   ,( 3, 'Thread Tape', .32, 3)
					   ,( 4, 'Wall Mounts', 10.12, 4)
					   ,( 5, 'Flex Hose', 18.35, 5)
					   ,( 6, 'shut off valves', 120.20, 5)
					   ,( 7, 'Faucet', 10.99, 4)
					   ,( 8, 'sprinkler head', 2.46, 3)
					   ,( 9, 'Fire sprinkler', 55.23, 3)
					   ,( 10, 'Shower head', 1.23, 5)
					   ,( 11, 'Glue', 5.00, 1)


-- --------------------------------------------------------------------------------
-- Add Records into JobMaterials
-- --------------------------------------------------------------------------------
INSERT INTO TJobMaterials ( intJobMaterialID, intJobID, intMaterialID, intNumberofMaterialUsed)
VALUES						( 1, 1, 1, 19)
						   ,( 2, 2, 2, 1)
						   ,( 3, 3, 3, 5)
						   ,( 4, 4, 4, 2)
						   ,( 5, 5, 5, 6)
						   ,( 6, 3, 2, 10)
						   ,( 7, 7, 3, 3)
						   ,( 8, 8, 1, 1)
						   ,( 9, 1, 3, 5)
						   ,( 10, 9, 2, 2)
						   ,( 11, 10, 1, 5)
						   ,( 12, 11, 2, 1)
						   ,( 13, 12, 3, 2)
						   ,( 14, 1, 8, 1)
						   ,( 15, 1, 11, 1)
						   



-- --------------------------------------------------------------------------------
-- Add Records into Employess
-- --------------------------------------------------------------------------------
INSERT INTO TEmployees ( intEmployeeID, strFirstName, strLastName, dtmHireDate, monPayRate)
VALUES					( 1, 'Joe', 'Morgan', '08/01/2020', 25.12)
					   ,( 2, 'Nancy', 'Williams', '07/01/2021', 15.23)
					   ,( 3, 'Teresa', 'Farmer', '01/05/2017', 18.93)
					   ,( 4, 'Brayden', 'Thomas', '09/16/2013', 12.52)
					   ,( 5, 'Adalynn', 'May', '04/01/2011', 23.42)
					   ,( 6, 'Finley', 'Ballie', '08/19/2021', 9.57) 


-- --------------------------------------------------------------------------------
-- Add Records into JobEmployees
-- --------------------------------------------------------------------------------
INSERT INTO TJobEmployees ( intJobEmployeeID, intJobID, intEmployeeID, intHoursWorked)
VALUES						( 1, 1, 1, 5)
						   ,( 2, 2, 2, 3)
						   ,( 3, 3, 3, 2)
						   ,( 4, 4, 4, 2)
						   ,( 5, 5, 5, 30)
						   ,( 6, 5, 4, 2)
						   ,( 7, 1, 3, 12)
						   ,( 8, 8, 3, 3)
						   ,( 9, 9, 3, 2)
						   ,( 10, 1, 1, 1)
						   ,(11, 6, 1, 1)
						   ,( 12, 7, 2, 3)
						   ,( 13, 10, 3, 1)
						   ,( 14, 11, 4, 2)
						   ,( 15, 12, 1, 1)

-- --------------------------------------------------------------------------------
-- Add Records into Skills
-- --------------------------------------------------------------------------------
INSERT INTO TSkills ( intSkillID, strSkillDesc)
VALUES				( 1, 'Welder')
				   ,( 2, 'Pipe Cutter')
				   ,( 3, 'Pipe Repairer')
				   ,( 4, 'Heavy Machine Operator')
				   ,( 5, 'Long Haul Driver')

-- --------------------------------------------------------------------------------
-- Add Records into SkillLevel
-- --------------------------------------------------------------------------------
INSERT INTO TSkillLevels	( intSkillLevelID, strSkillLevel)
VALUES					( 1, 'Master')
					   ,( 2, 'Profecient')
					   ,( 3, 'Apprentice')
					   ,( 4, 'Expert')
					   ,( 5, 'Student')

-- --------------------------------------------------------------------------------
-- Add Records into SkillSkillLEvelEmployee
-- --------------------------------------------------------------------------------
INSERT INTO TSkillSkillLevelEmployees ( intSkillSkillLevelEmployeeID, intSkillID, intSkillLevelID, intEmployeeID)
VALUES			( 1, 1, 1, 1)
			   ,( 2, 2, 2, 2)
			   ,( 3, 3, 3, 3)
			   ,( 4, 4, 4, 4)
			   ,( 5, 5, 5, 5)
			   ,( 6, 5, 5, 3)
			   ,( 7, 2, 4, 1)
			   ,( 8, 2, 3, 4)
			   ,( 9, 2, 1, 3)
			   




---------------------------------------------------------------
--		Updates & Deletes
---------------------------------------------------------------

--3.1 update address for one cutomer. I am going to update TCustomer.intCustomer1

SELECT *

FROM TCustomers

UPDATE TCustomers

SET strAddress = '4432 Bluebird Ct'
    ,strCity = 'Loveland'
	,intZipID = 2

Where TCustomers.intCustomerID = 1

SELECT *
FROM TCustomers


--3.2 increase hourly rate for all employees who have been working for at least a year

SELECT *
FROM TEmployees

UPDATE TEmployees

SET monPayRate = monPayRate + 2
WHERE dtmHireDate < '08/18/2020'

SELECT *
FROM TEmployees

-- 3.3 delete a specific job that has materials and jobs associated with it

SELECT*

FROM TJobs
	

DELETE TJobMaterials

WHERE TJobMaterials.intJobID = 8

DELETE TJobEmployees

WHERE TJobEmployees.intJobID = 8

DELETE TJobs
	   
WHERE TJobs.intJobID = 8

SELECT*

FROM TJobs

---------------------------------------------------
--	Queries
---------------------------------------------------

--4.1 list all jobs in process, include JobID, Description, Customer ID and name, and the start date. Order by the Job ID. 

SELECT TJobs.intJobID, TJobs.strJobDesc, TCustomers.intCustomerID, TCustomers.strFirstName, TCustomers.strLastName, TJobs.dtmStartDate

FROM TJobs Join TJobStatus
ON	TJobs.intJobStatusID = TJobStatus.intJobStatusID

JOIN TCustomers
ON TJobs.intCustomerID = TCustomers.intCustomerID

WHERE TJobStatus.strJobStatus = 'In Process'

ORDER BY TJobs.intJobID

-- 4.2.		Write a query to list all complete jobs for a specific customer and the materials used on each job. 
--          Include the customer ID and Description, the Material ID and Description, quantity, unit cost, and total cost for 
--			each material on each job. 
--          Order by Job ID and material ID. Note: Select a customer that has at least 3 complete jobs and at least 1 open job 
--			and 1 in process job. 
--			At least one of the complete jobs should have multiple materials. If needed, go back to your inserts and add data. 

SELECT TJobs.intJobID, TCustomers.intCustomerID, TJobs.strJobDesc, TMaterials.intMaterialID
	  ,TMaterials.strMaterialDesc, TJobMaterials.intNumberofMaterialUsed, TMaterials.monCostOfMaterial
	  ,TJobMaterials.intNumberofMaterialUsed * TMaterials.monCostOfMaterial AS Total_Cost
		

From TCustomers JOIN TJobs
ON TCustomers.intCustomerID = TJobs.intCustomerID

JOIN TJobMaterials
ON TJobs.intJobID = TJobMaterials.intJobID

JOIN TMaterials
ON TJobMaterials.intMaterialID = TMaterials.intMaterialID

WHERE TCustomers.intCustomerID = 1

ORDER BY intJobID
		,intMaterialID


--4.3		This step should use the same customer as in step 4.2. Write a query to list the total cost of materials 
--			for each completed job for the customer.  This should result in a row for each job for the customer.  
--			Order by Job ID.  Use the data returned in step 4.2 to validate your results. 	

SELECT TJobs.intJobID ,TCustomers.intCustomerID 
	  ,SUM((TMaterials.monCostOfMaterial * TJobMaterials.intNumberofMaterialUsed )) AS Total_Cost_of_Materials
		

From TCustomers JOIN TJobs
ON TCustomers.intCustomerID = TJobs.intCustomerID

JOIN TJobMaterials
ON TJobs.intJobID = TJobMaterials.intJobID

JOIN TMaterials
ON TJobMaterials.intMaterialID = TMaterials.intMaterialID

WHERE TCustomers.intCustomerID = 1
and	  TJobs.intJobStatusID = 3

GROUP BY TJobs.intJobID
		,TMaterials.intMaterialID
		,TCustomers.intCustomerID
		,TMaterials.strMaterialDesc
		,TJobMaterials.intNumberofMaterialUsed 
		

ORDER BY TJobs.intJobID

--4.4.	Write a query to list all jobs that have work entered for them. Include the job ID, job description, 
--		and job status description. List the total hours worked for each job with the lowest, highest, and average 
--		hourly rate. The average hourly rate should be weighted based on the number of hours worked at that rate. 
--		Make sure that your data includes at least one job that does not have hours logged. This job should not be 
--		included in the query. Order by highest to lowest average hourly rate. 

SELECT TJobs.intJobID, TJobs.strJobDesc, TJobStatus.strJobStatus 
	  ,SUM(TJobEmployees.intHoursWorked) AS Total_Hours_Worked
	  ,AVG(TJobEmployees.intHoursWorked * TEmployees.monPayRate) AS Average_Pay_Rate
	  ,MIN(TJobEmployees.intHoursWorked * TEmployees.monPayRate) AS Lowest_Average_Hourly_Rate
	  ,MAX(TJobEmployees.intHoursWorked * TEmployees.monPayRate) AS Highest_Average_Hourly_Rate

FROM TJobs JOIN TJobStatus
ON TJobs.intJobStatusID = TJobStatus.intJobStatusID

JOIN TJobEmployees
ON TJobEmployees.intJobID = TJobs.intJobID

JOIN TEmployees
ON TEmployees.intEmployeeID = TJobEmployees.intEmployeeID

GROUP BY TJobs.intJobID
		,TJobs.strJobDesc
	    ,TJobStatus.strJobStatus

ORDER BY Highest_Average_Hourly_Rate DESC

--4.5.	Write a query that lists all materials that have not been used on any jobs. 
--      Include Material ID and Description. Order by Material ID. 

SELECT TMaterials.intMaterialID, TMaterials.strMaterialDesc

FROM TMaterials

WHERE TMaterials.intMaterialID NOT IN (SELECT TMaterials.intMaterialID
										FROM TMaterials Join TJobMaterials
											on TMaterials.intMaterialID = TJobMaterials.intMaterialID)

ORDER BY TMaterials.intMaterialID


--4.6.	Create a query that lists all workers with a specific skill, their hire date, 
--		and the total number of jobs that they worked on. Include the Worker ID, 
--		Worker Name, Skill ID and description with each row. Order by Worker ID. 
--		getting all employees with TSkill.intSkillID = 1

SELECT TEmployees.intEmployeeID
	  ,CONCAT(TEmployees.strFirstname, ', ', TEmployees.strLastName) AS Employee_Name
	  ,TEmployees.dtmHireDate
	  ,TSkills.intSkillID, TSkills.strSkillDesc
	  ,SUM(TJobEmployees.intEmployeeID) AS Total_Jobs_Worked

FROM TEmployees JOIN TSkillSkillLevelEmployees
ON TEmployees.intEmployeeID = TSkillSkillLevelEmployees.intEmployeeID

JOIN TSkills
ON TSkills.intSkillID = TSkillSkillLevelEmployees.intSkillID

JOIN TJobEmployees
ON TJobEmployees.intEmployeeID = TEmployees.intEmployeeID


GROUP BY TEmployees.intEmployeeID
		,TEmployees.strLastName
		,TEmployees.strFirstName
		,TEmployees.dtmHireDate
		,TSkills.intSkillID
		,TSkills.strSkillDesc
		
HAVING TSkills.intSkillID = 1

ORDER By TEmployees.intEmployeeID

--4.7.	Create a query that lists all workers that worked greater than 20 hours across all jobs that they worked on. 
--		They do not need to have 20 hours on a single job.  Include the Worker ID and name, number of hours worked,
--		and number of jobs that they worked on. Order by Worker ID. 

SELECT TEmployees.intEmployeeID
	  ,TEmployees.strFirstName +' ' +TEmployees.strLastName AS Employee_Name
	  ,SUM(TJobEmployees.intHoursWorked) AS Total_Hours_Worked
	  ,COUNT(TJobEmployees.intEmployeeID) AS Number_of_Jobs_Worked
	  


FROM TEmployees Join TJobEmployees
ON TEmployees.intEmployeeID = TJobEmployees.intEmployeeID

Group BY TEmployees.intEmployeeID
		,TEmployees.strFirstName
		,TEmployees.strLastName

HAVING  SUM(TJobEmployees.intHoursWorked) > 20

ORDER BY intEmployeeID

--4.8.	Write a query that lists all customers who are located on 'Main Street'. Include the customer Id and full address. 
--		Order by Customer ID. Make sure that you have at least three customers on 'Main Street' each with different house numbers. 
--		Make sure that you also have customers that are not on 'Main Street'. 

SELECT TCustomers.intCustomerID, TCustomers.strAddress, TCustomers.strCity, TZips.strZip, TStates.strState

FROM TCustomers JOIN TZips
ON TCustomers.intStateID = TZips.intZipID

JOIN TStates
ON TStates.intStateID = TCustomers.intStateID

WHERE TCustomers.strAddress  LIKE '%Main%'

ORDER BY TCustomers.intCustomerID

--4.9.	Write a query to list completed jobs that started and ended in the same month. 
--		List Job, Job Status, Start Date and End Date.  Order by Job ID.

SELECT TJobs.intJobID, TJobStatus.strJobStatus, TJobs.dtmStartDate, TJobs.dtmEndDate

FROM TJobs JOIN TJobStatus
ON TJobs.intJobStatusID = TJobStatus.intJobStatusID	

WHERE TJobStatus.strJobStatus = 'complete'
and   Month(TJobs.dtmStartDate) + YEAR(TJobs.dtmStartDate) = MONTH(TJobs.dtmEndDate) + YEAR(TJobs.dtmEndDate)

ORDER BY  TJobs.intJobID
		,TJobs.dtmStartDate
		,TJobs.dtmEndDate

--4.10.	Create a query to list workers that worked on three or more jobs for the same customer.   
--		Include the Worker ID, Worker Name, Customer ID, Customer Name, and the Number of Jobs that they worked on.  
--		Order by Worker ID.

SELECT TEmployees.intEmployeeID
	  ,CONCAT(TEmployees.strLastName, ', ', TEmployees.strFirstName) AS Employee_Name
	  ,COUNT(TJobEmployees.intEmployeeID) AS Jobs_Worked
	  ,TCustomers.intCustomerID
	  ,CONCAT(TCustomers.strLastName, ', ', TCustomers.strFirstName) AS Customer_Name


FROM TEmployees JOIN TJobEmployees
ON TEmployees.intEmployeeID = TJobEmployees.intEmployeeID

JOIN TJobs
ON TJobs.intJobID = TJobEmployees.intJobID

JOIN TCustomers
ON TCustomers.intCustomerID = TJobs.intCustomerID



GROUP BY TEmployees.intEmployeeID
		,TEmployees.strLastName
		,TEmployees.strFirstName
		,TCustomers.intCustomerID
		,TCustomers.strLastName
		,TCustomers.strFirstName
	
HAVING COUNT(TJobEmployees.intEmployeeID) >= 3

ORDER BY TEmployees.intEmployeeID

--4.11.	Create a query to list all workers and their total # of skills. 
--		Make sure that you have workers that have multiple skills and that you have at least 1 
--		worker with no skills. The worker with no skills should be included with a total number 
--		of skills = 0. List Worker ID and name, and Total # of Skills.   
--		Order by lowest to highest # of Skills. 

SELECT TEmployees.intEmployeeID
	  ,CONCAT( TEmployees.strLastName, ', ', TEmployees.strFirstName) AS Employee_Name
	  ,COUNT( TSkillSkillLevelEmployees.intEmployeeID) AS Employee_Skills

FROM TEmployees LEFT JOIN  TSkillSkillLevelEmployees
ON TEmployees.intEmployeeID = TSkillSkillLevelEmployees.intEmployeeID



GROUP BY TEmployees.intEmployeeID
		 ,TEmployees.strLastName
		 ,TEmployees.strFirstName

ORDER BY COUNT(TSkillSkillLevelEmployees.intEmployeeID)

--4.12.	Write a query to list the total Labor costs for each job.   
--      Include the Job ID and Description, Customer ID and Name, total hours worked, 
--		and total cost for those hours worked.  Order by Job ID.


SELECT TJobs.intJobID, TJobs.strJobDesc, TCustomers.intCustomerID
      ,CONCAT(TCustomers.strFirstName, ', ', TCustomers.strLastName) AS Customer_Name
	  ,SUM(intHoursWorked) AS Hours_Worked
	  ,SUM(TJobEmployees.intHoursWorked * TEmployees.monPayRate) AS Total_Cost

FROM TJobs JOIN TCustomers
ON TJobs.intCustomerID = TCustomers.intCustomerID

JOIN TJobEmployees
ON TJobs.intJobID = TJobEmployees.intJobID

JOIN TEmployees
ON TEmployees.intEmployeeID = TJobEmployees.intEmployeeID

GROUP BY TCustomers.intCustomerID
		,TJobs.intJobID
		,TJobs.strJobDesc		
		,Tcustomers.strLastName
		,TCustomers.strFirstName
		
ORDER BY TJobs.intJobID


--4.13.	Write a query that totals what is owed to each vendor for a particular job.   
--		The query should result in 1 row per vendor and should list the Vendor ID, 
--		Vendor Name, Total material cost for a specific job.  Order by highest to 
--		lowest vendor cost.



SELECT TVendors.intVendorID, TVendors.strVendorName, TJobs.intJobID
		,SUM(TJobMaterials.intNumberofMaterialUsed * TMaterials.monCostOfMaterial) Cost_0f_Materials

From TVendors Join TMaterials
ON TVendors.intVendorID = TMaterials.intVendorID

JOIN TJobMaterials
ON TMaterials.intMaterialID = TJobMaterials.intMaterialID

JOIN TJobs
ON TJobs.intJobID = TJobMaterials.intJobID

WHERE TJobs.intJobID = 1

GROUP BY TVendors.intVendorID
		,TVendors.strVendorName
		,TJobs.intJobID


ORDER BY Cost_0f_Materials DESC




--TESTING-- YAY!!!!!!!

--4.4 needs work





