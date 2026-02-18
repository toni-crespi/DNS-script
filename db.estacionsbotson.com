$TTL    60
@       IN      SOA     ns01.botson.com. admin.botson.com. (
                              2026020101 ; Serial
                              120        ; Refresh
                              60         ; Retry
                              86400      ; Expire
                              60 )       ; Negative Cache TTL
@       IN      NS      ns01.botson.com.
@       IN      NS      ns02.botson.com.
est01   IN      A       10.18.50.163
est02   IN      A       10.18.50.164
est03   IN      A       10.18.50.165
est04   IN      A       10.18.50.166
est05   IN      A       10.18.50.167
