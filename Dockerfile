FROM alpine:3.7

RUN apk add --no-cache busybox \
curl \
gnupg \
git \
tar \
openssh-client \
make \
alpine-sdk \
ca-certificates \
openssl-dev \
curl-dev \
readline-dev \
sqlite-dev \
llvm \
ncurses-dev \
xz-dev \
xz \
tk-dev \
autoconf \
automake \
bzip2 \
dpkg-dev \
file \
imagemagick-dev \
bzip2-dev \
libc-dev \
linux-headers \
db-dev \
libevent-dev \
libffi-dev \
gdbm-dev \
geoip-dev \
glib-dev \
jpeg-dev \
krb5-dev \
libtool \
libunwind

RUN apk add --no-cache python3 python3-dev && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

RUN pip3 install jupyter
RUN mkdir /root/.jupyter
RUN echo "c.NotebookApp.ip = '*'" \
         "\nc.NotebookApp.open_browser = False" \
         "\nc.NotebookApp.token = ''" \
         > /root/.jupyter/jupyter_notebook_config.py

RUN pip3 install numpy pandas matplotlib h5py keras pydot ipython scipy pyconfig wheel six
RUN pip3 install tensorflow

## Cleanup ##
RUN rm -rf /var/cache/apk/*


#  docker run -p 8888:8888 --name deep01 --rm -it dscience:latest
# we need to run "jupyter-notebook --allow-root" from inside the container
