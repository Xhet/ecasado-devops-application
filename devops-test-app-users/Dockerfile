FROM node:8.15.1-alpine

ARGV users_USERNAME
ARGV users_PASSWORD

ENV DEVOPS_TEST_DATABASE_NAME='devops_test' \
    DEVOPS_TEST_DATABASE_HOST='mydb.cxwjc5rwxold.us-west-2.rds.amazonaws.com' \
    DEVOPS_TEST_ENV='production' \
    DEVOPS_TEST_DATABASE_USERNAME=${users_USERNAME} \
    DEVOPS_TEST_DATABASE_PASSWORD=${users_PASSWORD} 
COPY . .
RUN npm install
RUN npm run migrate-up
ENTRYPOINT 3082
CMD ["npm", "run", "start"]
