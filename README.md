# ViLangSpeak - Applicaiton services

## Description

Services for ViLangSpeak application.

## For development

### Prerequisites

| Software/Tool | Version |
| ------------- | ------- |
| yarn          | 1.22.19 |
| node          | 18.7.0  |

### Installation

```bash
yarn install
```

And create a folder name `public/` and move file `index.html` to this folder.

### Running the app

```bash
# development
yarn start

# watch mode
yarn start:dev
```

## For production

### Prerequisites

| Software/Tool  | Version  | Installation method                     |
| -------------- | -------- | --------------------------------------- |
| docker engine  | 20.10.21 | https://docs.docker.com/engine/install/ |
| docker compose | 2.13.0   |                                         |

### Installation

Create folder `~/vls-appservice-public` and move file `index.html` to this folder.

### How to run

Only need `docker-compose.yml` file and `docker login` to account. Then execute commands:

```bash
docker compose pull
docker compose up -d
```