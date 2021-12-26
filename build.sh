#!/usr/bin/env bash

TEMPLATES='tpl'
CONTENT='content'
OUTPUT='public'

shopt -s globstar

mkdir -p "$OUTPUT"

function render() {
    # TODO: smart eval (keep indentation)
    eval echo '"'"$(sed 's_"_\\"_g')"'"'
}

function render_template() {
    # Make an empty config or format existing config block
    local content=$(awk '
        NR==1 && /^---/ { has_config = 1; next }
        NR!=1 && has_config && /^---/ { has_config = 0; printf "@@@"; next}
        NR==1 && !has_config { printf "@@@" }
        1
    ')

    local commands="${content%@@@*}"
    local content="${content#*@@@}"

    eval "$commands"

    local template="${template:-base.html}"

    sed -E 's/\{\s*(\S+)\s*\}/$\1/g' "${TEMPLATES}/${template}" \
        | render | render # render template, then render content
}

for content_file in "$CONTENT"/**/*; do
    render_template < "$content_file" > "${OUTPUT}/${content_file#*${CONTENT}}"
done

