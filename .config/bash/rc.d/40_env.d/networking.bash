#! /dev/null/bash

#
## Custom Networking Variables
#
function ___tmp ()
{

    declare vars=(
        tc_nln
        rgx_net_if
        l2u
        ifc_out
        net_if
        net_if_vals
        net_if_eth
        net_if_ip4
        net_if_ip6
        I
    )
    declare ${vars[*]}

    printf -v tc_nln '\n'
    l2u=( {a..z} {A..Z} )

    rgx_net_if="^(.*${tc_nln})?([^:[:space:]]+): [^${tc_nln}]*${tc_nln}(.*)"

    ifc_out="$( ifconfig )"

    while [[ "${ifc_out}" =~ ${rgx_net_if} ]]
    do

        ifc_out="${BASH_REMATCH[1]}"
        net_if="${BASH_REMATCH[2]}"
        net_if_vals="${BASH_REMATCH[3]}"

        [[ ! "${net_if_vals}" =~ [[:blank:]]ether[[:blank:]]([^[:blank:]]+) ]] \
            || net_if_eth="${BASH_REMATCH[1]}"
        [[ ! "${net_if_vals}" =~ [[:blank:]]inet[[:blank:]]([^[:blank:]]+)  ]] \
            || net_if_ip4="${BASH_REMATCH[1]}"
        [[ ! "${net_if_vals}" =~ [[:blank:]]inet6[[:blank:]]([^[:blank:]]+) ]] \
            || net_if_ip6="${BASH_REMATCH[1]}"

        for (( I=0; I<(${#l2u[@]}/2); I++ ))
        do
            net_if="${net_if//${l2u[${I}]}/${l2u[$((I+26))]}}"
        done

        [ -z "${net_if_eth}" ] || eval "NET_IF_${net_if}_ETH='${net_if_eth}'"
        [ -z "${net_if_ip4}" ] || eval "NET_IF_${net_if}_IP4='${net_if_ip4}'"
        [ -z "${net_if_ip6}" ] || eval "NET_IF_${net_if}_IP6='${net_if_ip6}'"

    done

}
___tmp 1>&2
unset -f ___tmp
