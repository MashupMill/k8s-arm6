# k8s-arm6

Kubernetes binaries built for arm v6.

## Usage

Run the following command and it will install the kubernetes binaries into `/usr/bin`

```bash
docker run --rm -v /usr/bin:/dest mashupmill/k8s-arm6
```

> Note: Still a work-in-progress. So far have `kubeadm`, `kube-proxy`, `kubectl` and `kubelet` building. Haven't actually verified running kubernetes on an arm6 device (like a raspberry pi zero w). Just verified that the commands help comes back cleanly. So far everything except for `kubelet` comes back cleanly when running `<cmd> --help`