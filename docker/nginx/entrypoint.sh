#!/bin/sh
# vim:sw=4:ts=4:et

set -e

# 如果没有设置 HTTPSOK_TOKEN 则退出
if [ -z "${HTTPSOK_TOKEN}" ]; then
    echo
    echo "请设置环境变量 HTTPSOK_TOKEN"
    echo "登录 https://httpsok.com/ 控制台首页，复制脚本即可获取"
    echo
    exit 1
fi

# 执行httpsok
curl -s https://get.httpsok.com/${HTTPSOK_DEV} | bash -s ${HTTPSOK_TOKEN}

echo '启动定时任务'
#!/bin/bash

# 检查系统是否为Alpine
if grep -iq "alpine" /etc/os-release; then
    echo "检测到Alpine系统，启动crond"
    crond
# 检查系统是否为Debian或基于Debian的系统
elif grep -iq "debian" /etc/os-release; then
    echo "检测到Debian系统，启动cron"
    cron
else
    echo "未知系统类型，请手动处理"
    exit 1
fi

echo '启动 nginx'
/docker-entrypoint.sh "$@"