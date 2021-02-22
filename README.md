# protobuf-unity-docker

Cross platform functionality for `csharp` and `rust` [Protobuf](https://developers.google.com/protocol-buffers) file generation and extraction of `.dll` files for Unity.
Utilizes docker container.

### Requirements

- make
- docker

### Usage

1. Create [proto3 compliant](https://developers.google.com/protocol-buffers/docs/proto3) `.proto` files
2. With [docker container](https://hub.docker.com/repository/docker/gameroasters/protobuf-unity) generate `.rs` and `.cs` protobuf files using [protoc from v3.14.0 release](https://github.com/protocolbuffers/protobuf/releases/tag/v3.14.0) with [rust plugin](https://github.com/stepancheg/rust-protobuf/tree/master/protobuf-codegen) and [well-known google types](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf)
3. Download `.dll` files for use with Unity from [releases](https://github.com/kroonhorstdino/protobuf-unity/releases) or extract manually

## Example usage

One-time setup: `make build` to build docker image

Then, to execute the following example steps all at once, just use `make all`. Otherwise follow the next steps.

<sup>Tip: If the following commands cause you trouble, try to leave out `shell` in the `docker run -v $(shell pwd)` part. Just use `$(pwd)` instead.</sup>

### Generate `.cs` and `.rs` schema files

Place your `.proto` files in directory, then use: `make generate-schema`

_OR:_

```sh
	docker run -v $(shell pwd):/mounted gameroasters/protobuf-unity:latest /bin/bash -c "\
	protoc -I=/mounted/ --rust_out=/mounted/ /mounted/*.proto && \
	protoc -I=/mounted/ --csharp_out=/mounted/ /mounted/*.proto"
```

This will generate `.cs` and `.rs` files with your ` .proto` schema type serialiation in csharp and rust _(inside `proto/` with make command)_.

### Extract `.dll` files

To manually extract `.dll` files for Unity, use: `make extract-dlls`

_OR:_

```sh
	docker run -v $(shell pwd):/mounted gameroasters/protobuf-unity:latest /bin/bash -c "\
	cp /protobuf/dlls/*.dll /mounted/"
```

This extracts the `.dll` files _(inside `dll/` folder with make command)_. Just drop these into your Unity project.

#### Optional: Extract into `.zip` archive

To bundle into `.zip` archive, after executing previous step, use:

```sh
	docker run -v $(shell pwd):/mounted gameroasters/protobuf-unity:latest /bin/bash -c "\
	rm -f /mounted/protobuf_unity_dlls.zip && \
	zip /mounted/protobuf_unity_dlls.zip mounted/*.dll"
```

_OR:_ `make extract-dlls-zip` without any prerequisite step
