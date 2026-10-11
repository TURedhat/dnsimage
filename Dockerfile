# DNS 서버 이미지 (BIND)
FROM quay.io/centos/centos:10

# 1) 서버 패키지 설치 (bind-utils: dig, named-checkzone 등)
RUN dnf -y install bind bind-utils && dnf clean all

# 2) named 실행에 필요한 디렉토리
RUN mkdir -p /run/named /var/named/data \
 && chown named:named /run/named /var/named/data

# 3) 주 설정 파일 복사 + 권한
COPY named.conf /etc/named.conf
RUN chown root:named /etc/named.conf && chmod 640 /etc/named.conf

# 4) 존 파일 템플릿 + 실행 스크립트
COPY team.test.zone.tpl /usr/local/share/dns/team.test.zone.tpl
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 5) DNS 서버가 실행되는 VM의 IP (docker run -e HOST_IP=... 로 변경)
ENV HOST_IP=192.168.10.10

# DNS는 UDP/TCP 53번 포트를 모두 사용
EXPOSE 53/udp 53/tcp

ENTRYPOINT ["/entrypoint.sh"]

