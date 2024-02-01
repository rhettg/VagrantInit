#!/bin/bash
set -e
set -o pipefail

# Get the directory where the script itself is located
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

# Paths to the directories containing the scripts and default env vars
provision_dir="$script_dir/provision"
default_dir="$script_dir/default"

# Check if the provision directory exists
if [ ! -d "$provision_dir" ]; then
    echo "provision directory $provision_dir does not exist."
    exit 1
fi

# Iterate over sorted executable scripts in the provision directory
for script_path in $(find "$provision_dir" -maxdepth 1 -type f -executable | sort); do
    script_name=$(basename "$script_path")
    
    # Extract script prefix (e.g., "deploy" from "00-deploy.sh")
    script_prefix=$(echo "$script_name" | sed -E 's/[0-9]+-([^.]+)\.sh/\1/')

    # Path to the potential default env file
    default_env_file="$default_dir/$script_prefix"

    # Execute each script in a subshell
    (
        # Source the default env file if it exists
        if [ -f "$default_env_file" ]; then
            source "$default_env_file"
        fi

        # Execute the script and tee the output to a .log file
        echo "running $script_name"
        source "${provision_dir}/${script_name}" | tee "${provision_dir}/${script_name}.log"
    )

    # Check the exit status of the script
    if [ $? -eq 0 ]; then
        # If the script succeeded, remove the executable bit
        chmod -x "$provision_dir/$script_name"
    else
        # If the script failed, print a message and exit the subshell with a non-zero status
        echo "script $script_name failed."
        echo "stopping execution due to script failure."
        exit 1
    fi
done

