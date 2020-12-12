from flask_mysqldb import MySQL
import collections
from flask import Flask, render_template, request, send_file
QUESTION_INDEX = 2

app = Flask(__name__)

# configure with database information HERE
# app.config['MYSQL_HOST'] =
# app.config['MYSQL_USER'] =
# app.config['MYSQL_PASSWORD'] =
# app.config['MYSQL_DB'] =

# mysql = MySQL(app)
last_query = []
save_these = {}
templates = []
currently_modifying = -1
@app.route('/', methods=["GET", "POST"])
def land():
    if request.method == "POST":
        email_addr = request.form.get('email')

        cursor = mysql.connection.cursor()
        cursor.execute("SELECT email FROM users")

        for i in cursor.fetchall():
            # if a successful login
            if(i[0] == email_addr):
                return render_template('main_page.html')
        # if failed login
        return render_template('login_page.html')

    return render_template('landing_page.html')


@app.route('/templates/main_page.html')
def main_page():
    return render_template('main_page.html')


@app.route('/templates/store_page.html', methods=["GET", "POST"])
def store():
    if request.method == 'POST':
        x = request.form['button']
        cursor = mysql.connection.cursor()

        if x == "Upload File":
            table_output = []
            clean_list = []
            upload = request.files['file']
            file_extension = upload.filename.split('.').pop()
            contents = []
            if file_extension == "txt":
                read_strings = upload.readlines()
                for read_string in read_strings:
                    read_string = read_string.decode("utf-8")
                    read_string = read_string.strip()
                    if not read_string.isspace() and read_string != '':
                        table_output.append(read_string)

            cursor = mysql.connection.cursor()
            if table_output:
                for q in table_output:
                    query = "INSERT INTO question_templates(category, subcategory, template_string, avg_grade, difficulty, course, language) " \
                            " VALUES(0, 0, '" + q + "', 0, '-', 0, 0)"
                    cursor.execute(query)
                mysql.connection.commit()
            return render_template('store_page.html', results=table_output)
        elif x == "Upload Single Question":
            up_text = request.form.get('upload_text');
            if not up_text.isspace() and up_text != '':
                query = "INSERT INTO question_templates(category, subcategory, template_string, avg_grade, difficulty, course, language) " \
                            " VALUES(0, 0, '" + up_text + "', 0, '-', 0, 0)"
                cursor.execute(query)
                mysql.connection.commit()
                return render_template('store_page.html', results="", outstring=[up_text + " added!"])
            else:
                return render_template('store_page.html', results="", outstring=["Question failed to add."])
    return render_template('store_page.html', results="")


@app.route('/templates/modify_page.html', methods=["GET", "POST"])
def modify():
    global templates;
    global currently_modifying;
    categories, subcategories, langs = get_lists()
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT restrictions.restriction_string, restrictions.restriction_id, qr.subcategory_id FROM restrictions INNER JOIN question_restrictions qr on restrictions.restriction_id = qr.restriction_id ORDER BY restriction_id ASC")
    restrict_list = list(cursor)

    restrict_list_dict = collections.OrderedDict()

    for entry in restrict_list:
        if entry[0] in restrict_list_dict:
            restrict_list_dict[entry[0]].append(entry[2])
        else:
            restrict_list_dict[entry[0]] = [entry[2]]

    if request.method == "GET":
        currently_modifying = -1
        templates = []
        query = "SELECT question_templates.template_id," \
                "question_templates.template_string FROM question_templates"
        cursor.execute(query)
        for c in list(cursor):
            templates.append(str(c[0]) + " - " + str(c[1]))


        return render_template('modify_page.html', question_list=templates)
    if request.method == "POST":
        headers = ["ID", "Category", "Subcategory", "Template", "Average Grade", "Expected Difficulty", "Course", "Language", "Restrictions"]
        x = request.form['button']
        if x == "Modify Selected":
            selected = str(request.form.get("question_list"))
            selected = selected.split('-')
            currently_modifying = int(selected[0].strip())

            query = "SELECT * FROM question_templates WHERE question_templates.template_id=" + str(currently_modifying)
            cursor.execute(query)

            template_values = list(cursor)
            template_values = template_values[0]

            result_list = []
            result_list.append(template_values[0])

            cat = '<select name="category_list" value="c_list">'
            for i in range(len(categories)):
                if i == template_values[1]:
                    cat += '<option value="' + str(categories[i]) + '" selected>' + str(categories[i]) + '</option>';
                else:
                    cat += '<option value="' + str(categories[i]) + '">' + str(categories[i]) + '</option>';
            result_list.append(cat)

            subcat = '<select name="subcategory_list" value="sc_list">'
            for i in range(len(subcategories)):
                if i == template_values[2]:
                    subcat += '<option value="' + str(subcategories[i]) + '" selected>' + str(subcategories[i]) + '</option>';
                else:
                    subcat += '<option value="' + str(subcategories[i]) + '">' + str(subcategories[i]) + '</option>';
            result_list.append(subcat)

            result_list.append(template_values[3])

            result_list.append('<input name="avg_grade" type=number value="' + str(template_values[4]) + '">')

            result_list.append('<input name="difficulty" type=text value="' + str(template_values[5]) + '">')

            result_list.append('<input name="course" type=number value="' + str(template_values[6]) + '">')

            lang = '<select name="lang_list" value="l_list">'
            for i in range(len(langs)):
                if i == template_values[7]:
                    lang += '<option value="' + langs[i] + '" selected>' + langs[i] + '</option>';
                else:
                    lang += '<option value="' + langs[i] + '">' + langs[i] + '</option>'
            result_list.append(lang)

            restricts = '<select multiple name="restrict_list", value="r_list">'
            for key in restrict_list_dict:
                if template_values[2] in restrict_list_dict[key]:
                    restricts += '<option value="' + key + '" selected>' + key + '</option>'
                else:
                    restricts += '<option value="' + key + '">' + key + '</option>';
            result_list.append(restricts)
            return render_template('modify_page.html', question_list=templates,
                                   headers=headers, results=result_list)
        if x == "Save Changes":
            if currently_modifying != -1:
                cat_index = str(categories.index(str(request.form.get("category_list"))))
                subcat_index = str(subcategories.index(str(request.form.get("subcategory_list"))))
                temp_string = str(request.form.get("template"))
                avg_grade = str(request.form.get("avg_grade"))
                difficulty = str(request.form.get("difficulty"))
                course = str(request.form.get("course"))
                lang_index = str(langs.index(str(request.form.get("lang_list"))))
                restrictions_list = request.form.getlist("restrict_list")
                query = "UPDATE question_templates SET category=" + cat_index + ", subcategory=" + subcat_index + ", template_string='" + temp_string + "', avg_grade=" + avg_grade + ", difficulty='" + difficulty + "', course=" + course + ", language=" + lang_index + " WHERE template_id=" + str(currently_modifying)
            
                cursor = mysql.connection.cursor()
                cursor.execute(query)
                mysql.connection.commit()

                for r in restrictions_list:
                    rest_index = list(restrict_list_dict.keys()).index(r) + 1
                    query = "SELECT * FROM question_restrictions WHERE restriction_id=" + str(rest_index) + " AND subcategory_id=" + subcat_index
                    cursor.execute(query)
                    if not list(cursor):
                        query = "INSERT INTO question_restrictions(subcategory_id, restriction_id) VALUES (" + subcat_index + ", " + str(rest_index) + ")"
                        cursor.execute(query)
                        mysql.connection.commit()

                currently_modifying = -1

            return render_template('modify_page.html', question_list=templates,
                                   headers="", results="")
@app.route('/templates/retrieve_page.html', methods=["GET", "POST"])
def retrieve():
    global last_query
    global save_these
    categories, subcategories, langs = get_lists()
    if request.method == 'GET':
        save_these = {}
        return render_template('retrieve_page.html', categories=categories, subcategories=subcategories, langs=langs,
                               results="")
    if request.method == "POST":
        table_output = []
        display_list = []
        x = request.form['button']
        if x == "Retrieve":

            query = "SELECT question_templates.template_id," \
                    "question_templates.template_string, question_templates.avg_grade," \
                    "question_templates.difficulty, question_templates.course FROM question_templates" \
                    " WHERE category=" + str(categories.index(request.form.get("categories"))) + \
                    " AND subcategory = " + str(subcategories.index(request.form.get("subcategories"))) + \
                    " AND language = " + str(langs.index(request.form.get("langs")))

            cursor = mysql.connection.cursor()

            headers = ["Select", "ID", "Template", "Average Grade", "Expected Difficulty", "Course"]
            table_output.append(headers)
            display_list.append(headers)
            cursor.execute(query)

            for i in cursor.fetchall():
                id_num = int(i[0])

                table_row = ['<input type="checkbox" name="checkbox' + str(id_num) + '">']
                for j in i:
                    j = str(j)

                    if j.__contains__("{field}"):
                        inner_count = 0
                        while j.__contains__("{field}"):
                            j = j.replace("{field}", '<input type="text" name="field' + str(id_num) + '|' + str(inner_count) + 't">', 1)
                            inner_count += 1

                    if j.__contains__("{num}"):
                        inner_count = 0
                        while j.__contains__("{num}"):
                            j = j.replace("{num}", '<input type="number" name="field' + str(id_num) + '|' + str(inner_count) + 'n">', 1)
                            inner_count += 1

                    table_row.append(j)
                table_output.append(table_row)

                if str(id_num) not in save_these:
                    display_list.append(table_row)
            last_query = list(display_list)
            return render_template('retrieve_page.html', categories=categories, subcategories=subcategories,
                                   langs=langs,
                                   headers=display_list[0], results=display_list[1:], tosave=save_these.values())
        if x == "Retrieve All":

            query = "SELECT question_templates.template_id," \
                    "question_templates.template_string, question_templates.avg_grade," \
                    "question_templates.difficulty, question_templates.course FROM question_templates"

            cursor = mysql.connection.cursor()

            headers = ["Select", "ID", "Template", "Average Grade", "Expected Difficulty", "Course"]
            table_output.append(headers)
            display_list.append(headers)
            cursor.execute(query)

            for i in cursor.fetchall():
                id_num = int(i[0])

                table_row = ['<input type="checkbox" name="checkbox' + str(id_num) + '">']
                for j in i:
                    j = str(j)

                    if j.__contains__("{field}"):
                        inner_count = 0
                        while j.__contains__("{field}"):
                            j = j.replace("{field}", '<input type="text" name="field' + str(id_num) + '|' + str(inner_count) + 't">', 1)
                            inner_count += 1

                    if j.__contains__("{num}"):
                        inner_count = 0
                        while j.__contains__("{num}"):
                            j = j.replace("{num}", '<input type="number" name="field' + str(id_num) + '|' + str(inner_count) + 'n">', 1)
                            inner_count += 1

                    table_row.append(j)
                table_output.append(table_row)

                if str(id_num) not in save_these:
                    display_list.append(table_row)
            last_query = list(display_list)
            return render_template('retrieve_page.html', categories=categories, subcategories=subcategories,
                                   langs=langs,
                                   headers=display_list[0], results=display_list[1:], tosave=save_these.values())
        if x == "Add":
            table_output = list(last_query)
            current_string = ""
            form_dict = request.form.to_dict(True)
            tried_ids = {}
            current_index = '-1'
            current_num_index = 0

            for entry in form_dict:

                entry = str(entry)
                if int(current_num_index) + 1 < len(table_output):
                    check_string = table_output[int(current_num_index) + 1][QUESTION_INDEX]
                    # check to see if string tied to it has no fields at all
                    if 'field' not in check_string and table_output[int(current_num_index + 1)][1] not in tried_ids:

                        tried_ids[table_output[int(current_num_index + 1)][1]] = check_string
                        current_num_index += 1

                # checkboxes come before fields
        if entry.__contains__('checkbox'):
          current_index = entry[len('checkbox'):]
          current_string = check_string

          check_to_see_if_found = tried_ids.get(current_index, '')

          if 'field' not in check_to_see_if_found and table_output[int(current_num_index)][1] == current_index:
              save_these[current_index] = table_output[int(current_num_index)][QUESTION_INDEX]

        elif entry.__contains__('field'):

          entry_indexes = entry[len('field'):].split('|')
          field_index = entry_indexes[1]
          if current_index == entry_indexes[0]:
            check_for_num = '<input type="number" name="field' + str(int(current_index)) + '|' + field_index + '">'
            check_for_text = '<input type="text" name="field' + str(int(current_index))  + '|' + field_index + '">'

            if current_string.__contains__(check_for_num):
              if form_dict[entry] == '':
                current_string = current_string.replace(check_for_num, '{number}', 1)
              current_string = current_string.replace(check_for_num, form_dict[entry], 1)

            if current_string.__contains__(check_for_text):

              if form_dict[entry] == '':
                current_string = current_string.replace(check_for_text, '{text}', 1)
              current_string = current_string.replace(check_for_text, form_dict[entry], 1)
            if '<input type="text"' not in current_string and '<input type="number"' not in current_string and current_index not in save_these:
              save_these[current_index] = current_string

          if field_index[:len(field_index) - 1] == '0' and entry_indexes[0] not in tried_ids:
            current_num_index += 1
            tried_ids[entry_indexes[0]] = current_string
            last_query = []

            return render_template('retrieve_page.html', categories=categories, subcategories=subcategories,
                                   langs=langs,
                                   headers="", results="", tosave=save_these.values())
        if x == "Save":
            output_file = ""
            restrictions = "Recommended Restrictions for this Assignment:\n"
            count = 1
            langs_in_assn = []
            for key in save_these:
                cursor = mysql.connection.cursor()

                cursor.execute("SELECT question_templates.subcategory, question_templates.language FROM question_templates WHERE template_id=" + str(key))

                look_for_restrictions = list(cursor)[0]

                subcat = look_for_restrictions[0]
                lang = look_for_restrictions[1]
                if lang not in langs_in_assn:
                    langs_in_assn.append(lang)

                if lang == 0 and subcat != 0:
                    cursor.execute("SELECT restrictions.restriction_string FROM restrictions INNER JOIN question_restrictions qr on restrictions.restriction_id = qr.restriction_id WHERE qr.subcategory_id=" + str(subcat))
                    for ret in list(cursor):
                        if ret[0] not in restrictions:
                            restrictions += "- " + str(ret[0]) + "\n"
                elif subcat != 0:
                    cursor.execute("SELECT restrictions.restriction_string FROM restrictions INNER JOIN question_restrictions qr on restrictions.restriction_id = qr.restriction_id WHERE qr.subcategory_id=" + str(subcat) + " AND language_id=" + str(lang))
                    for ret in list(cursor):
                        if ret[0] not in restrictions:
                            restrictions += "- " + str(ret[0]) + "\n"

                output_file += ("Question " + str(count) + " - ")
                output_file += save_these[key]
                output_file += '\n\n'
                count += 1

            if 0 in langs_in_assn:
                if "Language for some" not in restrictions:
                    restrictions = "Language for some questions not defined, which may impact these recommendations.\n" + restrictions
                cursor.execute("SELECT restrictions.restriction_string FROM restrictions INNER JOIN question_restrictions qr on restrictions.restriction_id = qr.restriction_id WHERE qr.subcategory_id=0")
                for ret in list(cursor):
                    if ret[0] not in restrictions:
                        restrictions += "- " + str(ret[0]) + "\n"

            else:
                for lan in langs_in_assn:
                    cursor.execute("SELECT restrictions.restriction_string FROM restrictions INNER JOIN question_restrictions qr on restrictions.restriction_id = qr.restriction_id WHERE qr.subcategory_id=0 AND language_id=" + str(lan))
                for ret in list(cursor):
                    if ret[0] not in restrictions:
                        restrictions += "- " + str(ret[0]) + "\n"

            output_file += '\n\n' + restrictions
            path = "exported_questions.txt"
            my_file = open(path, 'w')
            my_file.write(output_file)
            my_file.close()
            save_these = {}
            return send_file('exported_questions.txt', as_attachment=True)


@app.route('/templates/landing_page.html')
def landing():
    return render_template('landing_page.html')


def get_lists():
    categories = []
    subcategories = []
    langs = []

    cursor = mysql.connection.cursor()
    cursor.execute("SELECT category_name FROM categories ORDER BY category_id ASC")
    for c in list(cursor):
        categories.append(c[0])

    cursor.execute("SELECT subcategory_name FROM subcategories ORDER BY subcategory_id ASC")
    for c in list(cursor):
        subcategories.append(c[0])

    cursor.execute("SELECT lang_name FROM languages ORDER BY lang_id ASC")
    for c in list(cursor):
        langs.append(c[0])

    return categories, subcategories, langs


if __name__ == '__main__':
    app.run()
