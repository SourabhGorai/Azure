
[![Build Status Widget]][Build Status] [![DockerHub Widget]][DockerHub]
# Description

Kompose UI is a web interface for [Kompose](http://kompose.io). It helps people easily switch from `docker-compose` to `Kubernetes` by converting the YAML files.

Here is a [live demo for the project](https://composetokube.com)

# Using kompose UI

You can either use the docker image from docker hub or run the project locally

## Use the Docker Image

* Pull latest image

```sh
docker pull jadcham/komposeui:latest
```

* Run the container
```sh
docker run -it --name komposeui -p 8000:8000 jadcham/komposeui
```

That's it ! Happy converting.

## Run the Project locally

### Requirements

* [uv Installation Guide](https://docs.astral.sh/uv/getting-started/installation/)
* [Kompose Installation Guide](https://github.com/kubernetes/kompose#installation)

### Steps

* Setup venv and install requirements
```sh
uv sync --frozen
```


* Prepare the database
```sh
uv run python manage.py makemigrations
uv run python manage.py migrate
```

* Run server
```sh
uv run python manage.py runserver 0.0.0.0:8000
```

# Contributions and Support

__Issues:__ If you find an issue or want to suggest a feature [file an issue here](https://github.com/jadcham/komposeui/issues).

__Contributions:__ If you want to contribute to the project [make a pull request](https://github.com/jadcham/komposeui/pulls).


[Build Status]: https://github.com/JadCham/komposeui/actions/workflows/test.yml/badge.svg
[Build Status Widget]: https://github.com/JadCham/komposeui/actions/workflows/test.yml/badge.svg
[DockerHub]: https://hub.docker.com/r/jadcham/komposeui/
[DockerHub Widget]: https://img.shields.io/docker/pulls/jadcham/komposeui.svg

