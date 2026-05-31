FROM registry.access.redhat.com/ubi9-minimal:9.8-1779809423@sha256:6ea809bdd8164f8b2b607e38f01b14c374a15bdfbc74fcd0155161512dd4e00e AS build

RUN microdnf install -y gzip tar && microdnf clean all

ADD bin/download-oc-mirror.sh .
RUN ./download-oc-mirror.sh

FROM registry.access.redhat.com/ubi9-minimal:9.8-1779809423@sha256:6ea809bdd8164f8b2b607e38f01b14c374a15bdfbc74fcd0155161512dd4e00e

LABEL org.opencontainers.image.source="https://github.com/johankok/ubi9-oc-mirror" \
      org.opencontainers.image.description="Let's run oc mirror in a container"

RUN microdnf install -y pigz && microdnf clean all

COPY --from=build /usr/local/bin/* /usr/local/bin/
