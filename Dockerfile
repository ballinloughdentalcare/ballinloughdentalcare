# WORK IN PROGRESS
# Dockerfile in case I move from Heroku

FROM bjjb/nodejs

MAINTAINER JJ Buckley <jj@bjjb.org>

ENV APPNAME ballinloughdentalcare
ENV APPHOME /var/www/ballinloughdentalcare
ENV PORT 5000
ENV ENV production

RUN adduser $APPNAME \
            --group www \
            --home $APPHOME \
            --shell /bin/bash \
            --disabled-password

ADD . /var/www/$APPNAME

WORKDIR /var/www/$APPNAME

USER $APPNAME
WORKDIR /var/www/$APPNAME

EXPOSE $PORT

CMD npm start
