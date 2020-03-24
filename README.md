## 简介

该 [GitHub Action](https://help.github.com/cn/actions) 用于构建Docker镜像并上传镜像到[阿里云私有镜像仓库](https://cr.console.aliyun.com)。

## workflow 示例

在目标仓库中创建 `.github/workflows/xxxx.yml` 即可，文件名任意,且仅可有一个yml文件，使用配置参考如下：

```yaml
name: Docker Build And Push To Aliyun Hub

on:
  push:
    branches:
      - master

jobs:
  build:
    name: Build Spring Boot
    runs-on: ubuntu-latest
    steps:
      - name: Git Checkout Code
        uses: actions/checkout@v1
        id: git_checkout

      - name: Set up JDK 12.0
        uses: actions/setup-java@v1
        with:
          java-version: 12.0

      - name: Build with Gradle
        run: ./gradlew build

      - name: Build Docker Image
        uses: risfeng/aliyun-docker-image-build-push-action@master
        with:
          registry_url: 'registry.us-east-1.aliyuncs.com'
          namespaces: 'adotcode'
          repository_name: 'adc.ms.eureka.usa'
          user_name: ${{ secrets.ALIYUN_IMAGES_HUB_USER_NAME }}
          password: ${{ secrets.ALIYUN_IMAGES_HUB_TOKEN }}
          image_version: 'v1.0'
          docker_file: '.'
```

其中 `registry_url、namespaces、repository_name、user_name、password` 为自己阿里云镜像仓库设置，`${{ secrets.ALIYUN_IMAGES_HUB_USER_NAME }} ${{ secrets.ALIYUN_IMAGES_HUB_TOKEN }}`是调用Github仓库settings配置的阿里云镜像仓库的登录用户名和密码，防止密码硬编码被泄漏，配置路径：Github代码仓库-->[settings]->[Secrets]中添加对应的Key。

## 相关参数说明

以下参数均可参见
[阿里云私有镜像仓库](https://cr.console.aliyun.com)

| 参数 | 是否必传 | 描述 |
| --- | --- | --- |
| registry_url | 是 | 仓库地址，eg: `registry.us-east-1.aliyuncs.com` |
| namespaces | 是 | 命名空间|
| repository_name | 是 | 镜像仓库名称 |
| user_name | 是 | 阿里云登录账户 |
| password | 是 | 登录个人容器镜像服务后在[访问凭证]中设置的密码 |
| image_version | 是 | 生成镜像的版本，可以写死，也可以通过上下文自行动态赋值|
| docker_file | 否 | 构建镜像的Dockerfile目录，默认当前目录（.）|
