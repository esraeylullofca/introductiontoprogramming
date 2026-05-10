# Implements a registration form, storing registrants in a SQLite database, with support for multiple sports and deregistration

# TODO: Import SQL from cs50
# TODO: Import Flask, redirect, render_template, and request from flask


# TODO: Create the Flask app instance


# TODO: Connect to "froshims.db" with cs50's SQL() and store in db


# TODO: Define the SPORTS list with at least 3 sport names


# TODO: Define a GET route for "/" that renders index.html with sports=SPORTS


# TODO: Define a POST route for "/deregister" that:
#         - Reads "id" from the form
#         - If id exists, deletes the row: DELETE FROM registrants WHERE id = ?
#         - Redirects to "/registrants"


# TODO: Define a POST route for "/register" that:
#         1. Validates name (missing → error.html message="Missing name")
#         2. Uses request.form.getlist("sport") to get all selected sports
#         3. If the list is empty → error.html message="Missing sport"
#         4. If any sport is not in SPORTS → error.html message="Invalid sport"
#         5. Inserts one row per sport into the database
#         6. Redirects to "/registrants"


# TODO: Define a GET route for "/registrants" that:
#         - Queries all registrants from the database
#         - Renders registrants.html passing the results as "registrants"
