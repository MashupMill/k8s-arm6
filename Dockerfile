FROM golang:latest AS build
ARG K8S_REF=master

# install system stuff and clone repos
RUN apt-get update \
    && apt-get install -y git gcc-arm-linux-gnueabi gcc-arm-linux-gnueabihf make rsync \
    && git clone https://github.com/kubernetes/kubernetes.git /tmp/kubernetes

# build kube-proxy, kubelet, kubectl
RUN cd /tmp/kubernetes \
    && git checkout $K8S_REF \
    && perl -pi -e '$_ .= qq(  export GOARM=6\n) if /export GOARCH/' hack/lib/golang.sh \
    && make all WHAT=cmd/kube-proxy KUBE_VERBOSE=5 KUBE_BUILD_PLATFORMS=linux/arm \
    && make all WHAT=cmd/kubelet KUBE_VERBOSE=5 KUBE_BUILD_PLATFORMS=linux/arm \
    && make all WHAT=cmd/kubectl KUBE_VERBOSE=5 KUBE_BUILD_PLATFORMS=linux/arm \
    && make all WHAT=cmd/kubeadm KUBE_VERBOSE=5 KUBE_BUILD_PLATFORMS=linux/arm \
    && mkdir -p /build \
    && cp _output/local/bin/linux/arm/* /build

FROM alpine:latest

WORKDIR /build
COPY --from=build /build .
COPY install.sh /

VOLUME /dest

CMD ["/install.sh"]