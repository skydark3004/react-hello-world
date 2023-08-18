# Base image
FROM node:18-alpine as builder

# Create app directory
WORKDIR /usr/src/app

COPY package*.json .
RUN npm install
COPY . .

RUN npm run build


FROM nginx:1.19
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html
