#!/usr/bin/env bash
channel=$1

version=$(curl -sX GET "https://gitlab.com/api/v4/projects/9317860/repository/commits/${channel}" | awk '/id/{print $4;exit}' FS='[""]')

printf "%s" "${version}"
