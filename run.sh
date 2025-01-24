# docker image
if [ "$#" -eq 1 ] && [ "$1" == "d" ]; then

    # build image
    DOCKER_BUILDKIT=1 docker build . --tag "collectivae-im"

    # copy database to Downloads
    cp ./db.sqlite ~/Downloads/
    # database path
    export DB_PATH="/usr/home/data/db.sqlite"

    # create and run the container, then purge resources upon exit
    docker create --name collectivae \
        --mount type=bind,source="/home/touny/Downloads",target="/usr/home/data" \
        --env DB_PATH \
        --publish 8080:8080 \
        collectivae-im:latest

    docker start collectivae
    docker logs collectivae

    read -p 'press anything to stop the container and purge resources' tmp

    docker stop collectivae
    docker rm collectivae
    docker rmi collectivae-im
    rm ~/Downloads/db.sqlite

# local opam
else
    # set db path env variable
    export DB_PATH="./db.sqlite"

    # build and execute; use ./ as workspace root
    dune exec ./main.exe

    # watch mood
    # source: https://github.com/aantron/dream/tree/master/example/w-watch#folders-and-files
    # dune exec ./main.exe --watch
fi
