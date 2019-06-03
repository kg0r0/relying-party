FROM centos:centos7.6.1810

ENV HTTPD_VERSION=2.4.6-88.el7.centos \
    MOD_AUTH_OPENIDC_VERSION=2.3.10.2-1.el7.x86_64 \
    MOD_AUTH_OPENIDC_SHORT_VERSION=2.3.10.2 \
    HIREDIS_VERSION=0.12.1-1.el7.x86_64 \
    CJOSE_VERSION=0.5.1-1.el7.centos.x86_64

RUN set -x \
  && yum install -y iproute \
  && yum install -y httpd-${HTTPD_VERSION} \
  && yum clean all 

RUN mkdir -p /tmp/work \
  && cd /tmp/work \
  && curl -k -L -O https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/h/hiredis-${HIREDIS_VERSION}.rpm \
  && curl -k -L -O https://github.com/zmartzone/mod_auth_openidc/releases/download/v2.3.0/cjose-${CJOSE_VERSION}.rpm \
  && curl -k -L -O https://github.com/zmartzone/mod_auth_openidc/releases/download/v${MOD_AUTH_OPENIDC_SHORT_VERSION}/mod_auth_openidc-${MOD_AUTH_OPENIDC_VERSION}.rpm \
  && yum install -y *.rpm \
  && yum clean all \
  && rm -rf /tmp/work

RUN ln -sf /dev/stdout /var/log/httpd/access_log && ln -sf /dev/stderr /var/log/httpd/error_log

COPY httpd.conf /etc/httpd/conf/httpd.conf
COPY index.html /var/www/html/private

EXPOSE 80

CMD exec /usr/sbin/httpd -DFOREGROUND
