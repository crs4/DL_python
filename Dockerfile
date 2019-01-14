FROM tensorflow/tensorflow:1.12.0-devel-gpu-py3
LABEL maintainer="giovanni.busonera@crs4.it"
USER root
RUN apt-get update \
    && apt-get install -y vim libblas-dev libatlas-base-dev python3-pip libgeos-dev python-tifffile python-opencv python-h5py python3-tk iputils-ping\
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
    && pip3 install --no-cache --index-url https://test.pypi.org/simple/ spams \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/* \
    && useradd -m jupyter

WORKDIR /home/jupyter
USER jupyter
RUN mkdir .jupyter
COPY --chown=jupyter jupyter_notebook_config.py .jupyter/

WORKDIR notebooks

EXPOSE 8888
ENTRYPOINT ["/bin/bash", "-c", "jupyter notebook"]
