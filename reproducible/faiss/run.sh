docker build . -t faiss -f Dockerfile.debian12
docker run --rm -it -v ${PWD}:/libs faiss /bin/bash /libs/get-libs.sh

