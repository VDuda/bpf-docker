# bpf-docker

`bpf-docker` is an image to help you run BPF and profiling programs in Docker.

Easily incorporate LinuxKit kernel headers, BTF, and debugfs into your container. As a result, you can now execute BPF programs within Docker Desktop for Mac/Windows(WSL) and Linux.

For profiling analysis would highly recommend reading [perf](https://perf.wiki.kernel.org/index.php/Main_Page) and [eBPF](http://www.brendangregg.com/ebpf.html), as well as this excellent post from [Netflix Performance Engineering team for their investigation process in 60 seconds](https://netflixtechblog.com/linux-performance-analysis-in-60-000-milliseconds-accc10403c55).

### 60 second analysis
```
uptime
dmesg | tail
vmstat 1
mpstat -P ALL 1
pidstat 1
iostat -xz 1
free -m
sar -n DEV 1
sar -n TCP,ETCP 1
top
```

## Usage

Consult [bpftrace documentation](https://github.com/iovisor/bpftrace/tree/master?tab=readme-ov-file#one-liners) for additional tracing,

```shell
docker run -it --rm \ 
  --privileged \ 
  -v /lib/modules:/lib/modules:ro \ 
  -v /etc/localtime:/etc/localtime:ro \ 
  --pid=host \ 
  bpftrace -e 'tracepoint:raw_syscalls:sys_enter { @[comm] = count(); }'
```
Note: /lib/modules probably doesn't exist on your mac host, so Docker will map the volume in from the linuxkit host VM.

Note: you need to make sure the image matches the architecture of the host.
For example, if you are running on a M1/M2 Mac, you need to use `arm64` image.

set flag `KERNEL_VERSION=5.15.110-arm64`


# Maintenance

Docker publishes their for-desktop kernel's [on Docker hub](https://hub.docker.com/r/docker/for-desktop-kernel/tags?page=1&ordering=last_updated) you may need to update the Dockerfile for the latest kernel that matches your linuxkit host VM.
