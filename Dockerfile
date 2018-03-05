FROM ubuntu:16.04

RUN apt-get update && apt-get install wget curl -y
RUN apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev llvm libncurses5-dev  libncursesw5-dev xz-utils tk-dev \
libcupti-dev python3-numpy python3-dev python3-pip python3-wheel

# install python 3.6
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:jonathonf/python-3.6 -y \
&&  apt-get update -y \
&& apt-get install python3.6 -y


RUN python3.6 -m pip install --upgrade pip
RUN python3.6 -m pip install jupyter
RUN mkdir /root/.jupyter
RUN echo "c.NotebookApp.ip = '*'" \
         "\nc.NotebookApp.open_browser = False" \
         "\nc.NotebookApp.token = ''" \
         > /root/.jupyter/jupyter_notebook_config.py
\
RUN python3.6 -m pip install numpy pandas matplotlib \
tensorflow h5py keras pydot ipython scipy pyconfig

## Cleanup ##
RUN apt-get clean && apt-get autoclean && apt-get autoremove 
RUN apt-get purge lib*-dev build-essential -y

# ENTRYPOINT ["bash", "http://0.0.0.0:8888"]
#  docker run -p 8888:8888 --name deep01 --rm -it dscience:latest
# we need to run "jupyter-notebook --allow-root" from inside the container
