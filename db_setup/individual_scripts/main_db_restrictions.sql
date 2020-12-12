create table restrictions
(
    restriction_id     int auto_increment,
    restriction_string varchar(50) charset utf8 not null,
    language_id        int                      null,
    constraint restrictions_restriction_id_uindex
        unique (restriction_id),
    constraint restrictions_restriction_string_uindex
        unique (restriction_string)
);

alter table restrictions
    add primary key (restriction_id);

# add question restrictions here
INSERT INTO main_db.restrictions (restriction_id, restriction_string, language_id) VALUES (1, 'min()', 1);
INSERT INTO main_db.restrictions (restriction_id, restriction_string, language_id) VALUES (2, 'max()', 1);
INSERT INTO main_db.restrictions (restriction_id, restriction_string, language_id) VALUES (3, '.index()', 1);
INSERT INTO main_db.restrictions (restriction_id, restriction_string, language_id) VALUES (4, 'break, continue', 1);
INSERT INTO main_db.restrictions (restriction_id, restriction_string, language_id) VALUES (5, 'quit()', 1);
INSERT INTO main_db.restrictions (restriction_id, restriction_string, language_id) VALUES (6, 'sum()', 1);
INSERT INTO main_db.restrictions (restriction_id, restriction_string, language_id) VALUES (7, 'enumerate()', 1);
INSERT INTO main_db.restrictions (restriction_id, restriction_string, language_id) VALUES (8, 'zip()', 1);
INSERT INTO main_db.restrictions (restriction_id, restriction_string, language_id) VALUES (9, 'cmath.h', 2);
INSERT INTO main_db.restrictions (restriction_id, restriction_string, language_id) VALUES (10, 'string.h', 2);
INSERT INTO main_db.restrictions (restriction_id, restriction_string, language_id) VALUES (11, 'goto', 2);