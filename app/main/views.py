from flask.views import MethodView

from flask import jsonify


class Index(MethodView):

    def get(self):

        response = {
            'content': 'sample Application',
            'purpose': 'Test Driven development'
        }

        return jsonify(response)
