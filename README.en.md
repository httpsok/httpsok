<p align="center"><a href="https://fposter.cn/doc/" target="_blank"><img width="168" src="https://fposter.cn/dassets/httpsok-logo.png" alt="httpsok logo"></a></p>

<p align="center">
  <img alt="csharp" src="https://img.shields.io/badge/language-shell-brightgreen.svg">
  <img alt="license" src="https://img.shields.io/badge/license-MIT-blue.svg">
  <img alt="version" src="https://img.shields.io/badge/version-1.8.0-brightgreen">
</p>

## Introduction

**One command, easily renew SSL certificates**

`httpsok` is a convenient tool for automatic renewal of HTTPS certificates, designed specifically for Nginx servers. One of its features is the ability to install with just one command, without manually modifying any Nginx configuration files. It is particularly suitable for scenarios with multiple Nginx servers and managing multiple domains, especially when dealing with complex Nginx configuration files in old systems, httpsok can provide an efficient solution.

## Documentation

- Documentation: [https://fposter.cn/doc/](https://fposter.cn/doc/)

## Features

- **⚡️ Simple and Efficient**: Easily renew SSL certificates with just one command in one minute.
- **✅ Non-intrusive**: Does not modify the existing `nginx` configuration in the system.
- **✅ Automatic Detection**: Seamless support for production environments with old systems and complex configurations, effortlessly detecting and supporting them.
- **✅ Multi-server Support**: Supports multiple servers with multiple domain names.
- **✅ Wildcard and Multi-level Domain Support**: Easily handles domain wildcard resolution and multi-level domain names.
- **✅ Certificate Monitoring**: Provides WeChat public account push notifications for expiring certificates.
- **✅ Excellent Compatibility**: Compatible with mainstream Linux systems, including `CentOS` and `TencentOS`.
- **✅ Panel Adaptation**: Compatible with popular Linux operation panels such as `Baota`, `AMH`, `cPanel`, and more.

# Quick Start

## Install httpsok

```bash
curl -s https://fposter.cn/httpsok.sh | bash -s 'your token'
```


> Login to the console 👉 👉 [获取token](https://fposter.cn/console/)

## Installation Success

After successful installation, it will automatically check the `nginx` certificates in the system.

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
2024-03-04 04:54:24 ee262ecba47d4173 /etc/nginx/certs/fposter.cn_nginx/fposter.cn_bundle.crt Cert valid

2024-03-04 04:54:24 Nginx reload needless.
```

## DNS Configuration

If you encounter the following prompt:

Please add the corresponding DNS-CNAME resolution record, **only needs to be configured once**.

**Solution:** Refer to [DNS Resolution](https://fposter.cn/doc/guide/dns.html)

```bash
DNS-CNAME resolution invalid. Reference: https://fposter.cn/doc/guide/dns.html?code=1361fd24380436d44ea
Please add the following DNS-CNAME resolution record (only needs to be configured once):

_acme-challenge.******.cn >> 043a438043a438d40c.httpsok.com
```

## Issue Feedback

Author's WeChat: Please mention `httpsok`

<p align="center"><img width="168" src="https://fposter.cn/dassets/qrcode.png" alt="httpsok logo"></p>
