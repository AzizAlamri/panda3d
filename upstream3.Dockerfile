FROM ubuntu:20.04
MAINTAINER Hunter Ray <docker@judge.sh>

ENV DEBIAN_FRONTEND=noninteractive

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN echo "deb http://azure.archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://azure.archive.ubuntu.com/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://azure.archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    apt-get update && apt-get install -y locales software-properties-common sudo > /dev/null

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8 

RUN apt-get install -y --no-install-recommends \
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
  libjpeg-dev \
  libode-dev \
  libopenal-dev \
  libpng-dev \
  libssl-dev \
  libtiff-dev \
  libvorbis-dev \
  nvidia-cg-toolkit \
  patchelf \
  python-setuptools \
  tzdata \
  zlib1g-dev \
  libpython3-dev \
  python3-dev \
  python3-pip \
  python3-apport \
  fakeroot && \
  apt-get clean && \
  update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1
RUN pip install sentry-sdk requests pymongo pyyaml semidbm six pytest pycurl pycrypto ddtrace[profiling]

COPY astronpanda3d /build
WORKDIR /build

RUN python3 makepanda/makepanda.py --threads $(nproc --all) --everything --no-contrib --no-fmodex --no-physx --no-bullet --no-pview  --no-swscale --no-swresample --no-speedtree --no-vrpn --no-artoolkit --no-opencv --no-directcam --no-vision --no-rocket --no-awesomium --no-deploytools --no-skel --no-ffmpeg --no-eigen --no-assimp --no-gles --no-gles2 --no-egl --no-gtk --installer && \
    dpkg -i *.deb && \
    rm -rf built && \
    rm -rf *.deb
