<p align="center"><a href="https://fposter.cn/doc/" target="_blank"><img width="168" src="https://fposter.cn/dassets/httpsok-logo.png" alt="httpsok logo"></a></p>

<p align="center">
  <a href="https://github.com/httpsok/httpsok" class="link github-link" target="_blank"><img style="max-width: 100px; max-height: 30px;" alt="GitHub Repo stars" src="https://img.shields.io/github/stars/httpsok/httpsok?style=social"></a>
  <a href="https://gitee.com/httpsok/httpsok" class="link gitee-link" target="_blank"><img style="max-width: 100px; max-height: 30px;" alt="gitee Repo stars" src="https://gitee.com/httpsok/httpsok/badge/star.svg"></a>
  <img style="max-width: 100px; max-height: 30px;" alt="csharp" src="https://img.shields.io/badge/language-shell-brightgreen.svg">
  <img style="max-width: 100px; max-height: 30px;"alt="license" src="https://img.shields.io/badge/license-MIT-blue.svg">
  <img style="max-width: 100px; max-height: 30px;"alt="version" src="https://img.shields.io/badge/version-1.8.1-brightgreen">
</p>

## 介绍

**httpsok** 是一个便捷的 HTTPS 证书自动续签工具，专为 Nginx、OpenResty 服务器设计。已服务众多中小企业，**稳定**、**安全**、**可靠**。

**一行命令，一分钟轻松搞定SSL证书自动续期**

## 文档

- 官方帮助文档地址：[https://fposter.cn/doc/](https://fposter.cn/doc/)

## 特性

- **⚡️ 简单高效** 一行命令，一分钟轻松搞定SSL证书自动续签
- **✅ 自动检测** 无需关心nginx配置，自动识别证书配置，适合老旧系统、复杂配置的生产环境
- **✅ 泛解析、多域名、多服务器** 轻松搞定
- **✅ 证书监控** 对于即将失效的证书，提供公众号推送提醒
- **✅ 兼容性好** 兼容主流的Linux系统也支持Docker环境运行

## 快速开始

只需二步，轻松搞定SSL证书自动续签。

### 一、安装httpsok

登陆控制台 👉 👉 👉 **[获取token](https://fposter.cn/console/)**

```bash
curl -s https://fposter.cn/httpsok.sh | bash -s 'your token'
```

安装成功后，会自动检测一次系统中的`nginx`证书。

```bash
Httpsok make SSL easy.     https://fposter.cn/ 
version: 1.8.1
TraceID: 92592593890e8a442be7f50c7ddc5d2d
home: /root/.httpsok

2024-03-04 04:54:24 DNS check pass
2024-03-04 04:54:24 ee262ecba47d4173 /etc/nginx/certs/fposter.cn_nginx/fposter.cn_bundle.crt Cert valid

2024-03-04 04:54:24 Nginx reload needless.
```


### 二、DNS解析配置

添加一条类型为 **CNAME** 的DNS解析记录，**只需添加一次即可**。

添加成功后请稍等1分钟左右（DNS生效需要一点时间），再次运行安装脚本即可。

```bash
DNS-CNAME解析无效 参考：https://fposter.cn/doc/guide/dns.html
请添以下DNS-CNAME解析记录（只需配置一次即可）: 

_acme-challenge.yourdomain.com >> 043a438043a438d40c.httpsok.com
```

[DNS解析配置参考](https://fposter.cn/doc/guide/dns.html)

### 三、完成

没错，已经结束了，SSL证书自动续签就这么简单。

## 问题反馈

欢迎大家添加作者微信，共同交流一些技术、想法。

作者微信 请备注 `httpsok`

<img width="168" src="https://fposter.cn/dassets/qrcode.png" alt="httpsok logo">
