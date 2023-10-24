#!/bin/bash
# Ronald Mulyono Abadi
# DBS Foundation Coding Camp 2023, Learning Path DevOps Engineer
# Kelas Expert, Belajar Membangun Arsitektur Microservices
# Submission Proyek Akhir: Proyek Implementasi Asynchronous
# Communication pada Aplikasi E-Commerce App
# File: build_push_image_order-service.sh


# Instruksi Kriteria 2: Perintah untuk build Docker image
# dari berkas Dockerfile yang dibuat mandiri
echo "---------------------------------"
echo "Buat Docker image dari Dockerfile"
echo "---------------------------------"
docker build -t order-service:latest .
echo -e "\n"


# Melihat daftar image di lokal
echo "---------------------------"
echo "Lihat daftar image di lokal"
echo "---------------------------"
docker images > docker-images-order-service-awal.txt
echo "Lihat file docker-images-order-service-awal.txt untuk melihat daftar image di lokal"
docker images
echo -e "\n"


# Mengubah nama image agar sesuai dengan format Docker Hub
echo "----------------------------------------"
echo "Ubah nama image dengan format Docker Hub"
echo "----------------------------------------"
docker tag order-service:latest ronaldabadi/order-service:latest
echo -e "\n"


# Instruksi Kriteria 2: Login ke Docker Hub
# Gunakan environment variable untuk merahasiakan password Docker Hub
# Catatan: saya sudah melakukan export SUDO_PASSWORD dan export PASSWORD_DOCKER_HUB sebelumnya
echo "-------------------"
echo "Login ke Docker Hub"
echo "-------------------"
echo $SUDO_PASSWORD | sudo -S service docker stop
echo $SUDO_PASSWORD | sudo -S rm ~/.docker/config.json
echo $SUDO_PASSWORD | sudo -S service docker start
echo $PASSWORD_DOCKER_HUB | docker login -u ronaldabadi --password-stdin
echo -e "\n"


# Instruksi Kriteria 2: Mengunggah image ke Docker Hub
echo "--------------------------"
echo "Unggah image ke Docker Hub"
echo "--------------------------"
docker push ronaldabadi/order-service:latest
echo -e "\n"


# Mengubah nama image agar sesuai dengan format GitHub Packages
echo "---------------------------------------------"
echo "Ubah nama image dengan format GitHub Packages"
echo "---------------------------------------------"
export ITEM_APP_IMAGE_ID="$(docker images -q order-service:latest)"
docker tag $ITEM_APP_IMAGE_ID ghcr.io/ronald-abadi/order-service:latest
echo -e "\n"


# Instruksi Kriteria 2: Login ke GitHub Packages
# Catatan: saya sudah melakukan export PASSWORD_GITHUB_PACKAGES sebelumnya
echo "------------------------"
echo "Login ke GitHub Packages"
echo "------------------------"
echo $SUDO_PASSWORD | sudo -S service docker stop
echo $SUDO_PASSWORD | sudo -S rm ~/.docker/config.json
echo $SUDO_PASSWORD | sudo -S service docker start
echo $PASSWORD_GITHUB_PACKAGES | docker login ghcr.io --username ronald-abadi --password-stdin
echo -e "\n"


# Instruksi Kriteria 2: Mengunggah image ke GitHub Packages
echo "-------------------------------"
echo "Unggah image ke GitHub Packages"
echo "-------------------------------"
docker push ghcr.io/ronald-abadi/order-service:latest
echo -e "\n"


# Penutup
echo "---------------------------------------"
echo "Lihat daftar image di lokal sekali lagi"
echo "---------------------------------------"
docker images > docker-images-order-service-akhir.txt
echo "Lihat file docker-images-order-service-akhir.txt untuk melihat daftar image di lokal"
docker images
echo "DONE..."
