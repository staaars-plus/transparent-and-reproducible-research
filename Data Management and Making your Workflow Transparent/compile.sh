#!/bin/bash

PARAMS=(
-f markdown+raw_tex+fenced_code_attributes+definition_lists+link_attributes+fenced_divs
--filter=pandoc-latex-admonition
-t beamer
-o presentation.pdf
)

pandoc ${PARAMS[@]} presentation.md