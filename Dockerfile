FROM nginx:latest

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y certbot python-certbot-nginx

COPY site/public /usr/share/nginx/html
COPY resources/nginx/jakemorgan.io.conf /etc/nginx/conf.d/jakemorgan.io.conf

EXPOSE 80
EXPOSE 443

ENTRYPOINT certbot --nginx -n -m jakeelliotmorgan@gmail.com --agree-tos --redirect --expand --domains jakemorgan.io,www.jakemorgan.io
