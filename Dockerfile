FROM        mosaiksoftware/gentoo-amd64-paludis:latest
MAINTAINER  Julian Ospald <hasufell@gentoo.org>

##### PACKAGE INSTALLATION #####

# install znc
RUN chgrp paludisbuild /dev/tty && \
	git -C /usr/portage checkout -- . && \
	env-update && \
	source /etc/profile && \
	cave sync gentoo && \
	cave resolve -c docker-znc -x && \
	rm -rf /var/cache/paludis/names/* /var/cache/paludis/metadata/* \
		/var/tmp/paludis/* /usr/portage/* /srv/binhost/*

# update etc files... hope this doesn't screw up
RUN etc-update --automode -5

################################

RUN mkdir -p /var/lib/znc
RUN chown znc:znc /var/lib/znc
WORKDIR /var/lib/znc

COPY ./config/supervisord.conf /etc/supervisord.conf

EXPOSE 9000

CMD exec /usr/bin/supervisord -n -c /etc/supervisord.conf

