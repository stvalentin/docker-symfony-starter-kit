Generate a simple cli/website Symfony skeleton application with minimal steps

Application stack:
- php 7.3
- nginx
- postgresql 12

## Requirements
- Docker version 18.06 or later
- Docker compose version 1.22 or later
- An editor or IDE

## Installation
**Clone this repository**
```
$ git clone --bare git@github.com:stvalentin/docker-symfony-starter-kit.git
```

**Generate the project that fits your needs** 

Run this if you like to choose your own packages
```
$ make generate
```

Run this if you're building a console application / API 
```
$ make generate-skeleton
```


Run this if you're building a traditional web application
```
$ make generate-website
```

### Use cases
Add new composer package
```
make package
```

```
# via docker-compose
docker-compose run --rm php-fpm composer require packagename
```

### Useful commands

Start containers
```
make up
```

Stop existing containers
```
make down
```


### Cleaning out your machine:

Before deleting all the containers, force stop them:
```bash 
docker ps -q -a | xargs docker stop
```

Once stopped delete the existing containers using: 
```bash
docker ps -q -a | xargs docker rm
```

Now delete all the dangling images using: 
```bash
docker rmi $(docker images | grep “^<none>” | awk ‘{print $3}’)
```