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
	rm -rf /var/lib/apt/lists/* 

WORKDIR /root

COPY  startup.sh /root/MT4/
COPY  supervisord.conf /root/MT4/
COPY  MT4 /root/MT4
ENV DISPLAY=:1
EXPOSE 5900
WORKDIR /root/MT4/
ENTRYPOINT ["./startup.sh"]
