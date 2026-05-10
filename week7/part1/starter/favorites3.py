# favorites3.py

import csv

with open("favorites.csv") as file:
    reader = csv.DictReader(file)
    for row in reader:
        print(row["language"])

