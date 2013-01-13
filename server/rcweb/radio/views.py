from django.http import HttpResponse
from concurrence import Tasklet

def index(request):
    Tasklet.sleep(10)
    return HttpResponse("Hello, world. You're at the poll index.")
