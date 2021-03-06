CREATE DATABASE ACADEMI_CO_DB;
USE ACADEMI_CO_DB;


CREATE TABLE DOCUMENTS (
	ID BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	NAME VARCHAR(60),
	DATA LONGBLOB
);

CREATE TABLE INBOXES (
	ID BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT
);

CREATE TABLE NOTIFICATIONS (
	ID BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	BODY VARCHAR(100),
	CREATION_DATE TIMESTAMP,
	WAS_READ BOOLEAN,
	PARENT BIGINT NOT NULL
);
ALTER TABLE NOTIFICATIONS
ADD FOREIGN KEY (PARENT) REFERENCES INBOXES(ID);


CREATE TABLE USERS (
	ID BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	USERNAME VARCHAR(45) NOT NULL UNIQUE,
	EMAIL VARCHAR(320) NOT NULL UNIQUE,
	PASSWORD_HASH VARCHAR(64) NOT NULL,
	USER_TYPE VARCHAR(32) NOT NULL,
	BIO VARCHAR(500),
	CAN_BE_MODERATOR BOOLEAN,
	PROFILE_PICTURE BIGINT,
	INBOX BIGINT
);
ALTER TABLE USERS
ADD FOREIGN KEY (PROFILE_PICTURE) REFERENCES DOCUMENTS(ID);
ALTER TABLE USERS
ADD FOREIGN KEY (INBOX) REFERENCES INBOXES(ID);

CREATE TABLE POSTS (
	ID BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	AUTHOR BIGINT NOT NULL,
	CONTENT VARCHAR(3000),
	CREATION_DATE TIMESTAMP,
	SCORE INT,
	BANNED BOOLEAN,
	POST_TYPE VARCHAR(45) NOT NULL
);
ALTER TABLE POSTS
ADD FOREIGN KEY (AUTHOR) REFERENCES USERS(ID);

CREATE TABLE QUESTION_THREADS (
	ID BIGINT PRIMARY KEY NOT NULL,
	TITLE VARCHAR(100),
	SUBJECT BIGINT NOT NULL,
	LANGUAGE BIGINT NOT NULL
);
ALTER TABLE QUESTION_THREADS
ADD FOREIGN KEY (ID) REFERENCES POSTS(ID);

CREATE TABLE COMMENTS (
	ID BIGINT PRIMARY KEY NOT NULL,
	QUESTION BIGINT NOT NULL
);
ALTER TABLE COMMENTS
ADD FOREIGN KEY (QUESTION) REFERENCES QUESTION_THREADS(ID);
ALTER TABLE COMMENTS
ADD FOREIGN KEY (ID) REFERENCES POSTS(ID);


CREATE TABLE LANGUAGE_TAGS (
	ID BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	NAME VARCHAR(20) NOT NULL,
	TAG_TYPE VARCHAR(45) NOT NULL
);

ALTER TABLE QUESTION_THREADS
ADD FOREIGN KEY (LANGUAGE) REFERENCES LANGUAGE_TAGS(ID);

CREATE TABLE MAIN_TAGS (
		ID BIGINT PRIMARY KEY NOT NULL
);
ALTER TABLE MAIN_TAGS
ADD FOREIGN KEY (ID) REFERENCES LANGUAGE_TAGS(ID);

ALTER TABLE QUESTION_THREADS
ADD FOREIGN KEY (SUBJECT) REFERENCES MAIN_TAGS(ID);

CREATE TABLE SECONDARY_TAGS (
		ID BIGINT PRIMARY KEY NOT NULL,
		PARENT BIGINT NOT NULL
);
ALTER TABLE SECONDARY_TAGS
ADD FOREIGN KEY (ID) REFERENCES LANGUAGE_TAGS(ID);
ALTER TABLE SECONDARY_TAGS
ADD FOREIGN KEY (PARENT) REFERENCES MAIN_TAGS(ID);


CREATE TABLE UPVOTERS (
	POST_ID BIGINT NOT NULL,
	USER_ID BIGINT NOT NULL
);
ALTER TABLE UPVOTERS
ADD FOREIGN KEY (POST_ID) REFERENCES POSTS(ID);
ALTER TABLE UPVOTERS
ADD FOREIGN KEY (USER_ID) REFERENCES USERS(ID);

CREATE TABLE DOWNVOTERS (
	POST_ID BIGINT NOT NULL,
	USER_ID BIGINT NOT NULL
);
ALTER TABLE DOWNVOTERS
ADD FOREIGN KEY (POST_ID) REFERENCES POSTS(ID);
ALTER TABLE DOWNVOTERS
ADD FOREIGN KEY (USER_ID) REFERENCES USERS(ID);


CREATE TABLE USERS_THREADS (
	USER_ID BIGINT NOT NULL,
	THREAD_ID BIGINT NOT NULL
);
ALTER TABLE USERS_THREADS
ADD FOREIGN KEY (THREAD_ID) REFERENCES QUESTION_THREADS(ID);

CREATE TABLE QUESTIONS_TOPICS (
	QUESTION_ID BIGINT NOT NULL,
	TOPIC_ID BIGINT NOT NULL
);
ALTER TABLE QUESTIONS_TOPICS
ADD FOREIGN KEY (QUESTION_ID) REFERENCES QUESTION_THREADS(ID);
ALTER TABLE QUESTIONS_TOPICS
ADD FOREIGN KEY (TOPIC_ID) REFERENCES SECONDARY_TAGS(ID);

CREATE TABLE LANGUAGE (
	QUESTION BIGINT NOT NULL,
	LANGUAGE_TAG_ID BIGINT NOT NULL
);
ALTER TABLE LANGUAGE
ADD FOREIGN KEY (QUESTION) REFERENCES QUESTION_THREADS(ID);
ALTER TABLE LANGUAGE
ADD FOREIGN KEY (LANGUAGE_TAG_ID) REFERENCES MAIN_TAGS(ID);


CREATE TABLE MODERATOR_PROMOTION_REQUESTS (
	ID BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	ORIGINATOR BIGINT NOT NULL
);
ALTER TABLE MODERATOR_PROMOTION_REQUESTS
ADD FOREIGN KEY (ORIGINATOR) REFERENCES USERS(ID);


CREATE TABLE ADVERTISEMENTS (
	ID BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	HORIZONTAL_IMAGE BIGINT NOT NULL,
	VERTICAL_IMAGE BIGINT NOT NULL
);
ALTER TABLE ADVERTISEMENTS
ADD FOREIGN KEY (HORIZONTAL_IMAGE) REFERENCES DOCUMENTS(ID);
ALTER TABLE ADVERTISEMENTS
ADD FOREIGN KEY (VERTICAL_IMAGE) REFERENCES DOCUMENTS(ID);

CREATE TABLE ADVERTISEMENT_POINTER (
	ID BIGINT PRIMARY KEY NOT NULL,
	CURRENT BIGINT
);
ALTER TABLE ADVERTISEMENT_POINTER
ADD FOREIGN KEY (CURRENT) REFERENCES ADVERTISEMENTS(ID);
