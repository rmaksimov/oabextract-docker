FROM debian:stable-slim as setup
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update \
    && apt-get install -y git gcc autoconf make automake libtool

# Statically linked binary
FROM setup as build
WORKDIR /opt
RUN git clone --depth 1 https://github.com/kyz/libmspack
RUN cd libmspack/libmspack \
    && ./cleanup.sh \
    && ./autogen.sh \
    && ./configure LDFLAGS=-static \
    && make

FROM debian:stable-slim
WORKDIR /opt
COPY --from=build /opt/libmspack/libmspack/examples/oabextract .
ENTRYPOINT ["/opt/oabextract"]

# # Dynamically linked binary
# FROM setup as build
# WORKDIR /opt
# RUN git clone --depth 1 https://github.com/kyz/libmspack
# RUN cd libmspack/libmspack \
#     && ./rebuild.sh \
#     && make
# ENTRYPOINT ["/opt/libmspack/libmspack/examples/oabextract"]
