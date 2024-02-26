<p align="center"><a href="https://fposter.cn/doc/" target="_blank"><img width="168" src="https://fposter.cn/dassets/httpsok-logo.png" alt="httpsok logo"></a></p>

<p align="center">
  <!--
<a href="https://github.com/httpsok/httpsok" class="link github-link" target="_blank"><img style="max-width: 100px;" alt="GitHub Repo stars" src="https://img.shields.io/github/stars/httpsok/httpsok?style=social"></a>
  <a href="https://gitee.com/httpsok/httpsok" class="link gitee-link" target="_blank"><img style="max-width: 100px;" alt="gitee Repo stars" src="https://gitee.com/httpsok/httpsok/badge/star.svg"></a>
    -->
  <img alt="csharp" src="https://img.shields.io/badge/language-shell-brightgreen.svg">
  <img alt="license" src="https://img.shields.io/badge/license-MIT-blue.svg">
  <img alt="version" src="https://img.shields.io/badge/version-1.7.1-brightgreen">
</p>

## 介绍

**一行命令，轻松搞定SSL证书自动续期**

`httpsok` 是一个便捷的 HTTPS 证书自动续期工具，专为 Nginx 服务器设计。其特性之一是通过一行命令即可完成安装，无需手动修改任何 Nginx 配置文件。特别适用于多台 Nginx 服务器和多域名管理的场景，尤其是在面对老系统中复杂的 Nginx 配置文件时，httpsok能够提供高效的解决方案。

## 文档

- 帮助文档：[https://fposter.cn/doc/](https://fposter.cn/doc/)

## 特性

- 使用简单，一行命令，一分钟轻松解决SSL证书自动续期。
- 无需修改任何nginx配置。
- 对于复杂配置的生产环境，无缝支持。
- 多域名、多服务器节点支持。
- 证书监控功能，对于即将失效的证书，提供公众号推送提醒。

# 快速开始


## 安装httpsok

```bash
curl -s https://fposter.cn/httpsok.sh | bash -s 'your token'
```

> 登陆控制台 👉 👉 [获取token](https://fposter.cn/console/)

## 安装成功

安装成功后，会自动检测一次系统中的`nginx`证书。

```bash
2024-01-21 00:22:56 os-name: TencentOS Server 2.4
2024-01-21 00:22:56 version: nginx/1.20.1
2024-01-21 00:22:56 nginx-config-home: /etc/nginx

Httpsok make SSL easy.     https://fposter.cn/ 
version: 1.7.1
home: /root/.httpsok

2024-01-21 00:22:57 DNS check pass
2024-01-21 00:22:57 cdb8e6b945154127 /etc/nginx/certs/api.fastposter.net_nginx/api.fastposter.net_bundle.crt Cert valid
2024-01-21 00:22:58 e29c94e6c2504f37 /etc/nginx/certs/cloud.fastposter.net_nginx/cloud.fastposter.net_bundle.crt Cert valid
2024-01-21 00:22:58 32614897bc364812 /etc/nginx/certs/fastposter.net_nginx/fastposter2.net_bundle.crt Cert valid
2024-01-21 00:22:58 7b9be1c745cb41f8 /etc/nginx/certs/fposter.cn_nginx/fposter.cn_bundle.crt Cert valid

2024-01-21 00:22:58 Nginx reload needless.
```


## DNS配置

出现如下提示

请添对应的DNS-CNAME解析记录，**只需配置一次即可**。

**解决方案：** 参考[DNS解析](https://fposter.cn/doc/guide/dns.html)

```bash
DNS-CNAME解析无效 参考：https://fposter.cn/doc/guide/dns.html?code=1361fd24380436d44ea
请添以下DNS-CNAME解析记录（只需配置一次即可）: 

_acme-challenge.******.cn >> 043a438043a438d40c.httpsok.com
```

## 问题反馈

作者微信 请备注 `来自httpsok`

![httpsok作者微信](https://fposter.cn/dassets/qrcode.png)
