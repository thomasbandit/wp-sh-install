# Install Latest WP reading target directory as argument
TARGET_DIR=$1

# If target directory is not set
if [ -z "${TARGET_DIR}" ]; then
	echo "Target directory not set! Script will abort."
	exit 1
# If target directory is a file
elif [ -f "./${TARGET_DIR}" ]; then
	echo "Target directory is a file! Script will abort."
	exit 1
# Create directory if it doesn't exist
elif [ ! -d "./${TARGET_DIR}" ]; then
	mkdir $TARGET_DIR
fi

echo "Installing latest WordPress in $TARGET_DIR"

# Download and extract WordPress
wget http://wordpress.org/latest.tar.gz
tar -xzvf ./latest.tar.gz -C $TARGET_DIR

# Clean up
rm ./latest.tar.gz

mv ${TARGET_DIR}/wordpress/* ${TARGET_DIR}/

cd ${TARGET_DIR}
rm -R ./wordpress

mv ./wp-config-sample.php ./wp-config.php

# Create uploads directory + set permissions
mkdir ./wp-content/uploads/
chmod -R 777 ./wp-content/uploads/

echo "WordPress install complete! Remember to create your DB and configure your wp-config.php"