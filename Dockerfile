FROM alpine:3.16.4

RUN apk add --no-cache docker-cli

RUN apk add --no-cache \
    bcc-doc \
    bcc-tools \
    bpftrace \
    bpftrace-doc \
    bpftrace-tools \
    bpftrace-tools-doc

ARG KERNEL_VERSION=5.15.110
FROM linuxkit/kernel:${KERNEL_VERSION} as kernel

WORKDIR /
COPY --from=kernel /kernel-dev.tar .
RUN tar xf kernel-dev.tar
RUN rm kernel-dev.tar

WORKDIR /app

CMD mount -t debugfs debugfs /sys/kernel/debug && /bin/sh