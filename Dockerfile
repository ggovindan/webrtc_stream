FROM restreamio/gstreamer:latest-prod-dbg

RUN apt-get update \
  && apt-get install -y ssh \
      build-essential gcc g++ gdb libglib2.0-dev libunwind-dev libdw-dev \
      clang cmake rsync tar python3 \
      cmake git pkg-config libgtk-3-dev \
      libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
      libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
      gfortran openexr libatlas-base-dev python3-dev python3-numpy \
      libtbb2 libtbb-dev libdc1394-22-dev python3-dev libgirepository1.0-dev \
      libcairo2-dev python3-gi libcairo2-dev gir1.2-gstreamer-1.0 libtool python-gi-dev \
      python3 python3-pip python3-setuptools python3-wheel ninja-build vim rsync \
  && apt-get clean

RUN git clone https://github.com/jackersson/gstreamer-python.git
RUN git clone https://github.com/jackersson/gst-plugins-tf.git

RUN ( \
    echo 'LogLevel DEBUG2'; \
    echo 'PermitRootLogin yes'; \
    echo 'PasswordAuthentication yes'; \
    echo 'Subsystem sftp /usr/lib/openssh/sftp-server'; \
  ) > /etc/ssh/sshd_config_test_clion \
  && mkdir /run/sshd


RUN useradd -m user \
  && yes password | passwd user
COPY ./ /webrtc_stream

RUN pip3 install  -r /webrtc_stream/requirements.txt

# build gst-python
RUN sh /webrtc_stream/build-gst-python.sh


ENV RTMP_URL "rtmp://sea.contribute.live-video.net/app/live_654012349_GvszGQnGHqmX6heyy85CI3UKChY86q"
# ENV PYTHONPATH ${python3 -c 'import sysconfig; x = sysconfig.get_paths(); print(x["platlib"])'}
RUN cd /webrtc_stream && /usr/bin/cmake .
RUN cd /webrtc_stream && /usr/bin/make
# CMD ["/streamlabs/streamlabs"]

# this is for debugging with clion
CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config_test_clion"]


# docker run -d --cap-add sys_ptrace -p127.0.0.1:1977:22 --name clion_remote_env clion/remote-cpp-env:0.5

# docker build -t clion/remote-cpp-env:0.5 .

