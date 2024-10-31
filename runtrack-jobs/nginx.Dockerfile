FROM ubuntu:latest

RUN apt-get update && apt-get install sudo -y

RUN sudo apt-get install nginx -y && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/nginx && \
    chmod 755 /var/run/nginx

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
