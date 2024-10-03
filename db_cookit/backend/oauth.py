from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import User
from rest_framework.authtoken.models import Token

class OauthView(APIView):
    def post(self, request):
        email = request.data.get('email')
        password = request.data.get('password')
        first_name = request.data.get('first_name')
        last_name = request.data.get('last_name')
        user = User.objects.filter(email=email).first()
        if not user:
            user = User(email=email, username=email, first_name=first_name, last_name=last_name)
            user.set_password(password)
            user.save()
        token = Token.objects.get_or_create(user=user)
        if user:
            return Response({
                'id': user.pk,
                'token': token[0].key,
                'email': user.email,
                'first_name': user.first_name,
                'last_name': user.last_name,
                'phone_number': user.phone_number
            })
        else:
            return Response(status=status.HTTP_401_UNAUTHORIZED)