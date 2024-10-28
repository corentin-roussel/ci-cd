FROM ubuntu:latest

RUN apt update && apt install openssh-server sudo -y

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1010 test

RUN echo 'root:root123' | chpasswd

RUN service ssh start

EXPOSE 44

CMD ["/usr/sbin/sshd", "-D"]
