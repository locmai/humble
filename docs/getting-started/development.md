--8<--
./docs/templates/development.md
--8<--

## Prerequisites

### Install the required tools

- [Docker](https://www.docker.com/)
- [make](https://www.gnu.org/software/make/manual/make.html)

### Recommended hardware specification

- Operating System: Linux or macOS
- CPUs: 4 cores
- Memory: 16 GiB

## Build

Simply clone the repository

```sh
git clone https://github.com/locmai/humble
```

Then run the follwing `make` commands:

```shell
make tools
make dev
```
## Explore

> TBD

## Clean up

Delete the cluster:

```
k3d cluster delete humble-dev
```
