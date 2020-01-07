from flask import Flask, jsonify, make_response, request
from datetime import datetime, timedelta
import postgresql
import re
import jwt

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

    user = auth.authenticate(username, password)

    if not user:
        return jsonify({
            'message': 'Invalid credentials',
            'authenticated': False}), 401

    token = jwt.encode({
        'sub': username,
        'iat': datetime.utcnow(),
        'exp': datetime.utcnow() + timedelta(minutes=30)},
        config.SECRET_KEY
    )

    return jsonify({'token': token.decode('UTF-8')}), 200


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
            query = db.prepare('select select_from_raw_' + table_name + '()')
        except:
            return jsonify('Error occured during query!', 500)

        return jsonify(query(), 200)

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


if __name__ == '__main__':
    app.run(host=config.HOSTNAME, port=config.PORT, debug=config.DEBUG)
