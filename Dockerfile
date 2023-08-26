FROM alpine:edge

ENV BUILD_PATH /workspace/build

WORKDIR /workspace

COPY bin .

# 'make' IS NOT included in 'cmake'
RUN apk update \
    && apk add g++ make cmake

# '-p' make directory recursiely
# Also only create if does not exist
RUN mkdir -p $BUILD_PATH

# '-S' source in this case current dir
# '-B' where to put build files
RUN cmake -S . -B $BUILD_PATH

# '-C' the dir where Makefile is located
RUN make -C $BUILD_PATH

# optional but simplifies CMD
RUN mv $BUILD_PATH/main .

CMD ["./main"]