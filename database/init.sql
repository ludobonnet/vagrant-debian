
# Create an external user with privileges on all databases in mysql so
# that a connection can be made from the local machine without an SSH tunnel
GRANT ALL PRIVILEGES ON *.* TO 'external'@'%' IDENTIFIED BY 'external';

# Create your database and account
# CREATE DATABASE IF NOT EXISTS `totoDB`;
#GRANT ALL PRIVILEGES ON `totoDB`.* TO 'totoUser'@'localhost' IDENTIFIED BY 'totoPwd';
