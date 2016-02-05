## Installation

```sh
docker build -t mosaiksoftware/gentoo-znc .
```

## Configuration

All znc data including configuration is located at `/var/lib/znc/`. You
definitely want to mount this in from the host or create a data volume
container for it.

Since znc configuration is complex, you are required to create all relevant
config files yourself at that location `/var/lib/znc/` or use the interactive
method from the ebuild, e.g.:

```sh
docker run -ti \
	-v <folder-on-host>:/var/lib/znc \
	hasufell/gentoo-znc \
	/usr/bin/znc --system-wide-config-as znc -c -r -d /var/lib/znc
```

Also make sure the permissions on `/var/lib/znc/` are `znc:znc`.

### Certificates

Mount in your pem file from the host into the container, e.g. at `/etc/ssl/znc`,
and then make sure it is correctly set in `/var/lib/znc/configs/znc.conf`
(SSLCertFile = ...).

## Running

A full command could look like this:

```sh
docker run -ti -d \
	--name=znc \
	-v <config-folder>:/var/lib/znc \
	-v <cert-folder>:/etc/ssl/znc \
	-p 9000:9000 \
	mosaiksoftware/gentoo-znc
```


