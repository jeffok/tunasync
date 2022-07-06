# 开源镜像站

## 说明

本项目是镜像服务器的前端与后台维护脚本源码。

前端页面会定时（本项目默认为1分钟，注：定时刷新功能不支持 IE8 及以下浏览器）从后台获取各同步源数据状态，并刷新至浏览器。

### 默认配置

- 源列表：CentOS，EPEL，Ubuntu，Pypi，ArchLinux，Ceph，OpenStack，Rocky，Debian
- 镜像路径：/data/tunasync/mirrors/
- 配置文件：/data/tunasync/config/
- 日志路径：/data/tunasync/logs/

## 致谢

本项目参考清华大学开源软件镜像站(https://mirrors.tuna.tsinghua.edu.cn/)、[USTC open source software mirror](https://mirrors.ustc.edu.cn/)