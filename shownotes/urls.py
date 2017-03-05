from django.conf.urls import url
from shownotes import views
from shownotes import api

urlpatterns = [
    url(r'^$', views.index),
    url(r'^search$', views.search_topics),
    url(r'^api/topics$', api.topics),
    url(r'^api/search$', api.search),
    url(r'^api/show$', api.show),
    url(r'^api/note$', api.note)
]
