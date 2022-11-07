class DefaultConfig:

    @staticmethod
    def init_app(app):

        pass 


class Development(DefaultConfig):

    @staticmethod
    def init_app(app):
        
        pass 

class Testing:

    TESTING = True

    @staticmethod
    def init_app(app):

        pass 


class Production:

    @staticmethod
    def init_app(app):

        pass


env_config = {
    "default":Development,
    "development":Development,
    "testing":Testing,
    "production":Production
}