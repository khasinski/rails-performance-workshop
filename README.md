# Rails performance workshop

This repository contains a simple Rails application that simulates a slow application.

It will seed the database and simulate the traffic.

The goal is to use an APM (in this case AppSignal) to identify the bottlenecks and improve the performance.

## Pre-Requisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [AppSignal account](https://appsignal.com)
- [AppSignal Push API key](https://docs.appsignal.com/appsignal/terminology.html#push-api-key)
- Free ports: 3001, 5442 and 6389

## Setup

1. Sign up on [AppSignal](https://appsignal.com) and get a Push API key

1. Start the app with the following command:
    ```bash
    APPSIGNAL_PUSH_API_KEY=YOUR_KEY docker compose up
    ```

1. Navigate to [http://localhost:3001](http://localhost:3001) and check if the app is running

1. Navigate to AppSignal, pick the environment `production` and wait for the traffic data.
