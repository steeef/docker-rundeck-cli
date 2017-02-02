FROM openjdk:8
MAINTAINER Stephen Price <stephen@stp5.net>

ENV RDECK_VER=2.7.1 \
    RDECK_BASE=/rundeck \
    PATH=/rundeck/tools/bin:${PATH} \
    RDECK_UID=350 \
    RDECK_GID=350

RUN groupadd -r -g ${RDECK_GID} rundeck \
    && useradd -r -g rundeck -u ${RDECK_UID} -m -d ${RDECK_BASE} rundeck \
    && curl -sL -o ${RDECK_BASE}/rundeck.jar \
       https://dl.bintray.com/rundeck/rundeck-maven/rundeck-launcher-${RDECK_VER}.jar

USER rundeck

WORKDIR ${RDECK_BASE}

EXPOSE 4440

CMD ["java", "-jar", "rundeck.jar"]
