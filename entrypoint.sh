#!/bin/bash -e

printUsage() {
	echo "protoc-go generates protobuf @mukko"
	echo "options:"
	echo "-d DIR: (required) specify directory "
	echo "-o DIR: "
	echo "--go_opt OPT: "
}

PROTO_DIR=""
OUT_DIR=""
GO_OPT=""

while test $# -gt 0; do
    case "$1" in
        -h)
            printUsage
            exit 0
            ;;
        -d)
            shift
            if test $# -gt 0; then
                PROTO_DIR=$1
            else
                echo "no directory specified"
                exit 1
            fi
            shift
            ;;
        -o)
            shift
            OUT_DIR=$1
            shift
            ;;
        --go_opt)
            shift
            GO_OPT=$1
            shift
            ;;
        *)
            break
            ;;
    esac
done

if [[ $OUT_DIR == '' ]]; then
    OUT_DIR="gen/pb-go"
fi

if [[ ! -d $OUT_DIR ]]; then
    mkdir -p $OUT_DIR
fi

GEN_STRING=""
if [[ ! -z $GO_OPT ]]; then
    GEN_STRING="$GEN_STRING --go_opt=$GO_OPT --go_out=$OUT_DIR"
else 
    GEN_STRING="$GEN_STRING --go_out=$OUT_DIR"
fi

PROTO_INCLUDE=""
if [[ ! -z $PROTO_DIR ]]; then
    PROTO_INCLUDE="$PROTO_INCLUDE -I $PROTO_DIR"
    FIND_DEPTH="-maxdepth 1"
    PROTO_FILES=(`find ${PROTO_DIR} ${FIND_DEPTH} -name "*.proto"`)
else 
    echo "-d option is empty"
    exit 1
fi

# run protoc
protoc $PROTO_INCLUDE\
    $GEN_STRING \
    ${PROTO_FILES[@]}