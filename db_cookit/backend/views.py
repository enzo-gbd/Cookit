from rest_framework.views import APIView
from rest_framework.generics import CreateAPIView, UpdateAPIView, DestroyAPIView
from rest_framework.response import Response
from rest_framework import viewsets, status
from backend.models import User, Favorite
from backend.serializers import UserSerializer, FavoriteSerializer
from .openai.prompt import ask_prompt
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication
from rest_framework.authtoken.models import Token
import json


class LoginView(APIView):
    def post(self, request, format=None):
        email = request.data.get('email')
        password = request.data.get('password')
        user = User.objects.filter(email=email).first()
        if user is not None:
            if user.check_password(password):
                token = Token.objects.get_or_create(user=user)
                return Response({'email': user.email,
                                 'first_name': user.first_name,
                                 'last_name': user.last_name,
                                 'phone_number': user.phone_number,
                                 'id': user.pk,
                                 'token': token[0].key}, status=status.HTTP_200_OK)
        return Response({'error': 'Wrong Credentials'}, status=status.HTTP_401_UNAUTHORIZED)
    

class OpenAIView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request, format=None):
        peopleNumber = request.data.get('peopleNumber')
        mealNumber = request.data.get('mealNumber')
        mealType = request.data.get('mealType')
        allergies = request.data.get('allergies')
        ingredients = request.data.get('ingredients')
        nutrition = request.data.get('nutrition')
        prompt = f"""tu es cuisinier et expert nutritionniste,
        j'aimerais que tu me donne {mealNumber} idées de {mealType} pour {peopleNumber} personnes en sachant que je suis
        allergique à: {allergies}.
        je ne veux pas de: {ingredients}.
        je veux que ce soit: {nutrition}.
        J'aimerais si possible que tu me donne le nombre de calories de chaque propositions. Donne moi les propositions sous format: [nom du plat] : [calories par portion] calories par portion : [recette]"""

        message = ask_prompt(prompt)
        for i in range(len(message)):
            message[i][0] = json.dumps(message[i][0]).encode('utf-8')
            message[i][2] = json.dumps(message[i][2]).encode('utf-8')
        return Response({'meals': message}, status=status.HTTP_200_OK)

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    
class UserCreate(CreateAPIView):
    serializer_class = UserSerializer

class UserUpdate(UpdateAPIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    queryset = User.objects.all()
    serializer_class = UserSerializer

class UserDelete(DestroyAPIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    queryset = User.objects.all()
    serializer_class = UserSerializer

class getFavoritesUser(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request, format=None):
        user_id = request.data.get('user_id')
        user = User.objects.filter(id=user_id).first()
        if user is not None:
            favorites = Favorite.objects.filter(user=user)
            data = []
            for favorite in favorites:
                favorite.dish_name = json.dumps(favorite.dish_name).encode('utf-8')
                data.append({"id": favorite.id, "dish_name": favorite.dish_name, "calories": favorite.calories})
            return Response(data, status=status.HTTP_200_OK)
        return Response({'error': 'Wrong Credentials'}, status=status.HTTP_401_UNAUTHORIZED)

class FavoriteViewSet(viewsets.ModelViewSet):
    queryset = Favorite.objects.all()
    serializer_class = FavoriteSerializer

class FavoriteCreate(CreateAPIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    serializer_class = FavoriteSerializer

class FavoriteUpdate(UpdateAPIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    queryset = Favorite.objects.all()
    serializer_class = FavoriteSerializer

class FavoriteDelete(DestroyAPIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    queryset = Favorite.objects.all()
    serializer_class = FavoriteSerializer
