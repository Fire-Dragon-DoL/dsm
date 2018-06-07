FROM dsm/ubuntu:latest

ENV LANG C.UTF-8

WORKDIR /app
RUN  /app/bin/dsm setup \
  && cp -r "/app/build" "/app/deb/opt/dsm/build"

RUN  cp -r "/app/bin" "/app/deb/opt/dsm/bin" \
  && cp -r "/app/lib" "/app/deb/opt/dsm/lib" \
  && cp -r "/app/templates" "/app/deb/opt/dsm/templates" \
  && cp "/app/VERSION" "/app/deb/opt/dsm/VERSION" \
  && rm -f "/app/deb/opt/dsm/.keep" \
  && rm -rf "/app/deb/opt/dsm/deb"

RUN app_version="$(cat /app/VERSION)" \
  && mv deb dsm \
  && sed -i -e "s/__VERSION__/${app_version}/g" /app/dsm/DEBIAN/control \
  && dpkg-deb --build dsm

