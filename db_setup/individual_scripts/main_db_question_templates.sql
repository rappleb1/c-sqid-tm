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