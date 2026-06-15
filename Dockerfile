FROM alpine

# coreutils provides GNU `timeout`, which accepts suffixed durations like
# `30m`/`1h`. BusyBox's built-in timeout only accepts plain seconds and would
# make every `timeout $TIME_OUT git ...` call fail.
RUN apk add --no-cache git openssh-client bash jq curl coreutils && \
  echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

ADD *.sh /

RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]