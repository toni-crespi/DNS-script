echo "=== Instal·lant Bind9 ==="
apt update && apt install -y bind9 bind9utils bind9-doc wget

echo "=== Creant carpeta de zones a /etc/bind/zones ==="
mkdir -p /etc/bind/zones

echo "=== Descarregant fitxers de configuració des de GitHub ==="

# Descarreguem zona botson.org
wget https://raw.githubusercontent.com/toni-crespi/DNS-script/main/db.botson.com -O /etc/bind/zones/db.botson.com

# Descarreguem zona estacions (Compte: al teu GitHub es diu 'db.estacionsbotson.org')
wget https://raw.githubusercontent.com/toni-crespi/DNS-script/main/db.estacionsbotson.com -O /etc/bind/zones/db.estacions.botson.com

# Descarreguem zona inversa (Compte: al teu GitHub es diu 'db.zonainversa')
wget https://raw.githubusercontent.com/toni-crespi/DNS-script/main/db.zonainversa -O /etc/bind/zones/db.50.18.10

# Descarreguem configuració general
wget https://raw.githubusercontent.com/toni-crespi/DNS-script/main/named.conf.local -O /etc/bind/named.conf.local

echo "=== Comprovant sintaxi ==="
named-checkconf
named-checkzone botson.com /etc/bind/zones/db.botson.com
named-checkzone estacions.botson.com /etc/bind/zones/db.estacions.botson.com
named-checkzone 50.18.10.in-addr.arpa /etc/bind/zones/db.50.18.10

echo "=== Reiniciant Bind9 ==="
systemctl restart bind9
systemctl enable bind9
systemctl status bind9
