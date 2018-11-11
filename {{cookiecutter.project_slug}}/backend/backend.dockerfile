FROM tiangolo/uwsgi-nginx-flask:python3.7

COPY ./app /app
WORKDIR /app/

ENV PYTHONPATH=/app

RUN pip install --upgrade pip
RUN pip install -r requirements/common.txt
RUN pip install -r requirements/backend.txt

# For development, Jupyter remote kernel, Hydrogen
# Using inside the container:
# jupyter notebook --ip=0.0.0.0 --allow-root
ARG env=prod
RUN bash -c "if [ $env == 'dev' ] ; then pip install jupyter ; fi"
EXPOSE 8888

ENV STATIC_PATH /app/app/static
ENV STATIC_INDEX 1

EXPOSE 80
