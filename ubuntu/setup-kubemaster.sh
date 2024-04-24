sudo su;

kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=192.168.56.11

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

export KUBECONFIG=/etc/kubernetes/admin.conf

# Each kubenode
# kubeadm reset
# kubeadm join 192.168.56.11:6443 --token s3o1ut.df4shpwx14kul0cn --discovery-token-ca-cert-hash sha256:02a240c3404ef63a23d644217a31bb846b8df695969a2da18b234a9cb3a95e41 