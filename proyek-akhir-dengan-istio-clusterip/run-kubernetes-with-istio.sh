#!/bin/bash
# Ronald Mulyono Abadi
# DBS Foundation Coding Camp 2023, Learning Path DevOps Engineer
# Kelas Expert, Belajar Membangun Arsitektur Microservices
# Submission Proyek Akhir: Proyek Implementasi Asynchronous Communication
# pada Aplikasi E-Commerce App
# File: run-kubernetes-with-istio.sh
# Tujuan: Untuk membantu menjalankan Kubernetes dengan istio

printf "Pastikan istio sudah ter-install..\n"
/opt/istio/istio-1.17.1/bin/istioctl uninstall --purge --force --skip-confirmation

kubectl delete namespace istio-system

/opt/istio/istio-1.17.1/bin/istioctl install --set profile=demo -y
  
kubectl label namespace default istio-injection=enabled

printf "\nHapus dulu semua sekiranya diperlukan...\n"
kubectl delete -f kubernetes-with-istio/istio-gateway.yml \
  -f kubernetes-with-istio/istio-virtualservice.yml \
  --force --grace-period=0 &> /dev/null

kubectl delete -f kubernetes-with-istio/shipping-deployment.yml \
  -f kubernetes-with-istio/shipping-service.yml \
  --force --grace-period=0 &> /dev/null
  
kubectl delete -f kubernetes-with-istio/order-deployment.yml \
  -f kubernetes-with-istio/order-service.yml \
  --force --grace-period=0 &> /dev/null
  
kubectl delete -f kubernetes-with-istio/rabbitmq-statefulset.yml \
  -f kubernetes-with-istio/rabbitmq-service.yml \
  --force --grace-period=0 &> /dev/null   
  
printf "\nTunggu beberapa saat...\n"
sleep 15

printf "\nBuat Kubernetes objects untuk RabbitMQ...\n"
kubectl apply -f kubernetes-with-istio/rabbitmq-statefulset.yml \
  -f kubernetes-with-istio/rabbitmq-service.yml

printf "\nTunggu beberapa saat...\n"
sleep 15

kubectl port-forward service/rabbitmq-with-istio 5672:5672 &
  
printf "\nDaftar StatefulSets saat ini:\n"  
kubectl get statefulsets -o wide

printf "\nDaftar Services saat ini:\n"  
kubectl get services -o wide

printf "\nDaftar Pods saat ini:\n"  
kubectl get pods -o wide

printf "\nBuat Kubernetes objects untuk Order...\n"
kubectl apply -f kubernetes-with-istio/order-deployment.yml \
  -f kubernetes-with-istio/order-service.yml
  
printf "\nTunggu beberapa saat...\n"
sleep 15  
  
printf "\nDaftar Deployments saat ini:\n"  
kubectl get deployments -o wide  

printf "\nDaftar Services saat ini:\n"  
kubectl get services -o wide

printf "\nDaftar Pods saat ini:\n"  
kubectl get pods -o wide

printf "\nBuat Kubernetes objects untuk Shipping...\n"
kubectl apply -f kubernetes-with-istio/shipping-deployment.yml \
  -f kubernetes-with-istio/shipping-service.yml
  
printf "\nTunggu beberapa saat...\n"
sleep 15  
  
printf "\nDaftar Deployments saat ini:\n"  
kubectl get deployments -o wide  

printf "\nDaftar Services saat ini:\n"  
kubectl get services -o wide

printf "\nDaftar Pods saat ini:\n"  
kubectl get pods -o wide

printf "\nBuat Kubernetes objects untuk Istio...\n"
kubectl apply -f kubernetes-with-istio/istio-gateway.yml \
  -f kubernetes-with-istio/istio-virtualservice.yml
  
printf "\nTunggu beberapa saat...\n"
sleep 15  

printf "\nDaftar Deployments saat ini:\n"  
kubectl get deployments -o wide  

printf "\nDaftar Services saat ini:\n"  
kubectl get services -o wide

printf "\nDaftar Pods saat ini:\n"  
kubectl get pods -o wide

printf "\nSelesai...\n"
