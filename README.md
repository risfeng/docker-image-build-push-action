## 简介

该 [GitHub Action](https://help.github.com/cn/actions) 用于构建Docker镜像并上传镜像到镜像仓储平台，下列平台已亲测，其他镜像仓储平台理论上同样支持：

- [云私有镜像仓库](https://cr.console.aliyun.com)
- [腾讯云私有镜像仓库](https://console.cloud.tencent.com/tke2/registry/user)

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
        id: buildAndPushImage
        uses: risfeng/docker-image-build-push-action@v1.0
        with:
          registry_url: 'registry.us-east-1.aliyuncs.com'
          namespaces: 'adotcode'
          repository_name: 'adc.ms.eureka.usa'
          user_name: ${{ secrets.ALIYUN_IMAGES_HUB_USER_NAME }}
          password: ${{ secrets.ALIYUN_IMAGES_HUB_TOKEN }}
          image_version: 'v1.0'
          docker_file: '.'
      - name: Get pre step result output image_pull_url
        run: echo "The time was ${{ steps.buildAndPushImage.outputs.image_pull_url }}"
```

其中 `registry_url、namespaces、repository_name、user_name、password` 为自己云镜像仓库设置，`${{ secrets.ALIYUN_IMAGES_HUB_USER_NAME }} ${{ secrets.ALIYUN_IMAGES_HUB_TOKEN }}`是调用Github仓库settings配置的云镜像仓库的登录用户名和密码，防止密码硬编码被泄漏，配置路径：Github代码仓库-->[settings]->[Secrets]中添加对应的Key。

## 输入参数说明

以下参数均可参见云私有镜像仓库，如：[阿里云私有镜像仓库](https://cr.console.aliyun.com)

| 参数 | 是否必传 | 描述 |
| --- | --- | --- |
| registry_url | 是 | 仓库地址，eg: `registry.us-east-1.aliyuncs.com` |
| namespaces | 是 | 命名空间|
| repository_name | 是 | 镜像仓库名称 |
| user_name | 是 | 云登录账户 |
| password | 是 | 登录个人容器镜像服务设置 |
| image_version | 是 | 生成镜像的版本，可以写死，也可以通过上下文自行动态赋值|
| docker_file | 否 | 构建镜像的Dockerfile目录，默认当前目录（.）|

## 输出参数说明
脚本执行完成后会输出镜像pull地址，便于后续直接docker pull 使用

| 参数 | 是否必传 | 描述 |
| --- | --- | --- |
| image_pull_url | 是 | 镜像上传成功后返回的pull地址，eg: `registry.us-east-1.aliyuncs.com/ns/adc.ms.erika:v1.0` 使用示例: `docker pull ${{ steps.<steps.id>.outputs.image_pull_url }}` |