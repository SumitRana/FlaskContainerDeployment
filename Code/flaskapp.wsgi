#!/usr/bin/python
import sys
import logging
logging.basicConfig(stream=sys.stderr)

appPath = "/var/www/html/Code/"
sys.path.insert(0,appPath)

from FlaskApp import app as application
application.secret_key = 'Add your secret key'