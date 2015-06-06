#!/bin/bash
echo "Ande vamos pues:"
echo "h) home server"
echo "s) simone"
echo "b) briana"
echo "l) belladona"
echo "e) ecodes"
echo "p) panel"
echo "2) panel2"
echo "d) ns1"
echo "H) HL-mail"
echo "x) postfix"
echo "q) sesion local"
echo "b1) bifi srv1"
echo "b2) bifi srv2"
echo "b3) bifi srv3"
echo "b4) bifi srv4"
echo "b5) bifi database"
echo "b6) bifi monitor"
echo "b7) bifi webserver"
read case;
case $case in
    h) ssh 192.168.137.99;;
    s) ssh root@simone.traci.es;;
    b) ssh root@briana.traci.es;;
    l) ssh root@belladona.traci.es;;
    e) ssh root@ecodes.org;;
    d) ssh root@ns1.traci.es;;
    p) ssh root@panel.traci.es;;
    2) ssh root@panel2.traci.es;;
    H) ssh -p 22022 root@pound.hispalinux.es;;
    x) ssh root@correo.traci.es;;
    q) bash;;
    b1) ssh -i .ssh/id_rsa.bifi root@srv1.ibercivis.es ;;
    b2) ssh -i .ssh/id_rsa.bifi root@srv2.ibercivis.es ;;
    b3) ssh -i .ssh/id_rsa.bifi root@srv3.ibercivis.es ;;
    b4) ssh -i .ssh/id_rsa.bifi root@srv4.ibercivis.es ;;
    b5) ssh -i .ssh/id_rsa.bifi root@database.ibercivis.es ;;
    b6) ssh -i .ssh/id_rsa.bifi root@monitor.ibercivis.es ;;
    b7) ssh -i .ssh/id_rsa.bifi root@webserver.ibercivis.es ;;
esac

