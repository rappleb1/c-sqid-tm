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