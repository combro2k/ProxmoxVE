#!/usr/bin/env bash
source <(curl -fsSL https://raw.githubusercontent.com/combro2k/ProxmoxVE/main/misc/build.func)
# Copyright (c) 2021-2026 community-scripts ORG
# Author: combro2k
# License: MIT | https://github.com/combro2k/ProxmoxVE/raw/main/LICENSE
# Source: https://github.com/spotweb/spotweb

APP="alpine-spotweb"
var_tags="${var_tags:-alpine;spotweb}"                 # Max 2 tags, semicolon-separated
var_cpu="${var_cpu:-2}"                         # CPU cores: 1-4 typical
var_ram="${var_ram:-2048}"                      # RAM in MB: 512, 1024, 2048, etc.
var_disk="${var_disk:-20}"                      # Disk in GB: 6, 8, 10, 20 typical
var_os="${var_os:-alpine}"                      # OS: debian, ubuntu, alpine
var_version="${var_version:-3.23}"              # OS Version: 13 (Debian), 24.04 (Ubuntu), 3.23 (Alpine)
var_unprivileged="${var_unprivileged:-1}"       # 1=unprivileged (secure), 0=privileged (for Docker/Podman)

header_info "$APP" # Display app name and setup header
variables          # Initialize build.func variables
color              # Load color variables for output
catch_errors       # Enable error handling with automatic exit on failure

function update_script() {
  header_info
  check_container_storage
  check_container_resources

  # Step 1: Verify installation exists
  if [[ ! -d /opt/spotweb ]]; then
    msg_error "No ${APP} Installation Found!"
    exit
  fi

  # Step 2: Check if update is available
  if check_for_gh_release "spotweb" "spotweb/spotweb"; then
    echo "TBD." 
  fi
  exit
}

start
build_container
description

msg_ok "Completed successfully!\n"
echo -e "${CREATING}${GN}${APP} setup has been successfully initialized!${CL}"
echo -e "${INFO}${YW} Access it using the following URL:${CL}"
echo -e "${TAB}${GATEWAY}${BGN}http://${IP}${CL}"
