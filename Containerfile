FROM registry.access.redhat.com/ubi9-minimal:9.5-1739420147 AS build

RUN microdnf install -y gzip tar && microdnf clean all

ADD download-oc-mirror.sh .
RUN ./download-oc-mirror.sh

FROM registry.access.redhat.com/ubi9-minimal:9.5-1739420147

LABEL org.opencontainers.image.source="https://github.com/johankok/ubi9-oc-mirror" \
      org.opencontainers.image.description="Let's run oc mirror in a container"

RUN microdnf install -y pigz && microdnf clean all

COPY --from=build /usr/local/bin/* /usr/local/bin/

