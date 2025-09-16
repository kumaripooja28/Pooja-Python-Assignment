from rest_framework.routers import DefaultRouter
from .views import ItemViewSet
from django.urls import path, include

router = DefaultRouter()
router.register(r'', ItemViewSet, basename='item')

urlpatterns = [
    path('', include(router.urls)),
]
