from src.app import app
from src.utils import cfg

import sqlite3
from flask import g

def get_db():
    db = getattr(g, '_database', None)

    if db is None:
        db = g._database = sqlite3.connect(cfg.DATABASE)

    return db


@app.teardown_appcontext
def close_connection(excetion):
    db = getattr(g, '_database', None)

    if db is not None:
        db.close()