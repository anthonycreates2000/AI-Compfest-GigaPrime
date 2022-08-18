from django.contrib import admin
from .views import ColabBasedRecommedationAPI, ContentBasedRecommendationAPI, NewsFetchDetailsAPI, NewsFetchLinksAPI
from rest_framework import routers
from django.urls import path, include

urlpatterns = [
    path(r'travelling_places_list', ContentBasedRecommendationAPI.as_view(), name = "list_of_travelling_places"),
    path(r'news_list', NewsFetchLinksAPI.as_view(), name = "news_list"),
    path(r'news_details', NewsFetchDetailsAPI.as_view(), name = "news_details"),
    path(r'colab_filtering_travelling_places', ColabBasedRecommedationAPI.as_view(), name = "colab_filtering_travelling_places"),
]