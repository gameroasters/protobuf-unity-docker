CONTAINER=gameroasters/protobuf-unity
DLLS_ZIP_NAME=protobuf_unity_dlls

build:
	docker build -t ${CONTAINER}:latest -f Dockerfile .

all: generate-schema extract-dlls-zip

generate-schema:
	mkdir -p proto/
	docker run -v $(shell pwd):/mounted ${CONTAINER}:latest /bin/bash -c "\
	protoc -I=/mounted/ --rust_out=/mounted/proto /mounted/*.proto && \
	protoc -I=/mounted/ --csharp_out=/mounted/proto /mounted/*.proto"

extract-dlls:
	mkdir -p dlls/
	docker run -v $(shell pwd):/mounted ${CONTAINER}:latest /bin/bash -c "\
	cp /protobuf/dlls/*.dll /mounted/dlls"

extract-dlls-zip: extract-dlls
	docker run -v $(shell pwd):/mounted ${CONTAINER}:latest /bin/bash -c "cd /mounted/dlls/ && \
	rm -f ${DLLS_ZIP_NAME}.zip && \
	zip /mounted/dlls/${DLLS_ZIP_NAME}.zip *.dll"

