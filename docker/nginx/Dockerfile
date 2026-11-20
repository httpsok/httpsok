FROM nginx:1.31.3

LABEL maintainer="httpsok.com" \
      description="Nginx with HTTPSOK integration" \
      version="1.31.3"

ENV HTTPSOK_TOKEN=""

RUN apt-get update && \
    apt-get install --no-install-recommends -y cron procps && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]