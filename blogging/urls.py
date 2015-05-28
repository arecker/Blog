from django.conf.urls import url, include
from . import views
from . import api


urlpatterns = [
    url(r'^feed/$', views.view_post_feed),
    url(r'^(?P<slug>[^/]+)/$', views.view_post)
    #url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]
