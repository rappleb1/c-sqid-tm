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