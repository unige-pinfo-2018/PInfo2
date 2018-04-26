CREATE DATABASE ACADEMI_CO;
USE ACADEMI_CO;


CREATE TABLE DOCUMENTS (
	ID BIGINT PRIMARY KEY NOT NULL,
	CONTENT BLOB
);

CREATE TABLE INBOXS (
	ID BIGINT PRIMARY KEY NOT NULL
);

CREATE TABLE NOTIFICATIONS (
	ID BIGINT PRIMARY KEY NOT NULL,
	INBOX_ID BIGINT NOT NULL,
	BODY VARCHAR(100),
	CREATION_DATE TIMESTAMP,
	WAS_READ BOOLEAN

);
ALTER TABLE NOTIFICATIONS
ADD FOREIGN KEY (INBOX_ID) REFERENCES INBOXS(ID);


CREATE TABLE USERS (
	ID BIGINT PRIMARY KEY NOT NULL,
	USERNAME VARCHAR(45) NOT NULL,
	EMAIL VARCHAR(320) NOT NULL,
	PASSWORD_HASH BINARY(64) NOT NULL,
	USER_TYPE INT NOT NULL,
	BIO VARCHAR(500),
	CAN_BE_MODERATOR BOOLEAN,
	PROFILE_PICTURE BIGINT,
	INBOX BIGINT

);
ALTER TABLE USERS
ADD FOREIGN KEY (PROFILE_PICTURE) REFERENCES DOCUMENTS(ID);
ALTER TABLE USERS
ADD FOREIGN KEY (INBOX) REFERENCES INBOXS(ID);

CREATE TABLE POSTS (
	ID BIGINT PRIMARY KEY NOT NULL,
	AUTHOR BIGINT NOT NULL,
	CONTENT VARCHAR(3000),
	CREATION_DATE TIMESTAMP,
	BANNED BOOLEAN
);
ALTER TABLE POSTS
ADD FOREIGN KEY (AUTHOR) REFERENCES USERS(ID);

CREATE TABLE QUESTION_THREADS (
	ID BIGINT PRIMARY KEY NOT NULL,
	AUTHOR BIGINT NOT NULL,
	CONTENT VARCHAR(3000),
	CREATION_DATE TIMESTAMP,
	BANNED BOOLEAN,
	TITLE VARCHAR(100)
);
ALTER TABLE QUESTION_THREADS
ADD FOREIGN KEY (AUTHOR) REFERENCES USERS(ID);


CREATE TABLE COMMENTS (
	ID BIGINT PRIMARY KEY NOT NULL,
	AUTHOR BIGINT NOT NULL,
	CONTENT VARCHAR(3000),
	CREATION_DATE TIMESTAMP NOT NULL,
	BANNED BOOLEAN NOT NULL,
	QUESTION BIGINT NOT NULL

);
ALTER TABLE COMMENTS
ADD FOREIGN KEY (AUTHOR) REFERENCES USERS(ID);
ALTER TABLE COMMENTS
ADD FOREIGN KEY (QUESTION) REFERENCES QUESTION_THREADS(ID);


CREATE TABLE TAGS (
		ID BIGINT PRIMARY KEY NOT NULL,
		NAME VARCHAR(20)
);


CREATE TABLE MAIN_TAGS (
		ID BIGINT PRIMARY KEY NOT NULL,
		NAME VARCHAR(20) NOT NULL

);

CREATE TABLE LANGUAGE_TAGS (
		ID BIGINT PRIMARY KEY NOT NULL,
		NAME VARCHAR(20) NOT NULL
);

CREATE TABLE SECONDARY_TAGS (
		ID BIGINT PRIMARY KEY NOT NULL,
		NAME VARCHAR(20) NOT NULL
);


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


CREATE TABLE FOLLOWED_THREADS (
	USER_ID BIGINT NOT NULL,
	QUESTION BIGINT NOT NULL
);
ALTER TABLE FOLLOWED_THREADS
ADD FOREIGN KEY (QUESTION) REFERENCES QUESTION_THREADS(ID);

CREATE TABLE SUBJECT (
	QUESTION BIGINT NOT NULL,
	MAIN_TAG_ID BIGINT NOT NULL
);
ALTER TABLE SUBJECT
ADD FOREIGN KEY (QUESTION) REFERENCES QUESTION_THREADS(ID);
ALTER TABLE SUBJECT
ADD FOREIGN KEY (MAIN_TAG_ID) REFERENCES MAIN_TAGS(ID);

CREATE TABLE QUESTION_TOPICS (
	QUESTION BIGINT NOT NULL,
	SECONDARY_TAG_ID BIGINT NOT NULL
);
ALTER TABLE QUESTION_TOPICS
ADD FOREIGN KEY (QUESTION) REFERENCES QUESTION_THREADS(ID);
ALTER TABLE QUESTION_TOPICS
ADD FOREIGN KEY (SECONDARY_TAG_ID) REFERENCES MAIN_TAGS(ID);

CREATE TABLE LANGUAGE (
	QUESTION BIGINT NOT NULL,
	LANGUAGE_TAG_ID BIGINT NOT NULL
);
ALTER TABLE LANGUAGE
ADD FOREIGN KEY (QUESTION) REFERENCES QUESTION_THREADS(ID);
ALTER TABLE LANGUAGE
ADD FOREIGN KEY (LANGUAGE_TAG_ID) REFERENCES MAIN_TAGS(ID);
