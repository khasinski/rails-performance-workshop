# Rails performance workshop

## Pre-Requisites

- [Docker](https://docs.docker.com/desktop/mac/install/)
    - This is required to build and run the recommended development environment (detailed below)
- AppSignal Api Key
    - Create account on https://appsignal.com
    - APPSIGNAL_PUSH_API_KEY should be set in your env for configuration scripts to pick them up

## Setup

1. Create account on https://appsignal.com and set as  an environment variable "APPSIGNAL_PUSH_API_KEY"

1. Create and start the containers
      ```shell
      docker compose up
      ```

## Run with docker

```shell
docker-compose up
```

1. Copy `.env.example` to `.env` and update ports based on your setup.
      ```ruby
      cp .env.example .env
      ```

## Run with the Local Environment

```shell
rails s -p 3001
```
