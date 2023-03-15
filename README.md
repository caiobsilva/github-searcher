# GitHub Searcher
A Rails application for finding repositories on GitHub. Simply type in a repo name to have a list of results ordered by number of stars.

## Setting up
Running the application requires only having Docker and Docker Compose installed on your computer. The [official documentation](https://docs.docker.com/engine/install/) can be checked for platform-specific instructions.

## Running the application
With Docker installed, running the application is as simple as running a `docker-compose up` command.

Additionally, in order to access the container's shell, do the following:
1. Build the container in detached mode (`docker-compose up -d`)
2. Execute the container with bash as an entrypoint (`docker exec -it web bash`)
