#!/bin/bash

skip_folders=("libchart")

output_base_dir="../manifests"

mkdir -p "$output_base_dir"

containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

for folder in */; do
    # Remove the trailing slash from the folder name
    folder_name="${folder%/}"
    output_folder="$output_base_dir/$folder_name"
    output_file="manifest.yaml"


	if containsElement "$folder_name" "${skip_folders[@]}"; then
        echo "Skipping $folder_name"
        continue
    fi
    
	rm -rf "$output_folder"

    mkdir "$output_folder"
    
    helm template "$folder" > "$output_folder"/"$output_file"
    
    echo "Generated manifest for $folder_name at $output_file"
done
