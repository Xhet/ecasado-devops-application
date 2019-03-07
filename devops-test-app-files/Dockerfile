FROM node:8.15.1-alpine

ARG files_USERNAME
ARG files_PASSWORD

ENV DEVOPS_TEST_BACKEND_AWS_USER_BUCKET_NAME='ecasado-devops-application' \
    DEVOPS_TEST_BACKEND_AWS_REGION='us-west-2'\
    DEVOPS_TEST_ENV='production' \
    DEVOPS_TEST_BACKEND_AWS_ACCESS_KEY=${files_USERNAME} \
	DEVOPS_TEST_BACKEND_AWS_SECRET_KEY=${files_PASSWORD} 

COPY . .
RUN npm install
RUN npm run migrate-up
ENTRYPOINT 3081
CMD ["npm", "run", "start"]
