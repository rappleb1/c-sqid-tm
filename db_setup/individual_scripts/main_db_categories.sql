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