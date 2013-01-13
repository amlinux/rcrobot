from django.conf.urls.defaults import *

urlpatterns = patterns('',
#    (r'^rcweb/', include('rcweb.foo.urls')),
    (r'^$', 'rcweb.radio.views.index'),
)
