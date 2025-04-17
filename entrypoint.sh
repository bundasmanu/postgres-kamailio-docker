#!/bin/bash

set -e

trap "Ok received Exit" HUP INT QUIT TERM

# Function to remove unneeded SQL scripts based on both environment variables
remove_unneeded_sql_scripts() {
    if [ -n "$KAMAILIO_SQL_SCRIPTS_TO_RUN" ]; then
        IFS=',' read -ra kamailio_scripts <<< "$KAMAILIO_SQL_SCRIPTS_TO_RUN"
    fi

    if [ -n "$CUSTOM_SQL_SCRIPTS_TO_RUN" ]; then
        IFS=',' read -ra custom_scripts <<< "$CUSTOM_SQL_SCRIPTS_TO_RUN"
    fi

    for file in /scripts/*; do
        filename=$(basename "$file")

        # Check if the file is in either KAMAILIO_SQL_SCRIPTS_TO_RUN or CUSTOM_SQL_SCRIPTS_TO_RUN
        if [[ ! " ${kamailio_scripts[*]} " =~ " ${filename} " ]] && [[ ! " ${custom_scripts[*]} " =~ " ${filename} " ]]; then
            rm -f "$file"
        fi
    done
}

# Function to sort and separate Kamailio and custom SQL files for execution
sort_sql_files() {

    KAMAILIO_START_INDEX=10000
    last_kamailio_index=$((KAMAILIO_START_INDEX - 1))

    # Process Kamailio scripts
    if [ -n "$KAMAILIO_SQL_SCRIPTS_TO_RUN" ]; then
        IFS=',' read -ra kamailio_scripts <<< "$KAMAILIO_SQL_SCRIPTS_TO_RUN"

        # Create a temporary folder for sorted Kamailio scripts
        mkdir -p /scripts_sorted_kamailio

        # Sort and move Kamailio scripts in the correct order
        for i in "${!kamailio_scripts[@]}"; do
            script_name="${kamailio_scripts[i]}"
            if [ -f "/scripts/$script_name" ]; then
                echo "Moving $script_name to /scripts_sorted_kamailio/"
                index=$((KAMAILIO_START_INDEX + i))
                cp "/scripts/$script_name" "/scripts_sorted_kamailio/${index}_$script_name"
                last_kamailio_index=$index  # Track the last used index
            fi
        done
    fi

    # Process custom scripts
    if [ -n "$CUSTOM_SQL_SCRIPTS_TO_RUN" ]; then
        IFS=',' read -ra custom_scripts <<< "$CUSTOM_SQL_SCRIPTS_TO_RUN"

        # Create a temporary folder for sorted custom scripts
        mkdir -p /scripts_sorted_custom

        # Sort and move custom scripts, starting from the last Kamailio script index
        for i in "${!custom_scripts[@]}"; do
            script_name="${custom_scripts[i]}"
            if [ -f "/scripts/$script_name" ]; then
                echo "Moving $script_name to /scripts_sorted_custom/"
                index=$((last_kamailio_index + i + 1))  # Continue numbering
                cp "/scripts/$script_name" "/scripts_sorted_custom/${index}_$script_name"
            fi
        done
    fi

    # Clean up the original folder and move the sorted files back in the correct order
    rm -f /scripts/*

    # Move Kamailio scripts first
    mv /scripts_sorted_kamailio/* /scripts/
    rmdir /scripts_sorted_kamailio

    # Then move custom scripts
    mv /scripts_sorted_custom/* /scripts/
    rmdir /scripts_sorted_custom
}

remove_unneeded_sql_scripts
sort_sql_files

# Copy Kamailio SQL templates into mounted volume
cp -rp /usr/local/src/kamailio/utils/kamctl/postgres/* /all_postgres_db_scripts/
