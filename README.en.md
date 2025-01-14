<p align="center"><a href="https://httpsok.com/doc/" target="_blank"><img width="168" src="https://cdn.httpsok.com/doc/assets/httpsok-logo.png" alt="httpsok logo"></a></p>

<p align="center">
  <a href="https://github.com/httpsok/httpsok" class="link github-link" target="_blank"><img style="max-width: 100px; max-height: 30px;" alt="GitHub Repo stars" src="https://img.shields.io/github/stars/httpsok/httpsok?style=social"></a>
  <a href="https://gitee.com/httpsok/httpsok" class="link gitee-link" target="_blank"><img style="max-width: 100px; max-height: 30px;" alt="gitee Repo stars" src="https://gitee.com/httpsok/httpsok/badge/star.svg"></a>
  <img style="max-width: 100px; max-height: 30px;" alt="csharp" src="https://img.shields.io/badge/language-shell-brightgreen.svg">
  <img style="max-width: 100px; max-height: 30px;"alt="license" src="https://img.shields.io/badge/license-MIT-blue.svg">
  <img style="max-width: 100px; max-height: 30px;"alt="version" src="https://img.shields.io/badge/version-1.18.0-brightgreen">
</p>

## Introduction

**httpsok** is a convenient HTTPS certificate auto-renewal tool, based on a brand-new design concept, specifically built for servers such as `Nginx`, `OpenResty`, and `Apache`. It has already served numerous small and medium-sized enterprises, offering **stability**, **security**, and **reliability**.

**One command, easily renew SSL certificates in one minute.**

## Documentation

- Official help documentation: [https://httpsok.com/doc/](https://httpsok.com/doc/)

## Features

- **⚡️ Simple and Efficient** One command, easily renew SSL certificates in one minute.
- **✅ Auto Detection** No need to worry about nginx configuration. Automatically detects certificate configurations, suitable for older systems and complex production environments.
- **✅ Wildcard Domains, Multiple Domains, Multiple Servers** Easily handle.
- **✅ Certificate Monitoring** Provides push notifications via WeChat for certificates that are about to expire.
- **✅ Good Compatibility** Compatible with mainstream Linux systems such as `Debian`, `CentOS`, `Ubuntu`, `TencentOS`, and `Docker container` environments.
- **✅ Manual Certificate Request Support** Supports manual certificate requests.
- **✅ Easy Integration with CDN, LB, OSS** Supports major cloud providers.

## Quick Start

Just two steps to easily renew SSL certificates.

### 1. Install httpsok

Log in to the PC control panel 👉 👉 👉 **[Get Installation Command](https://httpsok.com/p/4c9n)**, then run it on your server.

![httsok.com Control Panel - Copy and execute installation command](https://cdn.httpsok.com/doc/assets/guide/image-20241124012814210.png)

After installation, the script will automatically detect the `nginx` certificate on the system and sync it to the control panel.

### 2. DNS Configuration

**According to the actual situation of the script**, add the corresponding DNS records. [DNS configuration reference](https://httpsok.com/doc/guide/dns.html)

![httsok-DNS Configuration Example](https://cdn.httpsok.com/doc/assets/guide/image-20250115041129964.png)

### 3. Done

That's it. The SSL certificate auto-renewal is that simple. Log in to the **[Control Panel](https://httpsok.com/?p=4c9n)** to check your certificate.

![httsok Control Panel - Certificate Management](https://cdn.httpsok.com/doc/assets/guide/image-20241029115047877.png)

## Feedback

Contact the author via WeChat with the note `httpsok`.

<img width="168" src="https://cdn.httpsok.com/doc/assets/qrcode.png" alt="httpsok logo">
