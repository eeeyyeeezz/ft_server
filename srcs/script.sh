service nginx start
service php7.3-fpm start
service mysql start
mysql -e "CREATE DATABASE DockerTest;" 
mysql -e "CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';"
mysql -e "GRANT ALL ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'admin' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES"

bash
