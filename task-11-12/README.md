# Практические работы №11-12


## Часть 1

Если Ingress Controller отсутствует, установите:
```bash
./deploy-ingress.sh
```


### Развертывание через kubectl

Используя скрипт:
```bash
./deploy-kubectl.sh
```

### Удаление ресурсов

Используя скрипт:
```bash
./cleanup-kubectl.sh
```

Или вручную:
```bash
kubectl delete -f manifests/
```

## Часть 2. 

### Развертывание ingress

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx --create-namespace

kubectl get svc -n ingress-nginx
```

### Развертывание через helm

```bash
helm upgrade my-release ./helm-charts/my-web-app -n production --create-namespace
```

### Артефакты

#### Часть 1
![img.png](artefacts/img.png)

![img_1.png](artefacts/img_1.png)

![img_2.png](artefacts/img_2.png)

![img_4.png](artefacts/img_3.png)

![img_4.png](artefacts/img_4.png)

![img_5.png](artefacts/img_4.png)

#### Часть 2

![img_6.png](artefacts/img_6.png)

![img_6.png](artefacts/img_7.png)

![img_6.png](artefacts/img_8.png)

![img_6.png](artefacts/img_9.png)



