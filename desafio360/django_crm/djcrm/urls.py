from django.shortcuts import redirect
from django.urls import path, include
from django.contrib import admin

urlpatterns = [
    path('admin/', admin.site.urls),  # URL para a interface administrativa do Django
    path('', lambda request: redirect('leads/')),  # Redireciona a rota raiz para 'leads/'
    path('leads/', include('leads.urls')),  # Inclui as URLs específicas da app 'leads'
]
