# DL_python

build the image with:
docker build -t crs4/dl-tf2-keras-asap-jupyter:tag .

Note:
In the Dockerfile is present a temporary downgrade of the setuptools package to allows the openslide-python installation.
At the moment openslide-python setup imports the Feature module that is not present in setuptools >=46.0.0
