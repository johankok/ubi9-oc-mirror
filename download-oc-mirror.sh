#!/bin/sh

# Download oc client and oc-mirror
VERSION="4.17.7"
BASE="https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/$VERSION"

for file in oc-mirror.tar.gz openshift-client-linux-$VERSION.tar.gz sha256sum.txt
do
  curl -OL $BASE/$file
done

# Verify downloads
sha256sum --check --ignore-missing sha256sum.txt

# Extract oc-mirror
tar zxf oc-mirror.tar.gz && chmod +rx oc-mirror && chown root:root oc-mirror && mv oc-mirror /usr/local/bin/

# Extract oc client
tar zxf openshift-client-linux-$VERSION.tar.gz && mv oc /usr/local/bin/
