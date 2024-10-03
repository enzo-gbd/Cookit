from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils import timezone

class User(AbstractUser):
    email = models.CharField(max_length=255, unique=True)
    password = models.CharField(max_length=255)
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    phone_number = models.CharField(max_length=255, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = 'users'

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['password', 'first_name', 'last_name']

class Favorite(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    dish_name = models.CharField(max_length=255)
    parts_number = models.IntegerField()
    calories = models.IntegerField()
    recipe = models.TextField()
    ingredients = models.TextField()

    class Meta:
        db_table = 'favorites'

