# SSH on CentOS-7
#
# VERSION               0.0.3

FROM     centos:centos7
MAINTAINER Chaiwat Suttipongsakul "cwt@bashell.com"

# generate locale and set timezone
RUN localedef --no-archive -i en_US -f UTF-8 en_US.UTF-8
RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/UTC /etc/localtime
RUN echo 'ZONE="UTC"' > /etc/sysconfig/clock && echo 'UTC=True' >> /etc/sysconfig/clock

# make sure the package repository is up to date
RUN yum install -y deltarpm epel-release
RUN yum --enablerepo=centosplus upgrade -y --skip-broken

# install ssh and other packages
RUN yum install -y initscripts openssh openssh-server openssh-clients sudo passwd sed screen tmux byobu which vim-enhanced
RUN sshd-keygen
RUN sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config

# setup default user
RUN useradd admin -G wheel -s /bin/bash -m
RUN echo 'admin:welcome' | chpasswd
RUN echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers
RUN su - admin -c "byobu-launcher-install"

# install development tools
RUN yum groupinstall -y "Development tools"

# add local path
ADD local.sh /etc/profile.d/local.sh
RUN chmod +x /etc/profile.d/local.sh

# make ssh dir
RUN mkdir -p /root/.ssh/
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
RUN echo "Host bitbucket.org\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

# create known_hosts
RUN touch /root/.ssh/known_hosts

# add bitbuckets key
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts

# expose ports for ssh, web
EXPOSE 22 80 443
CMD    ["/usr/sbin/sshd", "-D"]

