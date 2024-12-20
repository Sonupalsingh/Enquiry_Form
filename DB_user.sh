#!/bin/bash

# This script secures MariaDB installation and creates a new user with permissions on all databases.

# Function to run mysql_secure_installation
secure_mariadb() {
    echo "Running mysql_secure_installation..."
    sudo mysql_secure_installation
}

ROOT_PASS=1234
DB_USER=sonu
DB_USER=sonu
DB_NAME=TrainingEnquiry
# Function to create a new MariaDB user
create_mariadb_user() {
    # Prompt for the root password
    #read -sp "Enter the MariaDB root password: " ROOT_PASS
    #echo

    # Prompt for the new username and password
    #read -p "Enter the new MariaDB username: " DB_USER
    #read -sp "Enter the password for the new user: " DB_PASS
    #echo

    # Connect to MariaDB and create the user with permissions
    sudo mysql -u root -p"$ROOT_PASS" -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
    sudo mysql -u root -p"$ROOT_PASS" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost' WITH GRANT OPTION;"
    sudo mysql -u root -p"$ROOT_PASS" -e "FLUSH PRIVILEGES;"

    # Print completion message
    echo "User  '$DB_USER' created with permissions on all databases."
}

# Check if the root password is set
if sudo mysql -u root -e "exit" 2>/dev/null; then
    echo "Root password is already set."
    create_mariadb_user
else
    echo "Root password is not set. You will need to set it now."
    secure_mariadb
    create_mariadb_user
fi
