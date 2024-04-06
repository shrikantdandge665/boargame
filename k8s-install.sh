
Run on all nodes
sudo apt install docker.io -y
sudo chmod 666 /var/run/docker.sock
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt install -y kubeadm=1.28.1-1.1 kubelet=1.28.1-1.1 kubectl=1.28.1-1.1

Initialize Kubernetes Master Node [On MasterNode]
sudo kubeadm init --pod-network-cidr=10.244.0.0/16


. Configure Kubernetes Cluster [On MasterNode]
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

Deploy Networking Solution (Calico) [On MasterNode]
kubectl apply -f https://docs.projectcalico.org/v3.20/manifests/calico.yaml
10. Deploy Ingress Controller (NGINX) [On MasterNode]
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingressnginx/controller-v0.49.0/deploy/static/provider/baremetal/deploy.yaml