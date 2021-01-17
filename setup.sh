
echo "setup minikube"

minikube addons enable dashboard
minikube addons enable ingress
minikube start --vm-driver=virtualbox --extra-config=apiserver.service-node-port-range=1-10000



echo "build images"

#docker build --tag service_nginx ./srcs/nginx
#docker build -t service_mysql ./srcs/mysql
#docker build -t service_wordpress ./srcs/wordpress
#docker build -t service_phpmyadmin ./srcs/phpmyadmin
