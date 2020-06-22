#!/bin/bash

#########################################################################
# Author: Zhaoting Weng
# Created Time: Mon 22 Jun 2020 09:44:18 AM CST
# Description:
#########################################################################
MYDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MYNAME="$(basename "${BASH_SOURCE[0]}")"

die() {
    echo "$@" >&2
    exit 1
}

usage() {
    cat << EOF
Usage: ./${MYNAME} [options] id

Options:
    -h|--help           show this message
    --token             bear token

Arguments:
    id                  github id
EOF
}

main() {
    while :; do
        case $1 in
            -h|--help)
                usage
                exit 1
                ;;
            --token)
                shift
                token=$1
                shift
                break
                ;;
            --)
                shift
                break
                ;;
            *)
                break
                ;;
        esac
        shift
    done

    id=$1
    local expect_n_arg
    expect_n_arg=1
    [[ $# = "$expect_n_arg" ]] || die "wrong arguments (expected: $expect_n_arg, got: $#)"


    option=()
    if [[ -n $token ]]; then
        option+=("-H" "Authorization: token $token")
    fi

    repos=(
#         hashicorp/go-azure-helpers
#         hashicorp/terraform-plugin-sdk
#         bflad/tfproviderlint
        terraform-providers/terraform-provider-azurerm
#         katbyte/terrafmt
#         hashicorp/terraform
    )

cat << EOF
Terraform community contributions from @$id
===
EOF

    cat << EOF

ISSUE
===
EOF
    for repo in "${repos[@]}"; do
        cat << EOF

@$repo
---
EOF
curl "${option[@]}" -s "https://api.github.com/search/issues?q=type:issue+repo:$repo+commenter:$id" | jq -r '.items | .[] | "- [\(.title)](\(.html_url))"'
    done

    cat << EOF

PULL
===
EOF
    for repo in "${repos[@]}"; do
        cat << EOF

@$repo
---
EOF
        curl "${option[@]}" -s "https://api.github.com/search/issues?q=type:pr+repo:$repo+commenter:$id" | jq -r '.items | .[] |  "- [\(.title)](\(.html_url))"'
        #curl -s "https://api.github.com/repos/$repo/pulls?q=author:$id" | jq -r '.[] | .title'
    done
}

main "$@"
