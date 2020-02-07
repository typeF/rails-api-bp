_Setup based on tutorial from https://semaphoreci.com/community/tutorials/dockerizing-a-ruby-on-rails-application_

## Build rails-toolbox from Dockerfile.rails

```
docker build -t rails-toolbox \
       --build-arg USER_ID=$(id -u)  \
       --build-arg GROUP_ID=$(id -g) \
       -f Dockerfile.rails .
```

_For OSX substitute GROUP_ID of 1000_

```
docker build -t rails-toolbox \
       --build-arg USER_ID=$(id -u)  \
       --build-arg GROUP_ID=$(id -g) \
       -f Dockerfile.rails .
```

Remove .git directory

```
rm -rf funds-app/.git
```

## Create volumes

```
docker volume create --name funds-postgres
docker volume create --name funds-redis
```

## Initial compose

```
docker-compose up
```

Exit after error is thrown for schema.rb with CTRL+C

## Initialize Database

_OSX/Windows users will want to remove --­­user "$(id -­u):$(id -­g)"_

```
$ docker­-compose run --­­user "$(id ­-u):$(id -­g)" funds rake db:reset
$ docker­-compose run --­­user "$(id ­-u):$(id -­g)" funds rake db:migrate
```

## Running the application

```
docker-compose up
```

Access on localhost:8020 to verify everything is running correctly.
