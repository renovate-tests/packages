FROM ubuntu:20.10

ENV LANG C.UTF-8

RUN echo "Europe/Brussels" > /etc/timezone

# Add builder
RUN apt-get --yes update \
	&& DEBIAN_FRONTEND=noninteractive apt-get --yes install \
	make debhelper git-buildpackage binutils-arm-linux-gnueabihf apt-utils rsync

# Set the working directory to /app
WORKDIR /app

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT [ "/start.sh" ]
