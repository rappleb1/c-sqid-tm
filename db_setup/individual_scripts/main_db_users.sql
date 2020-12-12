create table users
(
    email varchar(25) charset utf8 null,
    constraint users_email_uindex
        unique (email)
);

# add emails to the users table here
INSERT INTO main_db.users (email) VALUES ('email@try.com');
