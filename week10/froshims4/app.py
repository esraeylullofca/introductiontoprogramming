# Stores registrants in a dictionary

from flask import Flask, redirect, render_template, request

app = Flask(__name__)

# Dictionary to store registrants
REGISTRANTS = {}

# Allowed sports
SPORTS = [
    "Basketball",
    "Soccer",
    "Ultimate Frisbee"
]


# Homepage
@app.route("/")
def index():
    return render_template("index.html", sports=SPORTS)


# Register route
@app.route("/register", methods=["POST"])
def register():

    # Validate name
    name = request.form.get("name")
    if not name:
        return render_template("error.html", message="Missing name")

    # Validate sport
    sport = request.form.get("sport")

    if not sport:
        return render_template("error.html", message="Missing sport")

    if sport not in SPORTS:
        return render_template("error.html", message="Invalid sport")

    # Store registrant
    REGISTRANTS[name] = sport

    # Redirect to registrants page
    return redirect("/registrants")


# Show all registrants
@app.route("/registrants")
def registrants():
    return render_template("registrants.html", registrants=REGISTRANTS)
