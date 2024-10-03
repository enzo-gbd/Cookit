from rest_framework import serializers
from backend.models import User, Favorite

class UserSerializer(serializers.ModelSerializer):
    email = serializers.EmailField(required=True)
    first_name = serializers.CharField(required=True)
    last_name = serializers.CharField(required=True)
    password = serializers.CharField(write_only=True, required=False)
    phone_number = serializers.CharField(required=False, allow_blank=True)

    class Meta:
        model = User
        fields = ('id', 'email', 'password', 'first_name', 'last_name', 'phone_number', 'created_at', 'updated_at')
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        password = validated_data.pop('password', None)
        validated_data['username'] = validated_data['email']
        user = User.objects.create_user(**validated_data)
        if password is not None:
            user.set_password(password)
            user.save()
        return user
    
    def update(self, instance, validated_data):
        email = validated_data.get('email')
        if email is not None:
            instance.email = email
        first_name = validated_data.get('first_name')
        if first_name is not None:
            instance.first_name = first_name
        last_name = validated_data.get('last_name')
        if last_name is not None:
            instance.last_name = last_name
        phone_number = validated_data.get('phone_number')
        if phone_number is not None:
            instance.phone_number = phone_number
        password = validated_data.get('password')
        if password is not None:
            instance.set_password(password)
        instance.save()
        return instance
    

class FavoriteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Favorite
        fields = ('id', 'user', 'dish_name', 'parts_number', 'calories', 'recipe', 'ingredients')
        extra_kwargs = {'user': {'write_only': True}}
    
    def create(self, validated_data):
        validated_data['dish_name'] = validated_data['dish_name'].replace("\"", "")
        favorite = Favorite.objects.create(**validated_data)
        return favorite
    
    def update(self, instance, validated_data):
        instance.user = validated_data.get('user', instance.user)
        instance.dish_name = validated_data.get('dish_name', instance.dish_name)
        instance.parts_number = validated_data.get('parts_number', instance.parts_number)
        instance.calories = validated_data.get('calories', instance.calories)
        instance.recipe = validated_data.get('recipe', instance.recipe)
        instance.ingredients = validated_data.get('ingredients', instance.ingredients)
        instance.save()
        return instance