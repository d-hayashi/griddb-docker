#!/bin/bash

export GS_HOME=${GS_HOME:-"${HOME}"}
export GS_LOG=${GS_LOGL-"${HOME}/log"}

gs_startnode
gs_joincluster -c dockerGridDB -u admin/admin

exec "$@"
