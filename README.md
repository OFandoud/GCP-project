<div align="center">
    <img src="https://github.com/OFandoud/OFandoud/blob/main/assets/banner.png" alt="Logo">
  </a>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#Demo application">Demo application</a></li>
    <li><a href="#How to deploy this app on gcp">How to deploy this app on gcp</a></li>
    <li><a href="#Requirements">Requirements</a></li>
    <li><a href="# Starting the Application"> Starting the Application</a></li>
  </ol>
</details>

# GCP-project

This application will be used as a demo for DevOps Challenges.

You should fork/clone this repository to use as a basis for the challenge.

## Demo application

<img src="https://github.com/OFandoud/GCP-project/blob/main/task.png" alt="Introduction Banner.." style="text-align: center; margin-bottom: 30px;" />


### :rocket: How to deploy this app on gcp
- In [terraform code] you will find terraform infrastruture code that build all infra you need to start the app.
- In [kubernetes code] you will find kubernetes files to deploy the app on your kubernetes claster.
### Requirements

#### System

- GNU/Linux
- `python` >= 3.7
- `pip` >= 9.0
- `redis` >= 5.0

`>=` means any version of the package, above or equal to the specified version.

#### Application

- `redis-py`
- `tornado`

You can find them in the `requirements.txt` file and their required version number.
You can install them by using:

```bash
pip install -r requirements.txt
```

### :rocket: Starting the Application

The application uses several environment variables.
You can find them all and their default values in the `.env` file. They need to be avaiable at runtime. Here is an overview about the environment variables:

- `ENVIRONMENT` the environment in which the application is run. Likely `PROD` for production or `DEV` for development context.
- `HOST` the hostname on which the application is running. Locally it is `localhost`.
- `PORT` is the port on which the application is running.
- `REDIS_HOST` is the hostname on which redis is running. Locally it is `localhost`.
- `REDIS_PORT` is the port on which to communicate with redis. Normally it is `6379`.
- `REDIS_DB` which redis db should be used. Normally it is `0`.

Application can be found in `hello.py` file. You can start the application by using:

```bash
export $(cat .env | xargs) && python hello.py
```

Although you don't have to export the environment variables that way. :wink:

### Static files

- Static files are located in `static/` folder.
- Templates are located in `template/` folder.

### Executing Tests

Tests can be found in `tests/test.py` file.
You can run the tests by using:

```bash
python tests/test.py
```
