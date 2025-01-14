-- Add up migration script here

DROP TABLE IF EXISTS USERS_SESSION;
DROP TABLE IF EXISTS USERS;

CREATE TABLE USERS (
    USERNAME VARCHAR(32) PRIMARY KEY,
    EMAIL VARCHAR(512) NOT NULL,
    PASSWORD VARCHAR(512) NOT NULL,
    NAME VARCHAR(32) NOT NULL,
    CREATED_AT TIMESTAMP DEFAULT NOW(),
    UPDATED_AT TIMESTAMP DEFAULT NOW()
);


CREATE TABLE USERS_SESSION (
    USERNAME VARCHAR(32) PRIMARY KEY, 
    TOKEN VARCHAR(256) NOT NULL UNIQUE,
    REFRESH_TOKEN VARCHAR(256) NOT NULL UNIQUE,
    EXPIRY_DATE TIMESTAMP NOT NULL,
    CREATED_AT TIMESTAMP DEFAULT NOW(),
    UPDATED_AT TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (USERNAME) REFERENCES USERS(USERNAME)
);

-- Create hash index for TOKEN
CREATE INDEX idx_token ON USERS_SESSION USING HASH (TOKEN);

-- Create hash index for REFRESH_TOKEN
CREATE INDEX idx_refresh_token ON USERS_SESSION USING HASH (REFRESH_TOKEN);
