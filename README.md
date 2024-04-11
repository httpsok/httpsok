<p align="center"><a href="https://httpsok.com/doc/" target="_blank"><img width="168" src="https://httpsok.com/dassets/httpsok-logo.png" alt="httpsok logo"></a></p>

<p align="center">
  <a href="https://github.com/httpsok/httpsok" class="link github-link" target="_blank"><img style="max-width: 100px; max-height: 30px;" alt="GitHub Repo stars" src="https://img.shields.io/github/stars/httpsok/httpsok?style=social"></a>
  <a href="https://gitee.com/httpsok/httpsok" class="link gitee-link" target="_blank"><img style="max-width: 100px; max-height: 30px;" alt="gitee Repo stars" src="https://gitee.com/httpsok/httpsok/badge/star.svg"></a>
  <img style="max-width: 100px; max-height: 30px;" alt="csharp" src="https://img.shields.io/badge/language-shell-brightgreen.svg">
  <img style="max-width: 100px; max-height: 30px;"alt="license" src="https://img.shields.io/badge/license-MIT-blue.svg">
  <img style="max-width: 100px; max-height: 30px;"alt="version" src="https://img.shields.io/badge/version-1.9.2-brightgreen">
</p>

## 介绍

**httpsok** 是一个便捷的 HTTPS 证书自动续签工具，专为 Nginx 、OpenResty 服务器设计。已服务众多中小企业，**稳定**、**安全**、**可靠**。

**一行命令，一分钟轻松搞定SSL证书自动续期**

## 文档

- 官方帮助文档地址：[https://httpsok.com/doc/](https://httpsok.com/doc/)

## 特性

- **⚡️ 简单高效** 一行命令，一分钟轻松搞定SSL证书自动续签
- **✅ 自动检测** 无需关心nginx配置，自动识别证书配置，适合老旧系统、复杂配置的生产环境
- **✅ 泛解析、多域名、多服务器** 轻松搞定
- **✅ 证书监控** 对于即将失效的证书，提供公众号推送提醒
- **✅ 兼容性好** 兼容主流的Linux系统 `Debain` `CentOS` `Ubuntu` `TencentOS` 等
- **✅ 支持手动申请** 支持手动申请证书，所见即所得。

## 快速开始

只需二步，轻松搞定SSL证书自动续签。

### 一、安装httpsok

登陆控制台 👉 👉 👉 **[获取token](https://httpsok.com/?p=4c9n)**

```bash
curl -s https://get.httpsok.com | bash -s 'your token'
```

安装成功后，脚本会自动检测一次系统中的`nginx`证书。

### 二、DNS解析配置

**根据脚本运行的实际情况**，添对应的的DNS解析记录。[DNS解析配置参考](https://httpsok.com/doc/guide/dns.html)

![httsok的DNS解析配置示例](https://httpsok.com/dassets/image-20240314024435126.png)

### 三、完成

没错，已经结束，SSL证书自动续签就这么简单。快登录控制台查看自己的证书吧。


![控制台-证书管理](https://httpsok.com/dassets/image-20240412020032142.png)

## 问题反馈

欢迎大家添加作者微信，共同交流一些技术、想法。

作者微信 请备注 `httpsok`

<img width="168" src="https://httpsok.com/dassets/qrcode.png" alt="httpsok logo">
