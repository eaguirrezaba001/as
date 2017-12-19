# Administración de Sistemas
Procedimiento a seguir para la puesta en marcha del proyecto

## 1. Crear la máquina virtual
clonar o descargar el contenido de la carpeta as_demo
dentro de la carpeta as_demo, ejecutar el siguiente comando para crear la máquina virtual:
> vagrant plugin install landrush

> vagrant up

## 2. Instalar minikube
Dentro de la propia máquina virtual, ejecutar:
> ./install_minikube.sh

## 3. Configurar Traefik y ejemplos
De igual modo, ejecutar:
> ./setup_traefik.sh

## Pruebas
Dentro de la máquina virtual, se puede acceder a las siguientes direcciones para comprobar el funcionamiento:
> http://minikube:30000

> http://traefik-ui.minikube

> http://cheddar.minikube  |  http://stilton.minikube  |  http://wensleydale.minikube

> http://cheeses.minikube/cheddar  |  http://cheeses.minikube/stilton  |  http://cheeses.minikube/wensleydale


