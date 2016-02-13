FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

#Tasking Manager Web Server
MAINTAINER Kristofor Carle - Moabi <kristoforcarle@moabi.org>

#install dependancies
RUN apt-get update && apt-get install -y python-pip libpq-dev libgeos-c1 python-dev build-essential
RUN pip install virtualenv virtualenvwrapper
RUN pip install --upgrade pip

#copy over application
RUN mkdir /home/tm
COPY . /home/tm
RUN chmod +x /home/tm/docker-entrypoint.sh

#copy environment specific config file
#COPY local.ini  /home/tm/local.ini

WORKDIR /home/tm
RUN easy_install virtualenv
RUN virtualenv --no-site-packages env

RUN ./env/bin/pip install -r requirements.txt

EXPOSE 6543

CMD /home/tm/docker-entrypoint.sh
