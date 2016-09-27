# Все пакеты, уходящие на 192.168.0.6 го перенаправить на сами видите куда.
sudo iptables -t nat -A OUTPUT -p tcp -d 192.168.0.6 -j DNAT --to-destination 172.18.168.16
