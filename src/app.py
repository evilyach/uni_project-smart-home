import cfg

from optparse import OptionParser
from flask import Flask

app = Flask(__name__)

@app.route('/')
def root():
    return 'Hello World!'

if __name__ == "__main__":
    app.run(cfg.hostname, cfg.port, debug=True)