FROM httpd:2.4
LABEL maintainer="Peter Stadler for the ViFE"

# For information about these parameters see 
# https://httpd.apache.org/docs/2.4/mod/mod_authnz_ldap.html
ARG AuthLDAPURL
ARG AuthLDAPBindDN
ARG AuthLDAPBindPassword
ARG RequireLDAPGroup

RUN apt-get update && apt-get --yes --force-yes --no-install-recommends install subversion libapache2-svn
COPY entrypoint.sh /my-docker-entrypoint.sh
RUN chmod 755 /my-docker-entrypoint.sh

WORKDIR /usr/local/apache2
RUN echo "Include conf/extra/vife.conf" >> conf/httpd.conf

VOLUME ["/var/svn"]
ENTRYPOINT ["/my-docker-entrypoint.sh"]
CMD ["httpd-foreground"]
