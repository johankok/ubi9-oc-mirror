FROM registry.access.redhat.com/ubi9-minimal:9.4-1134 AS build

RUN microdnf install -y gzip tar && microdnf clean all

ADD download-oc-mirror.sh .
RUN ./download-oc-mirror.sh

FROM registry.access.redhat.com/ubi9-minimal:9.4-1134

LABEL org.opencontainers.image.source = "https://github.com/johankok/ubi9-oc-mirror"
LABEL org.opencontainers.image.description = "Lets run oc mirror in a container"

COPY --from=build /usr/local/bin/* /usr/local/bin/

RUN microdnf install -y pigz && microdnf clean all
