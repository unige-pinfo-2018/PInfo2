FROM jboss/wildfly:latest

ADD ./mysql-connector-java-5.1.45-bin.jar ./config_wildfly.sh ./academi-co-realm-roles.properties ./academi-co-realm-users.properties /opt/jboss/wildfly/
RUN  sed -i_back 's/\r//g' /opt/jboss/wildfly/config_wildfly.sh

USER root
RUN groupadd -r wildfly-logs -g 433 && \
useradd -u 431 -r -g wildfly-logs -s /sbin/nologin -c "WildFly container logs" wildfly-logs

RUN mkdir -p /opt/jboss/wildfly/standalone/deployments
RUN chown wildfly-logs:wildfly-logs /opt/jboss/wildfly/standalone/deployments

RUN ["/opt/jboss/wildfly/config_wildfly.sh"]
RUN rm -rf  /opt/jboss/wildfly/standalone/configuration/standalone_xml_history
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "--debug", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

EXPOSE 8080
EXPOSE 8443
EXPOSE 8787
EXPOSE 9990
