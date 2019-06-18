# GANDHI RELOAD
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Èric Escribà

## SERVIDOR SSH

* En aquest apartat trobem la configuració per al servidor **SSH**. Servidor SSH  amb PAM amb autenticació AP de  kerberos i IP de ldap.

* Aquest servidor té la finalitat de poder establir connexions segures cap a la **xarxa interna** que té el desplegada el host amb els servidors.
 
* Aquest servidor ssh escolta al port **1022** i nomès permet l'acces als usuaris LDAP.

* Se li carrega el **volum** **/home** per poder tenir els directoris de treball dels usuaris.

### CONFIGURACIÓ

* Per tal de tenir aquest servidor, primer s'han d'instal·lar els pàquets bàsics d'autenticació i de treball:

```
krb5-workstation passwd pam_krb5 openldap-clients nss-pam-ldapd procps pam_mount openssh-clients openssh-server cifs-utils iputils
```

* A més a més hem de configurar el fitxer **sshd_config** que es troba a `/etc/ssh`:

```
#	$OpenBSD: sshd_config,v 1.101 2017/03/14 07:19:07 djm Exp $

# This is the sshd server system-wide configuration file.  See
# sshd_config(5) for more information.

# This sshd was compiled with PATH=/usr/local/bin:/usr/bin

# The strategy used for options in the default sshd_config shipped with
# OpenSSH is to specify options with their default value where
# possible, but leave them commented.  Uncommented options override the
# default value.

# If you want to change the port on a SELinux system, you have to tell
# SELinux about this change.
# semanage port -a -t ssh_port_t -p tcp #PORTNUMBER
#
# Port 22
#AddressFamily any
#ListenAddress 0.0.0.0
#ListenAddress ::

HostKey /etc/ssh/ssh_host_rsa_key
#HostKey /etc/ssh/ssh_host_dsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key

# Ciphers and keying
#RekeyLimit default none

# System-wide Crypto policy:
# If this system is following system-wide crypto policy, the changes to
# Ciphers, MACs, KexAlgoritms and GSSAPIKexAlgorithsm will not have any
# effect here. They will be overridden by command-line options passed on
# the server start up.
# To opt out, uncomment a line with redefinition of  CRYPTO_POLICY=
# variable in  /etc/sysconfig/sshd  to overwrite the policy.
# For more information, see manual page for update-crypto-policies(8).

# Logging
#SyslogFacility AUTH
SyslogFacility AUTHPRIV
#LogLevel INFO

# Authentication:

#LoginGraceTime 2m
PermitRootLogin yes
#StrictModes yes
#MaxAuthTries 6
#MaxSessions 10

#PubkeyAuthentication yes

# The default is to check both .ssh/authorized_keys and .ssh/authorized_keys2
# but this is overridden so installations will only check .ssh/authorized_keys
AuthorizedKeysFile	.ssh/authorized_keys

#AuthorizedPrincipalsFile none

#AuthorizedKeysCommand none
#AuthorizedKeysCommandUser nobody

# For this to work you will also need host keys in /etc/ssh/ssh_known_hosts
#HostbasedAuthentication no
# Change to yes if you don't trust ~/.ssh/known_hosts for
# HostbasedAuthentication
#IgnoreUserKnownHosts no
# Don't read the user's ~/.rhosts and ~/.shosts files
#IgnoreRhosts yes

# To disable tunneled clear text passwords, change to no here!
#PasswordAuthentication yes
#PermitEmptyPasswords no
PasswordAuthentication yes

# Change to no to disable s/key passwords
#ChallengeResponseAuthentication yes
ChallengeResponseAuthentication no

# Kerberos options
KerberosAuthentication yes
#KerberosOrLocalPasswd yes
KerberosTicketCleanup yes
#KerberosGetAFSToken no
KerberosUseKuserok yes

# GSSAPI options
GSSAPIAuthentication yes
GSSAPICleanupCredentials no
#GSSAPIStrictAcceptorCheck yes
#GSSAPIKeyExchange no
#GSSAPIEnablek5users no

# Set this to 'yes' to enable PAM authentication, account processing,
# and session processing. If this is enabled, PAM authentication will
# be allowed through the ChallengeResponseAuthentication and
# PasswordAuthentication.  Depending on your PAM configuration,
# PAM authentication via ChallengeResponseAuthentication may bypass
# the setting of "PermitRootLogin without-password".
# If you just want the PAM account and session checks to run without
# PAM authentication, then enable this but set PasswordAuthentication
# and ChallengeResponseAuthentication to 'no'.
# WARNING: 'UsePAM no' is not supported in Fedora and may cause several
# problems.
UsePAM yes

#AllowAgentForwarding yes
#AllowTcpForwarding yes
#GatewayPorts no
X11Forwarding yes
#X11DisplayOffset 10
#X11UseLocalhost yes
#PermitTTY yes
#PrintMotd yes
#PrintLastLog yes
#TCPKeepAlive yes
#UseLogin no
#PermitUserEnvironment no
#Compression delayed
#ClientAliveInterval 0
#ClientAliveCountMax 3
#ShowPatchLevel no
#UseDNS no
#PidFile /var/run/sshd.pid
#MaxStartups 10:30:100
#PermitTunnel no
#ChrootDirectory none
#VersionAddendum none

# no default banner path
#Banner none

# Accept locale-related environment variables
AcceptEnv LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES
AcceptEnv LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT
AcceptEnv LC_IDENTIFICATION LC_ALL LANGUAGE
AcceptEnv XMODIFIERS

# override default of no subsystems
Subsystem	sftp	/usr/libexec/openssh/sftp-server

# Example of overriding settings on a per-user basis
#Match User anoncvs
#	X11Forwarding no
#	AllowTcpForwarding no
#	PermitTTY no
#	ForceCommand cvs server

```

* Tenint això en marxa, falta generar les claus:

```
/usr/bin/ssh-keygen -A
```

* Finalment iniciem els serveis necessaris per al funcionament:

```
/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"
/usr/sbin/sshd && echo "ssh Ok"
```


### COMPROVACIÓ

```
ssh operador@192.168.2.44 -p 1022
operador@192.168.2.44's password: 

[operador@b5a558745a96 ~]$ ll
total 4
-rw-r--r-- 1 operador admin 33 Jun 18 15:51 welcome.md

[operador@b5a558745a96 ~]$ pwd
/home/grups/admin/operador

[operador@b5a558745a96 ~]$  ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
96: eth0@if97: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:1e:00:09 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.30.0.9/16 brd 172.30.255.255 scope global eth0
       valid_lft forever preferred_lft forever
[operador@b5a558745a96 ~]$ ping homes
PING homes (172.30.0.6) 56(84) bytes of data.
64 bytes from homes.edt.org.dockers_gandhi-net (172.30.0.6): icmp_seq=1 ttl=64 time=0.101 ms
64 bytes from homes.edt.org.dockers_gandhi-net (172.30.0.6): icmp_seq=2 ttl=64 time=0.065 ms
64 bytes from homes.edt.org.dockers_gandhi-net (172.30.0.6): icmp_seq=3 ttl=64 time=0.080 ms
^C
--- homes ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2049ms
rtt min/avg/max/mdev = 0.065/0.082/0.101/0.014 ms
```

* Usuari fora de LDAP: (Accès denegat)

```
ssh root@192.168.1.107 -p 1022
root@192.168.1.107's password: 
Permission denied, please try again.
root@192.168.1.107's password: 
Permission denied, please try again.
```

### ALTRES PUNTS

* Aquest servidor s'executa en mode **detach**

```
/usr/sbin/sshd -D
```

* En cas de voler ser **executat** sense cap altre component, és pot fer de la següent manera:


```
docker run --rm --name ssh.edt.org -h ssh.edt.org --network network_name --privileged --volumes-from homes.edt.org -d eescriba/sshserver:greload 
```

* El port d'accès al servidor es pot modificar pel que es vulgi.
