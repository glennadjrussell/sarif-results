// entrypoint.sh

#!/bin/bash

while IFS= read -r line
do
    echo "$line" | jq -c '.runs[] | .name'
done

