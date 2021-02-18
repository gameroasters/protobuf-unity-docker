CONTAINER=gameroasters/protobuf-unity
DLLS_ZIP_NAME=protobuf_unity_dlls

build:
	docker build -t ${CONTAINER}:latest -f Dockerfile .

pr-all: pr-gen pr-dlls-zip

pr-gen:
	mkdir -p proto/
	docker run -it -v $(shell pwd):/mounted ${CONTAINER}:latest /bin/bash -c "\
	protoc -I=/mounted/ --rust_out=/mounted/proto /mounted/*.proto && \
	protoc -I=/mounted/ --csharp_out=/mounted/proto /mounted/*.proto"

pr-dlls:
	mkdir -p dlls/
	docker run -it -v $(shell pwd):/mounted ${CONTAINER}:latest /bin/bash -c "\
	cp /protobuf/dlls/*.dll /mounted/dlls"

pr-dlls-zip: pr-dlls
	docker run -it -v $(shell pwd):/mounted ${CONTAINER}:latest /bin/bash -c "cd /mounted/dlls/ && \
	rm -f ${DLLS_ZIP_NAME}.zip && \
	zip /mounted/dlls/${DLLS_ZIP_NAME}.zip *.dll"

