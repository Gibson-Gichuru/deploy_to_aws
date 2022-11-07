from tests import TestBaseConfig


class TestAppRoutes(TestBaseConfig):

    def setUp(self):

        super().setUp()

        self.client = self.app.test_client()

    def test_home_route(self):

        response = self.client.get("/").get_json()

        self.assertDictEqual(response, {
            "content":"sample Application",
            "purpose":"Test Driven development",
        })
