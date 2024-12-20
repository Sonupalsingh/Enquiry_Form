#!/bin/bash

# Variables
DB_ROOT_PASSWORD="1234"
DB_USER="sonu"
DB_PASS="sonu"
DB_NAME="TrainingEnquiry"
TABLE_NAME="Enquiries"
GIT_REPO="https://github.com/Sonupalsingh/Enquiry_Form.git"
WEB_ROOT="/var/www/html"

# Update and install required packages
echo "Updating system and installing dependencies..."
sudo yum update -y
sudo yum install -y httpd git mariadb-server mariadb php php-mysqlnd

# Start and enable services
echo "Starting and enabling Apache and MariaDB services..."
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Clone Git repository and set it as web root
echo "Cloning Git repository..."
sudo git clone $GIT_REPO ${WEB_ROOT}/Enquiry_Form
sudo mv ${WEB_ROOT}/Enquiry_Form/* $WEB_ROOT/
sudo rm -rf ${WEB_ROOT}/Enquiry_Form
sudo rm -rf /home/ec2-user/Ecquiry_Form

# Secure MariaDB installation
echo "Securing MariaDB installation..."
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
sudo mysql -e "DELETE FROM mysql.user WHERE User='';"
sudo mysql -e "DROP DATABASE IF EXISTS test;"
sudo mysql -e "FLUSH PRIVILEGES;"

# Create the database and table
echo "Creating database and table..."
sudo mysql -u root -p"${DB_ROOT_PASSWORD}" -e "
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
USE ${DB_NAME};
CREATE TABLE IF NOT EXISTS ${TABLE_NAME} (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    fullName VARCHAR(255) NOT NULL,
    contact VARCHAR(20) NOT NULL,
    course VARCHAR(255) NOT NULL,
    reference VARCHAR(255) NOT NULL,
    submission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);"

# Create a new MariaDB user with permissions
echo "Creating MariaDB user with permissions..."
sudo mysql -u root -p"${DB_ROOT_PASSWORD}" -e "
CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;"

echo "Setup complete! Apache is running, MariaDB is secured, and the database is ready."
