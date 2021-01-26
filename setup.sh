
echo "setup minikube"
#minikube delete
minikube start --vm-driver=virtualbox
eval $(minikube docker-env)
minikube addons enable metallb

echo "\nbuild images"
docker build -t nginx ./srcs/nginx/.
#docker build -t service_mysql ./srcs/mysql
#docker build -t service_wordpress ./srcs/wordpress
#docker build -t service_phpmyadmin ./srcs/phpmyadmin
kubectl apply -f srcs/nginx.yaml
minikube dashboard &
