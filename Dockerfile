FROM alpine:latest

ARG KAM_BRANCH

WORKDIR /usr/local/src

RUN apk update && apk add git bash

## Fetch kamailio SQL scripts
RUN git clone https://github.com/kamailio/kamailio.git --branch=${KAM_BRANCH} kamailio

# Copy the Kamailio SQL scripts to a dedicated folder
RUN cp -rp ./kamailio/utils/kamctl/postgres/ /scripts

## Copy Custom SQL files (inserts namely) to a dedicated folder, should be executed only after all the Kamailio SQL files have been executed
COPY ./custom_scripts/ /scripts

# Filter, clean and sort the SQL scripts based on KAMAILIO_SQL_SCRIPTS_TO_RUN and CUSTOM_SQL_SCRIPTS_TO_RUN vars
COPY entrypoint.sh .

ENTRYPOINT [ "./entrypoint.sh" ]
