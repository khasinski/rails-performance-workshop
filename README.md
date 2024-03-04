# Rails performance workshop

## Pre-Requisites

- [Docker](https://docs.docker.com/desktop/mac/install/)
    - This is required to build and run the recommended development environment (detailed below)
- AppSignal Api Key
    - Create account on https://appsignal.com
    - APPSIGNAL_PUSH_API_KEY should be set in your env for configuration scripts to pick them up

**Important note for users of MacBooks:**

When you see error
```
objc[18501]: +[__NSCFConstantString initialize] may have been in progress in another thread when fork() was called.
objc[18501]: +[__NSCFConstantString initialize] may have been in progress in another thread when fork() was called. We cannot safely call it or ignore it in the fork() child process. Crashing instead. Set a breakpoint on objc_initializeAfterForkError to debug.
```

Please set OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES in your env

```
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
```

## Setup

1. Create account on https://appsignal.com and set as  an environment variable "APPSIGNAL_PUSH_API_KEY"

1. Create and start the containers
      ```shell
      docker compose up
      ```
## Running the Local Environment

If you want to run the app locally, you need to install ruby 3.1.4.

Run `bundle install` to install the dependencies.

## Run

```shell
docker-compose up
```


