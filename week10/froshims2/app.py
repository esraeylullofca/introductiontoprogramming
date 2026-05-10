# Implements a registration form using a select menu with server-side validation

from flask import Flask, render_template, request

app = Flask(__name__)

# List of allowed sports
SPORTS = [
    "Basketball",
    "Soccer",
    "Ultimate Frisbee"
]


# Homepage route
@app.route("/")
def index():
    return render_template("index.html", sports=SPORTS)


# Registration route
@app.route("/register", methods=["POST"])
def register():

    # Get form data
    name = request.form.get("name")
    sport = request.form.get("sport")

    # Validate submission
    if not name or not sport or sport not in SPORTS:
        return render_template("failure.html")

    # Confirm registration
    return render_template("success.html")
