FROM steeef/go-rundeck
MAINTAINER Stephen Price <stephen@stp5.net>

RUN apk --update add bash
RUN mkdir /bundle
WORKDIR /bundle
COPY rundeck.sh /bundle/
RUN chmod +x /bundle/rundeck.sh

ENTRYPOINT ["/bundle/rundeck.sh"]
