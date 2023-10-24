#!/bin/bash
# Ronald Mulyono Abadi
# DBS Foundation Coding Camp 2023, Learning Path DevOps Engineer
# Kelas Expert, Belajar Membangun Arsitektur Microservices
# Submission Proyek Akhir: Proyek Implementasi Asynchronous Communication
# pada Aplikasi E-Commerce App
# File: run-kubernetes.sh
# Tujuan: Untuk membantu menjalankan Kubernetes

printf "Hapus dulu semua sekiranya diperlukan...\n"
kubectl delete -f kubernetes/shipping-deployment.yml \
  -f kubernetes/shipping-service.yml \
  --force --grace-period=0 &> /dev/null
  
kubectl delete -f kubernetes/order-deployment.yml \
  -f kubernetes/order-service.yml \
  --force --grace-period=0 &> /dev/null

kubectl delete -f kubernetes/rabbitmq-statefulset.yml \
  -f kubernetes/rabbitmq-service.yml \
  --force --grace-period=0 &> /dev/null
  
printf "\nTunggu beberapa saat...\n"
sleep 15

printf "\nBuat Kubernetes objects untuk RabbitMQ...\n"
kubectl apply -f kubernetes/rabbitmq-statefulset.yml \
  -f kubernetes/rabbitmq-service.yml

printf "\nTunggu beberapa saat...\n"
sleep 15
  
printf "\nDaftar StatefulSets saat ini:\n"  
kubectl get statefulsets -o wide

printf "\nDaftar Services saat ini:\n"  
kubectl get services -o wide

printf "\nDaftar Pods saat ini:\n"  
kubectl get pods -o wide

printf "\nBuat Kubernetes objects untuk Order...\n"
kubectl apply -f kubernetes/order-deployment.yml \
  -f kubernetes/order-service.yml
  
printf "\nTunggu beberapa saat...\n"
sleep 15  
  
printf "\nDaftar Deployments saat ini:\n"  
kubectl get deployments -o wide  

printf "\nDaftar Services saat ini:\n"  
kubectl get services -o wide

printf "\nDaftar Pods saat ini:\n"  
kubectl get pods -o wide

printf "\nBuat Kubernetes objects untuk Shipping...\n"
kubectl apply -f kubernetes/shipping-deployment.yml \
  -f kubernetes/shipping-service.yml
  
printf "\nTunggu beberapa saat...\n"
sleep 15  
  
printf "\nDaftar Deployments saat ini:\n"  
kubectl get deployments -o wide  

printf "\nDaftar Services saat ini:\n"  
kubectl get services -o wide

printf "\nDaftar Pods saat ini:\n"  
kubectl get pods -o wide

printf "\nSelesai...\n"
