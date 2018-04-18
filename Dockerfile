FROM openjdk:8-jre

# set up arg for app version
ARG APP_VERSION
ENV APP_VERSION=$APP_VERSION

# set maintainer
LABEL maintainer "mick_mcgrath2@apple.com"

RUN useradd --home-dir /home/hkr --create-home -U hkr
USER hkr
RUN cd /home/hkr/; mkdir -p .hkr
ADD build/libs/hello-karyon-rxnetty-all-${APP_VERSION}.jar /home/hkr/h-k-rx-all.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/home/hkr/h-k-rx-all.jar"]

# set a health check
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:8080 || exit 1

# tell docker what port to expose
EXPOSE 8080