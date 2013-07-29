start_seconds=`date +%s`

echo "Config des sources..."
cat /srv/config/apt-source-default.list > /etc/apt/sources.list
cat /srv/config/apt-source-append.list >> /etc/apt/sources.list

apt_package_list=()

echo "Check for packages to install..."

# if dpkg --status webmin | grep -q 'Status: install ok installed';
# 	then echo "webmin already installed"
# 	else apt_package_list+=('webmin')
# fi

if dpkg --status php5 | grep -q 'Status: install ok installed';
	then echo "php5 already installed"
	else apt_package_list+=('php5')
fi

if dpkg --status libapache2-mod-php5 | grep -q 'Status: install ok installed';
	then echo "libapache2-mod-php5 already installed"
	else apt_package_list+=('libapache2-mod-php5')
fi

if dpkg --status php5-cli | grep -q 'Status: install ok installed';
	then echo "php5-cli already installed"
	else apt_package_list+=('php5-cli')
fi

# Common and dev packages for php
if dpkg --status php5-common | grep -q 'Status: install ok installed';
	then echo "php5-common already installed"
	else apt_package_list+=('php5-common')
fi

if dpkg --status php5-dev | grep -q 'Status: install ok installed';
	then echo "php5-dev already installed"
	else apt_package_list+=('php5-dev')
fi

# Extra PHP modules that we find useful
if dpkg --status php5-imap | grep -q 'Status: install ok installed';
	then echo "php5-imap already installed"
	else apt_package_list+=('php5-imap')
fi

if dpkg --status php5-imagick | grep -q 'Status: install ok installed';
	then echo "php5-imagick already installed"
	else apt_package_list+=('php5-imagick')
fi

if dpkg --status php5-xdebug | grep -q 'Status: install ok installed';
	then echo "php5-xdebug already installed"
	else apt_package_list+=('php5-xdebug')
fi

if dpkg --status php5-mcrypt | grep -q 'Status: install ok installed';
	then echo "php5-mcrypt already installed"
	else apt_package_list+=('php5-mcrypt')
fi

if dpkg --status php5-mysql | grep -q 'Status: install ok installed';
then
	echo "php5-mysql already installed"
else
	apt_package_list+=('php5-mysql')
fi

if dpkg --status php5-curl | grep -q 'Status: install ok installed';
	then echo "php5-curl already installed"
	else apt_package_list+=('php5-curl')
fi

if dpkg --status php-pear | grep -q 'Status: install ok installed';
	then echo "php-pear already installed"
	else apt_package_list+=('php-pear')
fi

if dpkg --status php5-gd | grep -q 'Status: install ok installed';
	then echo "php5-gd already installed"
	else apt_package_list+=('php5-gd')
fi

if dpkg --status php-apc | grep -q 'Status: install ok installed';
	then echo "php-apc already installed"
	else apt_package_list+=('php-apc')
fi

# nginx
if dpkg --status apache2 | grep -q 'Status: install ok installed';
	then echo "apache2 already installed"
	else 
		apt_package_list+=('apache2')
		apt_package_list+=('apache2-mpm-prefork')
fi

# mariadb
if dpkg --status mariadb-server-5.5 | grep -q 'Status: install ok installed';
then
	echo "mariadb-server-5.5 already installed"
else
	echo mysql-server mysql-server/root_password password root | debconf-set-selections
	echo mysql-server mysql-server/root_password_again password root | debconf-set-selections

#	apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db 
	apt_package_list+=('mariadb-server-5.5')
#	apt_package_list+=('libmysqlclient18=5.5.30-mariadb1~wheezy')
fi

# if dpkg --status phpmyadmin | grep -q 'Status: install ok installed';
# 	then echo "phpmyadmin already installed"
# 	else apt_package_list+=('phpmyadmin')
# fi

# memcached
if dpkg --status memcached | grep -q 'Status: install ok installed';
	then echo "memcached already installed"
	else 
		apt_package_list+=('memcached')
		apt_package_list+=('php5-memcached')
fi

# imagemagick
if dpkg --status imagemagick | grep -q 'Status: install ok installed';
	then echo "imagemagic already installed" 
	else apt_package_list+=('imagemagick')
fi

# subversion
if dpkg --status subversion | grep -q 'Status: install ok installed';
	then echo "subversion already installed"
	else apt_package_list+=('subversion')
fi

# ack-grep / ack
if dpkg --status ack-grep | grep -q 'Status: install ok installed';
	then echo "ack-grep already installed"
	else apt_package_list+=('ack-grep')
fi

# git
if dpkg --status git-core | grep -q 'Status: install ok installed';
	then echo "git-core already installed"
	else apt_package_list+=('git-core')
fi

# unzip
if dpkg --status unzip | grep -q 'Status: install ok installed';
	then echo "unzip already installed"
	else apt_package_list+=('unzip')
fi

# ngrep
if dpkg --status ngrep | grep -q 'Status: install ok installed';
	then echo "ngrep already installed"
	else apt_package_list+=('ngrep')
fi

# curl
if dpkg --status curl | grep -q 'Status: install ok installed';
	then echo "curl already installed"
	else apt_package_list+=('curl')
fi

# make
if dpkg --status make | grep -q 'Status: install ok installed';
	then echo "make already installed"
	else apt_package_list+=('make')
fi

# vim
if dpkg --status vim | grep -q 'Status: install ok installed';
	then echo "vim already installed"
	else apt_package_list+=('vim')
fi

# python
if dpkg --status python | grep -q 'Status: install ok installed';
	then echo "python already installed"
	else apt_package_list+=('python')
fi

# dos2unix
# allows conversion of DOS style line endings to something we'll have
# less trouble with in linux.
if dpkg --status dos2unix | grep -q 'Status: install ok installed';
	then echo "dos2unix already installed"
	else apt_package_list+=('dos2unix')
fi

# If there are any packages to be installed in the apt_package_list array,
# then we'll run `apt-get update` and then `apt-get install` to proceed.
if [ ${#apt_package_list[@]} = 0 ];
then 
	printf "No packages to install.\n\n"
else
	# update all of the package references before installing anything
	printf "Running apt-get update....\n"
	apt-get update --force-yes -y

	# install required packages
	printf "Installing apt-get packages...\n"
	apt-get install --force-yes -y ${apt_package_list[@]}

	# Clean up apt caches
	apt-get clean			
fi

# Make ack respond to its real name
ln -fs /usr/bin/ack-grep /usr/bin/ack

# COMPOSER
#
# Install or Update Composer based on expected hash from repository
if composer --version | grep -q 'Composer version e4b48d39d';
then
	printf "Composer already installed\n"
elif composer --version | grep -q 'Composer version';
then
	printf "Updating Composer...\n"
	composer self-update
else
	printf "Installing Composer...\n"
	curl -sS https://getcomposer.org/installer | php
	chmod +x composer.phar
	mv composer.phar /usr/local/bin/composer
fi

if [ ! -d /usr/local/src/vvv-phpunit ]
then
	printf "Installing PHPUnit, Hamcrest and Mockery...\n"
	mkdir -p /usr/local/src/vvv-phpunit
	cp /srv/config/phpunit-composer.json /usr/local/src/vvv-phpunit/composer.json
	sh -c "cd /usr/local/src/vvv-phpunit && composer install"
else
	cd /usr/local/src/vvv-phpunit
	if composer show -i | grep -q 'mockery'; then echo 'Mockery installed';else vvvphpunit_update=1;fi
	if composer show -i | grep -q 'phpunit'; then echo 'PHPUnit installed'; else vvvphpunit_update=1;fi
	if composer show -i | grep -q 'hamcrest'; then echo 'Hamcrest installed'; else vvvphpunit_update=1;fi
	cd ~/
fi

if [ "$vvvphpunit_update" = 1 ]
then
	printf "Update PHPUnit, Hamcrest and Mockery...\n"
	cp /srv/config/phpunit-composer.json /usr/local/src/vvv-phpunit/composer.json
	sh -c "cd /usr/local/src/vvv-phpunit && composer update"
fi

# SYMLINK HOST FILES
printf "\nLink Directories...\n"

# Configuration for nginx
ln -sf /srv/config/apache-config/apache2.conf /etc/apache2/apache2.conf | echo "Linked apache2.conf to /etc/apache2/"
ln -sf /srv/config/apache-config/httpd.conf /etc/apache2/httpd.conf | echo "Linked httpd.conf to /etc/apache2/"
ln -sf /srv/config/apache-config/ports.conf /etc/apache2/ports.conf | echo "Linked ports.conf to /etc/apache2/"

ln -sf /srv/config/php/php.ini /etc/php5/apache2/php.ini | echo "Linked php.ini to /etc/php5/apache2/php.ini"


# activation mod
printf "\nActivation modules apache2...\n"
a2enmod rewrite
a2enmod headers
a2enmod	expires

# RESTART SERVICES
#
# Make sure the services we expect to be running are running.
printf "\nRestart services...\n"
printf "service apache2 restart\n"
service apache2 restart

# mysql gives us an error if we restart a non running service, which
# happens after a `vagrant halt`. Check to see if it's running before
# deciding whether to start or restart.
exists_mysql=`service mysql status`
if [ "mysql stop/waiting" == "$exists_mysql" ]
then
	printf "service mysql start"
	service mysql start
else
	printf "service mysql restart"
	service mysql restart
fi

# IMPORT SQL
#
# Create the databases (unique to system) that will be imported with
# the mysqldump files located in database/backups/
if [ ! -f /home/vagrant/flags/disable_sql_commands ]
then
	if [ -f /srv/database/init-custom.sql ]
	then
		mysql -u root -proot < /srv/database/init-custom.sql | printf "\nInitial custom mysql scripting...\n"
	else
		printf "\nNo custom mysql scripting found in database/init-custom.sql, skipping...\n"
	fi
fi

# Setup mysql by importing an init file that creates necessary
# users and databases that our vagrant setup relies on.
mysql -u root -proot < /srv/database/init.sql | echo "Initial mysql prep...."

# Process each mysqldump SQL file in database/backups to import 
# an initial data set for mysql.
if [ ! -f /home/vagrant/flags/disable_sql_import ]
then
	/srv/database/import-sql.sh
fi

# WP-CLI Install
if [ -f /home/vagrant/flags/enable_wp_cli ]
then
	if [ ! -d /srv/www/wp-cli ]
	then
		printf "\nDownloading wp-cli.....http://wp-cli.org\n"
		git clone git://github.com/wp-cli/wp-cli.git /srv/www/wp-cli
		cd /srv/www/wp-cli
		composer install
	else
		printf "\nSkip wp-cli installation, already available\n"
	fi
	# Link wp to the /usr/local/bin directory
	ln -sf /srv/www/wp-cli/bin/wp /usr/local/bin/wp
fi

end_seconds=`date +%s`
echo -----------------------------
echo Provisioning complete in `expr $end_seconds - $start_seconds` seconds
echo For further setup instructions, visit http://192.168.50.5
