# Tunasync 开源镜像站

[![Docker Build](https://github.com/jeffok/tunasync/workflows/Build%20and%20Push%20Docker%20Image/badge.svg)](https://github.com/jeffok/tunasync/actions)
[![Docker Hub](https://img.shields.io/docker/pulls/jeffok/tunasync)](https://hub.docker.com/r/jeffok/tunasync)
[![Version](https://img.shields.io/badge/version-0.9.3-blue)](https://github.com/tuna/tunasync/releases/tag/v0.9.3)

基于 [Tunasync v0.9.3](https://github.com/tuna/tunasync) 的开源软件镜像站 Docker 镜像，提供便捷的镜像同步服务。

## 📋 项目简介

本项目是镜像服务器的前端与后台维护脚本源码的 Docker 化实现，支持多种主流 Linux 发行版和软件仓库的镜像同步。

**当前版本**：基于 [Tunasync v0.9.3](https://github.com/tuna/tunasync/releases/tag/v0.9.3)

### Tunasync v0.9.3 新特性

- ✅ 允许全局和每个镜像设置成功退出代码
- ✅ 添加 `success_exit_codes` 镜像配置选项
- ✅ 添加 `dangerous_global_success_exit_codes` 全局配置选项
- ✅ 改进的错误处理和测试覆盖

## ✨ 特性

- 🐳 **Docker 化部署**：一键启动，开箱即用
- 🔄 **多源支持**：支持 CentOS、EPEL、Ubuntu、ArchLinux、Debian、Rocky 等多种镜像源
- 🚀 **CI/CD 集成**：自动构建并推送到 Docker Hub
- 📦 **多平台支持**：支持 linux/amd64 和 linux/arm64 架构
- ⚙️ **灵活配置**：支持自定义配置文件
- 🔖 **最新版本**：基于 Tunasync v0.9.3（2025-02-28 发布）

## 🚀 快速开始

### 使用 Docker Compose（推荐）

```bash
# 克隆仓库
git clone https://github.com/jeffok/tunasync.git
cd tunasync

# 启动服务
docker-compose up -d

# 查看日志
docker-compose logs -f
```

### 使用 Docker 命令

```bash
# 拉取镜像
docker pull jeffok/tunasync:latest

# 运行容器
docker run -d \
  --name tunasync \
  -p 12345:12345 \
  -p 6000:6000 \
  -v $(pwd)/conf:/data/conf \
  -v $(pwd)/mirrors:/data/mirrors \
  -v $(pwd)/logs:/data/logs \
  jeffok/tunasync:latest
```

### 手动构建镜像

```bash
# 构建镜像（基于 Tunasync v0.9.3）
docker build -t jeffok/tunasync:0.9.3 .

# 运行容器
docker run -d \
  --name tunasync \
  -p 12345:12345 \
  -p 6000:6000 \
  -v $(pwd)/conf:/data/conf \
  -v $(pwd)/mirrors:/data/mirrors \
  -v $(pwd)/logs:/data/logs \
  jeffok/tunasync:0.9.3
```

## 📁 目录结构

```
tunasync/
├── .github/
│   └── workflows/
│       └── docker-build-push.yml    # CI/CD 工作流
├── conf/
│   ├── manager.conf                 # Manager 配置文件
│   └── worker.conf                  # Worker 配置文件
├── docker-compose.yml               # Docker Compose 配置
├── Dockerfile                       # Docker 镜像构建文件
├── run.sh                           # 启动脚本
└── README.md                        # 项目说明文档
```

## ⚙️ 配置说明

### 默认配置

- **镜像路径**：`/data/mirrors`
- **配置文件**：`/data/conf`
- **日志路径**：`/data/logs`
- **Manager 端口**：`12345`
- **Worker 端口**：`6000`

### 支持的镜像源

默认配置包含以下镜像源：

- CentOS
- EPEL
- Ubuntu
- ArchLinux
- Debian
- Rocky
- Alpine
- Kali
- Kernel
- Manjaro
- MariaDB
- Ceph
- OpenStack

### 自定义配置

编辑 `conf/manager.conf` 和 `conf/worker.conf` 来自定义配置：

```bash
# 编辑配置文件
vim conf/manager.conf
vim conf/worker.conf

# 重启容器使配置生效
docker-compose restart
```

## 🔧 环境变量

| 变量名 | 说明 | 默认值 |
|--------|------|--------|
| - | 暂无环境变量配置 | - |

## 📡 端口说明

| 端口 | 服务 | 说明 |
|------|------|------|
| 12345 | Manager API | 管理接口 |
| 6000 | Worker API | Worker 接口 |

## 🔄 CI/CD

项目使用 GitHub Actions 自动构建并推送到 Docker Hub：

- **触发条件**：
  - 推送到 `main` 分支
  - 创建版本标签（`v*`）
  - 手动触发（workflow_dispatch）

- **构建特性**：
  - 多平台构建（linux/amd64, linux/arm64）
  - 构建缓存加速
  - 自动版本标签

### 配置 GitHub Secrets

在 GitHub 仓库设置中配置以下 Secret：

1. `DOCKERHUB_TOKEN`：Docker Hub 访问令牌

配置步骤：
1. 登录 DockerHub → Account Settings → Security → New Access Token
2. 创建访问令牌并复制
3. 在 GitHub 仓库：Settings → Secrets and variables → Actions → New repository secret
4. 添加 `DOCKERHUB_TOKEN` secret

## 📦 Docker 镜像标签

- `latest`：最新版本（main 分支，基于 Tunasync v0.9.3）
- `0.9.3`：稳定版本（基于 Tunasync v0.9.3）
- `v*`：版本标签（如 v0.9.3）
- `main-*`：分支构建（包含 commit SHA）

> **注意**：当前镜像基于 [Tunasync v0.9.3](https://github.com/tuna/tunasync/releases/tag/v0.9.3)，这是最新的稳定版本（发布于 2025-02-28）。

## 🛠️ 开发

### 本地开发

```bash
# 克隆仓库
git clone https://github.com/jeffok/tunasync.git
cd tunasync

# 构建镜像
docker build -t jeffok/tunasync:dev .

# 运行测试
docker-compose up
```

### 提交代码

```bash
# 提交更改
git add .
git commit -m "feat: 添加新功能"

# 推送到远程
git push origin main
```

## 📝 许可证

本项目采用 [GNU General Public License v3.0](LICENSE) 许可证。

## 🙏 致谢

本项目参考并基于以下优秀的开源项目：

- [清华大学开源软件镜像站](https://mirrors.tuna.tsinghua.edu.cn/)
- [USTC 开源软件镜像站](https://mirrors.ustc.edu.cn/)
- [Tunasync](https://github.com/tuna/tunasync) - 镜像同步工具

## 📞 联系方式

- **GitHub**: [https://github.com/jeffok/tunasync](https://github.com/jeffok/tunasync)
- **Docker Hub**: [https://hub.docker.com/r/jeffok/tunasync](https://hub.docker.com/r/jeffok/tunasync)

## 📚 相关链接

- [Tunasync 官方仓库](https://github.com/tuna/tunasync)
- [Tunasync v0.9.3 发布说明](https://github.com/tuna/tunasync/releases/tag/v0.9.3)
- [Tunasync 中文文档](https://github.com/tuna/tunasync#get-started)
- [Docker 官方文档](https://docs.docker.com/)
- [Docker Compose 文档](https://docs.docker.com/compose/)

## 📝 版本历史

| 版本 | 基于 Tunasync | 发布日期 | 说明 |
|------|--------------|---------|------|
| 0.9.3 | v0.9.3 | 2025-02-28 | 最新稳定版本，支持成功退出代码配置 |
| 0.8.0 | v0.8.0 | - | 旧版本（已弃用） |

---

⭐ 如果这个项目对你有帮助，请给个 Star！
