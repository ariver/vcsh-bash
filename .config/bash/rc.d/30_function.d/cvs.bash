#! /dev/null/bash

function cvs ()
{

    #
    ## Proxy CVS through, well, a proxy. ;P
    #
    # CVS server ports are often blocked by firewall rules.
    #

    proxychains4 cvs "${@}"

}
