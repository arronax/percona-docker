#!/bin/sh

prefix=/usr
exec_prefix=/usr
libdir=/usr/lib64

LD_PRELOAD=/opt/jemalloc/lib/libjemalloc.so.2
export LD_PRELOAD

MALLOC_CONF=prof:true,prof_prefix:/tmp/mysqld_jeprof,lg_prof_sample:22,lg_prof_interval:28
export MALLOC_CONF

exec "$@"
