from flask import Flask

from config import env_config


def create_app(config):

    app = Flask(__name__)

    app.config.from_object(env_config[config])

    env_config[config].init_app(app)

    # Registering Application Blueprints

    from app.main import main_blueprint

    app.register_blueprint(main_blueprint)

    return app
