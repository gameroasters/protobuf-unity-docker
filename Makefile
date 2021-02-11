CONTAINER=gameroasters/protobuf-unity

docker-build:
	docker build -t ${CONTAINER}:latest -f Dockerfile .

proto-gen:
	docker run -it -v $(shell pwd):/schema ${CONTAINER}:latest /bin/bash -c "\
	protoc -I=schema/ --rust_out=schema/ foo.proto && \
	protoc -I=schema/ --csharp_out=schema/ foo.proto"

