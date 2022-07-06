# 开源镜像站

## 说明

本项目是镜像服务器的前端与后台维护脚本源码。

### 默认配置

- 源列表：CentOS，EPEL，Ubuntu，Pypi，ArchLinux，Ceph，OpenStack，Rocky，Debian
- 镜像路径：/data/tunasync/mirrors/
- 配置文件：/data/tunasync/config/
- 日志路径：/data/tunasync/logs/

### docker 编译
```
docker build -t jeffok/tunasync:0.8.0 .
```

### docker-compose 一键启动
```
docker-compose up -d 
```

## 致谢

本项目参考清华大学开源软件镜像站(https://mirrors.tuna.tsinghua.edu.cn/)、[USTC open source software mirror](https://mirrors.ustc.edu.cn/)