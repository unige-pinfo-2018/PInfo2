USE ACADEMI_CO_DB;

-- admin: admin123; modo: modo123; user: uer123
INSERT INTO USERS(USERNAME, EMAIL, PASSWORD_HASH, USER_TYPE) VALUES('admin', 'admin@softaware.ch', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'ADMINISTRATOR');
INSERT INTO USERS(USERNAME, EMAIL, PASSWORD_HASH, USER_TYPE) VALUES('modo', 'modo@softaware.ch', '421ed560511c12a34c70fb0ecfcd3e158ffda664c783b3623ae7f99c788ba6d6', 'MODERATOR');
INSERT INTO USERS(USERNAME, EMAIL, PASSWORD_HASH, USER_TYPE) VALUES('user', 'user@softaware.ch', 'e606e38b0d8c19b24cf0ee3808183162ea7cd63ff7912dbb22b5e803286b4446', 'REGISTERED');
