#!/bin/bash

/sbin/gmetad
/sbin/gmond

exec "$@"
