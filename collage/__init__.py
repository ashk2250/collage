"""Collage package initializer."""
import flask
import os

# app is a single object used by all the code modules in this package
app = flask.Flask(__name__)

# Read settings from config module (collage/config.py)
app.config.from_object('collage.config')

app.config.from_envvar('COLLAGE_SETTINGS', silent=True)

app.secret_key = os.environ.get("FLASK_SECRET_KEY", "your_secret_key")

def create_app():
    return app

import collage.server
import collage.views
# import collage.model