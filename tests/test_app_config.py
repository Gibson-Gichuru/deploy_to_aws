from tests import TestBaseConfig

class TestAppConfig(TestBaseConfig):

    def test_app_is_in_test_mode(self):

        self.assertTrue(self.app.config['TESTING'])