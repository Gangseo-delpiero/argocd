FROM httpd:latest
ENV DEBIAN_FRONTEND=nonintive
RUN apt-get update \
&& apt-get install vim -y
RUN echo " #\
LoadModule proxy_connect_module modules/mod_proxy_connect.so \
LoadModule proxy_module modules/mod_proxy.so \
LoadModule proxy_http_module modules/mod_proxy_http.so \
\
<VirtualHost *:80> \
        ProxyRequests Off \
        ProxyPreserveHost On \
\
        <Proxy *> \
                Order deny,allow \
                Allow from all \
        </Proxy> \
        ProxyPass '/' 'http://10.100.100.100:8080/' \
        ProxyPassReverse '/' 'http://10.100.100.100:8080/' \
</VirtualHost>" >> /usr/local/apache2/conf/httpd.conf

EXPOSE 80
CMD ["httpd-foreground"]
