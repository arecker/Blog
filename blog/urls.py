from django.conf.urls import url, include
from django.conf.urls.static import static
from django.conf import settings
from django.contrib import admin

from api import ROUTER
from subscribing.views import unsubscribe, verify


urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^api/', include(ROUTER.urls)),

    url(r'^verify/(?P<key>[^/]+)/$', verify, name='verify'),
    url(r'^unsubscribe/(?P<key>[^/]+)/$', unsubscribe, name='unsubscribe'),

]

urlpatterns += static(settings.MEDIA_URL,
                      document_root=settings.MEDIA_ROOT)
