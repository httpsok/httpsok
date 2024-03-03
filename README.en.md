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

- **Easy to use:** One command, effortlessly manage SSL certificate automatic renewal.
- **Certificate auto-updating and automatic renewal.**
- **Seamless integration:** No need to modify Nginx configuration, especially suitable for smooth transitions in old systems and online business operations.
- **Support for wildcard domains.**
- **Support for multiple domains and multiple server nodes.**
- **Certificate monitoring feature:** Provides WeChat public account push reminders for certificates about to expire.
- **Compatible with mainstream Linux systems.**
- **Trusted by numerous small and medium-sized enterprises for its stability, security, and reliability.**

# Quick Start

## Install httpsok

```bash
curl -s https://fposter.cn/httpsok.sh | bash -s 'your token'
```


> Login to the console 👉 👉 [获取token](https://fposter.cn/console/)

## Installation Success

After successful installation, it will automatically check the `nginx` certificates in the system.

```bash
2024-01-21 00:22:56 os-name: TencentOS Server 2.4
2024-01-21 00:22:56 version: nginx/1.20.1
2024-01-21 00:22:56 nginx-config-home: /etc/nginx

Httpsok makes SSL easy.     https://fposter.cn/ 
version: 1.8.0
home: /root/.httpsok

2024-01-21 00:22:57 DNS check pass
2024-01-21 00:22:57 cdb8e6b945154127 /etc/nginx/certs/api.fastposter.net_nginx/api.fastposter.net_bundle.crt Cert valid
2024-01-21 00:22:58 e29c94e6c2504f37 /etc/nginx/certs/cloud.fastposter.net_nginx/cloud.fastposter.net_bundle.crt Cert valid
2024-01-21 00:22:58 32614897bc364812 /etc/nginx/certs/fastposter.net_nginx/fastposter2.net_bundle.crt Cert valid
2024-01-21 00:22:58 7b9be1c745cb41f8 /etc/nginx/certs/fposter.cn_nginx/fposter.cn_bundle.crt Cert valid

2024-01-21 00:22:58 Nginx reload needless.
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

Author's WeChat: Please mention `来自httpsok`

<p align="center"><img width="168" src="https://fposter.cn/dassets/qrcode.png" alt="httpsok logo"></p>
