FROM ubuntu:latest 
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y mysql-server mysql-client
RUN mkdir -p /var/log/docker_log/mysql/ && chmod 777 /var/log/docker_log/mysql
ADD ["my.cnf", "/etc/mysql/my.cnf"]
RUN /etc/init.d/mysql start && \
    mysql -e "grant all privileges on *.* to 'root'@'%' identified by 'root';" &&\
    mysql -e "grant all privileges on *.* to 'root'@'localhost' identified by 'root';" &&\
    mysql -uroot -proot -e "show databases;"
EXPOSE 3306
CMD ["/usr/bin/mysqld_safe"]
