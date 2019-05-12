FROM golang:latest AS build
ARG K8S_REF=master
ARG KUBE_VERBOSE=1

# install system stuff and clone repos
RUN apt-get update \
    && apt-get install -y git gcc-arm-linux-gnueabi gcc-arm-linux-gnueabihf make rsync \
    && git clone https://github.com/kubernetes/kubernetes.git /tmp/kubernetes

WORKDIR /tmp/kubernetes

# build kube-proxy, kubelet, kubectl, kubeadm
RUN git checkout $K8S_REF \
    && perl -pi -e '$_ .= qq(  export GOARM=6\n) if /export GOARCH/' hack/lib/golang.sh \
    && make all WHAT=cmd/kube-proxy KUBE_VERBOSE=${KUBE_VERBOSE} KUBE_BUILD_PLATFORMS=linux/arm \
    && make all WHAT=cmd/kubelet KUBE_VERBOSE=${KUBE_VERBOSE} KUBE_BUILD_PLATFORMS=linux/arm \
    && make all WHAT=cmd/kubectl KUBE_VERBOSE=${KUBE_VERBOSE} KUBE_BUILD_PLATFORMS=linux/arm \
    && make all WHAT=cmd/kubeadm KUBE_VERBOSE=${KUBE_VERBOSE} KUBE_BUILD_PLATFORMS=linux/arm \
    && mkdir -p /build \
    && cp _output/local/bin/linux/arm/* /build

FROM arm32v6/alpine:latest

WORKDIR /build
COPY --from=build /build .
COPY install.sh /

VOLUME /dest

CMD ["/install.sh"]