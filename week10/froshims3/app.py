# Adds error messages

from flask import Flask, render_template, request

app = Flask(__name__)

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


# Registration
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

    # Validate allowed sports
    if sport not in SPORTS:
        return render_template("error.html", message="Invalid sport")

    # Success
    return render_template("success.html")
