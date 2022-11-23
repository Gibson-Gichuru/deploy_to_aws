import sys

import os

from app import create_app

application = create_app(os.environ.get("FLASK_ENV") or "default")


@application.cli.command()
def test():

    import unittest

    # running unittests

    tests = unittest.TestLoader().discover("tests")

    results = unittest.TextTestRunner(verbosity=2).run(tests)

    if not results.wasSuccessful():

        sys.exit()
