-- ==========================================================
-- College Event Management System
-- Complete Oracle SQL & PL/SQL Script
-- Author: Arun Mahajan
-- ==========================================================

-- ========================
-- 1. TABLE CREATION
-- ========================

-- PERSON
CREATE TABLE Person (
    Serial_ID NUMBER PRIMARY KEY,
    Name VARCHAR2(100)
);

-- Phone & Email (P1, P2)
CREATE TABLE P1 (
    Serial_ID NUMBER,
    Phone_No VARCHAR2(15),
    PRIMARY KEY (Serial_ID, Phone_No),
    FOREIGN KEY (Serial_ID) REFERENCES Person(Serial_ID)
);

CREATE TABLE P2 (
    Serial_ID NUMBER,
    Email VARCHAR2(100),
    PRIMARY KEY (Serial_ID, Email),
    FOREIGN KEY (Serial_ID) REFERENCES Person(Serial_ID)
);

-- STUDENT & FACULTY
CREATE TABLE Student (
    Roll_No VARCHAR2(20) PRIMARY KEY,
    Serial_ID NUMBER,
    Branch VARCHAR2(50),
    FOREIGN KEY (Serial_ID) REFERENCES Person(Serial_ID)
);

CREATE TABLE Faculty (
    Emp_ID VARCHAR2(20) PRIMARY KEY,
    Serial_ID NUMBER,
    Department VARCHAR2(50),
    FOREIGN KEY (Serial_ID) REFERENCES Person(Serial_ID)
);

-- CLUB
CREATE TABLE Club (
    Club_ID VARCHAR2(20) PRIMARY KEY,
    Category VARCHAR2(50),
    Name VARCHAR2(100)
);

-- EVENT & TYPES
CREATE TABLE Event (
    Event_ID VARCHAR2(20) PRIMARY KEY,
    Category VARCHAR2(20),
    Event_Name VARCHAR2(100),
    Description VARCHAR2(200),
    Datee DATE,
    Timee VARCHAR2(10),
    Venue VARCHAR2(100)
);

CREATE TABLE Hackathon (
    Event_ID VARCHAR2(20) PRIMARY KEY,
    Prize_Money NUMBER,
    FOREIGN KEY (Event_ID) REFERENCES Event(Event_ID)
);

CREATE TABLE Seminar (
    Event_ID VARCHAR2(20) PRIMARY KEY,
    Speaker VARCHAR2(100),
    FOREIGN KEY (Event_ID) REFERENCES Event(Event_ID)
);

CREATE TABLE Workshop (
    Event_ID VARCHAR2(20) PRIMARY KEY,
    Instructor VARCHAR2(100),
    FOREIGN KEY (Event_ID) REFERENCES Event(Event_ID)
);

-- ORGANIZED_BY
CREATE TABLE Organized_By (
    Club_ID VARCHAR2(20),
    Event_ID VARCHAR2(20),
    PRIMARY KEY (Club_ID, Event_ID),
    FOREIGN KEY (Club_ID) REFERENCES Club(Club_ID),
    FOREIGN KEY (Event_ID) REFERENCES Event(Event_ID)
);

-- REGISTRATION
CREATE TABLE Registration (
    Registration_ID NUMBER PRIMARY KEY,
    Event_ID VARCHAR2(20),
    Roll_No VARCHAR2(20),
    Reg_Date DATE,
    Reg_Time VARCHAR2(10),
    Ticket_ID VARCHAR2(30),
    FOREIGN KEY (Event_ID) REFERENCES Event(Event_ID),
    FOREIGN KEY (Roll_No) REFERENCES Student(Roll_No)
);

-- FEEDBACK
CREATE TABLE Feedback (
    Feedback_ID NUMBER PRIMARY KEY,
    Event_ID VARCHAR2(20),
    Timesstamp DATE,
    Comments VARCHAR2(200),
    Rating NUMBER(1),
    FOREIGN KEY (Event_ID) REFERENCES Event(Event_ID)
);

-- GIVES
CREATE TABLE Gives (
    Emp_ID VARCHAR2(20),
    Feedback_ID NUMBER,
    PRIMARY KEY (Emp_ID, Feedback_ID),
    FOREIGN KEY (Emp_ID) REFERENCES Faculty(Emp_ID),
    FOREIGN KEY (Feedback_ID) REFERENCES Feedback(Feedback_ID)
);

-- ========================
-- 2. SAMPLE DATA
-- ========================

INSERT INTO Person VALUES (1,'Arnav');
INSERT INTO Person VALUES (2,'Arpit');
INSERT INTO Person VALUES (3,'Arun');
INSERT INTO Person VALUES (4,'Dr. Verma');

INSERT INTO P1 VALUES (1,'9876543210');
INSERT INTO P2 VALUES (1,'arnav@student.com');
INSERT INTO P1 VALUES (4,'1234567890');
INSERT INTO P2 VALUES (4,'verma@faculty.com');

INSERT INTO Student VALUES ('STU001',1,'CSE');
INSERT INTO Student VALUES ('STU002',2,'ECE');

INSERT INTO Faculty VALUES ('FAC001',4,'CSE');

INSERT INTO Club VALUES ('CL001','Technical','Coding Club');
INSERT INTO Club VALUES ('CL002','Cultural','Drama Club');

INSERT INTO Event VALUES ('EVT001','Hackathon','CodeRush','Coding competition',TO_DATE('2024-11-01','YYYY-MM-DD'),'10:00 AM','Auditorium');
INSERT INTO Event VALUES ('EVT002','Seminar','AI Future','Talk on AI trends',TO_DATE('2024-11-05','YYYY-MM-DD'),'2:00 PM','Seminar Hall');
INSERT INTO Event VALUES ('EVT003','Workshop','Flutter Basics','Hands-on workshop',TO_DATE('2024-11-10','YYYY-MM-DD'),'11:00 AM','Lab 5');

INSERT INTO Hackathon VALUES ('EVT001',5000);
INSERT INTO Seminar VALUES ('EVT002','Dr. Sharma');
INSERT INTO Workshop VALUES ('EVT003','Mr. Roy');

INSERT INTO Organized_By VALUES ('CL001','EVT001');
INSERT INTO Organized_By VALUES ('CL002','EVT002');

INSERT INTO Registration VALUES (1001,'EVT001','STU001',SYSDATE,'10:15 AM',NULL);
INSERT INTO Registration VALUES (1002,'EVT003','STU002',SYSDATE,'11:30 AM',NULL);

INSERT INTO Feedback VALUES (501,'EVT001',SYSDATE,'Great experience',5);
INSERT INTO Gives VALUES ('FAC001',501);

-- ========================
-- 3. PROCEDURES
-- ========================

CREATE OR REPLACE PROCEDURE register_participant(
p_event_id IN VARCHAR2,
p_roll_no IN VARCHAR2,
p_reg_id IN NUMBER,
p_time IN VARCHAR2)
IS
BEGIN
INSERT INTO Registration(Registration_ID,Event_ID,Roll_No,Reg_Date,Reg_Time)
VALUES(p_reg_id,p_event_id,p_roll_no,SYSDATE,p_time);
END;
/

CREATE OR REPLACE PROCEDURE submit_feedback(
p_feedback_id IN NUMBER,
p_event_id IN VARCHAR2,
p_emp_id IN VARCHAR2,
p_rating IN NUMBER,
p_comments IN VARCHAR2)
IS
BEGIN
INSERT INTO Feedback VALUES(p_feedback_id,p_event_id,SYSDATE,p_comments,p_rating);
INSERT INTO Gives VALUES(p_emp_id,p_feedback_id);
END;
/

CREATE OR REPLACE PROCEDURE assign_club_to_event(
p_event_id IN VARCHAR2,
p_club_id IN VARCHAR2)
IS
v_event_exists NUMBER;
v_club_exists NUMBER;
BEGIN
SELECT COUNT(*) INTO v_event_exists FROM Event WHERE Event_ID=p_event_id;
SELECT COUNT(*) INTO v_club_exists FROM Club WHERE Club_ID=p_club_id;

IF v_event_exists=0 THEN
RAISE_APPLICATION_ERROR(-20001,'Event does not exist.');
ELSIF v_club_exists=0 THEN
RAISE_APPLICATION_ERROR(-20002,'Club does not exist.');
ELSE
INSERT INTO Organized_By VALUES(p_club_id,p_event_id);
END IF;
END;
/

-- ========================
-- 4. TRIGGERS
-- ========================

CREATE OR REPLACE TRIGGER trg_generate_ticket_id
BEFORE INSERT ON Registration
FOR EACH ROW
BEGIN
:NEW.Ticket_ID:='TICKET_'||:NEW.Registration_ID||'_'||TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS');
END;
/

CREATE TABLE Negative_Feedback_Log(
Log_ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
Feedback_ID NUMBER,
Event_ID VARCHAR2(20),
Rating NUMBER(1),
Logged_At DATE);

CREATE OR REPLACE TRIGGER trg_log_negative_feedback
AFTER INSERT ON Feedback
FOR EACH ROW
WHEN (NEW.Rating<=2)
BEGIN
INSERT INTO Negative_Feedback_Log(Feedback_ID,Event_ID,Rating,Logged_At)
VALUES(:NEW.Feedback_ID,:NEW.Event_ID,:NEW.Rating,SYSDATE);
END;
/

-- ========================
-- 5. CURSOR
-- ========================

CREATE OR REPLACE PROCEDURE show_all_registrations_for_event(p_event_id IN VARCHAR2)
IS
CURSOR reg_cursor IS
SELECT Roll_No,Reg_Time FROM Registration WHERE Event_ID=p_event_id;

v_roll_no Registration.Roll_No%TYPE;
v_time Registration.Reg_Time%TYPE;
BEGIN
DBMS_OUTPUT.PUT_LINE('Registrations for Event ID: '||p_event_id);

OPEN reg_cursor;
LOOP
FETCH reg_cursor INTO v_roll_no,v_time;
EXIT WHEN reg_cursor%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Participant: '||v_roll_no||' at '||v_time);
END LOOP;
CLOSE reg_cursor;
END;
/

COMMIT;
