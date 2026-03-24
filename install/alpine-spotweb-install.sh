#!/usr/bin/env bash

# Copyright (c) 2021-2026 community-scripts ORG
# Author: combro2k
# License: MIT | https://github.com/combro2k/ProxmoxVE/raw/main/LICENSE
# Source: https://github.com/spotweb/spotweb

source /dev/stdin <<<"$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apk add tzdata
msg_ok "Installed Dependencies"

PHP_VERSION="8.4" PHP_FPM="YES" PHP_MODULE="curl,dom,gettext,xml,simplexml,zip,zlib,gd,openssl,pdo,pdo_pgsql,json,mbstring,ctype,opcache,session,intl" setup_php
setup_composer

PG_VERSION="17" setup_postgresql
PG_DB_NAME="spotweb" PG_DB_USER="spotweb" setup_postgresql_db

get_lxc_ip

fetch_and_deploy_gh_release "spotweb" "spotweb/spotweb" "tarball" "latest" "/opt/spotweb"
cd /opt/spotweb
export COMPOSER_ALLOW_SUPERUSER=1
$STD composer update --no-plugins --no-scripts
$STD composer install --no-dev --prefer-dist --no-plugins --no-scripts

motd_ssh
customize
cleanup_lxc
