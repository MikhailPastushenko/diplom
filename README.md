# Дипломный практикум в Yandex.Cloud

## Создание облачной инфраструктуры ##

1. Создаём сервисный аккаунт, который будет в дальнейшем использоваться Terraform для работы с инфраструктурой

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/af3eb4a1-c6cc-4fa0-be2d-74131a747650)


Устанавливаем и настраиваем профиль yc. И создаём новый профиль sa-netology для сервисного аккаунта netology-account

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/f55641f6-705e-47b9-98f4-e5b8ac73f491)

Создаём авторизованный ключ. Назначаем его профилю sa-netology 

yc config set service-account-key key.json

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/2506fcb0-f245-47a4-b057-179577c502ce)

Задаём переменные и описываем их в файле variables.tf

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/59f299f9-34b1-43e4-b5e0-93571fcf617b)

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/bf17d345-4806-4deb-bf5b-d1677ed94941)

2. Подготавливаем бэкенд для Terraform, используя рекомендуемый вариант

Создаём бакет в консоли
   
![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/616590cf-7c44-4d51-875c-579bac661c20)

Добавляем описание бэкенда 

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/eb412ee9-92f1-4d7b-9aff-d53960575ee3)

Создаём статический ключ для доступа в бакет через консоль  и добавляем переменные
export ACCESS_KEY="<идентификатор_ключа>"
export SECRET_KEY="<секретный_ключ>"

Заодно добавляем все переменные перманентно

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/a2ba733b-3cc6-416d-8b29-413b042a6d2d)

Переинициализируем terraform

terraform init -backend-config="access_key=$TF_VAR_ACCESS_KEY" -backend-config="secret_key=$TF_VAR_SECRET_KEY"

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/b3a33b2c-bd74-4c7a-a648-d028d930003f)

3. Создаём VPC с подсетями в разных зонах доступности.
   
Добавляем указанные ресурсы в файл main.tf 

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/b865f52b-d41d-4205-af91-64a75d3cde51)

4. Проверяем выполнение команд terraform destroy и terraform apply

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/59f519d8-6ccc-4227-b49d-a8109206b556)

   
![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/09ddedaa-09c0-4973-9ac2-9e7e50c57d9d)

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/1c4e7d1c-f188-4b9c-9c03-7c77e8b35ed0)

Ссылка на репозиторий с файлами terraform https://github.com/MikhailPastushenko/diplom-terraform

## Создание Kubernetes кластера ##

Использую рекомендуемый вариант: самостоятельная установка Kubernetes кластера.

Добавляем ресурсы  в main.tf  (Одна ВМ master и 2 ВМ worker)

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/1b2f4b8f-7a16-407e-91c1-b3b20be3d300)


terraform apply

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/c3f336f9-7d55-48c8-8dfd-717728b53507)

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/5ae21244-63db-46a5-ae4f-4c0c29dc361a)

Разворачиваем на этих ВМ кластер kubernetes с помощью kubespray


![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/d7533af1-f838-49c0-a013-f8ef529112c4)


![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/263b7d35-7414-4f10-8393-2df699b936d6)

готовим инвентаризационный файл и запускаем установку

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/caea7608-1c57-4f91-ada1-72d581961a57)

`ansible-playbook -i inventory/mycluster/hosts.yaml cluster.yml -b -K -v`

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/46cfc3d8-8091-470e-b8ff-854d15663023)

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/097493fc-a6f5-4b6d-8b01-c6b455681c9e)

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/8b875ec7-638e-40c1-8a61-99285f5c9d19)

Изменённый файл инвентаризации: https://github.com/MikhailPastushenko/diplom/blob/main/kubespray/hosts.yaml


## Создание тестового приложения ##

Сделал заготовку для сайта 

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/7a888727-a119-49c3-9a75-7791dd1f0c44)

код выложен в репозиторий https://github.com/MikhailPastushenko/diplom-app

Готовим dokerfile

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/5e802b89-88a9-4d0a-99f8-ad647a68a892)

https://github.com/MikhailPastushenko/diplom-app/blob/main/Dockerfile

создаём образ

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/edbac19b-b7e9-4639-913e-ca1cf901e990)

авторизуемся в DockerHub
![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/eccabdd5-3df3-4235-81f5-f4da42575d21)

Создаём репозиторий под этот проект
![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/5c93cc9a-4bfb-401e-86fe-585e0fde0a95)

Пушим образ в репозиторий

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/c9ec66aa-e46e-4ecd-810c-28376c687b33)

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/4cb1e1b1-05d6-423f-a900-2e9c7ecc8e48)

Ссылка на репозиторий https://hub.docker.com/r/mikhailpastushenko/testchessanalyzer/tags

готовим на мастере манифест деплоймента и применяем

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/a1d2a98c-f82b-42ea-bea8-5f1141618a0c)

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/484679da-19ac-4478-97ee-1d6e3f79e05f)

Для доступа к приложению извне кластера устанавливаем ingress controller  ingress-nginx

![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/9fc5558c-4c1a-4577-af08-b94410e0ddda)



## Подготовка cистемы мониторинга и деплой приложения ##

Скачиваем и запускаем kube-prometheus

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/ad45c5f5-4e32-4ea5-9d3b-b0ab47978ada)

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/51b105c3-2c62-47f8-a335-eb9bbe8909c2)

устанавливаем qbec

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/bf67f4c9-43e8-4a5a-a43c-5b5760ed631f)

*(sudo mv qbec /usr/local/bin/)

Создаём приложение qbec

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/b6b2af74-c067-46c2-8200-91a37ba6b79c)

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/5d24e9e8-29f7-4ca5-ac12-4f5cd5407853)

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/c07055f1-d850-460c-bdab-3c7d0420e175)


Файлы находятся https://github.com/MikhailPastushenko/diplom/tree/main/qbec

Применяем конфигурацию

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/a5f163b2-f424-482d-8118-efea26aa251b)


К сожалению, не удалось добиться работы ингресса - почему-то не присваивается адрес (EXTERNAL-IP  ingress-nginx-controller).   

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/420f2869-9183-4f21-8a90-e6fa5fbd8340)

 Пробовал развернуть приложения как через qbec, так и вручную. Все поды подняты, сервис работает, приложение внутри кластера доступно, но не через ингресс. 
 Если это обязательное условие, то прошу помочь с выполнением.


## Установка и настройка CI/CD ##

Так как код лежит в GitHub, выбрал вариант с GitHub Actions

Создаём в репозитории секреты, необходимые  для подключения

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/9fb0ab3c-3d63-44fb-8337-40f80081bbef)

Создаём Workflow из двух экшенов: сборка образа и деплой

https://github.com/MikhailPastushenko/diplom-app/blob/main/.github/workflows/main.yml

Делаем кооммит с тегом (v1.2.8)

https://github.com/MikhailPastushenko/diplom-app/actions/runs/6633088528/job/18020197687

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/4442240e-6eb3-47a6-92ee-d6404fc8e0bf)


тэг добавился в репозиторий Docker https://hub.docker.com/repository/docker/mikhailpastushenko/testchessanalyzer/general

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/e08d3217-40c4-4bb6-a3a3-4afb528215c7)

и выполнился деплой в кластере

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/1698ab94-4f7c-4be5-87be-d997338caa03)





