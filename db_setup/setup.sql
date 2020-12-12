create table categories
(
    category_id   int auto_increment,
    category_name varchar(50) charset utf8 not null,
    constraint categories_category_id_uindex
        unique (category_id),
    constraint categories_category_name_uindex
        unique (category_name)
);

alter table categories
    add primary key (category_id);

# add question categories here
INSERT INTO main_db.categories (category_id, category_name) VALUES (5, 'Classes');
INSERT INTO main_db.categories (category_id, category_name) VALUES (3, 'Conditionals');
INSERT INTO main_db.categories (category_id, category_name) VALUES (2, 'Functions');
INSERT INTO main_db.categories (category_id, category_name) VALUES (1, 'Fundamentals');
INSERT INTO main_db.categories (category_id, category_name) VALUES (4, 'Recursion');
INSERT INTO main_db.categories (category_id, category_name) VALUES (0, 'Uncategorized');

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

create table question_restrictions
(
    subcategory_id int not null,
    restriction_id int not null
);

# relate subcategories to restrictions here
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (0, 4);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (0, 5);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (0, 6);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (6, 1);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (6, 2);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (15, 7);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (15, 8);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (15, 3);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (15, 1);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (15, 2);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (0, 1);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (4, 1);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (4, 4);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (4, 5);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (4, 6);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (0, 2);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (0, 3);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (15, 4);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (15, 5);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (15, 6);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (4, 2);
INSERT INTO main_db.question_restrictions (subcategory_id, restriction_id) VALUES (4, 3);

create table question_templates
(
    template_id     int auto_increment,
    category        int                       not null,
    subcategory     int                       not null,
    template_string varchar(255) charset utf8 not null,
    avg_grade       double                    null,
    difficulty      varchar(1)                null,
    course          int                       null,
    language        int                       not null,
    constraint template_id_UNIQUE
        unique (template_id)
);

alter table question_templates
    add primary key (template_id);

# insert question templates here
# or as a file upload
INSERT INTO main_db.question_templates (template_id, category, subcategory, template_string, avg_grade, difficulty, course, language) VALUES (0, 0, 0, 'template {field} {num}?', 0, 'E', 0, 0);

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

create table subcategories
(
    subcategory_id   int auto_increment,
    subcategory_name varchar(50) charset utf8 not null,
    constraint subcategories_subcategory_id_uindex
        unique (subcategory_id),
    constraint subcategories_subcategory_name_uindex
        unique (subcategory_name)
);

alter table subcategories
    add primary key (subcategory_id);

# add question subcategories here

INSERT INTO main_db.subcategories (subcategory_id, subcategory_name) VALUES (11, 'Access Modifiers');
INSERT INTO main_db.subcategories (subcategory_id, subcategory_name) VALUES (6, 'Comparison Operators');
INSERT INTO main_db.subcategories (subcategory_id, subcategory_name) VALUES (7, 'Dynamic Programming');
INSERT INTO main_db.subcategories (subcategory_id, subcategory_name) VALUES (14, 'Inheritance');
INSERT INTO main_db.subcategories (subcategory_id, subcategory_name) VALUES (1, 'Input and Output');
INSERT INTO main_db.subcategories (subcategory_id, subcategory_name) VALUES (10, 'Intro to Recursion');
INSERT INTO main_db.subcategories (subcategory_id, subcategory_name) VALUES (12, 'Linked Lists');
INSERT INTO main_db.subcategories (subcategory_id, subcategory_name) VALUES (15, 'Lists');
INSERT INTO main_db.subcategories (subcategory_id, subcategory_name) VALUES (5, 'Logical Operators');
INSERT INTO main_db.subcategories (subcategory_id, subcategory_name) VALUES (16, 'Loops');
INSERT INTO main_db.subcategories (subcategory_id, subcategory_name) VALUES (3, 'Parameters');
INSERT INTO main_db.subcategories (subcategory_id, subcategory_name) VALUES (13, 'Pass By Reference');
INSERT INTO main_db.subcategories (subcategory_id, subcategory_name) VALUES (4, 'Returns');
INSERT INTO main_db.subcategories (subcategory_id, subcategory_name) VALUES (9, 'Searching');
INSERT INTO main_db.subcategories (subcategory_id, subcategory_name) VALUES (8, 'Trees');
INSERT INTO main_db.subcategories (subcategory_id, subcategory_name) VALUES (0, 'Uncategorized');
INSERT INTO main_db.subcategories (subcategory_id, subcategory_name) VALUES (2, 'Variables');

create table users
(
    email varchar(25) charset utf8 null,
    constraint users_email_uindex
        unique (email)
);

# add emails to the users table here
INSERT INTO main_db.users (email) VALUES ('email@try.com');
