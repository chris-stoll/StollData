
--https://www.mssqltips.com/sqlservertip/4054/creating-a-date-dimension-or-calendar-table-in-sql-server/

DROP TABLE IF EXISTS dbo.dimDate;

CREATE TABLE dbo.dimDate (
	dimDate DATE NOT NULL
		CONSTRAINT pk_dbo_dimDate PRIMARY KEY CLUSTERED (dimDate)
	,[DDMMYYYY] CHAR(8) NOT NULL
	,[YYYYMMDD] CHAR(8) NOT NULL
	,dimYear SMALLINT NOT NULL
		CONSTRAINT ck_dbo_dimDate_dimYear CHECK (dimYear BETWEEN 1900 AND 2999)
	,dimQuarter TINYINT NOT NULL
		CONSTRAINT ck_dbo_dimDate_dimQuarter CHECK (dimQuarter BETWEEN 1 AND 4)
	,dimMonth TINYINT NOT NULL
		CONSTRAINT ck_dbo_dimDate_dimMonth CHECK (dimMonth BETWEEN 1 AND 12)
	,dimDayOfMonth TINYINT NOT NULL
		CONSTRAINT ck_dbo_dimDate_dimDayOfMonth CHECK(dimDayOfMonth BETWEEN 1 AND 31)
	,dimDayOfMonthSuffix CHAR(2) NOT NULL

	,dimDayofWeek TINYINT NOT NULL
		CONSTRAINT ck_dbo_dimDate_dimDayofWeek CHECK(dimDayofWeek BETWEEN 1 AND 7)
	,dimDayOfYear SMALLINT NOT NULL
		CONSTRAINT ck_dbo_dimDate_dimDayOfYear CHECK(dimDayOfYear BETWEEN 1 AND 366)
	
	,dimMonthNameLong VARCHAR(20) NOT NULL
	,dimMonthNameShort VARCHAR(10) NOT NULL
	,dimDayOfWeekLong VARCHAR(10) NOT NULL
	,dimDayOfWeekShort VARCHAR(4) NOT NULL

	,dimFirstDayOfWeek DATE NOT NULL
	,dimLastDayOfWeek DATE NOT NULL
	,dimFirstDayOfMonth DATE NOT NULL
    ,dimLastDayOfMonth DATE NOT NULL
	,dimFirstDayOfYear DATE NOT NULL
	,dimLastDayOfYear DATE NOT NULL
	


	,dimStyle101 VARCHAR(10) NOT NULL
	,dimStyle103 VARCHAR(10) NOT NULL
	,dimStyle112 VARCHAR(10) NOT NULL
	,dimStyle120 VARCHAR(10) NOT NULL

	,dimIsWeekend BIT NOT NULL
	,dimIsLeapYear BIT NOT NULL


);