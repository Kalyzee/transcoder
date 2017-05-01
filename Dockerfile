FROM kalyzee/nginx-rtmp


RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y --force-yes install autoconf automake build-essential libass-dev libfreetype6-dev \
  libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev \
  libxcb-xfixes0-dev pkg-config texinfo zlib1g-dev libx264-dev libmp3lame-dev libopus-dev yasm

RUN cd /tmp && wget http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-1.5.0.tar.bz2 && tar xjvf libvpx-1.5.0.tar.bz2
RUN cd /tmp/libvpx-1.5.0 && ./configure --disable-examples --disable-unit-tests && make && make install && make clean

RUN cd /tmp && wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && tar xjvf ffmpeg-snapshot.tar.bz2
RUN cd /tmp/ffmpeg && ./configure   --enable-gpl \
  --enable-libass \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-nonfree && make && make install

CMD /usr/local/nginx/sbin/nginx -c "/data/conf/nginx.conf" -g 'daemon off;'

EXPOSE 1935
