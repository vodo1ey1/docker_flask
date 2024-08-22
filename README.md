Создать образ:
docker build -t docker_gertsev_rate:v1.2 flask_app/

Запустить контейнер:
docker run -it -p 8000:8000 --name docker_gertsev_rate  docker_gertsev_rate:v1.2
