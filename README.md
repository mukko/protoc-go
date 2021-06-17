# protoc-go docker

protoc container for golang.

This container can use options as for `protoc` command are available.

## Usage

help:  

```bash
docker run --rm mukko/protoc-go:1.0 -h
```

example:  

```bash
docker run --rm -v "$PWD":/tmp/src -w /tmp/src mukko/protoc-go:1.0 -I=pb --go_out=model pb/*.proto
```
