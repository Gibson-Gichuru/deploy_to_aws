from flask import Blueprint

main_blueprint = Blueprint("index",__name__)

from . import views

main_blueprint.add_url_rule(
 "/",
 view_func=views.Index.as_view("index")   
)