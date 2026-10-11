$TTL 1H
@       IN SOA  ns1.team.test. root.team.test. (
                        10      ; serial
                        1D      ; refresh
                        1H      ; retry
                        1W      ; expire
                        3H )    ; minimum

;; (0) DNS Server
team.test.      IN  NS  ns1.team.test.
ns1             IN  A   __HOST_IP__

;; (1) WEB Server
www             IN  A   __WEB_IP__

;; (2) FTP Server
ftp             IN  A   __FTP_IP__

;; (3) MAIL Server
team.test.      IN  MX  10  mail.team.test.
mail            IN  A   __MAIL_IP__

;; (4) DB Server
db              IN  A   __DB_IP__

;; (5) etc
cafe            IN  CNAME   www
