
DROP TABLE IF EXISTS dbo.email_domain;

CREATE TABLE dbo.email_domain (
	email_domain VARCHAR(50) NOT NULL
		CONSTRAINT uq_dbo_email_domain UNIQUE (email_domain)
);

INSERT INTO dbo.email_domain(email_domain)
SELECT 
	 a.email_domain
FROM 
(
VALUES
	('gmail.com'),
	('yahoo.com'),
	('outlook.com'),
	('hotmail.com'),
	('aol.com'),
	('icloud.com'),
	('live.com'),
	('mail.com'),
	('protonmail.com'),
	('zoho.com'),
	('fastmail.com'),
	('hey.com'),
	('hushmail.com'),
	('gmx.com'),
	('yandex.com'),
	('inbox.com'),
	('tutanota.com'),
	('startmail.com'),
	('runbox.com'),
	('mailbox.org'),
	('comcast.net'),
	('sbcglobal.net'),
	('verizon.net'),
	('cox.net'),
	('rogers.com'),
	('shaw.ca'),
	('att.net'),
	('bellsouth.net'),
	('charter.net'),
	('earthlink.net'),
	('alumni.harvard.edu'),
	('student.ucla.edu'),
	('mit.edu'),
	('uni-muenchen.de'),
	('ox.ac.uk'),
	('nyu.edu'),
	('berkeley.edu'),
	('college.edu'),
	('campusmail.edu'),
	('sharklasers.com'),
	('mailinator.com'),
	('10minutemail.com'),
	('guerrillamail.com'),
	('fakeinbox.com'),
	('temp-mail.org'),
	('throwawaymail.com'),
	('getairmail.com'),
	('maildrop.cc')
) a (email_domain)