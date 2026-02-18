$TTL    604800
@       IN      SOA     ns01.botson.com. admin.botson.com. (
                              2026020101 ; Serial
                              604800     ; Refresh
                              86400      ; Retry
                              2419200    ; Expire
                              604800 )   ; Negative Cache TTL
@       IN      NS      ns01.botson.com.
@       IN      NS      ns02.botson.com.
@       IN      MX  10  mail01.botson.com.
@       IN      MX  10  mail02.botson.com.
ns01    IN      A       192.168.146.4
ns02    IN      A       192.168.146.5
mail01  IN      A       192.168.146.6
mail02  IN      A       192.168.146.7
web     IN      A       192.168.146.8
file    IN      A       192.168.146.9
www     IN      CNAME   web.botson.com.
ftp     IN      CNAME   file.botson.com.
estacions IN    NS      ns01.botson.com.
estacions IN    NS      ns02.botson.com.
