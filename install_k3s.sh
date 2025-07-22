#Instal K3s (Kubernetes ringan)
curl -sfL https://get.k3s.io | sh -

#Check k3s is running
sudo k3s kubectl get nodes