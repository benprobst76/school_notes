DROP DATABASE IF EXISTS conferenceDB;
CREATE DATABASE conferenceDB; 
USE    conferenceDB;

CREATE TABLE Member(
    ID INTEGER NOT NULL,
    NAME VARCHAR(40) NOT NULL,
    PRIMARY KEY(ID)
);
CREATE TABLE SubCommittee(
    NAME VARCHAR(40) NOT NULL,
    ChairID INTEGER NOT NULL UNIQUE,
    PRIMARY KEY(NAME),
    FOREIGN KEY(ChairID) REFERENCES Member(ID) ON DELETE RESTRICT
);
CREATE TABLE Membership(
    MID INTEGER NOT NULL,
    SCName VARCHAR(40) NOT NULL,
    PRIMARY KEY(MID, SCName),
    FOREIGN KEY(MID) REFERENCES Member(ID) ON DELETE CASCADE,
    FOREIGN KEY(SCName) REFERENCES SubCommittee(NAME) ON DELETE CASCADE
);
CREATE TABLE ConferenceRoom(
    NUMBER INTEGER NOT NULL,
    NAME VARCHAR(20) NOT NULL,
    PRIMARY KEY(NUMBER)
);
CREATE TABLE SESSION(
    NAME VARCHAR(40) NOT NULL,
    DATE DATE NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    CRNum INTEGER NOT NULL,
    PRIMARY KEY(NAME),
    FOREIGN KEY(CRNum) REFERENCES ConferenceRoom(NUMBER) ON DELETE RESTRICT
);
CREATE TABLE HotelRoom(
    NUMBER INTEGER NOT NULL,
    Beds INTEGER NOT NULL CHECK
        (Beds > 0),
        PRIMARY KEY(NUMBER)
);
CREATE TABLE SponsorCompany(
    NAME VARCHAR(20) NOT NULL,
    Tier ENUM('Platinum', 'Gold', 'Silver', 'Bronze') NOT NULL,
    EmailLimit INTEGER GENERATED ALWAYS AS(
        CASE WHEN Tier = 'Platinum' THEN 5 WHEN Tier = 'Gold' THEN 4 WHEN Tier = 'Silver' THEN 3 WHEN Tier = 'Bronze' THEN 0
    END
) VIRTUAL,
EmailsSent INTEGER DEFAULT 0,
PRIMARY KEY(NAME),
CONSTRAINT chk_email_limit CHECK
    (EmailsSent <= EmailLimit)
);
CREATE TABLE Attendee(
    ID INTEGER NOT NULL,
    NAME VARCHAR(40) NOT NULL,
    TYPE ENUM('Student', 'Professional', 'Sponsor') NOT NULL,
    Fee DECIMAL(10, 2) GENERATED ALWAYS AS(
        CASE WHEN TYPE = 'Student' THEN 50.00 WHEN TYPE = 'Professional' THEN 100.00 WHEN TYPE = 'Sponsor' THEN 0.00
    END
) VIRTUAL,
HRNum INTEGER,
SponsorCompany VARCHAR(20),
PRIMARY KEY(ID),
FOREIGN KEY(SponsorCompany) REFERENCES SponsorCompany(NAME),
FOREIGN KEY(HRNum) REFERENCES HotelRoom(NUMBER) ON DELETE SET NULL,
CONSTRAINT chk_student_housing CHECK
    (
        (TYPE = 'Student') OR(HRNum IS NULL)
    ),
    CONSTRAINT chk_sponsor_link
CHECK
    (
        (
            TYPE = 'Sponsor' AND SponsorCompany IS NOT NULL
        ) OR(
            TYPE <> 'Sponsor' AND SponsorCompany IS NULL
        )
    )
);
CREATE TABLE Speaker(
    SESSION VARCHAR(40) NOT NULL,
    SpeakerID INTEGER NOT NULL,
    PRIMARY KEY(SpeakerID, SESSION),
    FOREIGN KEY(SpeakerID) REFERENCES Attendee(ID) ON DELETE CASCADE,
    FOREIGN KEY(SESSION) REFERENCES SESSION(NAME) ON DELETE CASCADE
);
CREATE TABLE JobAd(
    Sponsor VARCHAR(20) NOT NULL,
    Province VARCHAR(20) NOT NULL,
    Title VARCHAR(20) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    City VARCHAR(20) NOT NULL,
    PRIMARY KEY(Title, Province, City),
    FOREIGN KEY(Sponsor) REFERENCES SponsorCompany(NAME) ON DELETE CASCADE
);
INSERT INTO ConferenceRoom
VALUES('101', 'Grand Ballroom'),('102', 'Tech Lab'),('201', 'Executive Suite'),('202', 'Small Hall'),('301', 'Workshop A'),('302', 'Workshop B');
INSERT INTO HotelRoom
VALUES(101, 2),(102, 1),(103, 2),(201, 2),(202, 1),(301, 4),(302, 2),(401, 1);
INSERT INTO Member
VALUES(10, 'Alice Smith'),(11, 'Bob Jones'),(12, 'Charlie Brown'),(13, 'Diana Prince'),(14, 'Edward Norton'),(15, 'Fiona Glen'),(16, 'George Miller'),(17, 'Hannah Abbott');
INSERT INTO SubCommittee
VALUES('Finance', 10),('Technical', 11),('Logistics', 12),('Marketing', 13),('Ethics', 14),('Social', 15);
INSERT INTO SponsorCompany(NAME, Tier)
VALUES('Wayne Corp', 'Gold'),('Daily Planet', 'Silver'),('Stark Industries', 'Platinum'),('InnoVate', 'Platinum'),('SoftWeb', 'Bronze'),('CloudNet', 'Gold');
INSERT INTO Attendee(ID, NAME, TYPE, HRNum, SponsorCompany)
VALUES(
    1001,
    'John Doe',
    'Student',
    101,
    NULL
),(
    1002,
    'Jane Doe',
    'Professional',
    NULL,
    NULL
),(
    1003,
    'Sam Slack',
    'Student',
    101,
    NULL
),(
    1004,
    'Chris Evans',
    'Professional',
    NULL,
    NULL
),(
    1005,
    'Peter Parker',
    'Student',
    301,
    NULL
),(
    1006,
    'Bruce Wayne',
    'Sponsor',
    NULL,
    'Wayne Corp'
),(
    1007,
    'Clark Kent',
    'Sponsor',
    NULL,
    'Daily Planet'
),(
    1008,
    'Tony Stark',
    'Sponsor',
    NULL,
    'Stark Industries'
),(
    1009,
    'Joe Blow',
    'Sponsor',
    NULL,
    'InnoVate'
),(
    1010,
    'Charles Darwin',
    'Sponsor',
    NULL,
    'SoftWeb'
),(
    1011,
    'Mike Isreatel',
    'Sponsor',
    NULL,
    'CloudNet'
);
INSERT INTO SESSION
VALUES(
    'AI Today',
    '2026-05-10',
    '09:00:00',
    '10:30:00',
    101
),(
    'Database Deep Dive',
    '2026-05-10',
    '11:00:00',
    '12:30:00',
    102
),(
    'CyberSecurity 101',
    '2026-05-10',
    '14:00:00',
    '15:30:00',
    201
),(
    'Web Dev Fun',
    '2026-05-11',
    '09:00:00',
    '10:30:00',
    202
),(
    'Ethics in Tech',
    '2026-05-11',
    '11:00:00',
    '12:30:00',
    301
),(
    'Cloud Scaling',
    '2026-05-11',
    '14:00:00',
    '15:30:00',
    302
),(
    'Mobile Apps',
    '2026-05-12',
    '09:00:00',
    '10:30:00',
    101
),(
    'Future Tech',
    '2026-05-12',
    '11:00:00',
    '12:30:00',
    102
);
INSERT INTO JobAd
VALUES(
    'Wayne Corp',
    'Ontario',
    'Software Engineer',
    90000,
    'Toronto'
),(
    'Wayne Corp',
    'Quebec',
    'Data Analyst',
    85000,
    'Montreal'
),(
    'InnoVate',
    'BC',
    'UI Designer',
    75000,
    'Vancouver'
),(
    'CloudNet',
    'Alberta',
    'Cloud Architect',
    120000,
    'Calgary'
),(
    'SoftWeb',
    'Ontario',
    'Security Specialist',
    110000,
    'Ottawa'
),(
    'Stark Industries',
    'New York',
    'Lead Scientist',
    250000,
    'NYC'
);
INSERT INTO Speaker
VALUES('AI Today', 1004),('AI Today', 1008),('Database Deep Dive', 1008),('CyberSecurity 101', 1004),('Web Dev Fun', 1002),('Ethics in Tech', 1001),('Cloud Scaling', 1004),('Future Tech', 1008);
INSERT INTO Membership
VALUES(10, 'Finance'),(11, 'Technical'),(10, 'Technical'),(12, 'Logistics'),(13, 'Marketing'),(14, 'Ethics'),(15, 'Social');
