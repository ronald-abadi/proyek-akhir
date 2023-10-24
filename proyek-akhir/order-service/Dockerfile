# Menggunakan image node:14
# Mengikuti contoh: di https://www.dicoding.com/academies/433/tutorials/31380?from=31375
# dan tutorial di: https://nodejs.org/en/docs/guides/nodejs-docker-webapp
FROM node:14 as base

# Tambahkan beberapa label sekedar informasi saja
LABEL applikasi="order-service"
LABEL maintainer="Ronald Mulyono Abadi"
LABEL version="1.0"
LABEL description="DBS Foundation Coding Camp 2023, Learning Path \
DevOps Engineer, Kelas Expert, Belajar Membangun Arsitektur Microservices, \
Submission Proyek Akhir: Proyek Implementasi Asynchronous Communication \
pada Aplikasi E-Commerce App"

# Setting WORKDIR (work directory) dan copy 2 file package.json dan package-lock.json
WORKDIR /src
COPY package*.json ./

# Definisikan Production Stage, Environment Variables, dan install dependencies 
FROM base as production
ENV NODE_ENV=production
ENV PORT=3000
RUN npm ci

# Copy file .js, expose ke Port 3000 sesuai instruksi, dan jalankan
COPY ./*.js ./
EXPOSE 3000
CMD ["npm", "start"]
