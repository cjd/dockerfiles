FROM alpine:latest
LABEL org.opencontainers.image.source=https://github.com/cjd/dockerfiles
RUN apk add --no-cache bind-tools
CMD while true;do rm /tmphosts; for N in `seq 1 255`;do IP=${NET}.${N}; NAME=`dig @${DNS} -x $IP +short | cut -f1 -d'.'`;if [ -n "$NAME" ];then echo $IP $NAME ${NAME}.${LOCALDOMAIN} >> tmphosts;fi;done;cat /tmphosts > /hosts;sleep 10m;done;
