#!/usr/bin/env zsh
cat << "EOF"

 _     _       _                _
| |__ (_) __ _| |__  _ __   ___| |_
| '_ \| |/ _` | '_ \| '_ \ / _ \ __|
| | | | | (_| | | | | | | |  __/ |_
|_| |_|_|\__, |_| |_|_| |_|\___|\__|
         |___/          shelljumpa

EOF
PS3='
select host:'
select item in \
"josh@lab.highnet" \
"josh@dns.highnet" \
"josh@box.highnet" \
"root@cat.highnet" \
"spongebob@bikinibottom"
do
     clear
     echo connecting to $item
     PS3='select connection type: '
     select type in "ssh" "sftp"
     do
          printf "additional $type arguments : "
          read args
          case "$type" in
               ssh ) clear && ssh $args $item ;;
               sftp ) clear && sftp $args $item ;;
               "")  select one of the above ;;
          esac
          exit 0
     done
     exit 0
done
