<p align="center"><a href="https://fposter.cn/doc/" target="_blank"><img width="168" src="https://fposter.cn/dassets/httpsok-logo.png" alt="httpsok logo"></a></p>

<p align="center">
  <!-- 
<a href="https://github.com/httpsok/httpsok" class="link github-link" target="_blank"><img style="max-width: 100px;" alt="GitHub Repo stars" src="https://img.shields.io/github/stars/httpsok/httpsok?style=social"></a>
  <a href="https://gitee.com/httpsok/httpsok" class="link gitee-link" target="_blank"><img style="max-width: 100px;" alt="gitee Repo stars" src="https://gitee.com/httpsok/httpsok/badge/star.svg"></a>
    -->
  <img alt="csharp" src="https://img.shields.io/badge/language-shell-brightgreen.svg">
  <img alt="license" src="https://img.shields.io/badge/license-MIT-blue.svg">
  <img alt="version" src="https://img.shields.io/badge/version-1.8.0-brightgreen">
</p>

## 介绍

**一行命令，轻松搞定SSL证书自动续期**

`httpsok` 是一个便捷的 HTTPS 证书自动续期工具，专为 Nginx 服务器设计。已服务众多中小企业，稳定、安全、可靠。

## 文档

- 帮助文档：[https://fposter.cn/doc/](https://fposter.cn/doc/)

## 特性

- **简单** 一行命令，一分钟轻松解决SSL证书自动续期
- **无侵入** 不会修改现有`nginx`配置
- **适配强** 适配主流的Linux操作面板，如`宝塔`、`cPanel`、`AMH`、`1Panel`等
- 对于复杂配置的生产环境，无缝支持
- 易操作多域名、多服务器节点支持
- 证书监控功能，对于即将失效的证书，提供公众号推送提醒
- 支持主流Linux系统


# 快速开始


## 安装httpsok

```bash
curl -s https://fposter.cn/httpsok.sh | bash -s 'your token'
```


> 登陆控制台 👉 👉 [获取token](https://fposter.cn/console/)

## 安装成功

安装成功后，会自动检测一次系统中的`nginx`证书。

```bash
2024-03-04 04:54:23 os-name: TencentOS Server 2.4
2024-03-04 04:54:23 version: nginx/1.20.1
2024-03-04 04:54:23 nginx-config: /etc/nginx/nginx.conf
2024-03-04 04:54:23 nginx-config-home: /etc/nginx

Httpsok make SSL easy.     https://fposter.cn/ 
version: 1.8.0
TraceID: 92592593890e8a442be7f50c7ddc5d2d
home: /root/.httpsok

2024-03-04 04:54:24 DNS check pass
2024-03-04 04:54:24 71e1bbd5f2e5415e /etc/nginx/certs/api.fastposter.net_nginx/api.fastposter.net_bundle.crt Cert valid
2024-03-04 04:54:24 f5f7b9c586a14907 /etc/nginx/certs/cloud.fastposter.net_nginx/cloud.fastposter.net_bundle.crt Cert valid
2024-03-04 04:54:24 922c8597778a434d /etc/nginx/certs/fastposter.net_nginx/fastposter2.net_bundle.crt Cert valid
2024-03-04 04:54:24 ee262ecba47d4173 /etc/nginx/certs/fposter.cn_nginx/fposter.cn_bundle.crt Cert valid

2024-03-04 04:54:24 Nginx reload needless.
```


## DNS解析配置

出现如下提示

请添对应的DNS-CNAME解析记录 参考[DNS解析](https://fposter.cn/doc/guide/dns.md)，**只需配置一次即可**。

**添加成功后请稍等1分钟左右**（DNS生效需要一小会儿），再次运行安装脚本即可。

```bash
DNS-CNAME解析无效 参考：https://fposter.cn/doc/guide/dns.html
请添以下DNS-CNAME解析记录（只需配置一次即可）: 

_acme-challenge.yourdomain.com >> 043a438043a438d40c.httpsok.com

```

## 完成

没错，已经结束了，证书自动续期就这么简单。

## 问题反馈

作者微信 请备注 `来自httpsok`


<p align="center"><img width="168" src="https://fposter.cn/dassets/qrcode.png" alt="httpsok logo"></p>
