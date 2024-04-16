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
1. Navigate to `http://localhost:3001` and seed the database using the popup.
