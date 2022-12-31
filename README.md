# oabextract (dockerized)
## Introduction
This repository contains a single Dockerfile which helps to build the `oabextract` binary from the `libsmpack` library

For more detailed information, see [libmspack](https://github.com/rmaksimov/libmspack)

## Building
Building a Docker image containing the `oabextract` binary (statically linked, by default)
```
docker build -t oabextract:latest https://github.com/rmaksimov/oabextract-docker.git
```

Copy the statically linked `oabextract` binary from the Docker container to the `bin` directory in the current directory
```
mkdir bin
docker run --rm -v "${PWD}/bin:/opt/bin" --entrypoint sh oabextract:latest -c "chown $(id -u):$(id -g) oabextract && cp -p oabextract bin"
```

Running a Docker container based on the image
```
docker run --rm -v "${PWD}/data:/opt/data" -w /opt/data oabextract:latest {INPUT}.lzx {OUTPUT}
```

(If there is a need to compile dynamically linked binary, uncomment the corresponding section and comment out the section related to the statically linked binary)
