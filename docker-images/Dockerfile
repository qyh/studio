FROM centos:latest
# 设置编码
ENV LANG en_US.utf8
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

# 安装openssh-server和sudo (命令连起来更省空间)
# 添加测试用户admin，密码admin，并且将此用户添加到sudoers里 \

RUN yum install -y openssh-server sudo && \
sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && \

useradd qyh && \
echo "qyh:123456" | chpasswd && \
echo "root:root" | chpasswd && \
echo "qyh   ALL=(ALL)       ALL" >> /etc/sudoers && \
chown qyh:qyh /home/qyh && \

ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key && \
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key && \

yum install -y epel-release make automake autoconf libtool svn unzip zip bzip2 git readline-devel telnet mysql net-tools mysql-devel python-devel  python-pip openssl-devel nc gdb vim && \

yum install -y gcc gcc-c++ && \

mkdir /var/run/sshd && \

echo 'export LANG="en_US.utf8"' >> /etc/profile && \

echo 'export LC_ALL="en_US.utf8"' >> /etc/profile && \

echo 'set -o vi' >> /etc/profile 

EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]