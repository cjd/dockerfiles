FROM alpine:latest
RUN apk add --no-cache docker-cli jq
CMD while true;do docker network ls -f driver=bridge --format '{{.Name}}' |  xargs docker network inspect | jq '.[].Containers|.[]|[.IPv4Address,.Name]|@csv' |  sed 's#\/16##;s#\"##g;s#\\##g;s#,# #' | sed 's/$/.docker/g' > /piholedns.list; cat /etc/hosts /piholedns.list | sort -u > /etc/dockerhosts;sleep 10m; done
