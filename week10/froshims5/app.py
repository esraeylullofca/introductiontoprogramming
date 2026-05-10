# Stores registrants in a SQLite database

# TODO: Import SQL from cs50
# TODO: Import Flask, redirect, render_template, and request from flask


# TODO: Create the Flask app instance


# TODO: Connect to the SQLite database "froshims.db" using cs50's SQL()
#       and store it in a variable called db


# TODO: Define the SPORTS list with at least 3 sport names


# TODO: Define a GET route for "/" that renders index.html with sports=SPORTS


# TODO: Define a POST route for "/register" that:
#         1. Validates name (missing → error.html with message="Missing name")
#         2. Validates sport (missing → "Missing sport", not in SPORTS → "Invalid sport")
#         3. Inserts the registrant into the database:
#            db.execute("INSERT INTO registrants (name, sport) VALUES(?, ?)", name, sport)
#         4. Redirects to "/registrants"


# TODO: Define a GET route for "/registrants" that:
#         - Queries all rows from the registrants table
#         - Renders registrants.html passing the results as "registrants"
