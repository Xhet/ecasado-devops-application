# devops-test-app
# NodeJS endpoints
A basic NodeJs backend application created for the devops test.

### General description

The application consist in two general endpoints, these are `GET /users` and `GET /files`. The first endpoint retrieves all the registers of users stored in a postgreSQL database, and the second one list all the files that are stored in a S3 bucket. The rest of the endpoint are for ensuring application health and rediness
### Endpoint PORTS

| PORT | Endpoint |
| ---- | --------------- |
| 3081 | files |
| 3082 | users |

### Endpoint list

| HTTP method | Endpoint |
| ---- | --------------- |
| GET | /files> |
| GET | /files/version |
| GET | /files/health |
| GET | /files/ready |
| GET | /users |
| GET | /users/version |
| GET | /users/health |
| GET | /users/ready |
### Endpoints description

* `GET 3082:/users`

This endpoint returns a fixed number of users (2) registered in the postgres database with the following structure:

```json
{
"meta": {
	"count" : 2
},

"data": [
	{
		"id": 1,
		"username": "Fake User 1",
		"email": "foo@email.com",
		"created_at": "2018-10-17T15:46:08.0003Z",
		"updated_at": "2018-10-17T15:46:08.0003Z",
		},
	{
		"id": 2,
		"username": "Fake User 2",
		"email": "bar@email.com",
		"created_at": "2018-10-17T15:46:08.0003Z",
		"updated_at": "2018-10-17T15:46:08.0003Z",
		}
	]
}
```

* `GET 3081:/files`

This endpoint returns the total number of items and the name of the files stored in a s3 bucket with the following structure:

```json
{
"meta": {
        "count" : 1
},

"data": {
                "number_of_items": 2,
                "filenames": ["foo.txt", "bar.txt"]
        }
}
```

* `GET <ENDPOINT_PORT>:/version`

This endpoint returns the actual version of the software running and it's uptime in seconds

```json
{
"meta": {
	"count": 0
},

"data": {
	"uptime": 82467,
	"version": "0.1.1"
	}
}
```

* `GET <ENDPOINT_PORT>:/health`

This endpoint returns the uptime of the application in seconds

```json
{
"meta": {
	"count": 0
},

"data": {
	"uptime": 82467,
	}
}
```

* `GET <ENDPOINT_PORT>:/ready`

This endpoint returns the current service uptime and dependencies readiness

```json
{
"meta": {
	"count": 0
},

"data": {
	"uptime": 82669,
	"service": "ok",
	"postgres": "ok"
	}
}
```

### Requirements

You will need the following tools to operate over `devops-test-app`:

- `nodejs` = 8.11
- `postgres` >= 9.4

Local development/deployment
- 
#### Requirements

You will need the following tools to `build/deploy` over `devops-test-app`:

- `docker` >= 18.06.1
- `docker-compose` >= 1.23.2

Install docker-compose
``` bash
$ sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

## Project can be run in one of two ways:
### Running both endpoints
#### execute in linux terminal:

 - Edit `.env` file with credentials provided  database/AWS credentials
```bash
$ vim .env
```
 - Run the script
```bash
$ run_all.sh
```
### Run specific endpoint
#### execute the following commands in your terminal:
 - Checkout specific endpoint directory 
```bash
#CREATE AN EMPTY REPO
$ git init
#ENABLE SPACE CHECKOUT FOR FOLCER CLONE
$ git config core.sparsecheckout true
#ADD PROJECT FOLDER TO THE CHEECKOUT FILE
$ echo "devops-test-app-<users/files>>/*">.git/info/sparse-checkout
#ADDING THE REPO URL FOR THE NEWLY CREATED REPO
$ git remote add -f origin https://github.com/Xhet/ecasado-devops-application.git
#PULLING SPECIFIC FOLDER
$ git pull origin master
```
- Change to `devops-test-app-<users/files>` root directory

```bash
$ cd devops-test-app-<users/files>
```
- Edit `.env` file with credentials provided database/AWS credentials

```bash
$ vim .env
```

- Run the start script

```bash
$ <run_files/run_users>.sh
```

### URL testing

To run applications tests, please execute the following commands in your terminal:

- Test files endpoint

```bash
$ curl -vv http://localhost:3081/files
```
- Test users endpoint

```bash
$ curl -vv http://localhost:3082/users
```

### Available configuration variables

| Name | Description | Default Value | Required |
| ---- | ----------- | ------------- | -------- |
| **Application** | | | |
| DEVOPS_TEST_BACKEND_RELEASE_VERSION | The current release of the application | - | no |
| DEVOPS_TEST_BACKEND_NAME | The name of the application | devops-test-backend | no |
| DEVOPS_TEST_ENV | The environment the application is running in | development | no |
| DEVOPS_TEST_PORT | The port that the application accepts requests on | <3081/3082> | no |
| **Database** | | | |
| DEVOPS_TEST_DATABASE_NAME | The name of the application's database | devops-test | no |
| DEVOPS_TEST_DATABASE_USERNAME | The username for the application's database | provided by .env file | yes |
| DEVOPS_TEST_DATABASE_PASSWORD | The password for the application's database | provided by .env file | yes |
| DEVOPS_TEST_DATABASE_HOST | The hostname for the application's database | mydb.cxwjc5rwxold.us-west-2.rds.amazonaws.com | no |
| DEVOPS_TEST_DATABASE_PORT | The port for the application's database | 5432 | no |
| DEVOPS_TEST_DATABASE_POOL_SIZE_MAX | The maximum size of the connection pool to use with the application's database | 3 | no |
| DEVOPS_TEST_DATABASE_POOL_SIZE_MIN | The minimum size of the connection pool to use with the application's database | 0 | no |
| DEVOPS_TEST_DATABASE_TIMEOUT | The amount of time (in milliseconds) to wait for the application's database before timing out | 1000 | no |
| DEVOPS_TEST_DATABASE_POOL_SIZE_MIN | The amount of times to retry connections to the application's database before erroring out | 3 | no |
| **External cloud services** | | | |
| DEVOPS_TEST_BACKEND_AWS_USER_BUCKET_NAME | The name of the bucket used for storing files | devops-test-dev-bucket | no |
| DEVOPS_TEST_BACKEND_AWS_ACCESS_KEY | The aws api access key used for devops-test | provided by .env file | yes |
| DEVOPS_TEST_BACKEND_AWS_SECRET_KEY | The aws api secret key used for devops-test | provided by .env file | yes |
| DEVOPS_TEST_BACKEND_AWS_PREFIX | The s3 prefix where files are stored | --------- | no |
| DEVOPS_TEST_BACKEND_AWS_REGION | The aws region where | us-east-1 | yes |

