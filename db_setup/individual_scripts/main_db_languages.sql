create table languages
(
    lang_id   int auto_increment,
    lang_name varchar(20) charset utf8 null,
    constraint languages_lang_id_uindex
        unique (lang_id),
    constraint languages_lang_name_uindex
        unique (lang_name)
);

alter table languages
    add primary key (lang_id);

# add programming languages here
INSERT INTO main_db.languages (lang_id, lang_name) VALUES (2, 'C++');
INSERT INTO main_db.languages (lang_id, lang_name) VALUES (0, 'None');
INSERT INTO main_db.languages (lang_id, lang_name) VALUES (1, 'Python');