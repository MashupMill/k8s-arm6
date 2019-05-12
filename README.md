# k8s-arm6

Kubernetes binaries built for arm v6.

## Usage

Run the following command and it will install the kubernetes binaries into `/usr/bin`

```bash
docker run --rm -v /usr/bin:/dest mashupmill/k8s-arm6
```

> Note: Still a work-in-progress. So far have `kube-proxy`, `kubectl` and `kubelet` building. Still wanna see if we can get `kubeadm` built as well