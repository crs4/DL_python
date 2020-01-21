FROM tensorflow/tensorflow:2.1.0-gpu-py3
LABEL maintainer="giovanni.busonera@crs4.it"
USER root
ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update \
    && apt dist-upgrade -y \
    && apt install -y wget apt-utils vim libblas-dev libatlas-base-dev libopenslide0 python3-pip libgeos-dev python-tifffile python-opencv python-h5py python3-tk iputils-ping\
    && wget https://github.com/computationalpathologygroup/ASAP/releases/download/1.9/ASAP-1.9-Linux-Ubuntu1804.deb \
    && apt install -y ./ASAP-1.9-Linux-Ubuntu1804.deb \
    && pip3 install --upgrade --no-cache pip \
    && pip3 install --upgrade --no-cache keras \
    && pip3 install --upgrade --no-cache jupyter \
    && pip3 install --upgrade --no-cache pandas \ 
    && pip3 install --upgrade --no-cache sentinelsat \
    && pip3 install --upgrade --no-cache shapely \
    && pip3 install --upgrade --no-cache descartes \
    && pip3 install --upgrade --no-cache cython \
    && pip3 install --upgrade --no-cache tsne \
    && pip3 install --upgrade --no-cache scikit-learn \
    && pip3 install --upgrade --no-cache pillow \
    && pip3 install --upgrade --no-cache matplotlib \ 
    && pip3 install --upgrade --no-cache opencv-python \
    && pip3 install --upgrade --no-cache openslide-python\
    && pip3 install --no-cache --index-url https://test.pypi.org/simple/ spams \
    && pip3 install --upgrade --no-cache joblib \
    && pip3 install --upgrade --no-cache tqdm \
    && pip3 install --upgrade --no-cache pywavelets \
    && pip3 install --upgrade --no-cache imutils \
    && apt clean \
    && apt autoremove -y \
    && rm -rf /tmp/* /var/tmp/* \
    && useradd -m jupyter
    

WORKDIR /home/jupyter
USER jupyter
RUN mkdir .jupyter
COPY --chown=jupyter jupyter_notebook_config.py .jupyter/
ENV PYTHONPATH="/opt/ASAP/bin/:${PYTHONPATH}"
WORKDIR notebooks

EXPOSE 8888
ENTRYPOINT ["/bin/bash", "-c", "jupyter notebook"]
