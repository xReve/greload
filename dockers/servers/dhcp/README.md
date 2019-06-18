# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

### SERVIDOR DHCP

* En aquest apartat del projecte està desenvolupat el servidor **DHCP**.

* Aquest servidor nomès és capaç de donar **IP** als clients que estàn dins de la mateixa xarxa que el servidor.

* Està configurat per ser executat en **detach**.

```
/usr/sbin/dhcpd -f
```

* Pel que respecta a la configuració, està configurat perquè actui sobre la interfície **eth0** i doni ips del rang **172.30.0.20 172.30.0.30**

* Aquest servidor funciona però no de la manera que s'esperava i estava enfocat.

cat `dhcpd.conf`

```
subnet 172.30.0.0 netmask 255.255.0.0 {
	range 172.30.0.20 172.30.0.30;
	option domain-name-servers 172.30.0.1;
	option domain-name "dhcp.edt.org";
	option routers 172.30.0.3;
	option broadcast-address 172.30.255.255;
}
```

* S'ha intentar configurar una altra subnet de la xarxa **192.168.x.x** però tampoc ha funcionat alhora d'assignar ip a un client.

* El client (fora de la xarxa del servidor) demana petició de **ip** al servidor però aquest no n'hi otorga cap.

* Part del projecte no acabada i pendent per millorar.
