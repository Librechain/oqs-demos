#!/bin/bash

# Script assumes nginx to have been built for this platform using the ../(nginx-)Dockerfile instructions
NGINX_INSTALL_DIR=/opt/nginx

#cleanup
rm -rf pki root common.py *.html *.conf

# Obtain current list of algorithms
wget https://raw.githubusercontent.com/open-quantum-safe/openssl/OQS-OpenSSL_1_1_1-stable/oqs-test/common.py

mkdir pki

# Now generate config file
python3 genconfig.py

# Now move it all in place
rm -rf ${NGINX_INSTALL_DIR}/pki
cp -R pki ${NGINX_INSTALL_DIR}
cp interop.conf ${NGINX_INSTALL_DIR}
cp index-base.html ${NGINX_INSTALL_DIR}/html
echo "start up nginx with 'nginx -c interop.conf'"