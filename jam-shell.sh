#!/usr/bin/env bash

TEMPLATES='tpl'
CONTENT='content'
OUTPUT='public'

shopt -s globstar

mkdir -p "$OUTPUT"

function normalize() {
    # Make an empty config or format existing config block
    awk 'NR==1 && /^---/ { has_config = 1; next }
        NR!=1 && has_config && /^\s*[a-zA-Z0-9_]+=/ {printf "local "}
        NR!=1 && has_config && /^---/ { has_config = 0; printf "@@@"; next}
        NR==1 && !has_config { printf "@@@" }
        1' | sed 's_"_\\"_g' | sed -E 's/\{\s*(\S+)\s*\}/$\1/g'
}

function eval_text() {
    eval echo '"'"$1"'"'
}

function render() {
    local content_file="$1"
    local contents="$(normalize < "$content_file")"

    local content_cfg="${contents%@@@*}"

    # choose template
    eval "$(sed -n '/template=/p' <<< "$content_cfg")"

    local _template=$(normalize < "${TEMPLATES}/${template:-base.html}")

    eval "${_template%@@@*}"
    eval "${content_cfg}"

    # TODO: smart eval (keep indentation)
    local content="$(eval_text "${contents#*@@@}")"
    eval_text "${_template#*@@@}"
}

for content_file in "$CONTENT"/**/*; do
    render "$content_file" > "${OUTPUT}/${content_file#*${CONTENT}}"
done

