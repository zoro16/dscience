FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y pulseaudio-utils \
    wget \
    curl \
    make \
    build-essential \
    gcc \
    g++ \
    libjack-jackd2-dev \
    portaudio19-dev \
    unzip \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libcupti-dev \
    python3-numpy \
    python3-dev \
    python3-pip \
    python3-wheel \
    ffmpeg

# install python 3.6
RUN wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz
RUN tar xvf Python-3.6.4.tgz
RUN cd Python-3.6.4 && ./configure && make && make install && cd ..
RUN rm -rf Python-3.6.4.tgz

RUN python3.6 -m pip install --upgrade pip
RUN python3.6 -m pip install jupyter
RUN mkdir /root/.jupyter
RUN echo "c.NotebookApp.ip = '*'" \
         "\nc.NotebookApp.open_browser = False" \
         "\nc.NotebookApp.token = ''" \
         > /root/.jupyter/jupyter_notebook_config.py

RUN python3.6 -m pip install numpy \
    pandas \
    matplotlib \
    tensorflow \
    h5py \
    keras \
    pydot \
    ipython \
    scipy \
    pyconfig \
    music21 \
    librosa \
    faker \
    tqdm \
    babel \
    pydub \
    pyaudio \
    six \
    resampy \
    pillow \
    ipykernel

RUN python3.6 -m ipykernel.kernelspec

## Cleanup ##
RUN apt-get clean && apt-get autoclean && apt-get autoremove 
RUN apt-get purge lib*-dev build-essential -y

# ENTRYPOINT ["bash", "http://0.0.0.0:8888"]
#  docker run -p 8888:8888 --name deep01 --rm -it dscience:latest
# we need to run "jupyter-notebook --allow-root" from inside the container
