FROM python:3.7

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

RUN chmod +x tests-start.sh

# This will make the container wait, doing nothing, but alive
CMD ["bash", "-c", "while true; do sleep 1; done"]

# Afterwards you can exec a command /tests-start.sh in the live container, like:
# docker exec -it backend-tests /tests-start.sh
