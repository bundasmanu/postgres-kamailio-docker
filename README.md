# postgres-kamailio-docker

- [postgres-kamailio-docker](#postgres-kamailio-docker)
  - [Purpose](#purpose)
  - [What offers?](#what-offers)
  - [.env file](#env-file)
  - [Network creation](#network-creation)
  - [Build the image](#build-the-image)
  - [Run container](#run-container)
  - [How we can access Database?](#how-we-can-access-database)
    - [Via Container](#via-container)
    - [Via host](#via-host)

## Purpose

A Database is a vital component, when we need to interact with some modules in `Kamailio`, or to help in some specific routing and customizaion stuff.
So, in this project we provide a more fiendly way to configure and mantain a `Postgres` Database for `Kamailio`.

## What offers?

- A container that directly gets all the `.sql` files stored and provided by Kamailio repo (we can choose the version);
- A logic that installs only the relevant `Kamailio` tables we need;
- All `Kamailio` tables are visible on host side, via a volume;
- A logic to install custom `sql` scripts;
- We can control the order, of scripts installation, without the need to put all code in single files;
- A `Postgres` container, that runs on bridge mode, on the IP/subnet that you want (you can change to use host mode, if you want);
- Provided a customizable `pg_hba.conf` file to control the access to the database;

## .env file

The `.env` file is quite simple and offers:

- `KAM_BRANCH`: Points to the `branch` or `tag` to get the `Postgres` scripts from `Kamailio` repo;
- `KAMAILIO_SQL_SCRIPTS_TO_RUN`: `Kamailio` `SQL` scripts to run. The files must be separated by a comma, and the ordering is preserved, so the sql files will be executed in the order they are listed;
- `CUSTOM_SQL_SCRIPTS_TO_RUN`: Custom `SQL` scripts to run. The same logic as before, the files must be separated by a comma, and the ordering is preserved;
- `POSTGRES_USER`: Database user;
- `POSTGRES_PASSWORD`: Database password;

## Network creation

If the network `common-network` is not already created, please follow one of these two available options:

Option 1. Create a network, and select the subnet you want (if you change the default value, you need to change the IP on `docker-compose.yaml` file):

```bash
docker network create --subnet=172.25.0.0/24 common-network
```

Option 2. Same logic as before, but overriding `mtu` to avoiding possible issues on SIP traffic:

```bash
docker network create --opt com.docker.network.driver.mtu=9000 --subnet=172.25.0.0/24 common-network
```

## Build the image

```bash
docker compose build
```

## Run container

```bash
docker compose up -d
```

## How we can access Database?

### Via Container

```bash
docker exec -it postgres psql -U postgres -d kamailio
```

### Via host

```bash
psql -h 127.0.0.1 -p 5433 -U postgres -d kamailio
```
