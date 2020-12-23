FROM ubuntu:18.04

# update system repository
RUN apt-get update --fix-missing

# installation for python3
RUN apt-get upgrade -y python3.6
#RUN python3 --version

# RUN DEBIAN_FRONTEND='noninteractive' apt-get install -y software-properties-common
#RUN add-apt-repository ppa:jonathonf/python-3.6
#RUN add-apt-repository ppa:deadsnakes/ppa
# RUN apt-get update -y 
#RUN apt-get install -y python3.6
#RUN python3 --version
#RUN python3.6 --version
#RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2
#RUN update-alternatives --config python3

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 2
RUN python3 --version

# install dependencies
RUN apt-get install -y python3-pip
# RUN apt-get install -y python-pip

# RUN apt-get install -y apt-utils
RUN apt-get install -y apache2 
# RUN apt-get install -y libapache2-mod-wsgi
RUN apt-get install -y libapache2-mod-wsgi-py3

# apache module
RUN a2enmod rewrite
RUN a2dismod ssl

#upgrade pip
RUN pip3 --version
RUN pip3 install --upgrade pip
RUN pip3 --version


# copying configuration file
# COPY ./conf/http-hosts.conf /etc/apache2/sites-available/

# exposing ports for communication
EXPOSE 80

# change work directory
WORKDIR /var/www/html/

# make new directory
RUN mkdir Code

# change workdirectory
WORKDIR /var/www/html/Code/

RUN ["df","-h"]
# copy code - backend code
# project structure - /Code/contents_of_Navia_production_server => not the folder
COPY ./Code/ /var/www/html/Code/
RUN ["ls","-l"]

# COPY ./apache2.conf /etc/apache2/
COPY ./VirtualHosts/000-default.conf /etc/apache2/sites-available/
COPY ./VirtualHosts/default-ssl.conf /etc/apache2/sites-available/

# copy requirements file
#COPY ./Code/requirements.txt /Code/	

# install project dependencies
RUN pip3 install -r requirements.txt


# starting proxy binding server
# RUN service apache2 start

# command to excute while initializing a container
# Running proxy server in background
#CMD ["service","apache2","start"]

# Running proxy server in foreground
#CMD ["python3","manage.py","runserver","0.0.0.0:8000"]
CMD ["apache2ctl","-D","FOREGROUND"]
