# Rails performance workshop

## Pre-Requisites

- [Docker](https://docs.docker.com/desktop/mac/install/)
- Docker Compose

## Setup

1. Create account on https://appsignal.com and get an API key

1. Create and start the containers

```shell
APPSIGNAL_PUSH_API_KEY=YOUR_KEY docker compose up
```

1. Navigate to [http://localhost:3001](http://localhost:3001) and check if the app is running

1. Navigate to AppSignal, pick the environment `production` and wait for the traffic data.
