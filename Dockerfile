#
# MongoDB Dockerfile
#
# https://github.com/dockerfile/mariadb
#

# Pull base image.
FROM debian

# Creating mongodb user
RUN groupadd -r mongodb && useradd -r -g mongodb mongodb

# Installing mongo
RUN sudo apt-get update
RUN sudo apt-get install mongodb
RUN sudo chown -R mongodb /opt/mongodb

# Create the mongo data dirs
RUN sudo mkdir -p /data/db && \
    sudo chown mongodb /data/db

# Creating runtime directories under /var
RUN install -o mongodb -g mongodb -d /var/log/mongodb/ && \
    install -o mongodb -g mongodb -d /var/lib/mongodb/

# Installing config scripts
ADD mongodb.conf .
RUN install mongodb.conf /etc

VOLUME /data/db

EXPOSE 27017
CMD ["/opt/mongodb/bin/mongod"]
