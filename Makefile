CONTAINER=gameroasters/protobuf-unity

build:
	docker build -t ${CONTAINER}:latest -f Dockerfile .

pr-all: pr-gen pr-dlls

pr-gen:
	mkdir -p proto/
	docker run -it -v $(shell pwd):/mounted ${CONTAINER}:latest /bin/bash -c "\
	protoc -I=mounted/ --rust_out=mounted/proto $(PROTO_FILE) && \
	protoc -I=mounted/ --csharp_out=mounted/proto $(PROTO_FILE)"

pr-dlls:
	mkdir -p dlls/
	docker run -it -v $(shell pwd):/mounted ${CONTAINER}:latest /bin/bash -c "\
	cp /protobuf/dlls/*.dll /mounted/dlls"


