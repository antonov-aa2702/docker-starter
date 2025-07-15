# my first image
ARG alpine_version=latest
FROM alpine:${alpine_version}
ARG buildno=1

WORKDIR /
WORKDIR app
WORKDIR build
# / + app + build = /app/build

RUN touch test.txt && echo "Hello World" >> test.txt
RUN apk add openjdk17
RUN cd .. \
    && wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.19/bin/apache-tomcat-10.1.19.tar.gz \
    && tar -xvzf apache-tomcat-10.1.19.tar.gz \
    && rm apache-tomcat-10.1.19.tar.gz
# /app/build/idea-new
COPY .idea idea-new
# *
COPY .idea/*.xml idea-new-xml/
COPY tomcat.tar.gz /app
ADD https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.19/bin/apache-tomcat-10.1.19.tar.gz tomcat-add.tar.gz

EXPOSE 8080
# entrypoint - to run executable
ENTRYPOINT ["/app/apache-tomcat-10.1.19/bin/catalina.sh"]
# cmd - to add params for prev executable
CMD ["run"]
# /app/apache-tomcat-10.1.19/bin/catalina.sh run -p debug
