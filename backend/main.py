from flask import Flask, jsonify
from flask_sqlalchemy import SQLAlchemy

import config

app = Flask(__name__)
app.config.from_pyfile('./config.py')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)


@app.route('/')
def index():
    ''' Index page route '''
    return "<h1>SHCP Backend Server</h1><p>This is a backend server, \
        use localhost:13490 to access the website</p>" 


@app.route('/api/add', methods=['POST'])
def add_device(params):
    ''' Add device query route '''
    return jsonify("Device {} was added".format(params.name)), 200


@app.route('/api/list', methods=['GET'])
def list_devices():
    ''' List devices query route '''
    return jsonify("List of devices"), 200


@app.route('/api/delete', methods=['POST'])
def delete_device(params):
    ''' Delete a device query route ''' 
    return jsonify("Device {} was deleted".format(params.name)), 200


@app.route('/api/modify', methods=['POST'])
def modifiy_device(old_params, new_params):
    ''' Modify a device query route '''
    return jsonify("Device {} was changed".format(old_params.name)), 200


def check_db():
    ''' Check if database exists. If does not exist, create one. '''
    if not db:
        pass


if __name__ == '__main__':
    check_db()

    app.run(host=config.HOSTNAME, port=config.PORT, debug=True)
