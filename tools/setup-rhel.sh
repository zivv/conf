#!/usr/bin/env bash

set -e

PKG_INSTALL=${PKG_INSTALL:-sudo dnf install}

$PKG_INSTALL curl procps util-linux-user
$PKG_INSTALL python3-pip vim
