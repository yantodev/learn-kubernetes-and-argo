# Cara menginstal ArgoCD di Ubuntu menggunakan k3s sebagai kubernetes ringan (Test di VirtualNBox)


## Install K3s
- install
```bash
./install_k3s.sh
```

- Cek apakah k3s berhasil berjalan:
```bash
sudo k3s kubectl get nodes
```

- Export alias supaya kubectl mudah digunakan:
```bash
alias kubectl='sudo k3s kubectl'
```

## Instal ArgoCD di K3s
Gunakan kubectl untuk menginstal ArgoCD.

- Buat namespace ```argocd```
```bash
kubectl create namespace argocd
```

- Instal ArgoCD dari manifests resminya
```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
Tunggu beberapa saat lalu jalankan:
```bash
kubectl get pods -n argocd
```

- Expose ArgoCD Server ke luar
    - Opsi 1: Port Forward
    ```bash
    kubectl port-forward svc/argocd-server -n argocd 8080:443
    ```
    Kemudian akses dari host browser ke:
    ```https://localhost:8080```
    - Opsi 2: Ganti Service Type ke NodePort
    ```bash
    kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
    ```
    Cek port-nya:
    ```bash
    kubectl get svc -n argocd argocd-server
    ```
    Lalu akses: https://<IP_VirtualBox>:<NodePort>

    💡 Gunakan ip a di Ubuntu untuk melihat IP K3s/Ubuntu.

- Login ke Dashboard ArgoCD
    - Username: ```admin```
    - Password (default):
    Ambil dari secret:
    ```bash
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
    ```
https://localhost:32380