## You will install these packages on all of your machines:
## - kubeadm: the command to bootstrap the cluster.
## - kubelet: the component that runs on all of the machines in your cluster and does things like starting pods and containers.
## - kubectl: the command line util to talk to your cluster. 

sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gpg


sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.26/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg


# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
sudo echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.26/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-cache madison kubeadm
sudo apt-get install -y kubelet=1.26.15-1.1 kubeadm=1.26.15-1.1 kubectl=1.26.15-1.1
sudo apt-mark hold kubelet kubeadm kubectl