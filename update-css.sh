#!/bin/bash

# get the directory in which this script is located (the theme source dir)
SOURCE_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

TAILWINDCSS_COMMAND="tailwindcss -i src/css/main.css -o static/css/main.css --minify"
UGLIFYJS_COMMAND="uglifyjs"

# call the tailwindcss cli executable, if it can be found in the path
if command -v tailwindcss >/dev/null; then
    pushd "${SOURCE_DIR}" >/dev/null
    ${TAILWINDCSS_COMMAND}
    popd >/dev/null

# alternatively use docker to create and run a container and execute tailwinds cli from there
elif command -v docker >/dev/null; then

    # create the container for zola builds and tailwindcss updates
    docker build -t develop-zola-tailwindcss "${SOURCE_DIR}" || exit 2

    # update the CSS file using tailwindcss
    docker run --user $UID:$(id -g) --mount type=bind,source=${SOURCE_DIR},target=/source -w /source develop-zola-tailwindcss \
        sh -c "uglifyjs ./src/js/main.js --compress --mangle -o ./static/js/main.js &&
               uglifyjs ./src/js/page.js --compress --mangle -o ./static/js/page.js &&
               uglifyjs ./src/js/search.js --compress --mangle -o ./static/js/search.js &&
               uglifyjs ./src/js/lang.js --compress --mangle -o ./static/js/lang.js
               ${TAILWINDCSS_COMMAND}" || exit 3


# print an error message if neither tailwindcss nor the docker executable could be found
else
    echo "Need either 'tailwindcss' or 'docker' executable in the path." >&2
    exit 1
fi
