FROM        hasufell/gentoo-amd64-paludis:latest
MAINTAINER  Julian Ospald <hasufell@gentoo.org>

##### PACKAGE INSTALLATION #####

# copy paludis config
COPY ./config/paludis /etc/paludis

# install necessary overlays
RUN git clone --depth=1 https://github.com/hasufell/prism-overlay.git \
	/usr/prism-overlay
RUN chgrp paludisbuild /dev/tty && cave sync prism-overlay
RUN eix-update

# update world with our USE flags
RUN chgrp paludisbuild /dev/tty && cave resolve -c world -x

# install znc set
RUN chgrp paludisbuild /dev/tty && cave resolve -c zncset -x

# install tools set
RUN chgrp paludisbuild /dev/tty && cave resolve -c tools -x

# update etc files... hope this doesn't screw up
RUN etc-update --automode -5

################################

RUN mkdir -p /var/lib/znc
RUN chown znc:znc /var/lib/znc
WORKDIR /var/lib/znc

COPY ./config/supervisord.conf /etc/supervisord.conf

EXPOSE 9000

CMD exec /usr/bin/supervisord -n -c /etc/supervisord.conf
