from flask import Flask, jsonify, make_response, request
from datetime import datetime, timedelta
import postgresql
import re
import jwt
import json

import config
import auth

app = Flask(__name__)


@app.route('/api/auth/register', methods=['POST'])
def register():
    data = request.get_json()

    user = auth.register(
        data.get('user_account_type_id'),
        data.get('name'),
        data.get('username'),
        data.get('password'),
        data.get('email')
    )

    if not user:
        return jsonify({
            'message': 'Could not register'
        }, 400)

    return jsonify('kek'), 201


@app.route('/api/auth/login', methods=['POST'])
def login():
    data = request.get_json()

    username = data.get('username')
    password = data.get('password')

    if auth.authenticate(username, password) != 'Ok':
        return jsonify({
            'message': 'Invalid credentials',
            'authenticated': False}), 401

    token = jwt.encode({
        'sub': username,
        'iat': datetime.utcnow(),
        'exp': datetime.utcnow() + timedelta(minutes=30)},
        config.SECRET_KEY
    )

    return jsonify({
        'username': username,
        'password': password,
        'token': token.decode('UTF-8'),
        'authenticated': True}), 200


@app.route('/')
def index():
    ''' Index page route '''
    return '<h1>SHCP Backend Server</h1><p>This is a backend server, \
        use localhost:13490 to access the website</p>'


@app.route('/api/raw/<string:table_name>', methods=['GET'])
def get_raw_table(table_name):
    ''' List devices query route '''
    if not re.match('^[a-z_]*$', table_name):
        return jsonify('Table name can only contain letters!', 400)

    with postgresql.open(config.DATABASE_URI) as db:
        try:
            query = db.prepare(f'select select_from_raw_{table_name}()')
        except:
            return jsonify('Error occured during query!', 500)

        return json.dumps(query(), indent=4, sort_keys=True, default=str), 200

    return jsonify('Could not connect to database!', 500)


@app.route('/api/get/real_estates', methods=['GET'])
def get_real_estates():
    ''' Get real estate name list '''
    with postgresql.open(config.DATABASE_URI) as db:
        try:
            query = db.prepare('select select_real_estate_list()')
        except:
            return jsonify('Error occured during query!', 500)

        return jsonify(query(), 200)

    return jsonify('Could not connect to database!', 500)


@app.route('/api/set/device', methods=['POST'])
def add_device():
    ''' Set new device and device parameters into the DB '''
    data = request.get_json()

    with postgresql.open(config.DATABASE_URI) as db:
        query = db.prepare(
            "call add_device({}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {})".format(
                data.get('device_type_id'),
                data.get('real_estate_id'),
                data.get('status'),
                f"'{data.get('time_activated')}'",
                f"'{data.get('time_deactivated')}'",
                f"'{data.get('name')}'",
                f"'{data.get('ip')}'",
                data.get('to_alarm')    if data.get('to_alarm')     else 'NULL',
                data.get('temperature') if data.get('temperature')  else 'NULL',
                data.get('humidity')    if data.get('humidity')     else 'NULL',
                data.get('speed')       if data.get('speed')        else 'NULL',
                int(data.get('color')[1:], 16) if data.get('color') else 'NULL',
                data.get('max_value')   if data.get('max_value')    else 'NULL',
                data.get('power')       if data.get('power')        else 'NULL',
                f"'{data.get('password')}'"
            )
        )
        try:
            query()
            return jsonify('Successfully added device'), 201

        except Exception as e:
            return jsonify('Could not add device: {}!'.format(str(e)), 400)

    return jsonify('Could not connect to database!', 500)


if __name__ == '__main__':
    app.run(host=config.HOSTNAME, port=config.PORT, debug=config.DEBUG)
