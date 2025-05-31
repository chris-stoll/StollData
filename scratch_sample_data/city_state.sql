
DROP TABLE IF EXISTS dbo.city_state;

CREATE TABLE dbo.city_state (
	city_name VARCHAR(50) NOT NULL,
	state_name VARCHAR(50) NOT NULL
		CONSTRAINT pk_dbo_city_state PRIMARY KEY CLUSTERED (city_name, state_name)
);

INSERT INTO dbo.city_state(city_name, state_name)
SELECT 
	 a.city, a.state
FROM 
(
VALUES
	('Akron','Ohio'),
	('Albany','New York'),
	('Allentown','Pennsylvania'),
	('Athens','Georgia'),
	('Atlanta','Georgia'),
	('Augusta','Georgia'),
	('Austin','Texas'),
	('Buffalo','New York'),
	('Chandler','Arizona'),
	('Charlotte','North Carolina'),
	('Chicago','Illinois'),
	('Cincinnati','Ohio'),
	('Cleveland','Ohio'),
	('Columbus','Ohio'),
	('Dallas','Texas'),
	('Durham','North Carolina'),
	('Erie','Pennsylvania'),
	('Fort Worth','Texas'),
	('Greensboro','North Carolina'),
	('Houston','Texas'),
	('Jacksonville','Florida'),
	('Los Angeles','California'),
	('Macon','Georgia'),
	('Mesa','Arizona'),
	('Miami','Florida'),
	('Naperville','Illinois'),
	('New York City','New York'),
	('Orlando','Florida'),
	('Peoria','Illinois'),
	('Philadelphia','Pennsylvania'),
	('Phoenix','Arizona'),
	('Pittsburgh','Pennsylvania'),
	('Raleigh','North Carolina'),
	('Rochester','New York'),
	('Rockford','Illinois'),
	('Sacramento','California'),
	('San Antonio','Texas'),
	('San Diego','California'),
	('San Francisco','California'),
	('San Jose','California'),
	('Savannah','Georgia'),
	('Scottsdale','Arizona'),
	('Scranton','Pennsylvania'),
	('Springfield','Illinois'),
	('Syracuse','New York'),
	('Tallahassee','Florida'),
	('Tampa','Florida'),
	('Toledo','Ohio'),
	('Tucson','Arizona'),
	('Winston-Salem','North Carolina')
) a (city, state);