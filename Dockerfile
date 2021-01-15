FROM debian:buster

LABEL student=gmorra

RUN apt-get update 
RUN	apt-get install nginx -y mariadb-server wget php7.3-fpm php7.3-mysql openssl

COPY /srcs/default /etc/nginx/sites-available/default

WORKDIR /var/www/html
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
RUN rm -rf latest.tar.gz
WORKDIR /var/www/html/wordpress
COPY ./srcs/wp-config.php .

WORKDIR /var/www/html/phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
RUN tar -xzvf phpMyAdmin-5.0.4-all-languages.tar.gz
RUN rm -rf phpMyAdmin-5.0.4-all-languages.tar.gz
RUN mv phpMyAdmin-5.0.4-all-languages phpMyAdmin

EXPOSE 80 443

COPY srcs/script.sh ./

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt  -subj "/C=RU/ST=Kazan/L=Kazan/O=21/OU=gmorra/CN=localhost"

RUN chmod 777 script.sh
CMD bash script.sh
