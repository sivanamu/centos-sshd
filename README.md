# CentOS 7 with SSH for Docker #

CentOS 7.x based with SSH running by default.

## Note ##
* Default user is "admin" with password "welcome".
* Require latest docker, CentOS host need to enable EPEL and install docker-io.

## Docker version that works ##
```
Client version: 1.0.0
Client API version: 1.12
Go version (client): go1.2.2
Git commit (client): 63fe64c/1.0.0
Server version: 1.0.0
Server API version: 1.12
Go version (server): go1.2.2
Git commit (server): 63fe64c/1.0.0
```
## Building ##

```
docker build -t centos7-ssh .
```

## Running ##
```
[root@otp790 centos7-ssh]# docker run -d -P -t --name centos7-1 centos7-ssh
58ca9baf1e75b8bb1e10cfe25c40281ea8fb9b10cd99f3ab0631270e67dc1f74          
[root@otp790 centos7-ssh]# docker ps
CONTAINER ID        IMAGE                 COMMAND             CREATED             STATUS              PORTS                   NAMES
58ca9baf1e75        centos7-ssh:latest   /usr/sbin/sshd -D   9 seconds ago       Up 7 seconds        0.0.0.0:49154->22/tcp   centos7-1
[root@otp790 centos7-ssh]# ssh admin@localhost -p 49154
The authenticity of host '[localhost]:49154 ([::1]:49154)' can't be established.
RSA key fingerprint is dc:4f:e6:64:f6:69:99:9d:a4:b9:6a:5d:ea:99:49:7b.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '[localhost]:49154' (RSA) to the list of known hosts.
admin@localhost's password:
[admin@58ca9baf1e75 ~]$ sudo -i

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for admin: 
[root@58ca9baf1e75 ~]# 
```
# centos-sshd
