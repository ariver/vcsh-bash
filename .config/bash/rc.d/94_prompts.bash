#! /dev/null/bash

set -a

PS1_BAK="${PS1_BAK:-${PS1}}"
PS1='\$ '
PS4='+${BASH_SOURCE}+${FUNCNAME}+ '

COLORFCBC="12;8"

PROMPT_COMMAND=bash_profile_prompt_command

#[ -z "${!GIT_PS1_*}" ] || unset ${!GIT_PS1_*}
#GIT_PS1_DESCRIBE_STYLE="branch"
#GIT_PS1_SHOWCOLORHINTS=1
#GIT_PS1_SHOWDIRTYSTATE=1
#GIT_PS1_SHOWSTASHSTATE=1
#GIT_PS1_SHOWUNTRACKEDFILES=1
#GIT_PS1_SHOWUPSTREAM="auto"

set +a

function bash_profile_prompt_command ()
{

    declare raw_err="${?}"

    declare vars=(
        I
        tc_tab      tc_nln
        tc_rst      tc_inv
        tc_tilde    tc_fslash
        tc_fmt_err
        tc_fmt_clfg
        tc_fmt_clbg
        fmt_err
        fmt_pwd
        fmt__py
        fmt_git
        ps1_new
        fmt_nln     fmt_spc
        ps1_div
        ps1_dts
        ps1_ver
        ps1_pid
        ps1_tty
        ps1_job
        ps1_err     raw_err
        ps1__py     raw__py
        ps1_git     raw_git
        ps1_pwd     raw_pwd
        ps1_prm
    )
    declare ${vars[*]}

    raw_pwd="${PWD}"
    raw__py="${VIRTUAL_ENV}"
    raw_git="$( __git_ps1 %s 2>/dev/null || printf _NO_GIT_PS1 )"

    printf -v tc_tab    "\t"
    printf -v tc_nln    "\n"
    printf -v tc_tilde  '~'
    printf -v tc_fslash '/'
    printf -v tc_rst    "\[\x1b[%sm\]" 0
    printf -v tc_inv    "\[\x1b[%sm\]" 7
    printvtcg   tc_fmt_err  15  1
    [[ ! "${COLORFCBC}" =~ ^[0-9]+\;[0-9]+$ ]] || {
        printvtcg tc_fmt_clbg   "${COLORFCBC#*;}"   "${COLORFCBC#*;}"
        printvtcg tc_fmt_clfg   "${COLORFCBC%;*}"   "${COLORFCBC%;*}"
    }
    printf -v tc_fmt_clbg %s "${tc_fmt_clbg}" "${tc_inv}"
    printf -v tc_fmt_clfg %s "${tc_fmt_clfg}" "${tc_inv}"

    fmt_nln="${tc_nln}${tc_fmt_clbg}#${tc_rst}"
    printf -v ps1_div "%*s" $((COLUMNS-2)) 0
    ps1_div="${tc_inv}${ps1_div//0/ }${tc_rst}"
    fmt_spc="${tc_rst} "

    ps1_div="${fmt_nln}${ps1_div}"
    ps1_dts="${fmt_nln}${tc_inv} dts ${tc_rst} \\D{%Y-%m-%d %H:%M:%S}"
    ps1_ver="${fmt_spc}${tc_inv} ver ${tc_rst} \\s \\V"
    ps1_pid="${fmt_spc}${tc_inv} pid ${tc_rst} $$"
    ps1_tty="${fmt_spc}${tc_inv} tty ${tc_rst} \\l"
    ps1_job="${fmt_spc}${tc_inv} job ${tc_rst} \\j"
    [ -z "${raw_err}" -o "${raw_err}" -eq 0 ] || {
        ps1_err="${fmt_spc}${tc_fmt_err} err ${tc_rst} ${raw_err}"
    }
    [ -z "${raw__py}"  ] || {
        fmt__py="${raw__py##*/}"
        ps1__py="${fmt_nln}${tc_inv}  py ${tc_rst} ${fmt__py}"
    }
    [ -z "${raw_git}" ] || {
        fmt_git="${raw_git}"
        [[ -z "${GIT_DIR}" || "${PWD}" == ${GIT_DIR}/* ]] \
            || fmt_git="${GIT_DIR/#${HOME}${tc_fslash}/${tc_tilde}${tc_fslash}} ${fmt_git}"
        ps1_git="${fmt_nln}${tc_inv} git ${tc_rst} ${fmt_git}"
    }
    [ -z "${raw_pwd}" ] || {
        fmt_pwd="${raw_pwd#${HOME}}"
        [ "${fmt_pwd}" == "${raw_pwd}" ] || fmt_pwd="~${fmt_pwd}"
        ps1_pwd="${fmt_nln}${tc_inv} pwd ${tc_rst} ${fmt_pwd}"
    }
    ps1_prm="${fmt_nln}${tc_inv} \\$ ${tc_fmt_clfg}# ${fmt_spc}"

    for I in ${vars[*]}
    do
        [[ "${I}" =~ ^ps1_ && "${I}" != "ps1_new" ]] || continue
        eval "ps1_new=\"\${ps1_new}\${${I}}\""
    done

    PS1="${ps1_new}"

    printf "\033]0;%s\007" "${fmt_pwd}" 1>&2

    history -a

    stty sane

    #for I in ${vars[*]}; do set | grep -m1 ^${I}=; done > "${TMPDIR}/${FUNCNAME[0]}.$( date "+%Y.%m.%d.%H.%M.%S" ).$$.out"

    return "${raw_err}"

}

function printv ()
{
    declare {___printv_variable,___printv_string,___printv_tmp}=
    ___printv_variable="${1}"
    shift
    for ___printv_string in ${@:+"${@}"}
    do
        printf -v ___printv_tmp "${___printv_tmp}${___printv_string}"
    done
    printf -v "${___printv_variable}" "${___printv_tmp}"
}

function printvtc ()
{
    declare {___printvtc_variable,___printvtc_string,___printvtc_tmp}=
    ___printvtc_variable="${1}"
    shift
    for ___printvtc_string in ${@:+"${@}"}
    do
        printf -v ___printvtc_tmp "${___printvtc_tmp}\[\x1b[${___printvtc_string}m\]"
    done
    printf -v "${___printvtc_variable}" "${___printvtc_tmp}"
}

function printvtcg ()
{
    declare {___printvtcg_color,___printvtcg_variable,___printvtcg_ground,___printvtcg_mode_fb,___printvtcg_tmp}=
    ___printvtcg_ground="${1}"
    ___printvtcg_variable="${2}"
    [[ "${___printvtcg_variable}" =~ [0-9]+ ]] && {
        ___printvtcg_mode_fb=1
        ___printvtcg_variable="${___printvtcg_ground}"
        ___printvtcg_ground="f"
        shift 1
    } || {
        ___printvtcg_mode_fb=0
        shift 2
    }
    [ "${___printvtcg_ground}" == "f" ] && ___printvtcg_ground=38 || ___printvtcg_ground=48
    printv "${___printvtcg_variable}" ""
    for ___printvtcg_color in ${@:+"${@}"}
    do
        [ "${___printvtcg_color}" -gt 15 ] \
        && printvtc ___printvtcg_tmp "${___printvtcg_ground};5;${___printvtcg_color}m" \
        || printvtc ___printvtcg_tmp "$(((___printvtcg_ground-8)+(___printvtcg_color/8*60)+(___printvtcg_color%8)))"
        eval "printv ${___printvtcg_variable} \"\${${___printvtcg_variable}}\${___printvtcg_tmp}\""
        [ "${___printvtcg_mode_fb}" -eq 0 ] || ___printvtcg_ground=$((___printvtcg_ground+10))
    done
}
