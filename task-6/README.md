# Task 6

Команда для запуска

```commandline
packer build  -var="subnet_id=YC_SUBNET_ID" -var="folder_id=YC_FOLDER" -var="token=YC_TOKEN" -var="ssh_public_key_path=SSH_PATH" packer.pkr.hcl
```

## Yandex Cloud данные
- folder_id: `yc resource-manager folder list`
- subnet_id: `yc vpc subnet list` 
- token: `yc iam create-token`

## Артефакты

Созданный диск

![img.png](img/img.png)

Созданная ВМ

![img2.png](img/img2.png)

nginx

![img_1.png](img/img_1.png)

ответ от flask сервера

![img.png](img/img-3.png)



