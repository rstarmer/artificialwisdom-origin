# A draft build process for generating FAISS for python and the .so libraries

[Faiss](https://github.com/facebookresearch/faiss) is a vector database that works well in retrieval-transformer style systems.  It is installable via conda, but for our purposes this is less than ideal.  To that end, this is a model for generating the required faiss linkable libraries and a python wheel with CUDA support.  It is still necessary to install the general NVIDIA drivers and cuda support and the Intel OneAPI MKL libraries in order to make use of the results of this system.

## For Debian 12 (faiss 1.7.4):

```sh
bash run.sh
```

Should produce a resulting set of .so files -- add to /usr/local/lib/ on the target system and update the /etc/ld.so.conf.d/aw_faiss.conf with a pointer to /usr/local/lib and reload the ld subsystem `sudo ldconfig`.

## For Debian 11 (faiss 1.7.3):

docker build . -t faiss:1.7.3
docker run --rm -it -v $PWD:/libs faiss:1.7.3 bash /libs/get-libs.sh

## For both

Add the shared libraries

```sh
sudo cp *.so /usr/local/lib/
echo '/usr/local/lib' | sudo tee /etc/ld.so.conf.d/aw_faiss.conf
sudo ldconfig
```

Install the Intel MKL libraries from Intel's OneAPI installer

Install the python faiss wheel into your virtualenv:

```sh
pip install faiss*whl
```

