#!/bin/bash

# Creating a comma-separated and row-wise list of installed apps
cat $INFO_DIR/installed_apps_list.txt | paste -sd ',' > $INFO_DIR/installed_apps_comma_separated.txt
cat $INFO_DIR/installed_apps_list.txt > $INFO_DIR/installed_apps_rows.txt
