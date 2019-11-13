FROM python:latest
WORKDIR /
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt && rm requirements.txt

VOLUME ./analytics.pickle /config/

COPY . /app
WORKDIR /app

CMD python -m celery worker -B -A schedule --loglevel=debug -Q nebula.import,nebula.express -n node_1_test
