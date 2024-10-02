#!/bin/bash

source ./src/config/config.sh
source ./src/util/create-dir.sh
source ./src/util/check-config.sh
source ./src/util/request.sh
source ./src/util/display-configurations.sh
source ./src/util/display-ignore-list.sh
source ./src/util/clone-private.sh
source ./src/util/clone-public.sh
source ./src/util/clone.sh

clear

create_backup_dir
create_date_directory
check_config
request
display_configurations
clone
