from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import \
    UserViewSet, UserCreate, UserUpdate, UserDelete, \
    FavoriteViewSet, FavoriteCreate, FavoriteUpdate, FavoriteDelete, getFavoritesUser, \
    LoginView, OpenAIView
from .oauth import OauthView

router = DefaultRouter()
router.register(r"users", UserViewSet, basename="users")
router.register(r"favorites", FavoriteViewSet, basename="favorites")

urlpatterns = [
    path("", include(router.urls)),
    path("users/", UserCreate.as_view(), name="create_user"),
    path("users/update/<int:pk>/", UserUpdate.as_view(), name="update_user"),
    path("users/delete/<int:pk>/", UserDelete.as_view(), name="delete_user"),
    path("login/", LoginView.as_view(), name="login"),
    path("oauth/", OauthView.as_view(), name="oauth"),
    path("favorites/", FavoriteCreate.as_view(), name="create_favorite"),
    path("favoritesUser/", getFavoritesUser.as_view(), name="get_favorites_user"),
    path("favorites/update/<int:pk>/", FavoriteUpdate.as_view(), name="update_favorite"),
    path("favorites/delete/<int:pk>/", FavoriteDelete.as_view(), name="delete_favorite"),
    path("openai/", OpenAIView.as_view(), name="openai"),
]