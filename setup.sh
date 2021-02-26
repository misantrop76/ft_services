#!/bin/bash

function build_spec() 
{
	printf "\e[39mSTART BUILDING \e[5;92m${1}\e[0m\r"
	docker build srcs/$1/. -t $1-image
	kubectl apply -f srcs/$1/yaml/.
}
	minikube delete --all
	minikube start --driver=virtualbox
	export GLOBIP=$(minikube ip)
	eval $(minikube docker-env)

	sed -e "s/GLOB_IP/$GLOBIP/g" srcs/templates/wp.sh > srcs/wordpress/srcs/wp.sh
	sed -e "s/IP_S/$GLOBIP/g;s/IP_E/$GLOBIP/g" srcs/templates/metallb.yaml > srcs/metallb/metallb.yaml
	sed -e "s/GLOB_IP/$GLOBIP/g" srcs/templates/Dockerfile_ftps > srcs/ftps/Dockerfile

	printf "\e[39m START BUILDING \e[5;92mmetallb\e[0m\r"
	start=`date +%s`
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
	kubectl apply -f srcs/metallb/.
	end=`date +%s`
	runtime=$((end-start))
	printf "\e[K\e[92m metallb DONE (in ${runtime}s)!\e[0m\n"

	build_spec influxdb
	build_spec mysql
	build_spec nginx
	build_spec phpmyadmin
	printf "\e[36mPlease wait 10 sec...\n"
	sleep 10
	build_spec wordpress
	build_spec ftps
	build_spec grafana
	minikube dashboard
