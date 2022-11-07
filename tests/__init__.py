from unittest import TestCase

from app import create_app


class TestBaseConfig(TestCase):

    def setUp(self):

        self.app = create_app("testing")

        self.app_context = self.app.app_context()

        self.app_context.push()

    def tearDown(self):

        self.app_context.pop()

        self.app = None
