FROM registry.access.redhat.com/ubi9/ubi:9.4-1123.1719560047 AS build

ADD download-oc-mirror.sh .
RUN ./download-oc-mirror.sh

FROM registry.access.redhat.com/ubi9/ubi:9.4-1123.1719560047

LABEL org.opencontainers.image.source = "https://github.com/johankok/ubi9-oc-mirror"

COPY --from=build /usr/local/bin/* /usr/local/bin/

RUN dnf install -y pigz && dnf clean all
