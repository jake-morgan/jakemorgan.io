FROM nginx:latest

COPY site/public /usr/share/nginx/html

EXPOSE 80
EXPOSE 443
