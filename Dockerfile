FROM centos:7

WORKDIR /root/
RUN yum install -y wget java-1.8.0-openjdk-devel \
    && yum groupinstall -y "Development Tools" \
    && yum clean all \
    && wget -q https://github.com/griddb/griddb/releases/download/v4.5.0/griddb-4.5.0-1.linux.x86_64.rpm \
    && rpm -ivh griddb-4.5.0-1.linux.x86_64.rpm \
    && rm griddb-4.5.0-1.linux.x86_64.rpm

ENV HOME /var/lib/gridstore

RUN su - gsadm -c "gs_passwd admin -p admin" \
    && sed -i -e s/\"clusterName\":\"\"/\"clusterName\":\"dockerGridDB\"/g \
       /var/lib/gridstore/conf/gs_cluster.json

WORKDIR $HOME
USER gsadm

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["sleep", "infinity"]
