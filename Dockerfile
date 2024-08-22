
ARG BASE_IMAGE=python:3.12.5-slim
FROM ${BASE_IMAGE}

COPY requirements.txt .
COPY . /app
WORKDIR /app 

RUN pip install -r requirements.txt

VOLUME /rates

ENV CURR_DEFAULT='USD'

ENTRYPOINT ["python3"]
CMD ["app.py"]