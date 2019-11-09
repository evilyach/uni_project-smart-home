import utils.config as config
import utils.logger
import routes.index
from db.init import init_db

import os
from optparse import OptionParser
from flask import Flask

app = Flask(__name__)

def parse_opts():
    parser = OptionParser(usage='%prog [options]')

    parser.add_option("--host",
                      dest='host',
                      help='host, default: localhost',
                      default='localhost')
    parser.add_option("--port",
                      dest='port',
                      help='port, default: 13490',
                      default=13490)
    parser.add_option("--username",
                      dest='username',
                      help='username, default: {}'.format(config.BASIC_AUTH_USERNAME),
                      default=config.BASIC_AUTH_USERNAME)
    parser.add_option("--password",
                      dest='password',
                      help='password, default: {}'.format(config.BASIC_AUTH_PASSWORD),
                      default=config.BASIC_AUTH_PASSWORD)

    return parser.parse_args()

from flask import render_template
@app.route('/')
def index():
    return render_template('index.html')

if __name__ == "__main__":
    app.config.from_pyfile('utils/config.py')

    opts, args = parse_opts()
    app.config.update(dict(
        BASIC_AUTH_USERNAME=opts.username,
        BASIC_AUTH_PASSWORD=opts.password,
    ))

    app_dir = os.path.realpath(os.path.dirname(__file__))
    db_path = os.path.join(app_dir, app.config['DATABASE_FILE'])

    if not os.path.exists(db_path):
        init_db()

    app.run(host=opts.host, port=opts.port, debug=True, threaded=True)