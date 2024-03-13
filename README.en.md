<p align="center"><a href="https://fposter.cn/doc/" target="_blank"><img width="168" src="https://fposter.cn/dassets/httpsok-logo.png" alt="httpsok logo"></a></p>

<p align="center">
  <a href="https://github.com/httpsok/httpsok" class="link github-link" target="_blank"><img style="max-width: 100px; max-height: 30px;" alt="GitHub Repo stars" src="https://img.shields.io/github/stars/httpsok/httpsok?style=social"></a>
  <a href="https://gitee.com/httpsok/httpsok" class="link gitee-link" target="_blank"><img style="max-width: 100px; max-height: 30px;" alt="gitee Repo stars" src="https://gitee.com/httpsok/httpsok/badge/star.svg"></a>
  <img style="max-width: 100px; max-height: 30px;" alt="csharp" src="https://img.shields.io/badge/language-shell-brightgreen.svg">
  <img style="max-width: 100px; max-height: 30px;"alt="license" src="https://img.shields.io/badge/license-MIT-blue.svg">
  <img style="max-width: 100px; max-height: 30px;"alt="version" src="https://img.shields.io/badge/version-1.8.2-brightgreen">
</p>

## Introduction

**httpsok** is a convenient HTTPS certificate auto-renewal tool designed specifically for Nginx and OpenResty servers. It has served numerous small and medium-sized enterprises, offering stability, security, and reliability.

**One command, easily renew SSL certificates**

## Documentation

- Documentation: [https://fposter.cn/doc/](https://fposter.cn/doc/)

## Features

- ⚡️ **Simple and Efficient**: With just one command, effortlessly renew SSL certificates within a minute.
- ✅ **Automatic Detection**: No need to worry about Nginx configuration; it automatically identifies certificate configurations, suitable for older systems and complex production environments.
- ✅ **Wildcard Resolutions, Multiple Domains, Multiple Servers**: Easily handle diverse scenarios.
- ✅ **Certificate Monitoring**: Provides push notifications via public accounts for certificates approaching expiration.
- ✅ **Good Compatibility**: Compatible with mainstream Linux systems such as `Debain` `CentOS` `Ubuntu` `TencentOS`.

# Quick Start

## Install httpsok

```bash
curl -s https://fposter.cn/httpsok.sh | bash -s 'your token'
```

> Login to the console 👉 👉 [Get your token](https://fposter.cn/console/)

## Installation Success

After successful installation, it will automatically check the `nginx` certificates in the system.

```bash
Httpsok make SSL easy.     https://fposter.cn/ 
version: 1.8.2
TraceID: 92592593890e8a442be7f50c7ddc5d2d
home: /root/.httpsok

2024-03-04 04:54:24 DNS check pass
2024-03-04 04:54:24 ee262ecba47d4173 /etc/nginx/certs/fposter.cn_nginx/fposter.cn_bundle.crt Cert valid

2024-03-04 04:54:24 Nginx reload needless.
```

## DNS Configuration

Add a DNS resolution record of type **CNAME**, and it only needs to be added once.

**After successful addition, please wait for approximately 1 minute** (it takes a little while for DNS to take effect), and then run the installation script again.

**Solution:** Refer to [DNS Resolution](https://fposter.cn/doc/guide/dns.html)

```bash
+-------------------+-----------------------+------------+--------------------------------+
|  域名             |  主机记录             |  记录类型  |  记录值                            |
+-------------------+-----------------------+------------+--------------------------------+
|  *.baidu.com      |  _acme-challenge      |  CNAME     |  f4fe0275d790.httpsok.com      |
+-------------------+-----------------------+------------+--------------------------------+
|  *.sub.baidu.com  |  _acme-challenge.sub  |  CNAME     |  f4fe0275d790.sub.httpsok.com  |
+-------------------+-----------------------+------------+--------------------------------+
```

## Issue Feedback

Author's WeChat: Please mention `httpsok`

<img width="168" src="https://fposter.cn/dassets/qrcode.png" alt="httpsok logo">
