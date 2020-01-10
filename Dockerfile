FROM nginx:latest

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y certbot python-certbot-nginx

COPY site/public /usr/share/nginx/html
COPY resources/nginx/morganj.co.uk.conf /etc/nginx/conf.d/morganj.co.uk.io.conf

EXPOSE 80
EXPOSE 443

ENTRYPOINT certbot --nginx -n -m jakeelliotmorgan@gmail.com --agree-tos --redirect --expand --domains morganj.co.uk,www.morganj.co.uk && tail -f /dev/null
