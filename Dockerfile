FROM alpine
LABEL maintainer "Victor"

# Sets work directory, UID / GID and exposed ports
WORKDIR /opt/autosub-master
ARG USER_ID
ARG GROUP_ID
EXPOSE 9960/tcp

# Sets correct time zone
ENV TZ Europe/Amsterdam

# Installs dependencies and AutoSub
RUN apk update && apk add shadow python2 py2-cheetah py2-six && \
	wget https://github.com/BenjV/autosub/archive/master.zip && \
	unzip master.zip -d /opt && rm master.zip && \
	touch /opt/autosub-master/config.properties && \
	touch /opt/autosub-master/AutoSubService.log && \
	chown -R ${USER_ID}:${GROUP_ID} /opt/autosub-master

# Adds local user
RUN groupadd -g ${GROUP_ID} autosub && \
	useradd -lMN -u ${USER_ID} -g autosub autosub

# Runs AutoSub as local user
USER autosub
CMD [ "python", "AutoSub.py" ]
