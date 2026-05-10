# Implements a registration form using a select menu with server-side validation

from flask import Flask, render_template, request

# Create Flask app instance
app = Flask(__name__)


# Route for homepage (GET)
@app.route("/", methods=["GET"])
def index():
    return render_template("index.html")


# Route for form submission (POST)
@app.route("/register", methods=["POST"])
def register():
    # Get form data
    name = request.form.get("name")
    sport = request.form.get("sport")

    # Validation: check if empty or missing
    if not name or not sport:
        return render_template("failure.html")

    # If valid input
    return render_template("success.html")
