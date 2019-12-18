from flask import Flask, jsonify, make_response
import postgresql

import config

app = Flask(__name__)


@app.route('/')
def index():
    ''' Index page route '''
    return '<h1>SHCP Backend Server</h1><p>This is a backend server, \
        use localhost:13490 to access the website</p>'


@app.route('/api/raw/<string:table_name>', methods=['GET'])
def get_raw_table(table_name):
    ''' List devices query route '''
    with postgresql.open(config.DATABASE_URI) as db:
        query = db.prepare('SELECT * FROM "' + table_name + '"')
        return jsonify(query(), 200)

    return jsonify('Could not query!'), 500


if __name__ == '__main__':
    app.run(host=config.HOSTNAME, port=config.PORT, debug=config.DEBUG)
