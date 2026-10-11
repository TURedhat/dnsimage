#!/bin/bash
set -e

# 서버별 IP: 지정하지 않으면 HOST_IP(DNS를 실행하는 VM의 IP)를 사용
WEB_IP="${WEB_IP:-$HOST_IP}"
FTP_IP="${FTP_IP:-$HOST_IP}"
MAIL_IP="${MAIL_IP:-$HOST_IP}"
DB_IP="${DB_IP:-$HOST_IP}"

# 존 파일 템플릿의 자리표시자를 실제 IP로 치환
sed -e "s/__HOST_IP__/${HOST_IP}/g" \
    -e "s/__WEB_IP__/${WEB_IP}/g" \
    -e "s/__FTP_IP__/${FTP_IP}/g" \
    -e "s/__MAIL_IP__/${MAIL_IP}/g" \
    -e "s/__DB_IP__/${DB_IP}/g" \
    /usr/local/share/dns/team.test.zone.tpl > /var/named/team.test.zone
chown root:named /var/named/team.test.zone
chmod 640 /var/named/team.test.zone

# 문법 검사 (실패하면 컨테이너가 종료되고 docker logs에 원인이 남음)
named-checkconf /etc/named.conf
named-checkzone team.test /var/named/team.test.zone

# named를 foreground(-g)로 실행
exec /usr/sbin/named -g -u named

