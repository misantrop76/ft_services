FROM alpine:3.12.3

RUN	apk update
RUN	apk add nginx openrc openssh openssl

RUN		adduser -D -g 'www' www; mkdir /www; chown -R www:www /var/lib/nginx && chown -R www:www /www
RUN		echo "www:www" | chpasswd && echo "root:root" | chpasswd

RUN		mkdir /run/nginx && \
mkdir /run/openrc && \
touch /run/openrc/softlevel && \
rc-update add sshd && \
rc-status

RUN		echo "<h1>It works!!</h1>" > /www/index.html

COPY	default.conf /etc/nginx/conf.d/
COPY	nginx-selfsigned.crt /etc/ssl/certs/
COPY	nginx-selfsigned.key /etc/ssl/private/
COPY	sshd_config /etc/ssh/
COPY	start.sh /.
COPY	health.sh /.

CMD sh start.sh