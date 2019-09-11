-- ************* RUNNING THE SCRIPT ************************************
-- This Script uses "^" as the termination character. 
-- The script can be run from the db2 command window using command
-- db2 -td"^" -f "<file-name>".
-- *********************************************************************

-- *********************************************************************
-- This Script has been tested on DB2 UDB v8.2
-- *********************************************************************

-- ******************************************* 
-- * DDL to create LEAVE table			     * 
-- *******************************************
CREATE TABLE HR_DB.LEAVE
      (EMPNO         CHAR(6)         NOT NULL,
       LYEARMONTH    CHAR(6)         NOT NULL,
       LAVAILABLE    SMALLINT                , 
       LTAKEN        SMALLINT                ,
       LBALANCE      SMALLINT                ,
       WORKINGDAYS   SMALLINT		     ,
       PRIMARY KEY   (EMPNO, LYEARMONTH))^               
      
-- ******************************************* 
-- * DDL to create PAYROLL table             * 
-- *******************************************
CREATE TABLE HR_DB.PAYROLL
      (EMPNO         CHAR(6)         NOT NULL,
       PYEARMONTH    CHAR(6)         NOT NULL,
       SALARYPAID    DECIMAL(9,2)            ,
       BONUSPAID     DECIMAL(9,2)            ,
       COMMPAID      DECIMAL(9,2)            ,
       LOP           SMALLINT)^

-- ******************************************* 
-- * DDL to create table DEVELOPER to store Developer information *
-- *******************************************
CREATE TABLE HR_DB.DEVELOPER
      (DEVELOPER_ID  CHAR(6)         NOT NULL,
       HARDWARE_ID   CHAR(10)                ,
       SKILL_LEVEL   INTEGER                 ,
       SALARY        INTEGER                 ,
       EXPERIENCE    INTEGER                 ,
       PRIMARY KEY  (DEVELOPER_ID))^


-- ******************************************* 
-- * DDL to create table HARDWARE to store hardware information *
-- *******************************************
CREATE TABLE HR_DB.HARDWARE
      (HARDWARE_ID   		CHAR(10)        NOT NULL,
       MOUSE_ID      		VARCHAR(10)             ,
       KEYBOARD_ID   		VARCHAR(10)             ,  
       CPU_ID        		VARCHAR(10)             ,
       MONITOR_ID    		VARCHAR(10)             ,
       MOUSE_INS_VALUE          INTEGER			,
       KEYBOARD_INS_VALUE       INTEGER 		,
       CPU_INS_VALUE		INTEGER			,
       MONITOR_INS_VALUE	INTEGER			,	   
       PRIMARY KEY  		(HARDWARE_ID))^

   
-- ******************************************* 
-- The following foreign key is added later 
-- *******************************************/

ALTER TABLE HR_DB.DEVELOPER
    ADD FOREIGN KEY (HARDWARE_ID)
    REFERENCES HR_DB.HARDWARE
    ON DELETE RESTRICT^

-- ******************************************* 
-- The following indexes are created on HARDWARE table: 
-- *******************************************/

CREATE INDEX HR_DB.XHARDWARE1
       ON HR_DB.HARDWARE (CPU_ID)^


-- ******************************************* 
-- The following foreign key is added later 
-- *******************************************/

---ALTER TABLE HR_DB.DEVELOPER
---    ADD FOREIGN KEY (DEVELOPER_ID)
---    REFERENCES HR_DB.EMP(EMPNO)
---    ON DELETE RESTRICT^
 
-- ******************************************* 
-- * DDL to create table EMP to store Employee information *
-- *******************************************/
CREATE TABLE HR_DB.EMP
      (EMPNO       CHAR(6)         NOT NULL,
       FIRSTNAME   VARCHAR(12)     NOT NULL,
       MIDINIT     CHAR(1)         NOT NULL,
       LASTNAME    VARCHAR(15)     NOT NULL,
       WORKDEPT    CHAR(3)                 ,
       PHONENO     CHAR(4)                 ,
       HIREDATE    DATE                    ,
       JOB         CHAR(8)                 ,
       EDLEVEL     SMALLINT        NOT NULL,
       SEX         CHAR(1)                 ,
       BIRTHDATE   DATE                    ,
       SALARY      DECIMAL(9,2)            ,
       BONUS       DECIMAL(9,2)            ,
       COMM        DECIMAL(9,2)			   ,
       PRIMARY KEY (EMPNO))^

CREATE TABLE HR_DB.PART
      (PARTNO      CHAR(6)         NOT NULL,
       PARTNAME    VARCHAR(12)     NOT NULL,
       TYP         CHAR(1)         NOT NULL,
       QUANTITY    SMALLINT        NOT NULL,
       PRIMARY KEY (PARTNO))^

-- ******************************************* 
-- * DDL to create table DEPT to store Department information *
-- *******************************************/
CREATE TABLE HR_DB.DEPT
      (DEPTNO    CHAR(3)           NOT NULL,
       DEPTNAME  VARCHAR(36)       NOT NULL,
       MGRNO     CHAR(6)                   ,
       ADMRDEPT  CHAR(3)           NOT NULL, 
       LOCATION  CHAR(16)				   ,
       PRIMARY KEY (DEPTNO))^

CREATE TABLE HR_DB.SUPPLY
      (SUPNO    CHAR(3)           NOT NULL,
       SUPNAME  VARCHAR(36)       NOT NULL,
       LOCATION  CHAR(16)				   ,
       PRIMARY KEY (SUPNO))^

-- ********************************************************************
-- create table subsidiary. it maintains subsidiary authentication information.
-- *********************************************************************/

CREATE TABLE HR_DB.SUBSIDIARY ("SUBID" CHARACTER (4)  NOT NULL , "SUBNAME" CHARACTER (10)  NOT NULL , "SUBPASSOWRD" CHARACTER (16)  NOT NULL , PRIMARY KEY (SUBID))^
-- ********************************************************************
-- DDL to create employee photo table. it stored employee photo. 
-- *********************************************************************/
CREATE TABLE HR_DB.EMP_PHOTO  
             (EMPNO CHAR(6) NOT NULL, 
              PHOTO_FORMAT VARCHAR(10) NOT NULL, 
              PICTURE BLOB(100K), 
              PRIMARY KEY (EMPNO,PHOTO_FORMAT))^
 
ALTER TABLE HR_DB.EMP_PHOTO 
              ADD FOREIGN KEY (EMPNO) 
              REFERENCES HR_DB.EMP 
              ON DELETE RESTRICT^ 

-- ********************************************************************
-- DDL to create employee resume table. it stored employee resume. 
-- *********************************************************************/
CREATE TABLE HR_DB.EMP_RESUME  
             (EMPNO CHAR(6) NOT NULL, 
              RESUME_FORMAT VARCHAR(10) NOT NULL, 
              RESUME CLOB(5K), 
              PRIMARY KEY (EMPNO,RESUME_FORMAT))^
 
ALTER TABLE HR_DB.EMP_RESUME 
              ADD FOREIGN KEY (EMPNO) 
              REFERENCES HR_DB.EMP 
              ON DELETE RESTRICT^

-- ********************************************************************
-- DDL to create project table. it stores department wise details of the company projects. 
-- *********************************************************************/
CREATE TABLE HR_DB.PROJECT
      (PROJ_NO         CHAR(6)        NOT NULL,
       PROJ_NAME       VARCHAR(24)    NOT NULL,
       DEPTNO          CHAR(3)        NOT NULL,
       PROJ_EMP        CHAR(6)        NOT NULL,
       PROJ_STAFF      DECIMAL(5,2)           ,
       PROJ_STARTDATE  DATE                   ,
       PROJ_ENDDATE    DATE                   ,
       CTRLPROJ        CHAR(6)                ,
       PRIMARY KEY (PROJ_NO))^
 
ALTER TABLE HR_DB.PROJECT 
              ADD FOREIGN KEY (DEPTNO) 
              REFERENCES HR_DB.DEPT 
              ON DELETE RESTRICT^
 
ALTER TABLE HR_DB.PROJECT 
              ADD FOREIGN KEY (PROJ_EMP) 
              REFERENCES HR_DB.EMP 
              ON DELETE RESTRICT^
 
ALTER TABLE HR_DB.PROJECT 
              ADD FOREIGN KEY  RPP (CTRLPROJ) 
              REFERENCES HR_DB.PROJECT 
              ON DELETE CASCADE^

 
CREATE INDEX HR_DB.XPROJ2 
              ON HR_DB.PROJECT (PROJ_EMP)^


-- ********************************************************************
-- DDL to create activity table. it stores activity level details pertaining to projects.
-- *********************************************************************/
CREATE TABLE HR_DB.ACTIVITY 
             (ACT_NO      SMALLINT NOT NULL, 
              ACT_KEYWORD CHAR(6) NOT NULL, 
              ACT_DESC    VARCHAR(20) NOT NULL, 
              PRIMARY KEY (ACT_NO))^

CREATE UNIQUE INDEX HR_DB.XACT2 
              ON HR_DB.ACTIVITY (ACT_KEYWORD)^


-- ********************************************************************
-- DDL to create project activity table. it stores relations between project and activities.
-- *********************************************************************/
CREATE TABLE HR_DB.PACTIVITY 
             (PROJ_NO CHAR(6) NOT NULL, 
              ACT_NO SMALLINT NOT NULL, 
              ACT_STAFF DECIMAL(5,2), 
              ACT_STARTDATE DATE NOT NULL, 
              ACT_ENDDATE DATE , 
              PRIMARY KEY (PROJ_NO, ACT_NO, ACT_STARTDATE))^
 
ALTER TABLE HR_DB.PACTIVITY 
              ADD FOREIGN KEY RPAP (PROJ_NO) 
              REFERENCES HR_DB.PROJECT 
              ON DELETE RESTRICT^


ALTER TABLE HR_DB.PACTIVITY
            ADD FOREIGN KEY RPAA (ACT_NO)
                REFERENCES HR_DB.ACTIVITY
                ON DELETE RESTRICT^

-- ********************************************************************
-- DDL to message in tray table. this table stores details on the incoming messages for employees.
-- *********************************************************************/
CREATE TABLE HR_DB.MSG_IN_TRAY
    (EMPNO               CHAR(6) NOT NULL,
     RECEIVED            TIMESTAMP,
     SOURCE              CHAR(8),
     SUBJECT             CHAR(64),
     NOTE_TEXT           VARCHAR(3000))^

-- ********************************************************************
-- DDL to create emp_proj_act table. it maintain a relationshio between employee, 
-- project and activity with their start and end times.
-- *********************************************************************/
CREATE TABLE HR_DB.EMP_PROJ_ACT
      (EMPNO      CHAR(6)          NOT NULL,
       PROJ_NO    CHAR(6)          NOT NULL,
       ACT_NO     SMALLINT         NOT NULL,
       EMPTIME    DECIMAL(5,2)             ,
       ESTARTDATE DATE                     ,
       EENDDATE   DATE)^
 
ALTER TABLE HR_DB.EMP_PROJ_ACT 
              ADD FOREIGN KEY REPAPA (PROJ_NO, ACT_NO, ESTARTDATE) 
              REFERENCES HR_DB.PACTIVITY 
              ON DELETE RESTRICT^


-- ******************************************* 
-- * DDL to create indexes and relationships on EMP and DEPT tables *
-- *******************************************/
ALTER TABLE HR_DB.DEPT
      ADD FOREIGN KEY ROD (ADMRDEPT)
          REFERENCES HR_DB.DEPT
          ON DELETE CASCADE^

-- ******************************************* 
-- The following foreign key is added later 
-- *******************************************/

ALTER TABLE HR_DB.DEPT
      ADD FOREIGN KEY RDE (MGRNO)
          REFERENCES HR_DB.EMP
          ON DELETE SET NULL^

-- ******************************************* 
-- The following indexes are created on department table: 
-- *******************************************/

CREATE INDEX HR_DB.XDEPT2
       ON HR_DB.DEPT (MGRNO)^
 
CREATE INDEX HR_DB.XDEPT3
       ON HR_DB.DEPT (ADMRDEPT)^

-- ******************************************* 
-- The following foreign key is added later 
-- *******************************************/
ALTER TABLE HR_DB.EMP 
      ADD FOREIGN KEY RED (WORKDEPT) 
      REFERENCES HR_DB.DEPT 
      ON DELETE SET NULL^
 
ALTER TABLE HR_DB.EMP 
      ADD CONSTRAINT NUMBER 
      CHECK (PHONENO >= '0000' AND PHONENO <= '9999')^

-- ******************************************* 
-- The following indexes are created on employee table: 
-- *******************************************/

CREATE INDEX HR_DB.XEMP2 
       ON HR_DB.EMP (WORKDEPT)^

-- ******************************************* 
-- * Create call_procedure inorder to make calls from trigger to stored procedure *
-- *******************************************/

 CREATE FUNCTION HR_DB.call_procedure ( procedure VARCHAR(257),
      parameters VARCHAR(30000), databaseName VARCHAR(8),
      userName VARCHAR(128), password VARCHAR(200) )
   RETURNS INTEGER
   SPECIFIC call_stp
   EXTERNAL NAME 'functions!call_procedure'
   LANGUAGE C
   PARAMETER STYLE DB2SQL
   NOT DETERMINISTIC
   NOT FENCED
   CALLED ON NULL INPUT
   NO SQL
   EXTERNAL ACTION
   NO SCRATCHPAD
   NO FINAL CALL
   DISALLOW PARALLEL^
   
-- ******************************************* 
-- * DDL to create COBOL stored procedure to *
-- * print employee old and new salary which *
-- * will be invoked by a trigger            *
-- *******************************************/

CREATE PROCEDURE HR_DB.COBSPATS
(
 IN  PEMPNO        CHAR(6)
,IN  POLDSALARY    DEC(9,2)
,IN  PNEWSALARY    DEC(9,2)
)
RESULT SETS 0
EXTERNAL NAME COBSPATS
LANGUAGE COBOL
PARAMETER STYLE GENERAL
MODIFIES SQL DATA
NO DBINFO
PROGRAM TYPE SUB^

-- ***********************************************
-- * THIS DDL CREATS A SCHEMA OF THE COBOL STORED *
-- * PROCEDURE HR_DB.COBSPDTL WHICH THEN CAN   *
-- * BE CALLED FROM A DB2 TRIGGER OR A FUNCTION.  *
-- * THE COBOL PROGRAM IS KEPT IN NORMAL PDS.     *
-- * BINDING JCL HAS TO SPECIFY THE PATH AND      *
-- * LOADLIB FOR THIS COBOL STORED PROCEDURE      *
-- ************************************************/

CREATE PROCEDURE HR_DB.COBSPDTL
(
 IN  PEMPNO        CHAR(6)
,OUT PFIRSTNME     VARCHAR(12)
,OUT PMIDINIT      CHAR(1)
,OUT PLASTNAME     VARCHAR(15)
,OUT PWORKDEPT     CHAR(3)
,OUT PHIREDATE     DATE
,OUT PSALARY       DEC(9,2)
,OUT PSQLCODE      INTEGER
,OUT PSQLSTATE     CHAR(5)
,OUT PSQLERRMC     VARCHAR(250)
)
RESULT SETS 0
EXTERNAL NAME COBSPDTL
LANGUAGE COBOL
PARAMETER STYLE GENERAL
MODIFIES SQL DATA
NO DBINFO
PROGRAM TYPE SUB^


-- ***********************************************
-- * THIS DDL CREATS A SCHEMA OF THE COBOL STORED *
-- * PROCEDURE HR_DB.COBSPSET WHICH THEN CAN   *
-- * BE CALLED FROM A DB2 TRIGGER OR A FUNCTION.  *
-- * THE COBOL PROGRAM IS KEPT IN NORMAL PDS.     *
-- * BINDING JCL HAS TO SPECIFY THE PATH AND      *
-- * LOADLIB FOR THIS COBOL STORED PROCEDURE      *
-- ************************************************/

CREATE PROCEDURE HR_DB.COBSPSET
(
 IN  PDEPTNO       CHAR(3)
,OUT PDEPTNAME     VARCHAR(36)
,OUT PSQLCODE      INTEGER
,OUT PSQLSTATE     CHAR(5)
,OUT PSQLERRMC     VARCHAR(250)
)
RESULT SETS 1
EXTERNAL NAME COBSPSET
LANGUAGE COBOL
PARAMETER STYLE GENERAL
MODIFIES SQL DATA
NO DBINFO
PROGRAM TYPE SUB^

-- ******************************************* 
-- create trigger for invoking the procedure COBSPATS
-- *******************************************/

CREATE TRIGGER HR_DB.TRIG1VAL AFTER  
UPDATE OF SALARY 
ON HR_DB.EMP  REFERENCING  OLD 
AS O  NEW 
AS N  
FOR EACH ROW  MODE DB2SQL 
WHEN ((N.SALARY - O.SALARY) > O.SALARY * 0.10) 
BEGIN ATOMIC 
	VALUES (HR_DB.CALL_PROCEDURE('HR_DB.COBSPATS', char(N.EMPNO) || ',' || char(O.SALARY) || ',' || char(N.SALARY) ,'HR_DB','castusr','castusr'));
END^

-- ********************************************************************
-- stored procedure to get full details of an employee including the photo and resume
-- ********************************************************************
CREATE PROCEDURE HR_DB.GET_EMPLOYEEDETAILS(
IN  I_EMPLOYEE_NO     CHAR(6),
OUT O_FIRSTNAME       VARCHAR(12),
OUT O_MIDNAME         CHAR(1),
OUT O_LASTNAME        VARCHAR(15),
OUT O_WORKDEPT        CHAR(3),
OUT O_PHONENO         CHAR(4),
OUT O_HIREDATE        DATE,
OUT O_JOB             CHAR(8),
OUT O_SEX             CHAR(1),
OUT O_BIRTHDATE       DATE,
OUT O_SALARY          NUM(9,2),
OUT O_BONUS           NUM(9,2),
OUT O_EMPLOYEEPHOTO   BLOB(100K),
OUT O_PHOTO_FORMAT    VARCHAR(10),
OUT O_EMPLOYEE_RESUME CLOB(5K),
OUT O_RESUME_FORMAT   VARCHAR(10)
)
LANGUAGE SQL
BEGIN
 SELECT 
       FIRSTNAME
     , MIDINIT
     , LASTNAME
     , WORKDEPT
     , PHONENO
     , HIREDATE
     , JOB
     , SEX
     , BIRTHDATE
     , SALARY
     , BONUS
     , PICTURE
     , PHOTO_FORMAT
     , RESUME
     , RESUME_FORMAT
 INTO
       O_FIRSTNAME 
     , O_MIDNAME   
     , O_LASTNAME  
     , O_WORKDEPT  
     , O_PHONENO   
     , O_HIREDATE  
     , O_JOB       
     , O_SEX       
     , O_BIRTHDATE 
     , O_SALARY    
     , O_BONUS     
     , O_EMPLOYEEPHOTO
     , O_PHOTO_FORMAT 
     , O_EMPLOYEE_RESUME
     , O_RESUME_FORMAT  
 FROM
       HR_DB.EMP EMP
       INNER JOIN HR_DB.EMP_PHOTO EMP_PHOTO
       ON EMP.EMPNO  = EMP_PHOTO.EMPNO
       INNER JOIN HR_DB.EMP_RESUME EMP_RESUME
       ON EMP.EMPNO  = EMP_RESUME.EMPNO
 WHERE EMP.EMPNO     = I_EMPLOYEE_NO;
END^

-- ********************************************************************
-- stored procedure to get full details of an employee including the photo 
-- and resume
-- ********************************************************************
CREATE PROCEDURE HR_DB.DB2SPSVGET_EMPLOYEEDETAILSWITHPR(
IN  I_EMPLOYEE_NO     CHAR(6),
OUT O_FIRSTNAME       VARCHAR(12),
OUT O_MIDNAME         CHAR(1),
OUT O_LASTNAME        VARCHAR(15),
OUT O_WORKDEPT        CHAR(3),
OUT O_PHONENO         CHAR(4),
OUT O_HIREDATE        DATE,
OUT O_JOB             CHAR(8),
OUT O_SEX             CHAR(1),
OUT O_BIRTHDATE       DATE,
OUT O_SALARY          NUM(9,2),
OUT O_BONUS           NUM(9,2),
OUT O_EMPLOYEEPHOTO   BLOB(100K),
OUT O_PHOTO_FORMAT    VARCHAR(10),
OUT O_EMPLOYEE_RESUME CLOB(5K),
OUT O_RESUME_FORMAT   VARCHAR(10)
)
LANGUAGE SQL
BEGIN
 SELECT 
       FIRSTNAME
     , MIDINIT
     , LASTNAME
     , WORKDEPT
     , PHONENO
     , HIREDATE
     , JOB
     , SEX
     , BIRTHDATE
     , SALARY
     , BONUS
     , PICTURE
     , PHOTO_FORMAT
     , RESUME
     , RESUME_FORMAT
 INTO
       O_FIRSTNAME 
     , O_MIDNAME   
     , O_LASTNAME  
     , O_WORKDEPT  
     , O_PHONENO   
     , O_HIREDATE  
     , O_JOB       
     , O_SEX       
     , O_BIRTHDATE 
     , O_SALARY    
     , O_BONUS     
     , O_EMPLOYEEPHOTO
     , O_PHOTO_FORMAT 
     , O_EMPLOYEE_RESUME
     , O_RESUME_FORMAT  
 FROM
       HR_DB.EMP EMP
       INNER JOIN HR_DB.EMP_PHOTO EMP_PHOTO
       ON EMP.EMPNO  = EMP_PHOTO.EMPNO
       INNER JOIN HR_DB.EMP_RESUME EMP_RESUME
       ON EMP.EMPNO  = EMP_RESUME.EMPNO
 WHERE EMP.EMPNO     = I_EMPLOYEE_NO;
END^

-- ********************************************************************
-- stored procedure to get details of an employee from employee table
-- ********************************************************************
CREATE PROCEDURE HR_DB.DB2SPSVGET_EMPDETAILS(
IN  I_EMPLOYEE_NO     CHAR(6),
OUT O_FIRSTNAME       VARCHAR(12),
OUT O_MIDNAME         CHAR(1),
OUT O_LASTNAME        VARCHAR(15),
OUT O_WORKDEPT        CHAR(3),
OUT O_PHONENO         CHAR(4),
OUT O_HIREDATE        DATE,
OUT O_JOB             CHAR(8),
OUT O_EDLEVEL         SMALLINT,
OUT O_SEX             CHAR(1),
OUT O_BIRTHDATE       DATE,
OUT O_SALARY          NUM(9,2),
OUT O_BONUS           NUM(9,2),
OUT O_COMM            NUM(9,2)
)
LANGUAGE SQL
BEGIN
 SELECT * 
 INTO
       I_EMPLOYEE_NO
     , O_FIRSTNAME 
     , O_MIDNAME   
     , O_LASTNAME  
     , O_WORKDEPT  
     , O_PHONENO   
     , O_HIREDATE  
     , O_JOB       
     , O_EDLEVEL 
     , O_SEX       
     , O_BIRTHDATE 
     , O_SALARY    
     , O_BONUS     
     , O_COMM
 FROM
       HR_DB.EMP EMP
 WHERE EMP.EMPNO     = I_EMPLOYEE_NO;
END^

-- ********************************************************************
-- stored procedure to get details of compensation paid in a DEPT
-- ********************************************************************
CREATE PROCEDURE HR_DB.GET_TOTCOMPENSATIONFORDEPT(
IN  I_WORKDEPT        CHAR(3),
OUT O_SALARY          NUM(9,2),
OUT O_BONUS           NUM(9,2),
OUT O_COMM            NUM(9,2)
)
LANGUAGE SQL
BEGIN
 SELECT                                                
    SUM(SALARY),
    SUM(BONUS),
    SUM(COMM)
 INTO
    O_SALARY,
    O_BONUS,
    O_COMM    
 FROM HR_DB.EMP EMP
 WHERE EMP.WORKDEPT     = I_WORKDEPT
 GROUP BY WORKDEPT;
END^

-- **********************************************************************
-- stored procedure to get details of an employee with max bonus in DEPT 
-- **********************************************************************
CREATE PROCEDURE HR_DB.GET_EMPWITHMAXBONUSINADEPT (
IN  I_WORKDEPT        CHAR(3),
OUT O_EMPNO           CHAR(6),
OUT O_FIRSTNAME       VARCHAR(12),
OUT O_MIDNAME         CHAR(1),
OUT O_LASTNAME        VARCHAR(15),
OUT O_PHONENO         CHAR(4),
OUT O_HIREDATE        DATE,
OUT O_JOB             CHAR(8),
OUT O_EDLEVEL         SMALLINT,
OUT O_SEX             CHAR(1),
OUT O_BIRTHDATE       DATE,
OUT O_SALARY          NUM(9,2),
OUT O_BONUS           NUM(9,2),
OUT O_COMM            NUM(9,2)
)
LANGUAGE SQL
BEGIN
 SELECT                                                
    EMPNO,
    FIRSTNAME,
    MIDINIT,
    LASTNAME,
    PHONENO,
    HIREDATE,
    JOB,
    EDLEVEL,
    SEX,
    BIRTHDATE,
    SALARY,
    BONUS,
    COMM
 INTO
       O_EMPNO
     , O_FIRSTNAME 
     , O_MIDNAME   
     , O_LASTNAME  
     , O_PHONENO   
     , O_HIREDATE  
     , O_JOB       
     , O_EDLEVEL
     , O_SEX       
     , O_BIRTHDATE 
     , O_SALARY    
     , O_BONUS     
     , O_COMM
 FROM
       HR_DB.EMP EMP
 WHERE EMP.BONUS = (SELECT MAX(BONUS)
                      FROM HR_DB.EMP EMP1
                     WHERE EMP1.WORKDEPT = I_WORKDEPT);
END
^

-- ************************************ --
-- create function to get bonus flag.   --
-- flag will return true only for the   --
-- employees older than 5 years         --
-- ************************************ --
CREATE FUNCTION HR_DB.UDF_GETBONUSFLAG( IN_EMP_NO CHARACTER(6) )
    RETURNS INTEGER
------------------------------------------------------------------------
-- SQL UDF (Scalar)
------------------------------------------------------------------------
F1: BEGIN ATOMIC
    DECLARE JJ DEC(5,2);
    DECLARE RETVAL    INTEGER;

    SELECT (DAYS(CURRENT_DATE) - DAYS(EMP.HIREDATE)) FROM HR_DB.EMP AS EMP WHERE EMP.EMPNO = IN_EMP_NO;

    IF JJ > 365 * 5 THEN
        SET RETVAL = 0;
    ELSE
        SET RETVAL = 1;
    END IF;

     RETURN RETVAL;

    END
^

-- ************************************ --
-- procedure with standard violation of --
-- having 25 case statements with no    --
-- function calls.                      --
-- ************************************ --
CREATE PROCEDURE HR_DB.GET_EMPBONUS001  (
IN I_EMPLOYEE_NO  CHAR(6),
OUT O_SALARY      NUM(9,2),
OUT O_BONUS       NUM(9,2),
OUT O_BONUS_PERCENTAGE NUM(5,2)
)
LANGUAGE SQL
begin
 
 SELECT
       SALARY
     , BONUS

 INTO
       O_SALARY
     , O_BONUS
 FROM
       HR_DB.EMP AS EMP
 WHERE EMP.EMPNO = I_EMPLOYEE_NO;
 
CASE 
	 WHEN (O_SALARY < 1000)  THEN
	 	SET O_BONUS_PERCENTAGE = 30;

	 WHEN (O_SALARY > 1000 AND O_SALARY < 2000)  THEN
	 	SET O_BONUS_PERCENTAGE = 29;

	 WHEN (O_SALARY > 2000 AND O_SALARY < 3000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 28;

	 WHEN (O_SALARY > 3000 AND O_SALARY < 4000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 27;

	 WHEN (O_SALARY > 4000 AND O_SALARY < 5000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 26;

	 WHEN (O_SALARY > 5000 AND O_SALARY < 6000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 25;

	 WHEN (O_SALARY > 6000 AND O_SALARY < 7000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 24;

	 WHEN (O_SALARY > 7000 AND O_SALARY < 8000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 23;

	 WHEN (O_SALARY > 8000 AND O_SALARY < 9000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 22;

	 WHEN (O_SALARY > 9000 AND O_SALARY < 10000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 21;

	 WHEN (O_SALARY > 10000 AND O_SALARY < 11000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 20;

	 WHEN (O_SALARY > 11000 AND O_SALARY < 12000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 19;

	 WHEN (O_SALARY > 12000 AND O_SALARY < 13000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 18;

	 WHEN (O_SALARY > 13000 AND O_SALARY < 14000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 17;

	 WHEN (O_SALARY > 14000 AND O_SALARY < 15000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 16;

	 WHEN (O_SALARY > 15000 AND O_SALARY < 16000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 15;

	 WHEN (O_SALARY > 16000 AND O_SALARY < 17000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 14;

	 WHEN (O_SALARY > 17000 AND O_SALARY < 18000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 13;

	 WHEN (O_SALARY > 18000 AND O_SALARY < 19000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 12;

	 WHEN (O_SALARY > 19000 AND O_SALARY < 20000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 11;

	 WHEN (O_SALARY > 20000 AND O_SALARY < 21000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 10;

	 WHEN (O_SALARY > 21000 AND O_SALARY < 22000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 9;

	 WHEN (O_SALARY > 22000 AND O_SALARY < 23000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 8;

	 WHEN (O_SALARY > 23000 AND O_SALARY < 24000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 7;

	 WHEN (O_SALARY > 24000 AND O_SALARY < 25000)  THEN
	 	SET  O_BONUS_PERCENTAGE = 6;
	 ELSE
	    SET  O_BONUS_PERCENTAGE = 1;
END CASE;
END
^

-- ************************************ --
-- procedure with standard violation of --
-- having 25 case statements with       --
-- function calls.                      --
-- ************************************ --
CREATE PROCEDURE HR_DB.GET_EMPBONUS002  (
IN  I_EMPLOYEE_NO       CHAR(6),
OUT O_SALARY            NUM(9,2),
OUT O_BONUS             NUM(9,2),
OUT O_BONUS_PERCENTAGE  NUM(9,2),
OUT O_BONUSFLAG         INTEGER
)
 
LANGUAGE SQL
begin
 
 SELECT
       SALARY
     , BONUS

 INTO
       O_SALARY
     , O_BONUS
 FROM
       HR_DB.EMP AS EMP
 WHERE EMP.EMPNO     = I_EMPLOYEE_NO;
 

 
CASE 
	 WHEN (O_SALARY < 1000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 30;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 1000 AND O_SALARY < 2000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 29;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 2000 AND O_SALARY < 3000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 28;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 3000 AND O_SALARY < 4000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 27;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 4000 AND O_SALARY < 5000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 26;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 5000 AND O_SALARY < 6000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 25;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 6000 AND O_SALARY < 7000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 24;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 7000 AND O_SALARY < 8000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 23;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 8000 AND O_SALARY < 9000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 22;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 9000 AND O_SALARY < 10000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 21;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 10000 AND O_SALARY < 11000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 20;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 11000 AND O_SALARY < 12000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 19;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 12000 AND O_SALARY < 13000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 18;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 13000 AND O_SALARY < 14000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 17;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 14000 AND O_SALARY < 15000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 16;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 15000 AND O_SALARY < 16000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 15;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 16000 AND O_SALARY < 17000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 14;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 17000 AND O_SALARY < 18000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 13;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 18000 AND O_SALARY < 19000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 12;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 19000 AND O_SALARY < 20000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 11;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 20000 AND O_SALARY < 21000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 10;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 21000 AND O_SALARY < 22000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 9;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 22000 AND O_SALARY < 23000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 8;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 23000 AND O_SALARY < 24000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 7;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 WHEN (O_SALARY > 24000 AND O_SALARY < 25000)  THEN
	 	  SET O_BONUS_PERCENTAGE = 6;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

	 ELSE
	      SET O_BONUS_PERCENTAGE = 1;
     	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);
END CASE;
END
^

-- ************************************ --
-- procedure with standard violation of --
-- having 25 IfElse statements with no  --
-- function calls.                      --
-- ************************************ --
CREATE PROCEDURE HR_DB.GET_EMPBONUS003  (
IN  I_EMPLOYEE_NO       CHAR(6),
OUT O_SALARY            NUM(9,2),
OUT O_BONUS             NUM(9,2),
OUT O_BONUS_PERCENTAGE  NUM(9,2)
)

LANGUAGE SQL
begin
 
 SELECT
       SALARY
     , BONUS

 INTO
       O_SALARY
     , O_BONUS
 FROM
       HR_DB.EMP AS EMP
 WHERE EMP.EMPNO     = I_EMPLOYEE_NO;
 

 
 IF    O_SALARY < 1000  THEN
      SET O_BONUS_PERCENTAGE = 30;
	  
 ELSEIF O_SALARY < 2000  THEN 
	  SET O_BONUS_PERCENTAGE = 29;

 ELSEIF O_SALARY < 3000  THEN 
	  SET O_BONUS_PERCENTAGE = 28;

 ELSEIF O_SALARY < 4000  THEN 
	  SET O_BONUS_PERCENTAGE = 27;

 ELSEIF O_SALARY < 5000  THEN 
	  SET O_BONUS_PERCENTAGE = 26;

 ELSEIF O_SALARY < 6000  THEN 
	  SET O_BONUS_PERCENTAGE = 25;

 ELSEIF O_SALARY < 7000  THEN 
	  SET O_BONUS_PERCENTAGE = 24;

 ELSEIF O_SALARY < 8000  THEN 
	  SET O_BONUS_PERCENTAGE = 23;

 ELSEIF O_SALARY < 9000  THEN 
	  SET O_BONUS_PERCENTAGE = 22;

 ELSEIF O_SALARY < 10000 THEN 
	  SET O_BONUS_PERCENTAGE = 21;

 ELSEIF O_SALARY < 11000  THEN 
	  SET O_BONUS_PERCENTAGE = 20;

 ELSEIF O_SALARY < 12000 THEN 
	  SET O_BONUS_PERCENTAGE = 19;

 ELSEIF O_SALARY < 13000 THEN 
	  SET O_BONUS_PERCENTAGE = 18;

 ELSEIF O_SALARY < 14000 THEN 
	  SET O_BONUS_PERCENTAGE = 17;

 ELSEIF O_SALARY < 15000 THEN 
	  SET O_BONUS_PERCENTAGE = 16;

 ELSEIF O_SALARY < 16000 THEN 
	  SET O_BONUS_PERCENTAGE = 15;

 ELSEIF O_SALARY < 17000 THEN 
	  SET O_BONUS_PERCENTAGE = 14;

 ELSEIF O_SALARY < 18000 THEN 
	  SET O_BONUS_PERCENTAGE = 13;

 ELSEIF O_SALARY < 19000 THEN 
	  SET O_BONUS_PERCENTAGE = 12;

 ELSEIF O_SALARY < 20000 THEN 
	  SET O_BONUS_PERCENTAGE = 11;

 ELSEIF O_SALARY < 21000 THEN 
	  SET O_BONUS_PERCENTAGE = 10;

 ELSEIF O_SALARY < 22000 THEN 
	  SET O_BONUS_PERCENTAGE =  9;

 ELSEIF O_SALARY < 23000 THEN 
	  SET O_BONUS_PERCENTAGE =  8;

 ELSEIF O_SALARY < 24000 THEN 
	  SET O_BONUS_PERCENTAGE =  7;

 ELSEIF O_SALARY < 25000 THEN 
	  SET O_BONUS_PERCENTAGE =  6;

 ELSE
	 SET O_BONUS_PERCENTAGE = 1;
 END IF;
 
END
^

-- ************************************ --
-- procedure with standard violation of --
-- having 25 IfElse statements with     --
-- function calls.                      --
-- ************************************ --
CREATE PROCEDURE HR_DB.GET_EMPBONUS004  (
IN  I_EMPLOYEE_NO       CHAR(6),
OUT O_SALARY            NUM(9,2),
OUT O_BONUS             NUM(9,2),
OUT O_BONUS_PERCENTAGE  NUM(9,2),
OUT O_BONUSFLAG         INTEGER
)

LANGUAGE SQL
begin
 
 SELECT
       SALARY
     , BONUS

 INTO
       O_SALARY
     , O_BONUS
 FROM
       HR_DB.EMP AS EMP
 WHERE EMP.EMPNO     = I_EMPLOYEE_NO;
 

 
 IF    O_SALARY < 1000  THEN
      SET O_BONUS_PERCENTAGE = 30;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);
	  
 ELSEIF O_SALARY < 2000  THEN 
	  SET O_BONUS_PERCENTAGE = 29;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 3000  THEN 
	  SET O_BONUS_PERCENTAGE = 28;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 4000  THEN 
	  SET O_BONUS_PERCENTAGE = 27;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 5000  THEN 
	  SET O_BONUS_PERCENTAGE = 26;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 6000  THEN 
	  SET O_BONUS_PERCENTAGE = 25;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 7000  THEN 
	  SET O_BONUS_PERCENTAGE = 24;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 8000  THEN 
	  SET O_BONUS_PERCENTAGE = 23;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 9000  THEN 
	  SET O_BONUS_PERCENTAGE = 22;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 10000 THEN 
	  SET O_BONUS_PERCENTAGE = 21;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 11000  THEN 
	  SET O_BONUS_PERCENTAGE = 20;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 12000 THEN 
	  SET O_BONUS_PERCENTAGE = 19;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 13000 THEN 
	  SET O_BONUS_PERCENTAGE = 18;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 14000 THEN 
	  SET O_BONUS_PERCENTAGE = 17;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 15000 THEN 
	  SET O_BONUS_PERCENTAGE = 16;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 16000 THEN 
	  SET O_BONUS_PERCENTAGE = 15;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 17000 THEN 
	  SET O_BONUS_PERCENTAGE = 14;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 18000 THEN 
	  SET O_BONUS_PERCENTAGE = 13;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 19000 THEN 
	  SET O_BONUS_PERCENTAGE = 12;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 20000 THEN 
	  SET O_BONUS_PERCENTAGE = 11;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 21000 THEN 
	  SET O_BONUS_PERCENTAGE = 10;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 22000 THEN 
	  SET O_BONUS_PERCENTAGE =  9;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 23000 THEN 
	  SET O_BONUS_PERCENTAGE =  8;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 24000 THEN 
	  SET O_BONUS_PERCENTAGE =  7;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSEIF O_SALARY < 25000 THEN 
	  SET O_BONUS_PERCENTAGE =  6;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);

 ELSE
      SET O_BONUS_PERCENTAGE = 1;
	  SET O_BONUSFLAG = HR_DB.UDF_GETBONUSFLAG(I_EMPLOYEE_NO);
 END IF;
 
END
^

-- **************************************************************************
--               RAW SQL WITH 3 QUERIES ON 15 TABLES IN ONE PROCEDURE      --
--               RAW SQL WITH 15 QUERIES ON 3 TABLES IN ONE PROCEDURE      --
-- **************************************************************************


-- ************************************* --
-- PROCEDURE WITH 3 QUERIES ON 15 TABLES --
-- ************************************* --
CREATE PROCEDURE "HR_DB"."GET_EMPDETAILS_15TABLES"  (
IN  I_EMPNAME         CHAR(15),
OUT O_EMPNO           CHAR(6),
OUT O_EMPFIRSTNAME    CHAR(15),
OUT O_EMPLASTNAME     CHAR(15),
OUT O_EMPCOUNT        NUM(6)
)
LANGUAGE SQL
begin

------------
-- Query 1 
------------
   SELECT 
        Count(EMP.EMPNO) AS EMPCOUNT
   INTO
        O_EMPCOUNT
   FROM 
        HR_DB.EMP EMP
	  , HR_DB.EMP_PHOTO EMP_PHOTO
	  , HR_DB.PROJECT PROJECT_1
	  , HR_DB.PACTIVITY PACTIVITY
	  , HR_DB.PROJECT PROJECT
	  , HR_DB.DEPT DEPT
	  , HR_DB.EMP_PROJ_ACT EMP_PROJ_ACT
	  , HR_DB.EMP_RESUME EMP_RESUME
	  , HR_DB.MSG_IN_TRAY MSG_IN_TRAY
	  , HR_DB.ACTIVITY ACTIVITY
	  , HR_DB.DEPT DEPT_1
	  , HR_DB.ACTIVITY ACTIVITY_1
	  , HR_DB.EMP EMP_1
	  , HR_DB.EMP_PHOTO EMP_PHOTO_1
	  , HR_DB.MSG_IN_TRAY MSG_IN_TRAY_1 
   WHERE 
        EMP.EMPNO 		    	= EMP_PHOTO.EMPNO 
    AND EMP_PHOTO.EMPNO 		= EMP_PROJ_ACT.EMPNO 
	AND PROJECT_1.PROJ_NO 		= PACTIVITY.PROJ_NO 
	AND PROJECT_1.PROJ_NO 		= PROJECT.CTRLPROJ 
	AND PACTIVITY.PROJ_NO 		= PROJECT.PROJ_NO 
	AND PROJECT_1.DEPTNO 		= DEPT.DEPTNO 
	AND PROJECT.DEPTNO 			= DEPT.DEPTNO 
	AND PACTIVITY.PROJ_NO 		= EMP_PROJ_ACT.PROJ_NO 
	AND PACTIVITY.ACT_NO 	    = EMP_PROJ_ACT.ACT_NO 
	AND PACTIVITY.ACT_STARTDATE = EMP_PROJ_ACT.ESTARTDATE 
	AND EMP_PHOTO.EMPNO 		= EMP_RESUME.EMPNO 
	AND EMP_PHOTO.EMPNO 		= MSG_IN_TRAY.EMPNO 
	AND PACTIVITY.ACT_NO 		= ACTIVITY.ACT_NO 
	AND PROJECT_1.DEPTNO 		= DEPT_1.DEPTNO 
	AND PROJECT.DEPTNO 			= DEPT_1.DEPTNO 
	AND DEPT.MGRNO 				= DEPT_1.DEPTNO 
	AND PACTIVITY.ACT_NO 		= ACTIVITY_1.ACT_NO 
	AND EMP_PHOTO.EMPNO 		= EMP_1.EMPNO 
	AND EMP_PHOTO.EMPNO 		= EMP_PHOTO_1.EMPNO 
	AND EMP_PHOTO.EMPNO 		= MSG_IN_TRAY_1.EMPNO 
	AND EMP.FIRSTNAME 			= I_EMPNAME;

------------
-- Query 2 
------------

   SELECT 
        EMP.EMPNO
   INTO
        O_EMPNO
   FROM 
        HR_DB.EMP EMP
	  , HR_DB.EMP_PHOTO EMP_PHOTO
	  , HR_DB.PROJECT PROJECT_1
	  , HR_DB.PACTIVITY PACTIVITY
	  , HR_DB.PROJECT PROJECT
	  , HR_DB.DEPT DEPT
	  , HR_DB.EMP_PROJ_ACT EMP_PROJ_ACT
	  , HR_DB.EMP_RESUME EMP_RESUME
	  , HR_DB.MSG_IN_TRAY MSG_IN_TRAY
	  , HR_DB.ACTIVITY ACTIVITY
	  , HR_DB.DEPT DEPT_1
	  , HR_DB.ACTIVITY ACTIVITY_1
	  , HR_DB.EMP EMP_1
	  , HR_DB.EMP_PHOTO EMP_PHOTO_1
	  , HR_DB.MSG_IN_TRAY MSG_IN_TRAY_1 
   WHERE 
        EMP.EMPNO 		    	= EMP_PHOTO.EMPNO 
    AND EMP_PHOTO.EMPNO 		= EMP_PROJ_ACT.EMPNO 
	AND PROJECT_1.PROJ_NO 		= PACTIVITY.PROJ_NO 
	AND PROJECT_1.PROJ_NO 		= PROJECT.CTRLPROJ 
	AND PACTIVITY.PROJ_NO 		= PROJECT.PROJ_NO 
	AND PROJECT_1.DEPTNO 		= DEPT.DEPTNO 
	AND PROJECT.DEPTNO 			= DEPT.DEPTNO 
	AND PACTIVITY.PROJ_NO 		= EMP_PROJ_ACT.PROJ_NO 
	AND PACTIVITY.ACT_NO 	    = EMP_PROJ_ACT.ACT_NO 
	AND PACTIVITY.ACT_STARTDATE = EMP_PROJ_ACT.ESTARTDATE 
	AND EMP_PHOTO.EMPNO 		= EMP_RESUME.EMPNO 
	AND EMP_PHOTO.EMPNO 		= MSG_IN_TRAY.EMPNO 
	AND PACTIVITY.ACT_NO 		= ACTIVITY.ACT_NO 
	AND PROJECT_1.DEPTNO 		= DEPT_1.DEPTNO 
	AND PROJECT.DEPTNO 			= DEPT_1.DEPTNO 
	AND DEPT.MGRNO 				= DEPT_1.DEPTNO 
	AND PACTIVITY.ACT_NO 		= ACTIVITY_1.ACT_NO 
	AND EMP_PHOTO.EMPNO 		= EMP_1.EMPNO 
	AND EMP_PHOTO.EMPNO 		= EMP_PHOTO_1.EMPNO 
	AND EMP_PHOTO.EMPNO 		= MSG_IN_TRAY_1.EMPNO 
	AND EMP.FIRSTNAME 			= I_EMPNAME;

------------
-- Query 3 
------------

   SELECT 
        EMP.FIRSTNAME
	  , EMP.LASTNAME
   INTO
        O_EMPFIRSTNAME
	  , O_EMPLASTNAME
   FROM 
        HR_DB.EMP EMP
	  , HR_DB.EMP_PHOTO EMP_PHOTO
	  , HR_DB.PROJECT PROJECT_1
	  , HR_DB.PACTIVITY PACTIVITY
	  , HR_DB.PROJECT PROJECT
	  , HR_DB.DEPT DEPT
	  , HR_DB.EMP_PROJ_ACT EMP_PROJ_ACT
	  , HR_DB.EMP_RESUME EMP_RESUME
	  , HR_DB.MSG_IN_TRAY MSG_IN_TRAY
	  , HR_DB.ACTIVITY ACTIVITY
	  , HR_DB.DEPT DEPT_1
	  , HR_DB.ACTIVITY ACTIVITY_1
	  , HR_DB.EMP EMP_1
	  , HR_DB.EMP_PHOTO EMP_PHOTO_1
	  , HR_DB.MSG_IN_TRAY MSG_IN_TRAY_1 
   WHERE 
        EMP.EMPNO 		    	= EMP_PHOTO.EMPNO 
    AND EMP_PHOTO.EMPNO 		= EMP_PROJ_ACT.EMPNO 
	AND PROJECT_1.PROJ_NO 		= PACTIVITY.PROJ_NO 
	AND PROJECT_1.PROJ_NO 		= PROJECT.CTRLPROJ 
	AND PACTIVITY.PROJ_NO 		= PROJECT.PROJ_NO 
	AND PROJECT_1.DEPTNO 		= DEPT.DEPTNO 
	AND PROJECT.DEPTNO 			= DEPT.DEPTNO 
	AND PACTIVITY.PROJ_NO 		= EMP_PROJ_ACT.PROJ_NO 
	AND PACTIVITY.ACT_NO 	    = EMP_PROJ_ACT.ACT_NO 
	AND PACTIVITY.ACT_STARTDATE = EMP_PROJ_ACT.ESTARTDATE 
	AND EMP_PHOTO.EMPNO 		= EMP_RESUME.EMPNO 
	AND EMP_PHOTO.EMPNO 		= MSG_IN_TRAY.EMPNO 
	AND PACTIVITY.ACT_NO 		= ACTIVITY.ACT_NO 
	AND PROJECT_1.DEPTNO 		= DEPT_1.DEPTNO 
	AND PROJECT.DEPTNO 			= DEPT_1.DEPTNO 
	AND DEPT.MGRNO 				= DEPT_1.DEPTNO 
	AND PACTIVITY.ACT_NO 		= ACTIVITY_1.ACT_NO 
	AND EMP_PHOTO.EMPNO 		= EMP_1.EMPNO 
	AND EMP_PHOTO.EMPNO 		= EMP_PHOTO_1.EMPNO 
	AND EMP_PHOTO.EMPNO 		= MSG_IN_TRAY_1.EMPNO 
	AND EMP.FIRSTNAME 			= I_EMPNAME;

  END
^
-- ************************************* --
-- PROCEDURE WITH 15 QUERIES ON 3 TABLES --
-- ************************************* --
CREATE PROCEDURE "HR_DB"."GET_EMPDETAILS_3TABLES"  (
IN  I_PROJ_NAME       VARCHAR(24),
OUT O_ACT_NO          NUM(4),
OUT O_ACT_STAFF       NUM(5,2),
OUT O_ACT_DESC        VARCHAR(20),
OUT O_ACT_KEYWORD     CHAR(6),
OUT O_ACT_STARTDATE   DATE,
OUT O_ACT_ENDDATE     DATE,
OUT O_PROJ_NO         CHAR(6),
OUT O_PROJ_EMP        CHAR(6),
OUT O_PROJ_NAME       VARCHAR(24),
OUT O_DEPTNO          CHAR(3),
OUT O_PROJ_STAFF      NUM(5,2),
OUT O_PROJ_STARTDATE  DATE,
OUT O_PROJ_ENDDATE    DATE,
OUT O_CTRLPROJ        CHAR(6),
OUT O_PROJCOUNT       NUM(6) 
)
LANGUAGE SQL
begin

------------
-- Query 1 
------------
	SELECT 
	     PROJECT.PROJ_NO
	   , PROJECT.PROJ_NAME 
    INTO
         O_PROJ_NO
       , O_PROJ_NAME 
	FROM 
	     HR_DB.ACTIVITY ACTIVITY
	   , HR_DB.PACTIVITY PACTIVITY
	   , HR_DB.PROJECT PROJECT 
	WHERE 
	     ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
     AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
	 AND PROJECT.PROJ_NAME LIKE  I_PROJ_NAME;

------------
-- Query 2 
------------
	SELECT 
         PROJECT.PROJ_NO
       , ACTIVITY.ACT_KEYWORD
    INTO
         O_PROJ_NO
       , O_ACT_KEYWORD
	FROM 
	     HR_DB.ACTIVITY ACTIVITY
	   , HR_DB.PACTIVITY PACTIVITY
	   , HR_DB.PROJECT PROJECT 
	WHERE 
	     ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
     AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
	 AND PROJECT.PROJ_NAME LIKE  I_PROJ_NAME;

------------
-- Query 3 
------------
	SELECT 
         PROJECT.PROJ_NO
       , ACTIVITY.ACT_DESC
    INTO
         O_PROJ_NO
       , O_ACT_DESC
	FROM 
	     HR_DB.ACTIVITY ACTIVITY
	   , HR_DB.PACTIVITY PACTIVITY
	   , HR_DB.PROJECT PROJECT 
	WHERE 
	     ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
     AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
	 AND PROJECT.PROJ_NAME LIKE  I_PROJ_NAME;

------------
-- Query 4 
------------
	SELECT 
         PROJECT.PROJ_NO
       , PACTIVITY.ACT_NO
       , PACTIVITY.ACT_STAFF
    INTO
         O_PROJ_NO
       , O_ACT_NO
       , O_ACT_STAFF
	FROM 
	     HR_DB.ACTIVITY ACTIVITY
	   , HR_DB.PACTIVITY PACTIVITY
	   , HR_DB.PROJECT PROJECT 
	WHERE 
	     ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
     AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
	 AND PROJECT.PROJ_NAME LIKE  I_PROJ_NAME;

------------
-- Query 5 
------------
	SELECT 
         PROJECT.PROJ_NO
       , PACTIVITY.ACT_NO
       , PACTIVITY.ACT_STARTDATE
    INTO
         O_PROJ_NO
       , O_ACT_NO
       , O_ACT_STARTDATE
	FROM 
	     HR_DB.ACTIVITY ACTIVITY
	   , HR_DB.PACTIVITY PACTIVITY
	   , HR_DB.PROJECT PROJECT 
	WHERE 
	     ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
     AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
	 AND PROJECT.PROJ_NAME LIKE  I_PROJ_NAME;

------------
-- Query 6 
------------
	SELECT 
         PROJECT.PROJ_NO
       , PACTIVITY.ACT_NO
       , PACTIVITY.ACT_ENDDATE
    INTO
         O_PROJ_NO
       , O_ACT_NO
       , O_ACT_ENDDATE
	FROM 
	     HR_DB.ACTIVITY ACTIVITY
	   , HR_DB.PACTIVITY PACTIVITY
	   , HR_DB.PROJECT PROJECT 
	WHERE 
	     ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
     AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
	 AND PROJECT.PROJ_NAME LIKE  I_PROJ_NAME;

------------
-- Query 7 
------------
	SELECT 
         PROJECT.PROJ_NO
       , PROJECT.DEPTNO
    INTO
         O_PROJ_NO
       , O_DEPTNO 
	FROM 
	     HR_DB.ACTIVITY ACTIVITY
	   , HR_DB.PACTIVITY PACTIVITY
	   , HR_DB.PROJECT PROJECT 
	WHERE 
	     ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
     AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
	 AND PROJECT.PROJ_NAME LIKE  I_PROJ_NAME;

------------
-- Query 8 
------------
	SELECT 
         PROJECT.PROJ_NO
       , PROJECT.PROJ_EMP
    INTO
         O_PROJ_NO
       , O_PROJ_EMP
	FROM 
	     HR_DB.ACTIVITY ACTIVITY
	   , HR_DB.PACTIVITY PACTIVITY
	   , HR_DB.PROJECT PROJECT 
	WHERE 
	     ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
     AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
	 AND PROJECT.PROJ_NAME LIKE  I_PROJ_NAME;

------------
-- Query 9 
------------
	SELECT 
         PROJECT.PROJ_NO
       , PROJECT.PROJ_STAFF
    INTO
         O_PROJ_NO
       , O_PROJ_STAFF
	FROM 
	     HR_DB.ACTIVITY ACTIVITY
	   , HR_DB.PACTIVITY PACTIVITY
	   , HR_DB.PROJECT PROJECT 
	WHERE 
	     ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
     AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
	 AND PROJECT.PROJ_NAME LIKE  I_PROJ_NAME;

------------
-- Query 10 
------------
	SELECT 
         PROJECT.PROJ_NO
       , PROJECT.PROJ_STARTDATE
    INTO
         O_PROJ_NO
       , O_PROJ_STARTDATE
	FROM 
	     HR_DB.ACTIVITY ACTIVITY
	   , HR_DB.PACTIVITY PACTIVITY
	   , HR_DB.PROJECT PROJECT 
	WHERE 
	     ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
     AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
	 AND PROJECT.PROJ_NAME LIKE  I_PROJ_NAME;

------------
-- Query 11 
------------
	SELECT 
         PROJECT.PROJ_NO
       , PROJECT.PROJ_ENDDATE  
    INTO
         O_PROJ_NO
       , O_PROJ_ENDDATE  
	FROM 
	     HR_DB.ACTIVITY ACTIVITY
	   , HR_DB.PACTIVITY PACTIVITY
	   , HR_DB.PROJECT PROJECT 
	WHERE 
	     ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
     AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
	 AND PROJECT.PROJ_NAME LIKE  I_PROJ_NAME;

------------
-- Query 12 
------------
	SELECT 
         PROJECT.PROJ_NO
       , PROJECT.CTRLPROJ 
    INTO
         O_PROJ_NO
       , O_CTRLPROJ 
	FROM 
	     HR_DB.ACTIVITY ACTIVITY
	   , HR_DB.PACTIVITY PACTIVITY
	   , HR_DB.PROJECT PROJECT 
	WHERE 
	     ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
     AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
	 AND PROJECT.PROJ_NAME LIKE  I_PROJ_NAME;

------------
-- Query 13 
------------
	SELECT 
         PROJECT.PROJ_NO
       , PROJECT.PROJ_STARTDATE
       , PROJECT.PROJ_ENDDATE
    INTO
         O_PROJ_NO
       , O_PROJ_STARTDATE
       , O_PROJ_ENDDATE  
	FROM 
	     HR_DB.ACTIVITY ACTIVITY
	   , HR_DB.PACTIVITY PACTIVITY
	   , HR_DB.PROJECT PROJECT 
	WHERE 
	     ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
     AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
	 AND PROJECT.PROJ_NAME LIKE   I_PROJ_NAME;

------------
-- Query 14 
------------
	SELECT 
         PROJECT.PROJ_NO
       , PROJECT.PROJ_EMP
       , PROJECT.DEPTNO 
    INTO
         O_PROJ_NO
       , O_PROJ_EMP
       , O_DEPTNO 
	FROM 
	     HR_DB.ACTIVITY ACTIVITY
	   , HR_DB.PACTIVITY PACTIVITY
	   , HR_DB.PROJECT PROJECT 
	WHERE 
	     ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
     AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
	 AND PROJECT.PROJ_NAME LIKE  I_PROJ_NAME;

------------
-- Query 15 
------------
	SELECT 
         Count(PROJECT.PROJ_NO) 
    INTO
         O_PROJCOUNT
	FROM 
	     HR_DB.ACTIVITY ACTIVITY
	   , HR_DB.PACTIVITY PACTIVITY
	   , HR_DB.PROJECT PROJECT 
	WHERE 
	     ACTIVITY.ACT_NO = PACTIVITY.ACT_NO 
     AND PACTIVITY.PROJ_NO = PROJECT.PROJ_NO 
	 AND PROJECT.PROJ_NAME LIKE  I_PROJ_NAME;

  END
^
-- ************************************ --
-- procedure with standard violation of --
-- having 5 IfElse statements           --
-- ************************************ --
CREATE PROCEDURE HR_DB.GET_EMPBONUS_5IFSTMTS  (
IN  I_EMPLOYEE_NO       CHAR(6),
OUT O_SALARY            NUM(9,2),
OUT O_BONUS             NUM(9,2),
OUT O_BONUS_PERCENTAGE  NUM(9,2)
)

LANGUAGE SQL
begin
 
 SELECT
       SALARY
     , BONUS

 INTO
       O_SALARY
     , O_BONUS
 FROM
       HR_DB.EMP AS EMP
 WHERE EMP.EMPNO = I_EMPLOYEE_NO;
 
 IF    O_SALARY < 1000  THEN
      SET O_BONUS_PERCENTAGE  = 30;
 END IF;	  
 IF O_SALARY < 2000 AND O_SALARY > 1000  THEN 
	  SET O_BONUS_PERCENTAGE  = 29;
 END IF;
 IF O_SALARY < 3000 AND O_SALARY > 2000  THEN 
	 SET  O_BONUS_PERCENTAGE  = 28;
 END IF;
 IF O_SALARY < 4000 AND O_SALARY > 3000  THEN 
	  SET O_BONUS_PERCENTAGE  = 27;
 END IF;
 IF O_SALARY < 5000 AND O_SALARY > 4000  THEN 
	  SET O_BONUS_PERCENTAGE  = 26;
 END IF;
END
^

-- ************************************ --
-- procedure with standard violation of --
-- having 5 IfElse statements           --
-- ************************************ --
CREATE PROCEDURE HR_DB.GET_EMPBONUS_5NESTEDIFSTMTS  (
IN  I_EMPLOYEE_NO       CHAR(6),
OUT O_SALARY            NUM(9,2),
OUT O_BONUS             NUM(9,2),
OUT O_BONUS_PERCENTAGE  NUM(9,2)
)

LANGUAGE SQL
begin

 SELECT
       SALARY
     , BONUS

 INTO
       O_SALARY
     , O_BONUS
 FROM
       HR_DB.EMP AS EMP
 WHERE EMP.EMPNO     = I_EMPLOYEE_NO;
 
 IF    O_SALARY < 1000  THEN
      SET O_BONUS_PERCENTAGE  = 30;
	IF O_SALARY < 2000 AND O_SALARY > 1000  THEN 
		SET O_BONUS_PERCENTAGE  = 29;
		IF O_SALARY < 3000 AND O_SALARY > 2000  THEN 
			SET O_BONUS_PERCENTAGE  = 28;
			IF O_SALARY < 4000 AND O_SALARY > 3000  THEN 
				SET O_BONUS_PERCENTAGE  = 27;
				IF O_SALARY < 5000 AND O_SALARY > 4000  THEN 
					SET O_BONUS_PERCENTAGE  = 26;
				END IF;
			END IF;
		END IF;
	END IF;
 END IF;	  
  
END
^

-- ************************************************
-- * THIS DDL CREATS A SCHEMA OF THE COBOL STORED *
-- * PROCEDURE HR_DB.COBASV22 WHICH THEN IS       *
-- * CALLED FROM 5 PROCEDURES AND 5 COBOL PROGRAMS*
-- * PURPOSE: VIOLATION OF HIGH FAN IN RULE       *
-- ************************************************/

CREATE PROCEDURE HR_DB.COBASV22
(
 IN  PEMPNO        CHAR(6)
,OUT PHIREDATE     DATE

)
RESULT SETS 0
EXTERNAL NAME COBASV22
LANGUAGE COBOL
PARAMETER STYLE GENERAL
MODIFIES SQL DATA
NO DBINFO
PROGRAM TYPE SUB
^
-- ************************************************
-- * THIS DDL CREATS DB2 STORED PROCEDURE WHICH   *
-- * CALLS ANOTHER DB2 STORED PROCEDURE. THIS     *
-- * DB2 SP IS ONE OF THE 5 SPs CALLING SINGLE DB2* 
-- * SP FOR VIOLATIONS OF HIGH FAN IN             *
-- ************************************************/
CREATE PROCEDURE HR_DB.GET_HIREDATE1(
IN  I_EMPLOYEE_NO     CHAR(6),
OUT O_FIRSTNAME       VARCHAR(12),
OUT O_MIDNAME         CHAR(1),
OUT O_LASTNAME        VARCHAR(15),
OUT O_HIREDATE        DATE
)
------------------------------------------------------------------------
-- SQL Stored Procedure
------------------------------------------------------------------------
LANGUAGE SQL
P1: BEGIN

SELECT
       FIRSTNAME
     , MIDINIT
     , LASTNAME
 INTO
       O_FIRSTNAME
     , O_MIDNAME
     , O_LASTNAME
 FROM
       HR_DB.EMP AS EMP
 WHERE EMP.EMPNO = I_EMPLOYEE_NO;

 CALL HR_DB.COBASV22 (I_EMPLOYEE_NO, O_HIREDATE);

END P1
^
-- ************************************************
-- * THIS DDL CREATS DB2 STORED PROCEDURE WHICH   *
-- * CALLS ANOTHER DB2 STORED PROCEDURE. THIS     *
-- * DB2 SP IS ONE OF THE 5 SPs CALLING SINGLE DB2* 
-- * SP FOR VIOLATIONS OF HIGH FAN IN             *
-- ************************************************/
CREATE PROCEDURE HR_DB.GET_HIREDATE2(
IN  I_EMPLOYEE_NO     CHAR(6),
OUT O_FIRSTNAME       VARCHAR(12),
OUT O_MIDNAME         CHAR(1),
OUT O_LASTNAME        VARCHAR(15),
OUT O_HIREDATE        DATE
)
------------------------------------------------------------------------
-- SQL Stored Procedure
------------------------------------------------------------------------
LANGUAGE SQL
P1: BEGIN

SELECT
       FIRSTNAME
     , MIDINIT
     , LASTNAME
 INTO
       O_FIRSTNAME
     , O_MIDNAME
     , O_LASTNAME
 FROM
       HR_DB.EMP AS EMP
 WHERE EMP.EMPNO = I_EMPLOYEE_NO;

 CALL HR_DB.COBASV22 (I_EMPLOYEE_NO, O_HIREDATE);

END P1
^
-- ************************************************
-- * THIS DDL CREATS DB2 STORED PROCEDURE WHICH   *
-- * CALLS ANOTHER DB2 STORED PROCEDURE. THIS     *
-- * DB2 SP IS ONE OF THE 5 SPs CALLING SINGLE DB2* 
-- * SP FOR VIOLATIONS OF HIGH FAN IN             *
-- ************************************************/
CREATE PROCEDURE HR_DB.GET_HIREDATE3(
IN  I_EMPLOYEE_NO     CHAR(6),
OUT O_FIRSTNAME       VARCHAR(12),
OUT O_MIDNAME         CHAR(1),
OUT O_LASTNAME        VARCHAR(15),
OUT O_HIREDATE        DATE
)
------------------------------------------------------------------------
-- SQL Stored Procedure
------------------------------------------------------------------------
LANGUAGE SQL
P1: BEGIN

SELECT
       FIRSTNAME
     , MIDINIT
     , LASTNAME
 INTO
       O_FIRSTNAME
     , O_MIDNAME
     , O_LASTNAME
 FROM
       HR_DB.EMP AS EMP
 WHERE EMP.EMPNO = I_EMPLOYEE_NO;

 CALL HR_DB.COBASV22 (I_EMPLOYEE_NO, O_HIREDATE);

END P1
^
-- ************************************************
-- * THIS DDL CREATS DB2 STORED PROCEDURE WHICH   *
-- * CALLS ANOTHER DB2 STORED PROCEDURE. THIS     *
-- * DB2 SP IS ONE OF THE 5 SPs CALLING SINGLE DB2* 
-- * SP FOR VIOLATIONS OF HIGH FAN IN             *
-- ************************************************/
CREATE PROCEDURE HR_DB.GET_HIREDATE4(
IN  I_EMPLOYEE_NO     CHAR(6),
OUT O_FIRSTNAME       VARCHAR(12),
OUT O_MIDNAME         CHAR(1),
OUT O_LASTNAME        VARCHAR(15),
OUT O_HIREDATE        DATE
)
------------------------------------------------------------------------
-- SQL Stored Procedure
------------------------------------------------------------------------
LANGUAGE SQL
P1: BEGIN

SELECT
       FIRSTNAME
     , MIDINIT
     , LASTNAME
 INTO
       O_FIRSTNAME
     , O_MIDNAME
     , O_LASTNAME
 FROM
       HR_DB.EMP AS EMP
 WHERE EMP.EMPNO = I_EMPLOYEE_NO;

 CALL HR_DB.COBASV22 (I_EMPLOYEE_NO, O_HIREDATE);

END P1
^
-- ************************************************
-- * THIS DDL CREATS DB2 STORED PROCEDURE WHICH   *
-- * CALLS ANOTHER DB2 STORED PROCEDURE. THIS     *
-- * DB2 SP IS ONE OF THE 5 SPs CALLING SINGLE DB2* 
-- * SP FOR VIOLATIONS OF HIGH FAN IN             *
-- ************************************************/
CREATE PROCEDURE HR_DB.GET_HIREDATE5(
IN  I_EMPLOYEE_NO     CHAR(6),
OUT O_FIRSTNAME       VARCHAR(12),
OUT O_MIDNAME         CHAR(1),
OUT O_LASTNAME        VARCHAR(15),
OUT O_HIREDATE        DATE
)
------------------------------------------------------------------------
-- SQL Stored Procedure
------------------------------------------------------------------------
LANGUAGE SQL
P1: BEGIN

SELECT
       FIRSTNAME
     , MIDINIT
     , LASTNAME
 INTO
       O_FIRSTNAME
     , O_MIDNAME
     , O_LASTNAME
 FROM
       HR_DB.EMP AS EMP
 WHERE EMP.EMPNO = I_EMPLOYEE_NO;

 CALL HR_DB.COBASV22 (I_EMPLOYEE_NO, O_HIREDATE);

END P1
^

-- ************************************************
-- * THIS DDL CREATS A SCHEMA OF THE COBOL STORED *
-- * PROCEDURE HR_DB.COBASV29 WHICH THEN IS       *
-- * CALLED FROM COBOL PROGRAM COBASV28           *
-- * PURPOSE: VIOLATION OF HIGH FAN OUT RULE      *
-- ************************************************/

CREATE PROCEDURE HR_DB.COBASV29
(
 IN  PEMPNO        CHAR(6)
,OUT PFIRSTNAME    VARCHAR(12)
)
RESULT SETS 0
EXTERNAL NAME COBASV29
LANGUAGE COBOL
PARAMETER STYLE GENERAL
MODIFIES SQL DATA
NO DBINFO
PROGRAM TYPE SUB
^
-- ************************************************
-- * THIS DDL CREATS A SCHEMA OF THE COBOL STORED *
-- * PROCEDURE HR_DB.COBASV30 WHICH THEN IS       *
-- * CALLED FROM COBOL PROGRAM COBASV28           *
-- * PURPOSE: VIOLATION OF HIGH FAN OUT RULE      *
-- ************************************************/

CREATE PROCEDURE HR_DB.COBASV30
(
 IN  PEMPNO        CHAR(6)
,OUT PLASTNAME    VARCHAR(15)
)
RESULT SETS 0
EXTERNAL NAME COBASV30
LANGUAGE COBOL
PARAMETER STYLE GENERAL
MODIFIES SQL DATA
NO DBINFO
PROGRAM TYPE SUB
^
-- ************************************************
-- * THIS DDL CREATS A SCHEMA OF THE COBOL STORED *
-- * PROCEDURE HR_DB.COBASV31 WHICH THEN IS       *
-- * CALLED FROM COBOL PROGRAM COBASV28           *
-- * PURPOSE: VIOLATION OF HIGH FAN OUT RULE      *
-- ************************************************/

CREATE PROCEDURE HR_DB.COBASV31
(
 IN  PEMPNO        CHAR(6)
,OUT PWORKDEPT     CHAR(3)
)
RESULT SETS 0
EXTERNAL NAME COBASV31
LANGUAGE COBOL
PARAMETER STYLE GENERAL
MODIFIES SQL DATA
NO DBINFO
PROGRAM TYPE SUB
^
-- ************************************************
-- * THIS DDL CREATS A SCHEMA OF THE COBOL STORED *
-- * PROCEDURE HR_DB.COBASV32 WHICH THEN IS       *
-- * CALLED FROM COBOL PROGRAM COBASV28           *
-- * PURPOSE: VIOLATION OF HIGH FAN OUT RULE      *
-- ************************************************/

CREATE PROCEDURE HR_DB.COBASV32
(
 IN  PEMPNO        CHAR(6)
,OUT PSALARY       DECIMAL(9,2)
)
RESULT SETS 0
EXTERNAL NAME COBASV32
LANGUAGE COBOL
PARAMETER STYLE GENERAL
MODIFIES SQL DATA
NO DBINFO
PROGRAM TYPE SUB
^

-- ************************************************
-- * THIS DDL CREATS DB2 SP FOR HIGH FAN OUT      *
-- ************************************************
CREATE PROCEDURE HR_DB.GET_EMPBIRTHDATE
(
 IN  I_EMPLOYEE_NO  CHAR(6)
,OUT O_BIRTHDATE   DATE
)
LANGUAGE SQL
BEGIN
 SELECT 
       BIRTHDATE
 INTO
       O_BIRTHDATE 
 FROM
       HR_DB.EMP EMP
 WHERE EMP.EMPNO     = I_EMPLOYEE_NO;
END^

-- ************************************************
-- * THIS DDL CREATS DB2 SP FOR HIGH FAN OUT      *
-- ************************************************
CREATE PROCEDURE HR_DB.GET_EMPPHONENO
(
  IN  I_EMPLOYEE_NO     CHAR(6)
, OUT O_PHONENO         CHAR(4)
)
LANGUAGE SQL
BEGIN
 SELECT 
       PHONENO
 INTO
       O_PHONENO 
 FROM
       HR_DB.EMP EMP
 WHERE EMP.EMPNO     = I_EMPLOYEE_NO;
END^

-- ************************************************
-- * THIS DDL CREATS DB2 SP FOR HIGH FAN OUT      *
-- ************************************************
CREATE PROCEDURE HR_DB.GET_EMPBONUS
(
  IN  I_EMPLOYEE_NO     CHAR(6)
, OUT O_BONUS           NUM(9,2)
)
LANGUAGE SQL
BEGIN
 SELECT 
       BONUS
 INTO
       O_BONUS
 FROM
       HR_DB.EMP EMP
 WHERE EMP.EMPNO     = I_EMPLOYEE_NO;
END^

-- ************************************************
-- * THIS DDL CREATS DB2 SP FOR HIGH FAN OUT      *
-- ************************************************
CREATE PROCEDURE HR_DB.GET_EMPJOB
(
  IN  I_EMPLOYEE_NO     CHAR(6)
, OUT O_JOB             CHAR(8)
)
LANGUAGE SQL
BEGIN
 SELECT 
       JOB
 INTO
       O_JOB
 FROM
       HR_DB.EMP EMP
 WHERE EMP.EMPNO     = I_EMPLOYEE_NO;
END^

-- ************************************************
-- * THIS DDL CREATS DB2 SP FOR HIGH FAN OUT      *
-- ************************************************
CREATE PROCEDURE HR_DB.GET_EMPSEX
(
  IN  I_EMPLOYEE_NO     CHAR(6)
, OUT O_SEX             CHAR(1)
)
LANGUAGE SQL
BEGIN
 SELECT 
       SEX
 INTO
       O_SEX
 FROM
       HR_DB.EMP EMP
 WHERE EMP.EMPNO     = I_EMPLOYEE_NO;
END^

-- -- ********************************************************************************
-- *        THIS DDL CREATS DB2 SP FOR HIGH FAN OUT : CALLING STORED PROCEDURE       *
-- ***********************************************************************************

CREATE PROCEDURE HR_DB.GET_EMPDETAILS_HIGHFANOUT(
IN  I_EMPLOYEE_NO     CHAR(6),
OUT O_FIRSTNAME       VARCHAR(12),
OUT O_LASTNAME        VARCHAR(15),
OUT O_WORKDEPT        CHAR(3),
OUT O_PHONENO         CHAR(4),
OUT O_HIREDATE        DATE,
OUT O_JOB             CHAR(8),
OUT O_SEX             CHAR(1),
OUT O_BIRTHDATE       DATE,
OUT O_SALARY          NUM(9,2),
OUT O_BONUS           NUM(9,2)
)
------------------------------------------------------------------------
-- SQL Stored Procedure
------------------------------------------------------------------------
LANGUAGE SQL
P1: BEGIN


-- Calling stored procedure 1
 CALL HR_DB.COBASV22 (I_EMPLOYEE_NO, O_HIREDATE);

-- Calling stored procedure 2
 CALL HR_DB.COBASV29 (I_EMPLOYEE_NO, O_FIRSTNAME);

-- Calling stored procedure 3
 CALL HR_DB.COBASV30 (I_EMPLOYEE_NO, O_LASTNAME);

-- Calling stored procedure 4
 CALL HR_DB.COBASV31 (I_EMPLOYEE_NO, O_WORKDEPT);

-- Calling stored procedure 5
 CALL HR_DB.COBASV32 (I_EMPLOYEE_NO, O_SALARY);

-- Calling stored procedure 6
 CALL HR_DB.GET_EMPBIRTHDATE (I_EMPLOYEE_NO, O_BIRTHDATE);

-- Calling stored procedure 7
 CALL HR_DB.GET_EMPPHONENO (I_EMPLOYEE_NO, O_PHONENO);

-- Calling stored procedure 8
 CALL HR_DB.GET_EMPBONUS (I_EMPLOYEE_NO, O_BONUS);

-- Calling stored procedure 9
 CALL HR_DB.GET_EMPJOB (I_EMPLOYEE_NO, O_JOB);

-- Calling stored procedure 10
 CALL HR_DB.GET_EMPSEX (I_EMPLOYEE_NO, O_SEX);

END P1
^
