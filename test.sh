# For each directory in the $PATH,display the number of executable files in that directory
#!/bin/bash

echo "checking directory"

if [ -z "$1" ] 
then
    echo "usage: $0 <directory_path>"
    exit 1
fi
for dir in "$1"/*/;
do
    if [ -d "$dir" ]
    then
    count=$(find "$dir" -maxdepth 1 -type f -executable | wc -l)
    echo "Directory : $dir - Executable files: $count"
    fi
done