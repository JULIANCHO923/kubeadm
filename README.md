# 3 Node kubeadm cluster on VirtualBox

Kubernetes installation using Kubeadm

## Prerequisites

[Click here](./docs/01-prerequisites.md) to begin.

```bash
git clone https://github.com/JULIANCHO923/kubeadm.git
```

Check the status. This Vagranfile consists of 3 virtual machines (VM): 

```bash
vagrant status
```

>
>Current machine states:
>
>kubemaster                 not created (virtualbox)
>kubenode01                not created (virtualbox)
>kubenode02                not created (virtualbox)
>


We are going to initialization the VMs, it can take a few minutes installing pre-requisite tools

```bash
vagrant up
```


Check the status. The VMs should be running

>
Current machine states:

kubemaster                 running (virtualbox)

kubenode01                running (virtualbox)

kubenode02                running (virtualbox)
>


Now, we are going to access the kubemaster node

```bash
vagrant ssh kubemaster
```

We need to get the current IP address, then you can set the IP in the `advertise-address` to initialize kubeadm

```bash
ifconfig
```

```bash
kubeadm reset
kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.56.11
```

Your Kubernetes control-plane has initialized successfully! SAVE the join value

To start using your cluster, you need to run the following as a regular user:

```bash
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
```


Alternatively, if you are the root user, you can run:

```bash
  export KUBECONFIG=/etc/kubernetes/admin.conf
```


[weave Net](https://www.weave.works/docs/net/latest/kubernetes/kube-addon/)

Download this https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

If you do set the --cluster-cidr option on kube-proxy, make sure it matches the IPALLOC_RANGE given to Weave Net (see below).

```yaml
spec:
    containers:
    - command:
    - /home/weave/launch.sh
    env:
    - name: IPALLOC_RANGE
        value: 10.244.0.0/16
    - name: INIT_CONTAINER
        value: "true"
    - name: HOSTNAME
        valueFrom:
        fieldRef:
            apiVersion: v1
            fieldPath: spec.nodeName
    image: weaveworks/weave-kube:latest
```


## Joining Nodes to the Kubernetes cluster

Then you can join any number of worker nodes by running the following on each as root:


```bash
sudo su
kubeadm reset
```
```bash
kubeadm join 192.168.56.11:6443 --token ?????????? \
        --discovery-token-ca-cert-hash ????????????
```

### Installing Kube Flow

In the kubemaster vm, you can execute the following commands:

```bash
git clone https://github.com/kubeflow/manifests.git
cd manifests/
git checkout -b v1.5-branch --track origin/v1.5-branch
snap install kustomize
```

```bash
while ! kustomize build example | kubectl apply -f -; do echo "Retrying to apply resources"; sleep 10; done
```

```bash
kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80
```