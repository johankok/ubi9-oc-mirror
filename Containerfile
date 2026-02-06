FROM registry.access.redhat.com/ubi9-minimal:9.7-1770267347@sha256:759f5f42d9d6ce2a705e290b7fc549e2d2cd39312c4fa345f93c02e4abb8da95 AS build

RUN microdnf install -y gzip tar && microdnf clean all

ADD download-oc-mirror.sh .
RUN ./download-oc-mirror.sh

FROM registry.access.redhat.com/ubi9-minimal:9.7-1770267347@sha256:759f5f42d9d6ce2a705e290b7fc549e2d2cd39312c4fa345f93c02e4abb8da95

LABEL org.opencontainers.image.source="https://github.com/johankok/ubi9-oc-mirror" \
      org.opencontainers.image.description="Let's run oc mirror in a container"

RUN microdnf install -y pigz && microdnf clean all

COPY --from=build /usr/local/bin/* /usr/local/bin/

