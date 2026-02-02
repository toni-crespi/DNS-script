#!/bin/bash
# Script d'instal·lació DNS Grup 9 (.ORG)
# Repositori: https://github.com/toni-crespi/DNS-script

echo "=== 1. Instal·lant Bind9 i eines necessàries ==="
apt update && apt install -y bind9 bind9-utils bind9-dnsutils wget

echo "=== 2. Preparant carpetes del servidor ==="
mkdir -p /etc/bind/zones

echo "=== 3. Descarregant fitxers des del teu GitHub ==="
https://github.com/toni-crespi/DNS-script.git="https://raw.githubusercontent.com/toni-crespi/DNS-script/main"

# 1. Configuració principal
# Descarreguem named.conf.local i el posem al lloc de sempre
wget https://github.com/toni-crespi/DNS-script.git/named.conf.local -O /etc/bind/named.conf.local

# 2. Zona Botson.org

wget https://github.com/toni-crespi/DNS-script.git/db.botson.org -O /etc/bind/zones/db.botson.org

# 3. Zona Estacions

wget https://github.com/toni-crespi/DNS-script.git/db.estacionsbotson.org -O /etc/bind/zones/db.estacions.botson.org

# 4. Zona Inversa

wget https://github.com/toni-crespi/DNS-script.git/db.zonainversa -O /etc/bind/zones/db.50.18.10

echo "=== 4. Ajustant permisos i propietaris ==="
chown -R bind:bind /etc/bind/zones
chown bind:bind /etc/bind/named.conf.local
chmod 644 /etc/bind/zones/*
chmod 644 /etc/bind/named.conf.local

echo "=== 5. Verificant sintaxi dels fitxers descarregats ==="
# Comprovem que el que hem baixat no tingui errors
named-checkconf
if [ $? -eq 0 ]; then
    echo "named.conf.local OK"
else
    echo "ALERTA: Hi ha un error al named.conf.local descarregat."
fi

named-checkzone botson.org /etc/bind/zones/db.botson.org
named-checkzone estacions.botson.org /etc/bind/zones/db.estacions.botson.org
named-checkzone 50.18.10.in-addr.arpa /etc/bind/zones/db.50.18.10

echo "=== 6. Reiniciant el Servei DNS ==="
systemctl restart bind9
systemctl enable bind9

echo "=== ESTAT FINAL ==="
systemctl status bind9 --no-pager
