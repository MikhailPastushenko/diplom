# Дипломный практикум в Yandex.Cloud

## Создание облачной инфраструктуры ##

1. Создаём сервисный аккаунт, который будет в дальнейшем использоваться Terraform для работы с инфраструктурой

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/ac76a1e9-11d0-49e8-9479-7a8e2fb95700)


Устанавливаем и настраиваем профиль yc. И создаём новый профиль sa-netology для сервисного аккаунта netology-account

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/b99b7f0b-3564-4e76-97fd-20bc659cc9d1)


Создаём авторизованный ключ. Назначаем его профилю sa-netology 

yc config set service-account-key key.json

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/9ec8a7cc-451e-4d72-9589-b236763d2d81)


Задаём переменные и описываем их в файле variables.tf

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/e2545fab-ae54-4ae8-8d1b-52dc45e02caf)


![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/afdc506c-94c7-4367-8cc4-8d45340abf2f)



2. Подготавливаем бэкенд для Terraform, используя рекомендуемый вариант

Создаём бакет в консоли

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/dd06d1d5-3e80-48d2-8c8b-56683edb0d8a)


Добавляем описание бэкенда 

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/55984bb7-f30b-4f6c-bf6e-6805aec2c97c)


Создаём статический ключ для доступа в бакет через консоль  и добавляем переменные
export ACCESS_KEY="<идентификатор_ключа>"
export SECRET_KEY="<секретный_ключ>"

Заодно добавляем все переменные перманентно

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/4a80ed4b-0d2e-4193-9d3e-e4c6d89efdba)


Переинициализируем terraform

terraform init -backend-config="access_key=$TF_VAR_ACCESS_KEY" -backend-config="secret_key=$TF_VAR_SECRET_KEY"

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/a6b740f4-ba77-491b-8fda-6fe4385d4dd5)


3. Создаём VPC с подсетями в разных зонах доступности.
   
Добавляем указанные ресурсы в файл main.tf 

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/aeb003a2-eca2-4587-8909-e123e0ccb976)

 Проверяем выполнение команд terraform destroy и terraform apply

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/ecaea408-ca72-4f45-8fd1-02d48e61fc0d)


![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/eea557f2-acf8-4207-9c1a-309c3a11f759)


![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/71c35714-edad-4ee4-985c-d20d683ac89b)


Ссылка на репозиторий с файлами terraform https://github.com/MikhailPastushenko/diplom-terraform

## Создание Kubernetes кластера ##

Использую рекомендуемый вариант: самостоятельная установка Kubernetes кластера.

Добавляем ресурсы  в main.tf  (Одна ВМ master и 2 ВМ worker)

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/ab096afc-3366-4d34-8119-bbf1f9f43fda)


![image](https://github.com/MikhailPastushenko/aboutDiplom/assets/99995304/1b2f4b8f-7a16-407e-91c1-b3b20be3d300)


terraform apply

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/44d15990-5bc3-4576-937f-bc48608f9d61)


![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/373c9a64-31c8-4805-be50-a067f3426b21)


Разворачиваем на этих ВМ кластер kubernetes с помощью kubespray

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/1729c7c3-04e6-4834-9d86-e035bdad183a)

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/b6016bd2-e0da-4e96-99e9-7375a5cf847e)


готовим инвентаризационный файл и запускаем установку

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/1c040e12-a603-4fd8-913e-5ccd5c4e72e6)


`ansible-playbook -i inventory/mycluster/hosts.yaml cluster.yml -b -K -v`



![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/936528c7-7d72-49c3-967b-2598712a7440)

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/3e551fc3-ac51-463d-ab90-92b58acbd8f3)

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/3cc66f93-c063-4e4f-ad8a-73db637c7ee0)


Изменённый файл инвентаризации: https://github.com/MikhailPastushenko/diplom/blob/main/kubespray/hosts.yaml


## Создание тестового приложения ##

Сделал заготовку для сайта 

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/33f7a618-d983-44e4-af3b-d254fbd1cffa)


код выложен в репозиторий https://github.com/MikhailPastushenko/diplom-app

Готовим dokerfile

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/c9ff4b49-f759-4965-b098-f24d5444be7b)


https://github.com/MikhailPastushenko/diplom-app/blob/main/Dockerfile

создаём образ

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/cacb8f8e-824a-44ce-9345-52126e865ca9)


авторизуемся в DockerHub
![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/433c0502-eafa-4482-a61c-2fe5b8deaa96)


Создаём репозиторий под этот проект
![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/4b45bdd4-57fd-44ba-a659-697ecca0d698)


Пушим образ в репозиторий

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/6c214d28-3cbf-4303-a51c-bd4760d75999)

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/c12dad15-28d7-4181-b082-8ace710d4f67)

Ссылка на репозиторий https://hub.docker.com/r/mikhailpastushenko/testchessanalyzer/tags

Для доступа к приложению извне кластера устанавливаем ingress controller  ingress-nginx

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/e8837264-4e55-4c3a-9b16-bd2679752386)



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



##  Доработка ##


1. Отображение картинок в README файле поправлено
   
2. Задал количество мастер-нод и воркеров через переменную count https://github.com/MikhailPastushenko/diplom-terraform/blob/main/main.tf#L32C1-L34C50
   
3. добавил в файл .gitignore пути, начинающиеся с точки https://github.com/MikhailPastushenko/diplom-terraform/blob/main/.gitignore
   
4. Добавил вывод переменных с ip-адресами мастер- и воркер-нод https://github.com/MikhailPastushenko/diplom-terraform/blob/main/main.tf#L88C1-L95C1

   результат выполнения `terraform apply`: https://github.com/MikhailPastushenko/diplom/blob/main/terraform/terraform_apply.txt

   далее этот список просто копируем в команду `declare -a IPs=(192.168.20.29 192.168.20.19 192.168.20.8)` при подготовке файла инветтаризации. Автоматическую передачу сделать не могу, т.к. terraform разворачивается с хостовой ВМ, а кластер kubernetes c одной из нод

5. Добавил дополнительный action проверки тега https://github.com/MikhailPastushenko/diplom-app/blob/main/.github/workflows/main.yml#L11C1-L29C56
   Если тег не соответствует формату, то экшены build и deploy не выполняются  https://github.com/MikhailPastushenko/diplom-app/actions/runs/6685125249
   
 ![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/19a99f90-6dd6-4175-9f79-e08ed79029ff)

6. Через ингресс не получилось сделать. Сделал через NodePort

   Создал сервис
   ![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/e8265625-f26f-4d91-ad9d-ea388928a6a6)

   Создал балансировщик

   ![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/659b2e15-7c95-4773-942f-0c1cc317cd79)

   Приложение доступно по адресам нод
   http://51.250.40.179:30480/
   http://51.250.32.67:30480/
   и по адресу БН
   http://158.160.130.11/

![image](https://github.com/MikhailPastushenko/diplom/assets/99995304/b3582ded-5a4d-40e6-b978-a737d5bd6cfc)



