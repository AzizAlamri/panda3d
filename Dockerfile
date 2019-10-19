FROM ubuntu:16.04
MAINTAINER Hunter Ray <docker@judge.sh>

ENV DEBIAN_FRONTEND=noninteractive

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y locales > /dev/null

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8 

RUN apt-get update && apt-get install -y software-properties-common > /dev/null
RUN add-apt-repository ppa:jonathonf/python-2.7
RUN apt-get update && apt-get install -y \
  bison \
  build-essential \
  curl \
  flex \
  git \
  libbullet-dev \
  libcurl4-openssl-dev \
  libeigen3-dev \
  libfreetype6-dev \
  libgl1-mesa-dev \
  libgtk2.0-dev \
  libjpeg-dev \
  libode-dev \
  libopenal-dev \
  libpng-dev \
  libssl-dev \
  libtiff-dev \
  libvorbis-dev \
  libx11-dev \
  libxcursor-dev \
  libxrandr-dev \
  libxxf86dga-dev \
  nvidia-cg-toolkit \
  patchelf \
  python2.7-dev \
  python-setuptools \
  tzdata \
  zlib1g-dev \
   > /dev/null
RUN easy_install pip
RUN pip install sentry-sdk faulthandler requests pymongo pyyaml semidbm six pytest pycurl pycrypto ddtrace

COPY . /build
WORKDIR /build

RUN python makepanda/makepanda.py --everything --no-contrib --no-fmodex --no-physx --no-bullet --no-pview  --no-swscale --no-swresample --no-speedtree --no-vrpn --no-artoolkit --no-opencv --no-directcam --no-vision --no-rocket --no-awesomium --no-deploytools --no-skel --no-ffmpeg --no-eigen --no-assimp --no-gles --no-gles2 --no-egl --no-gtk --installer
RUN dpkg -i *.deb
