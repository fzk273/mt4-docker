FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive 
 

RUN apt-get update &&\
	apt-get install -y supervisor \
		xfce4 xfce4-goodies \
		x11vnc xvfb \
		pwgen wine-stable && \
	dpkg --add-architecture i386 && \
	apt-get update && \
	apt-get install -y wine32 && \
	apt-get autoclean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/* && \
	useradd --shell /bin/bash --uid "1010" --password "" appuser


WORKDIR /root

COPY --chown=appuser:appuser startup.sh /home/appuser/MT4/
COPY --chown=appuser:appuser supervisord.conf /home/appuser/MT4/
COPY --chown=appuser:appuser MT4 /home/appuser/MT4
USER appuser
ENV DISPLAY=:1
EXPOSE 5900
WORKDIR /home/appuser/MT4/
ENTRYPOINT ["./startup.sh"]
